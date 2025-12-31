# 🚀 OpenPAI - 轻量级大模型开发平台

<p align="left">
  🌐 中文 | <a href="./README_en.md">🌍 English</a>  

🎉 **OpenPAI** —— 轻量易用、功能强大的生产级 AI Agent 开发平台。无需复杂技术栈，即可快速接入大模型服务、搭建Agent工作流，依托可视化界面高效构建 AI Agent 应用；全面支持本地、企业服务器及云端模型服务灵活接入，以直观友好的操作体验，让 AI Agent 开发门槛大幅降低、落地效率成倍提升！✨


---

## 🌟 功能亮点

✅ 无缝接入大模型：一键无缝接入本地大模型、全球大模型服务，部署灵活无绑定，兼顾数据合规与灵活选型

✅ 可视化智能体开发：拖拽式可视化开发、调试和发布AI Agent ，支持低 / 无代码双模式，无需复杂技术栈与编码功底。

✅ 生产级赋能：内置精准 RAG 联动企业知识库，保障回答精准合规；覆盖开发 - 测试 - 部署 - 运营全闭环，生产级稳定运行，赋能核心业务量产落地。

✅ 安全可控：原生支持私有化部署，输入输出内容安全审核。标配企业级 LLMOps，一站式实现监控、评估，适配强合规行业需求，安全合规双保障。

✅ 灵活自定义：系统支持灵活配置，可自定义标题、Logo 及背景，满足个性化界面需求。


---

## 📦 安装与部署
本项目主要采用K8s部署的方式，请先部署一个k8s在机器上。后续会完善docker部署方式。

整体安装部署思路是：**环境准备 → 拉镜像 → 准备模型 → 部署（部署数据库 → 部署 Chat → 部署 LLM-Serving)**。

### 一、环境准备：

```
1、系统：       ubuntu
2、部署:        Kubernetes
```

请准备至少 1 台机器（支持多节点更佳），已安装并可正常使用：docker、kubectl、kubernetes集群（k8s）。

### 二、拉镜像：

#### 2.1 主节点拉取镜像

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

#### 2.2 多节点情况（如无其他节点可忽略）

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



### 三、准备模型：

#### 3.1 选择部署节点

规划一下要将模型放置到哪个节点，**建议有足够CPU和GPU资源，主要用于部署模型**。

#### 3.2 拉取模型镜像

在该节点下执行如下操作：

拉取模型镜像：

```shell
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpai-rag-model:latest
```

#### 3.3 拷贝模型文件

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

#### 3.4 解压模型文件

将这5个压缩包分别解压：

```shell
tar -xf <TAR-PACKAGE>
```

其中<TAR-PACKAGE>为对应的压缩包名称，解压后会有5个对应的文件夹。



### 四、部署：
#### 4.1 部署数据库：

##### 4.1.1 方式一：使用已有数据库

如果机器上已有数据库，可以直接使用原来的数据库，并在在已有 MySQL / MariaDB 中执行如下SQL命令创建用户并给予权限，可根据实际情况修改用户名和密码：

```mysql
create user 'openpaiadmin' identified by 'OPENPAIChat';
flush privileges;
grant all privileges on openpaichat.* to openpaiadmin@'%';
flush privileges;
```

##### 4.1.2 方式二：使用 Docker 启动 MariaDB

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

#### 4.2 部署Chat：

##### 4.2.1 准备部署文件

chat部署的yaml文件在项目的**deploymnet/k8s/chat**目录下，先将其单独拷贝出来放到**主节点**任意目录下，然后cd到该目录下执行如下操作：

##### 4.2.2 修改配置文件

根据实际情况修改**openpai_config.yml**文件中的值：其中**{{HOST_IP}}**和**{{HOST_PATH}}**通过后面步骤的脚本传递参数整体修改

##### 4.2.3 创建数据目录

主节点上任意路径（用来持久化存储和存放日志信息）下，建好如下4个文件夹：**cache**（存放日志）、**mcp_data**、**es_data**（给予777权限：**chmod 777  HOST_PATH/es_data**）、**redis_data**和**minio_data**。

##### 4.2.4 执行替换脚本

**如下脚本主要用于替换all-openpai-deployment.yml中的值，如果不需要或有问题，可以根据实际情况手动指定all-openpai-deployment.yml中的部署方式（4个文件夹要建好并给与权限）。**

执行**replace.sh**脚本将**all-openpai-deployment.yml**文件中值替换为**openpai_config.yml**中配置的值，其中第一个参数为**主节点的IP**，第二个参数为创建的数据目录。

```shell
bash +x replace.sh 10.11.12.13 <HOST_PATH>
```

##### 4.2.5 部署chat服务

替换完成后，直接部署：

```shell
kubectl apply -f all-openpai-deployment.yml
```



#### 4.3 部署LLM-Serving：

##### 4.3.1 准备部署文件

LLM-Serving部署的yaml文件在项目的**deploymnet/k8s/LLM-Serving**目录下，先将其单独拷贝出来放到**主节点**任意目录下。

##### 4.3.2 修改配置文件

根据实际情况修改**llm-serving_config.yml**文件中的值：其中**{{HOST_IP}}**和**{{HOST_PATH}}**通过后面步骤的脚本传递参数整体修改;

如果是**CPU部署LLM-Serving**服务，请先在**llm-serving.yml**中将请求和限制的GPU资源**“nvidia.com/gpu: 1”**注释掉或者删除；

如果是**GPU部署LLM-Serving**服务，请先在**llm-serving.yml**中将环境变量**NVIDIA_VISIBLE_DEVICES及其值**注释掉或者删除。

##### 4.3.3 执行替换脚本

**如下脚本主要用于替换llm-serving.yml中的值，如果不需要或有问题，可以根据实际情况手动指定llm-serving.yml中的部署方式。**

执行**replace-llm-serving-yaml.sh**脚本将**llm-serving.yml**文件中值替换为**llm-serving_config.yml**中配置的值，其中第一个参数为主节点的IP，第二个参数为解压后的LLM-Serving模型**bussiness文件夹**所在位置（**对应节点的路径**）：

```shell
bash +x replace-llm-serving-yaml.sh <HOST_IP> <HOST_PATH>
```

其中<HOST_IP>为主节点IP，<HOST_PATH>为LLM-Serving模型所在对应节点的路径，如：

```shell
bash +x replace-llm-serving-yaml.sh 172.16.0.128 /home/model
```

##### 4.3.4 修改模型部署配置

如果是**CPU部署LLM-Serving**服务，请先执行如下命令：

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

##### 4.3.4 部署LLM-Serving

修改完成后，直接部署：

```shell
kubectl apply -f llm-serving.yml
```





启动后，访问 `http://<宿主机IP>:<宿主机端口>` 🚪 进入登录页面。

### 🔐 登录平台

访问 `http://<宿主机IP>:<宿主机端口>` 进入登录页面。

管理员使用admin账号密码直接登录，登录成功后即可访问平台主页！🎊

普通用户需要管理员创建账号后，再登录使用。🎊


![](doc/images/v1.0/login.png)

---

## 🌟 功能与角色

<table>
  <tr>
    <td align="left" width="15%">角色</td>
    <td align="left" width="20%">角色定位</td>
    <td align="left" width="60%">具体功能</td>
  </tr>
  <tr>
    <td align="left" rowspan="6">系统管理员</td>
    <td align="left" rowspan="6">平台全局的管控者，管理引入到平台的模型服务和数据，负责系统稳定性、安全性、资源分配及权限管理，支撑用户高效使用</td>
    <td align="left">1. 用户管理：创建/删除用户、分配角色权限、重置密码、禁用账号；</td>
  </tr>
  <tr>
    <td align="left">2. 模型管理：接入模型服务商，对模型服务进行管理和推理参数设置；</td>
  </tr>
  <tr>
    <td align="left">3. 智能体审批：审批智能体上线，分配算力/存储资源；</td>
  </tr>
  <tr>
    <td align="left">4. 数据管理：管理全平台的知识库、数据库；</td>
  </tr>
  <tr>
    <td align="left">5. 系统配置：配置平台参数、管理MCP/插件市场；</td>
  </tr>
  <tr>
    <td align="left">6. 运维监控：查看系统日志、监控服务状态。</td>
  </tr>
  <tr>
    <td align="left" rowspan="6">普通用户</td>
    <td align="left" rowspan="6">智能体开发与使用者，聚焦智能体全生命周期管理，完成开发、测试、部署与运维</td>
    <td align="left">1. 智能体创建：基于模板/自定义配置创建智能体、设置基础信息（名称/描述）；</td>
  </tr>
  <tr>
    <td align="left">2. 开发调试：设计 prompt、编排工作流、调用工具/API、进行单轮/多轮测试；</td>
  </tr>
  <tr>
    <td align="left">3. 测试验证：发起性能/功能测试、查看测试报告、优化智能体逻辑；</td>
  </tr>
  <tr>
    <td align="left">4. 部署发布：选择部署环境、发布智能体、管理版本迭代；</td>
  </tr>
  <tr>
    <td align="left">5. 运维管理：监控智能体运行状态、查看调用日志、排查运行故障；</td>
  </tr>
  <tr>
    <td align="left">6. 数据管理：创建知识库、数据库，设置基础信息和配置参数。</td>
  </tr>
</table>



---

## 📖 后续步骤
详细指南（模型配置、插件使用等高级功能）👉 [📚 OpenPAI 使用手册](./doc/用户手册.md)

---

## 🔮 未来规划
- 🛠️ **更丰富模型库**：持续集成更多模型服务。
- 📦 **额外插件生态**：知识库管理、智能搜索等功能增强。
- 🎛️ **精细化权限控制**：提升管理员对模型和用户的管控能力。