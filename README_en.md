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

### 🛠️**manage agents, datas**
- 🔧manage agents, eval-tasks, prompts
- 🖥️manage datas, including knowledge-bases, databases, profession lexicons

---

## 📦 Installation & Deployment

The following **installation and deployment steps** are all **command-line operations** performed on the server. Beginners should proceed with caution.

The overall installation and deployment workflow is:
 **Environment preparation → Pull images → Prepare models → Deployment (deploy database → deploy Chat → deploy LLM-Serving)**.

------

## I. Environment Preparation

This project primarily uses **Kubernetes (K8s)** for deployment. Docker-based deployment will be improved in the future.
 Please prepare at least **one machine** (multi-node setup is recommended).

### Hardware Requirements

- **Recommended configuration**:
  - CPU: 50 cores
  - Memory: 90 GB
  - GPU (NVIDIA): 1 × (≥ 60 GB VRAM)
  - Disk: 170 GB

### Software Requirements

- Operating System: **Ubuntu 22.04.2 LTS**
- Required tools:
  - Docker: 24.0.9
  - Kubernetes: 1.20.5
  - Kubectl: 1.20.5

------

## II. Pull Images

### 2.1 Pull Images on the Master Node

Use the following command to pull images:

```
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/<IMAGE-NAME>:<IMAGE-TAG>
```

Here, `<IMAGE-NAME>:<IMAGE-TAG>` represents the image name and tag.
 The required images are divided into **Chat images** and **LLM-Serving images**.

The **Chat** service requires the following 9 images:

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

The **LLM-Serving** service requires the following image:

```
llm-serving:8.0
```

------

### 2.2 Multi-node Scenario (Skip if Not Applicable)

After pulling images, if you have multiple nodes, you must pull the **apiserver**, **agent-ui**, and **openpaiparser** images on **each node**.

For example, if there is an additional node named `node2`:

```
ssh node2
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/<IMAGE-NAME>:<IMAGE-TAG>
```

Example:

```
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/apiserver:v1.1
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/agent-ui:latest
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpaiparser:v1.0
```

------

## III. Prepare Models

### 3.1 Select the Deployment Node

Plan which node will store the models.
 It is **recommended to choose a node with sufficient CPU and GPU resources**, as it will primarily be used for model deployment.

### 3.2 Pull the Model Image

On the selected node, execute the following command to pull the model image:

```
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpai-rag-model:latest
```

------

### 3.3 Copy Model Files

Copy the model files to any directory on the target node:

```
docker create --name <CONTAINER-NAME> easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpai-rag-model:latest
docker cp <CONTAINER-NAME>:/model/bussiness <HOST_PATH>
docker rm -f <CONTAINER-NAME>
```

Where:

- `<CONTAINER-NAME>` is the container name
- `<HOST_PATH>` is the path on the node used to store the model files

After copying, a **bussiness** directory will appear at the target path, containing the following five compressed files:

```
custom-models.tar.gz
embedding-models.tar.gz
ollama-cache.tar.gz
vl-models.tar.gz
whisper-models.tar.gz
```

------

### 3.4 Extract Model Files

Extract each of the five compressed files:

```
tar -xf <TAR-PACKAGE>
```

Where `<TAR-PACKAGE>` is the name of the compressed file.
 After extraction, five corresponding directories will be created.

------

## IV. Deployment

### 4.1 Deploy the Database

#### 4.1.1 Option 1: Use an Existing Database

If a database already exists on the machine, you can use it directly.
 Execute the following SQL commands in an existing **MySQL / MariaDB** instance to create a user and grant permissions (modify the username and password as needed):

```
create user 'openpaiadmin' identified by 'OPENPAIChat';
flush privileges;
grant all privileges on openpaichat.* to openpaiadmin@'%';
flush privileges;
```

------

#### 4.1.2 Option 2: Start MariaDB Using Docker

If no database is available, it is recommended to pull and run the latest **MariaDB image**.

Example commands (adjust as needed):

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

The Chat deployment YAML files are located in the project directory:
 `deploymnet/k8s/chat`

Clone the project and copy this directory to any path on the **master node**:

```
git clone https://github.com/fastaistack/OpenPAI.git
cp -r OpenPAI/deploymnet/k8s/chat <HOST_PATH>
```

------

#### 4.2.2 Modify Configuration Files

Modify the values in the **openpai_config.yml** file according to your environment.
 The placeholders **{{HOST_IP}}** and **{{HOST_PATH}}** can be ignored.

------

#### 4.2.3 Create Data Directories

On the master node, create the following directories under any path (used for persistent storage and logs):

- `cache` (for logs)
- `mcp_data`
- `es_data` (must have `777` permissions)
- `redis_data`
- `minio_data`

```
cd <HOST_PATH>
mkdir cache && mkdir mcp_data && mkdir es_data && mkdir redis_data && mkdir minio_data
chmod 777 es_data
```

------

#### 4.2.4 Execute the Replacement Script

The following script is used to replace values in `all-openpai-deployment.yml`.
 You may also manually configure the deployment method in `all-openpai-deployment.yml` (ensure the four directories exist and have proper permissions).

Run the **replace.sh** script to replace values in `all-openpai-deployment.yml` with those from `openpai_config.yml`.

- First parameter: **master node IP**
- Second parameter: **data directory path**

```
bash +x replace.sh 10.11.12.13 <HOST_PATH>
```

------

#### 4.2.5 Deploy the Chat Service

After replacement, deploy directly:

```
kubectl apply -f all-openpai-deployment.yml
```

------

### 4.3 Deploy LLM-Serving

#### 4.3.1 Prepare Deployment Files

The LLM-Serving deployment YAML files are located in:
 `deploymnet/k8s/LLM-Serving`

Clone the project and copy this directory to any path on the **master node**:

```
git clone https://github.com/fastaistack/OpenPAI.git
cp -r OpenPAI/deploymnet/k8s/deploymnet/k8s/LLM-Serving <HOST_PATH>
```

------

#### 4.3.2 Modify Configuration Files

Modify the values in **llm-serving_config.yml** according to your environment.
 The placeholders **{{HOST_IP}}** and **{{HOST_PATH}}** can be ignored.

- For **CPU-based LLM-Serving deployment**:
   Comment out or remove the GPU resource requests and limits
   `nvidia.com/gpu: 1` in `llm-serving.yml`.
- For **GPU-based LLM-Serving deployment**:
   Comment out or remove the environment variable `NVIDIA_VISIBLE_DEVICES` and its value in `llm-serving.yml`.

------

#### 4.3.3 Execute the Replacement Script

This script replaces values in `llm-serving.yml`. You may also manually configure it as needed.

Run the **replace-llm-serving-yaml.sh** script:

- First parameter: master node IP
- Second parameter: path to the extracted LLM-Serving model **bussiness** directory (on the target node)

```
bash +x replace-llm-serving-yaml.sh <HOST_IP> <HOST_PATH>
```

Example:

```
bash +x replace-llm-serving-yaml.sh 172.16.0.128 /home/model
```

------

#### 4.3.4 Modify Model Deployment Configuration

- For **CPU-based LLM-Serving**:

```
cp Param-rag-cpu.yaml Param-rag.yaml
```

- For **GPU-based LLM-Serving**:

```
cp Param-rag-gpu.yaml Param-rag.yaml
```

Then modify the paths in `Param-rag.yaml` using the following command, or edit it manually:

```
bash +x replace-rag-param.sh <HOST_PATH>
```

Where `<HOST_PATH>` is the path to the **bussiness** directory of the LLM-Serving model, for example:

```
bash +x replace-rag-param.sh /home/model
```

Copy the modified `Param-rag.yaml` to the **bussiness** directory of the RAG model:

```
cp Param-rag.yaml <HOST_PATH>/bussiness/
```

------

#### 4.3.5 Deploy LLM-Serving

After all modifications are complete, deploy the service:

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


