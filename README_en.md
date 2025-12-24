# 🚀 OpenPAI - Lightweight Large Model Development Platform

<p align="left">
   <a href="./README.md">🌐 中文</a> | 🌍 English  

🎉 **OpenPAI**  is a lightweight large-model application development platform that can be quickly deployed. It supports local, enterprise server, and public cloud model services, aiming to help users interact with LLMs via a visual web interface and rapidly build LLM-based applications.

---

## Key Highlights

### 📺 **Custom Configuration**
- 💻 **title**: Web browser title
- 🏢 **logo**: specify logo
- ☁️ **background**: specify background

### 🚀 **Seamless Model Integration**
- **Local Deployment**: Easily connect to local models for on-premise usage.
- **Enterprise Servers**: Integrate with models deployed on internal corporate servers.
- **Public Cloud Services**: Connect to external cloud-based model services (e.g., OpenStation, 3rd-party providers).

### 🏗 **Rapid Setup & Deployment**
- **Quick Installation**: Get started with minimal configuration.
- **Visual Web Interface**: Interact with large models via a friendly UI.
- **Scalable Architecture**: Supports integration of multiple model providers.

### 🎯 **Multiple Roles**
- **Administrator**: Access advanced settings, manage users, model connections, agents, resourcesand datas.
- **Standard User**: Engage in LLM conversations, adjust user preferences, and manage personal agents and datas.

### 🌐 **Connect to Various Model Sources**
- Integrate with **OpenStation**-deployed model services.
- Import 3rd-party model endpoints.
- Refresh or disable certain model connections as needed.


### 🛠️**manage agents, datas**
- 🔧manage agents, eval-tasks, prompts
- 🖥️manage datas, including knowledge-bases, databases, profession lexicons

---

## 📦 Installation & Deployment

This project is primarily deployed using **Kubernetes (K8s)**. Please make sure you have a Kubernetes cluster set up on your machine first. Docker-based deployment will be improved and completed in later versions.

------

### Environment

```
1. Operating System: Ubuntu
2. Deployment:       Kubernetes
3. Python Version:   3.10.14
```

------

### 1. Images

Pull images using the following command:

```shell
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/<IMAGE-NAME>:<IMAGE-TAG>
```

Where `<IMAGE-NAME>:<IMAGE-TAG>` represents the image name and tag.

There are two categories of images to pull: **Chat images** and **LLM-Serving images**.

#### Chat Images (9 images required)

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

#### LLM-Serving Image (1 image required)

```
llm-serving:8.0
```

After pulling all images, **if your cluster has multiple nodes**, you must pull the following images on **each node**:

- `apiserver`
- `agent-ui`
- `openpaiparser`

For example, if you have a secondary node named `node2`:

```shell
ssh node2
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/<IMAGE-NAME>:<IMAGE-TAG>
```

Example commands when using Harbor (modify as needed):

```shell
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/apiserver:v1.1
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/agent-ui:latest
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpaiparser:v1.0
```

------

### 2. Models

First, decide which node will store the model files
(**it is recommended to choose a node with sufficient CPU and GPU resources, as it will be used to deploy models**).

On the selected node, perform the following steps:

#### Pull the Model Image

```shell
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpai-rag-model:latest
```

#### Copy Model Files to the Host

```shell
docker create --name <CONTAINER-NAME> easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpai-rag-model:latest
docker cp <CONTAINER-NAME>:/model/bussiness <HOST_PATH>
docker rm -f <CONTAINER-NAME>
```

Where:

- `<CONTAINER-NAME>`: temporary container name
- `<HOST_PATH>`: any directory path on the node for storing model files

After copying, a **`bussiness`** directory will appear at `<HOST_PATH>`, containing five compressed files:

```
custom-models.tar.gz
embedding-models.tar.gz
ollama-cache.tar.gz
vl-models.tar.gz
whisper-models.tar.gz
```

#### Extract All Model Packages

```shell
tar -xf <TAR-PACKAGE>
```

Where `<TAR-PACKAGE>` is one of the files listed above.
After extraction, five corresponding directories will be created.

------

### 3. Deployment

### Database Deployment

If a database already exists on the machine, you can continue using it. Run the following commands in the database to create a user and grant privileges. You may modify the username and password according to your actual needs:

```mysql
create user 'openpaiadmin' identified by 'OPENPAIChat';
flush privileges;
grant all privileges on openpaichat.* to openpaiadmin@'%';
flush privileges;
```

If no database is available, it is recommended to directly pull the latest **MariaDB image**. Below is an example of how to pull and start it (adjust as needed):

```shell
docker pull mariadb:latest
docker run -d \
  --name mariadb \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=OPENPAIChat \
  -v /home/mariadb-data:/var/lib/mysql \
  mariadb:latest
```


#### Chat Deployment

The Chat deployment YAML files are located in:

```
deploymnet/k8s/chat
```

Copy this directory to **any location on the master node**, then `cd` into that directory.

##### Step 1: Modify Configuration

Edit `openpai_config.yml` according to your environment.

- `{{HOST_IP}}` and `{{HOST_PATH}}` will be automatically replaced by scripts in later steps.

##### Step 2: Replace the Main Deployment YAML

The script below is used to replace values in `all-openpai-deployment.yml`.

> If you do not want to use the script or encounter issues, you may manually configure `all-openpai-deployment.yml`.
> Make sure the required directories exist and have proper permissions.

Run the `replace.sh` script:

```shell
bash +x replace.sh 10.11.12.13 <HOST_PATH>
```

Where:

- First parameter: **Master node IP**
- Second parameter: **Any directory on the master node** used for persistent storage and logs

The following directories must exist under `<HOST_PATH>`:

- `cache` (log storage)
- `mcp_data`
- `es_data` (must grant permission: `chmod 777 <HOST_PATH>/es_data`)
- `redis_data`
- `minio_data`

##### Step 3: Deploy Chat Services

```shell
kubectl apply -f all-openpai-deployment.yml
```

------

#### LLM-Serving Deployment

The LLM-Serving YAML files are located in:

```
deploymnet/k8s/LLM-Serving
```

Copy this directory to **any location on the master node**.

##### Step 1: Modify Configuration

Edit `llm-serving_config.yml` according to your environment.

- `{{HOST_IP}}` and `{{HOST_PATH}}` will be replaced by scripts.

##### Step 2: Modify the Main LLM-Serving YAML

- **CPU Deployment**
  Comment out or remove GPU resource requests in `llm-serving.yml`:

  ```
  nvidia.com/gpu: 1
  ```

- **GPU Deployment**
  Comment out or remove the environment variable:

  ```
  NVIDIA_VISIBLE_DEVICES
  ```

You can use the script below to replace values automatically:

```shell
bash +x replace-llm-serving-yaml.sh <HOST_IP> <HOST_PATH>
```

Where:

- `<HOST_IP>`: Master node IP
- `<HOST_PATH>`: Path where the extracted **bussiness** directory is located

Example:

```shell
bash +x replace-llm-serving-yaml.sh 172.16.0.128 /home/model
```

##### Step 3: Configure RAG Parameters

- **CPU Deployment**

```shell
cp Param-rag-cpu.yaml Param-rag.yaml
```

- **GPU Deployment**

```shell
cp Param-rag-gpu.yaml Param-rag.yaml
```

Then update paths in `Param-rag.yaml` using:

```shell
bash +x replace-rag-param.sh <HOST_PATH>
```

Example:

```shell
bash +x replace-rag-param.sh /home/model
```

Copy the modified file into the `bussiness` directory:

```shell
cp Param-rag.yaml <HOST_PATH>/bussiness/
```

##### Step 4: Deploy LLM-Serving

```shell
kubectl apply -f llm-serving.yml
```



### 4. Logging In
Administrator use `admin` to login the system, if login is successful, you will see the OpenPAI homepage.
Standard user need the administrator to create a new accout for the system, after creating successfully, you can login and use the system.


![](doc/images/v1.0/login.png)

---

## 🎉 Features & Roles

### Administrator
- **Model**: model server, can add model servers, and model services belongs these server.
- **Resource**: system provides to manage mcp serices.
- **Applications**:  system provides to manage agents, prompts and app eval tasks
- **Operational Trace**: system will save the user's operational trace for analysis 
- **Settings**: system manage settings of many business.
- **Users**: add users, delete users, reset password.

### Standard User
- **LLM Conversations**: Chat with integrated large models.
- **Application Manage**: manage agents, prompt, eval tasks
- **Data Manage**: manage datas like kowledge-bases, databases, professional lexicon
- **Preference Manage**: Update personal preference

---

## 📖 Next Steps
For usage details (model configuration, plugin usage, or advanced features), please see **[OpenPAI User Guide](./doc/userguide.md)**.

---

## 🔮 Future Plans
- **Expanded Model Library**: Integration with more model providers.
- **Additional Plugins**: e.g., knowledge base enhancements, external search.
- **Refined Admin Controls**: More granular user and model access management.


