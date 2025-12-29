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

This project is mainly deployed using **Kubernetes (K8s)**. Please deploy a Kubernetes cluster on your machines first. A Docker-only deployment method will be improved and provided later.

The overall installation and deployment workflow is as follows:
 **Environment Preparation → Pull Images → Prepare Models → Deployment (Database → Chat → LLM-Serving)**

------

## I. Environment Preparation

```
1. Operating System:  Ubuntu
2. Deployment:        Kubernetes
```

Please prepare at least **one machine** (multi-node setups are recommended) with the following components installed and working properly:

- Docker
- kubectl
- A Kubernetes cluster (K8s)

------

## II. Pull Images

### 2.1 Pull Images on the Master Node

Use the following command to pull images:

```
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/<IMAGE-NAME>:<IMAGE-TAG>
```

Where `<IMAGE-NAME>:<IMAGE-TAG>` represents the image name and tag.

The required images are divided into **Chat images** and **LLM-Serving images**, listed as follows.

#### Chat Images (9 images required):

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

#### LLM-Serving Image (1 image required):

```
llm-serving:8.0
```

------

### 2.2 Multi-Node Scenario (Skip if Single Node)

After pulling the images, if your cluster has multiple nodes, you must pull the **apiserver**, **agent-ui**, and **openpaiparser** images on **each node**.

For example, if there is another node named `node2`:

```
ssh node2
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/<IMAGE-NAME>:<IMAGE-TAG>
```

Example commands (adjust according to your environment, e.g. when using Harbor):

```
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/apiserver:v1.1
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/agent-ui:latest
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpaiparser:v1.0
```

------

## III. Prepare Models

### 3.1 Choose the Deployment Node

Plan which node will store and serve the models.
 It is **recommended to choose a node with sufficient CPU and GPU resources**, as this node will be used to deploy the models.

------

### 3.2 Pull the Model Image

Run the following command on the selected node:

```
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpai-rag-model:latest
```

------

### 3.3 Copy Model Files

Copy the model files to any directory on the selected node:

```
docker create --name <CONTAINER-NAME> easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpai-rag-model:latest
docker cp <CONTAINER-NAME>:/model/bussiness <HOST_PATH>
docker rm -f <CONTAINER-NAME>
```

- `<CONTAINER-NAME>`: temporary container name
- `<HOST_PATH>`: target path on the node used to store model files

After copying, a **bussiness** directory will appear under `<HOST_PATH>`.
 Inside this directory, there will be five compressed files:

```
custom-models.tar.gz
embedding-models.tar.gz
ollama-cache.tar.gz
vl-models.tar.gz
whisper-models.tar.gz
```

------

### 3.4 Extract Model Files

Extract each compressed package:

```
tar -xf <TAR-PACKAGE>
```

Where `<TAR-PACKAGE>` is the name of each archive file.
 After extraction, five corresponding directories will be created.

------

## IV. Deployment

### 4.1 Deploy the Database

#### 4.1.1 Option 1: Use an Existing Database

If a database already exists, you can use it directly.
 Execute the following SQL commands in your existing **MySQL / MariaDB** instance to create a user and grant permissions (adjust username and password as needed):

```
create user 'openpaiadmin' identified by 'OPENPAIChat';
flush privileges;
grant all privileges on openpaichat.* to openpaiadmin@'%';
flush privileges;
```

------

#### 4.1.2 Option 2: Start MariaDB Using Docker

If no database is available, it is recommended to pull and run the latest **MariaDB** image:

```
docker pull mariadb:latest
docker run -d \
  --name mariadb \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=OPENPAIChat \
  -v /home/mariadb-data:/var/lib/mysql \
  mariadb:latest
```

------

### 4.2 Deploy Chat

#### 4.2.1 Prepare Deployment Files

The Chat deployment YAML files are located in the **deploymnet/k8s/chat** directory of the project.

Copy this directory to any location on the **master node**, then change into that directory to continue.

------

#### 4.2.2 Modify Configuration File

Edit the **openpai_config.yml** file according to your environment.
 The values **{{HOST_IP}}** and **{{HOST_PATH}}** will be automatically replaced by a script in later steps.

------

#### 4.2.3 Create Data Directories

On the master node, choose any path for persistent storage and logs, and create the following directories:

- `cache` (for logs)
- `mcp_data`
- `es_data` (set permissions to 777: `chmod 777 HOST_PATH/es_data`)
- `redis_data`
- `minio_data`

------

#### 4.2.4 Run the Replacement Script

> The following script is used to replace values in `all-openpai-deployment.yml`.
>  If you prefer, you may manually configure the deployment file instead (ensure all directories exist and have proper permissions).

Run the **replace.sh** script.

- First parameter: master node IP
- Second parameter: data directory path

```
bash +x replace.sh 10.11.12.13 <HOST_PATH>
```

------

#### 4.2.5 Deploy the Chat Service

After replacement, deploy the Chat service:

```
kubectl apply -f all-openpai-deployment.yml
```

------

### 4.3 Deploy LLM-Serving

#### 4.3.1 Prepare Deployment Files

The LLM-Serving deployment YAML files are located in **deploymnet/k8s/LLM-Serving**.
 Copy this directory to any location on the **master node**.

------

#### 4.3.2 Modify Configuration File

Edit **llm-serving_config.yml** according to your environment.
 The values **{{HOST_IP}}** and **{{HOST_PATH}}** will be replaced by a script later.

- **CPU deployment**:
   Comment out or remove the GPU resource request/limit

  ```
  nvidia.com/gpu: 1
  ```

- **GPU deployment**:
   Comment out or remove the environment variable

  ```
  NVIDIA_VISIBLE_DEVICES
  ```

------

#### 4.3.3 Run the Replacement Script

> This script replaces values in `llm-serving.yml`.
>  If not needed, you may manually configure the file instead.

Run the script with:

- First parameter: master node IP
- Second parameter: path to the extracted **bussiness** model directory

```
bash +x replace-llm-serving-yaml.sh <HOST_IP> <HOST_PATH>
```

Example:

```
bash +x replace-llm-serving-yaml.sh 172.16.0.128 /home/model
```

------

#### 4.3.4 Modify Model Deployment Configuration

- **CPU deployment**:

```
cp Param-rag-cpu.yaml Param-rag.yaml
```

- **GPU deployment**:

```
cp Param-rag-gpu.yaml Param-rag.yaml
```

Then update the paths in `Param-rag.yaml` (or edit manually):

```
bash +x replace-rag-param.sh <HOST_PATH>
```

Example:

```
bash +x replace-rag-param.sh /home/model
```

Copy the updated file into the model directory:

```
cp Param-rag.yaml <HOST_PATH>/bussiness/
```

------

#### 4.3.5 Deploy LLM-Serving

After completing the configuration, deploy the service:

```
kubectl apply -f llm-serving.yml
```

### 5. Logging In
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


