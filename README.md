# 🚀 OpenPAI - 轻量级大模型开发平台

<p align="left">
  🌐 中文 | <a href="./README_en.md">🌍 English</a>  

🎉 **OpenPAI** 是一个轻量、强大且易用的大模型应用开发平台，帮助用户快速部署和交互大模型。平台支持本地、企业服务器及云端模型服务，并提供直观、友好的网页界面，让你轻松构建 AI 应用！✨


---

## 🌟 功能亮点

### 📺 **系统灵活配置**
- 💻 **定制标题**：支持自定义系统标题。
- 🏢 **定制logo**：支持自定义系统logo。
- ☁️ **定制背景**：支持自定义系统背景。

### 🌌 **无缝模型整合**
- 💻 **本地部署**：系统连接并使用本地大模型。
- 🏢 **企业服务器**：灵活整合企业内部部署模型。
- ☁️ **公有云服务**：快速连接外部云模型服务（如 OpenStation 等）。

### ⚡ **快速安装与部署**
- 🚨 **快速上手**：极简安装，即开即用。
- 🖥️ **可视化界面**：友好的操作体验，极易上手。
- 🔧 **扩展性强**：支持多个模型来源，灵活扩展。

### 👥 **多角色管理**
- 🛠️ **管理员**：全面控制平台设置，管理用户、模型、应用、资源、数据等。
- 👤 **普通用户**：随时体验模型对话，管理个人偏好、应用、数据等。

### 🌐 **多源模型接入**
- 📡 接入部署于 **OpenStation** 的模型服务。
- 🌍 引入第三方外部模型。
- 🔄 自由刷新、启用或禁用模型连接。

### 🛠️**应用、数据管理**
- 🔧管理应用、任务、提示工程
- 🖥️管理各种数据，包括知识库、数据库、词库


---

## 📦 安装与部署
本项目主要采用K8s部署的方式，请先部署一个k8s在机器上。后续会完善docker部署方式。

**环境：**

```
1、系统：       ubuntu
2、部署:        Kubernetes
```



### 一、镜像：

通过如下命令拉取镜像：

```shell
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/<IMAGE-NAME>:<IMAGE-TAG>
```

其中<IMAGE-NAME>:<IMAGE-TAG>为镜像名称:镜像标签，需要拉取的镜像分为**chat镜像**和**LLM-Serving镜像**，两部分镜像名称和镜像标签如下：

chat需要拉取如下9个镜像：

```
openpaichat:v1.0
apiserver:v1.1
openpaiparser:v1.0
openpai-ui:latest
agent-ui:latest
redis:7.2.4
quay.io/minio/minio:RELEASE.2023-12-20T01-00-02Z
docker.elastic.co/elasticsearch/elasticsearch:8.11.3
busybox:1.31.0
```

LLM-Serving需要拉取如下1个镜像：

```
llm-serving:8.0
```

拉取完成后，如果机器有多个节点，需要在**每个节点**拉取apiserver、agentui和openpaiparser的镜像，例如，除了主节点外还有一个node2节点：

```shell
ssh node2
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/<IMAGE-NAME>:<IMAGE-TAG>
```

例如，在有Harbor的情况下，执行类似如下命令，根据实际情况修改：

```shell
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/apiserver:v1.1
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/agent-ui:latest
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpaiparser:v1.0
```



### 二、模型：

首先，先规划一下要将模型放置到哪个节点**（建议有足够CPU和GPU资源，主要用于部署模型）**，然后在该节点下执行如下操作：

拉取模型镜像：

```shell
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpai-rag-model:latest
```

拷贝模型文件到对应节点任意路径下：

```shell
docker create --name <CONTAINER-NAME> easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpai-rag-model:latest
docker cp <CONTAINER-NAME>:/model/bussiness <HOST_PATH>
docker rm -f <CONTAINER-NAME>
```

其中<CONTAINER-NAME>为容器名称，<HOST_PATH>为对应节点的路径（用于存放模型文件）。

拷贝完成后会在对应路径下有**bussiness**文件夹，在该文件夹下会有5个压缩包文件，分别为：

```
custom-models.tar.gz
embedding-models.tar.gz
ollama-cache.tar.gz
vl-models.tar.gz
whisper-models.tar.gz
```

将这5个压缩包分别解压：

```shell
tar -xf <TAR-PACKAGE>
```

其中<TAR-PACKAGE>为对应的压缩包名称，解压后会有5个对应的文件夹。



### 三、部署：
### 数据库部署：

如果机器上已有数据库，可以直接使用原来的数据库，并在数据库中执行如下命令创建用户并给予权限，可根据实际情况修改用户名和密码：

```mysql
create user 'openpaiadmin' identified by 'OPENPAIChat';
flush privileges;
grant all privileges on openpaichat.* to openpaiadmin@'%';
flush privileges;
```


如果没有数据库，建议直接拉取最新的**mariadb镜像**，拉取及启动命令示例(可根据实际情况修改)：

```shell
docker pull mariadb:latest
docker run -d \
  --name mariadb \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=OPENPAIChat \
  -v /home/mariadb-data:/var/lib/mysql \
  mariadb:latest
```


#### Chat部署：

chat部署的yaml文件在项目的**deploymnet/k8s/chat**目录下，先将其单独拷贝出来放到**主节点**任意目录下，然后cd到该目录下执行如下操作：

1、根据实际情况修改**openpai_config.yml**文件中的值：其中**{{HOST_IP}}**和**{{HOST_PATH}}**通过后面步骤的脚本传递参数整体修改

2、替换主部署文件**all-openpai-deployment.yml**：

**如下脚本主要用于替换all-openpai-deployment.yml中的值，如果不需要或有问题，可以根据实际情况手动指定all-openpai-deployment.yml中的部署方式（4个文件夹要建好并给与权限）。**

执行**replace.sh**脚本将**all-openpai-deployment.yml**文件中值替换为**openpai_config.yml**中配置的值，其中第一个参数为**主节点的IP**，第二个参数为**主节点**上任意路径（用来持久化存储和存放日志信息），并在该路径下建好如下4个文件夹：**cache**（存放日志）、**mcp_data**、**es_data**（给予777权限：**chmod 777  HOST_PATH/es_data**）、**redis_data**和**minio_data**。

```shell
bash +x replace.sh 10.11.12.13 <HOST_PATH>
```

3、替换完成后，直接部署：

```shell
kubectl apply -f all-openpai-deployment.yml
```



#### LLM-Serving部署：

LLM-Serving部署的yaml文件在项目的**deploymnet/k8s/LLM-Serving**目录下，先将其单独拷贝出来放到**主节点**任意目录下。

1、根据实际情况修改**llm-serving_config.yml**文件中的值：其中**{{HOST_IP}}**和**{{HOST_PATH}}**通过后面步骤的脚本传递参数整体修改;

2、替换LLM-Serving主yaml: 

如果是**CPU部署LLM-Serving**服务，请先在**llm-serving.yml**中将请求和限制的GPU资源**“nvidia.com/gpu: 1”**注释掉或者删除；

如果是**GPU部署LLM-Serving**服务，请先在**llm-serving.yml**中将环境变量**NVIDIA_VISIBLE_DEVICES及其值**注释掉或者删除。

**如下脚本主要用于替换llm-serving.yml中的值，如果不需要或有问题，可以根据实际情况手动指定llm-serving.yml中的部署方式。**

执行**replace-llm-serving-yaml.sh**脚本将**llm-serving.yml**文件中值替换为**llm-serving_config.yml**中配置的值，其中第一个参数为主节点的IP，第二个参数为解压后的LLM-Serving模型**bussiness文件夹**所在位置（**对应节点的路径**）：

```shell
bash +x replace-llm-serving-yaml.sh <HOST_IP> <HOST_PATH>
```

其中<HOST_IP>为主节点IP，<HOST_PATH>为LLM-Serving模型所在对应节点的路径，如：

```shell
bash +x replace-llm-serving-yaml.sh 172.16.0.128 /home/model
```

3、如果是**CPU部署LLM-Serving**服务，请先执行如下命令：

```shell
cp Param-rag-cpu.yaml Param-rag.yaml
```

如果是**GPU部署LLM-Serving**服务，请先执行如下命令：

```shell
cp Param-rag-gpu.yaml Param-rag.yaml
```

然后执行如下命令修改Param-rag.yaml中路径的值，或者可以手动修改：

```SHELL
bash +x replace-rag-param.sh <HOST_PATH>
```

其中<HOST_PATH>为LLM-Serving模型**bussiness文件夹**所在对应节点的路径，如：

```shell
bash +x replace-rag-param.sh /home/model
```

然后拷贝修改后的Param-rag.yaml文件到RAG模型下的bussiness目录下

```shell
cp Param-rag.yaml <HOST_PATH>/bussiness/
```

完成后，直接部署：

```shell
kubectl apply -f llm-serving.yml
```





启动后，访问 `http://<宿主机IP>:<宿主机端口>` 🚪 进入登录页面。

### 🔐 登录平台



管理员使用admin账号密码直接登录，登录成功后即可访问平台主页！🎊
普通用户需要管理员创建账号后，再登录使用。


![](doc/images/v1.0/login.png)

---

## 🌟 功能与角色

### 🔧 管理员
- 📡**模型**：，模型服务，可以添加模型服务商、及模型服务。
- 💬**资源**： 提供对MCP等资源的管理。
- 🖥︎ **应用**: 提供对智能体、提示工程、评测任务的管理
- 📄**数据**: 知识库、数据库、专业词库的管理
- 🕹**操作轨迹**：提供对用户操作的系统操作轨迹的查看
- ⚙️**系统设置**: 提供平台业务的设置，更好的控制、利用平台资源
- 🤵🏽‍♂️**用户管理**：提供对用户的管理，包括创建、删除、重置密码等

### 🗣️ 普通用户
- 🤖 **模型对话**：实时与各种接入的大模型互动。
- ⚙️*应用管理**：自主创建智能体、提示工程、评测任务
- 📄**数据管理**：自由的管理自己的知识库、数据库、专业词库，更符合自己对系统操作的匹配感
- 🤩 **偏好管理**：实时更改系统的设置，更符合自己喜好。

---

## 📖 后续步骤
详细指南（模型配置、插件使用等高级功能）👉 [📚 OpenPAI 使用手册](./doc/用户手册.md)

---

## 🔮 未来规划
- 🛠️ **更丰富模型库**：持续集成更多模型服务。
- 📦 **额外插件生态**：知识库管理、智能搜索等功能增强。
- 🎛️ **精细化权限控制**：提升管理员对模型和用户的管控能力。