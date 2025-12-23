# 🚀 OpenPAI - Lightweight Large Model Development Platform

<p align="left">
   <a href="./README.md">🌐 中文</a> | 🌍 English  

🎉 **OpenPAI**  is a lightweight large-model application development platform that can be quickly deployed. It supports local, enterprise server, and public cloud model services, aiming to help users interact with LLMs via a visual web interface and rapidly build LLM-based applications.

>  <font color='red' size=20>todo 替换图片</font>
![](doc/images/v1.0/1.png)

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

### 1. Prerequisites
1. **OpenStation** must be installed and running first.
2. A **Docker** environment is recommended for pulling the OpenPAI image.
3. **Database Credentials** (matching the environment variables you will provide at runtime).

### 2. Pull OpenPAI Docker Image
```bash
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpai:v1.0
```

Check if the image is successfully pulled:
```bash
docker images
```

You should see `easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpai:v1.0` in the list.

### 3. Run OpenPAI Container
```bash
docker run -d --rm \
  --name CONTAINER-NAME \
  --network=openstation \
  -p HOST_PORT:8080 \
  -e OPEN_DB_HOST=DB-HOST \
  -e OPEN_DB_USER=DB-USER \
  -e OPEN_DB_PASSWORD=DB-PASSWORD \
  easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpai:v1.0
```
- **CONTAINER-NAME**: Container name.
- **HOST_PORT**: Port used to access the platform.
- **HOST-IP**: Database IP address.
- **DB-USER** and **DB-PASSWORD**: Database root user credentials for OpenPAI.

Once running, you can open a web browser and navigate to `http://<HOST-IP>:<HOST_PORT>` to access the OpenPAI login page.

### 4. Logging In
Administrator use `admin` to login the system, if login is successful, you will see the OPenPAI homepage.
Standard user need the administrator to create a new accout for the system, after creating successfully, you can login and use the system.

>  <font color='red' size=20>todo 替换图片</font>
![](doc/images/v1.0/2.png)

---

## 🎉 Features & Roles

### Administrator
- **Model**: model server, can add model servers, and model services belongs these server.
- **Resource**: system provides to manage mcp serices.
- **Applications**:  system provides to manage agents, prompts and app eval tasks
- **Operational trace**: system will save the user's operational trace for analysis 
- **Settings**: system manage settings of many business.
- **Users**: add users, delete users, reset password.

### Standard User
- **LLM Conversations**: Chat with integrated large models.
- **Application manage**: manage agents, prompt, app eval tasks
- **Data manage**: manage datas like kowledge-bases, databases, professional lexicon
- **Preference management**: Update personal preference

---

## 📖 Next Steps
For usage details (model configuration, plugin usage, or advanced features), please see **[OpenPAI User Guide](./doc/userguide.md)**.

---

## 🔮 Future Plans
- **Expanded Model Library**: Integration with more model providers.
- **Additional Plugins**: e.g., knowledge base enhancements, external search.
- **Refined Admin Controls**: More granular user and model access management.


