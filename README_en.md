# 🚀 OpenPAI - Lightweight Large Model Development Platform

<p align="left">
   <a href="./README.md">🌐 中文</a> | 🌍 English  

🎉 **OpenPAI**  — the lightweight, easy-to-use yet powerful production-ready AI Agent platform. Access large models and build Agent workflows without complex stacks; develop AI Agent apps efficiently via visual interface. Support flexible integration of local, enterprise & cloud models, drastically cutting development barriers and doubling implementation efficiency.


---

## Key Highlights

✅ Seamless LLM Integration: One-click access to both local and global large language models (LLMs), offering flexible, non-vendor-locked deployment that balances data compliance with the freedom to choose the best-fit model.

✅ Visual Agent Development: Build, debug, and deploy AI agents through an intuitive drag-and-drop interface. Supports both low-code and no-code modes—no complex tech stack or coding expertise required.

✅ Production-Ready Capabilities: Features built-in, precision-tuned RAG tightly integrated with enterprise knowledge bases to ensure accurate, compliant responses. Covers the full lifecycle—from development and testing to deployment and operations—enabling stable, production-grade performance and scalable rollout of core business applications.

✅ Secure & Controllable: Natively supports on-premises/private deployment and includes content security review for all inputs and outputs. Comes standard with enterprise-grade LLMOps for end-to-end monitoring and evaluation, meeting stringent compliance requirements in regulated industries—with robust safeguards for both security and compliance.

✅ Flexible Customization: Fully configurable interface allowing custom titles, logos, and background themes to match your brand and user experience needs.

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

<table>
  <tr>
    <td align="left" width="15%">Role</td>
    <td align="left" width="20%">Role Position</td>
    <td align="left" width="60%">Functions</td>
  </tr>
  <tr>
    <td align="left" rowspan="6">System Administrator</td>
    <td align="left" rowspan="6">Platform-wide controller. Manages model service providers and data introduced to the platform; responsible for system stability, security, resource allocation, and permission management.</td>
    <td align="left">1. User Management: Create/delete users, assign role permissions, reset passwords, disable accounts;</td>
  </tr>
  <tr>
    <td align="left">2. Model Management: Onboard model service providers, manage model services, and configure inference parameters;</td>
  </tr>
  <tr>
    <td align="left">3. Agent Approval: Approve agent launch, allocate computing/storage resources;</td>
  </tr>
  <tr>
    <td align="left">4. Data Management: Manage knowledge bases and databases across the platform;</td>
  </tr>
  <tr>
    <td align="left">5. System Configuration: Configure platform parameters, manage MCP/plugin marketplace;</td>
  </tr>
  <tr>
    <td align="left">6. O&M Monitoring: View system logs, monitor service status.</td>
  </tr>
  <tr>
    <td align="left" rowspan="6">Regular User</td>
    <td align="left" rowspan="6">Agent developer and user. Focuses on the full-lifecycle management of agents, handling development, testing, deployment, and O&M.</td>
    <td align="left">1. Agent Creation: Create agents via template/custom configuration, set basic info (name/description);</td>
  </tr>
  <tr>
    <td align="left">2. Development & Debugging: Design prompts, orchestrate workflows, call tools/APIs, conduct single/multi-turn tests;</td>
  </tr>
  <tr>
    <td align="left">3. Testing & Validation: Initiate performance/functional tests, view test reports, optimize agent logic;</td>
  </tr>
  <tr>
    <td align="left">4. Deployment & Release: Select deployment environments, release agents, manage version iterations;</td>
  </tr>
  <tr>
    <td align="left">5. O&M Management: Monitor agent operation status, view call logs, troubleshoot operational faults;</td>
  </tr>
  <tr>
    <td align="left">6. Data Management: Create knowledge bases/databases, set basic info and configuration parameters.</td>
  </tr>
</table>

---

## 📖 Next Steps
For usage details (model configuration, plugin usage, or advanced features), please see **[OpenPAI User Guide](./doc/userguide.md)**.

---

## 🔮 Future Plans
- **Expanded Model Library**: Integration with more model providers.
- **Additional Plugins**: e.g., knowledge base enhancements, external search.
- **Refined Admin Controls**: More granular user and model access management.


