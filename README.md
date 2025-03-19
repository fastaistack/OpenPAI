# 🚀 OpenPAI - 轻量级大模型开发平台

<p align="left">
  🌐 中文 | <a href="./README_en.md">🌍 English</a>  

🎉 **OpenPAI** 是一个轻量、强大且易用的大模型应用开发平台，帮助用户快速部署和交互大模型。平台支持本地、企业服务器及云端模型服务，并提供直观、友好的网页界面，让你轻松构建 AI 应用！✨

![](doc/images/v1.0/1.png)

---

## 🌟 功能亮点

### 📺 **软件灵活配置**
- 💻 **定制标题**：支持自定义软件标题。
- 🏢 **定制logo**：支持自定义软件logo。
- ☁️ **定制背景**：支持自定义软件背景。

### 🌌 **无缝模型整合**
- 💻 **本地部署**：轻松连接并使用本地大模型。
- 🏢 **企业服务器**：灵活整合企业内部部署模型。
- ☁️ **公有云服务**：快速连接外部云模型服务（如 OpenStation 等）。

### ⚡ **快速安装与部署**
- 🚨 **快速上手**：极简安装，即开即用。
- 🖥️ **可视化界面**：友好的操作体验，极易上手。
- 🔧 **扩展性强**：支持多个模型来源，灵活扩展。

### 🔗 **OpenStation 无缝集成**
🔑 OpenPAI V1.0 与 **OpenStation** 深度整合，共享统一账号体系，无需额外注册即可快速登录。

### 👥 **多角色管理**
- 🛠️ **管理员**：全面控制平台设置，管理用户与模型。
- 👤 **普通用户**：随时体验模型对话，管理个人账户与偏好。

### 🌐 **多源模型接入**
- 📡 接入部署于 **OpenStation** 的模型服务。
- 🌍 引入第三方外部模型。
- 🔄 自由刷新、启用或禁用模型连接。

---

## 📦 安装与部署

### 📌 前提条件
1. 🔖 已安装并运行 **OpenStation**。
2. 🐳 推荐使用 **Docker** 快速部署 OpenPAI。
3. 🔑 准备数据库凭证（运行时需提供对应环境变量）。

### 📥 拉取 Docker 镜像
```bash
docker pull easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpai:v1.0
```

检查是否成功：
```bash
docker images
```

镜像列表显示为 `easyds-registry.cn-beijing.cr.aliyuncs.com/faststack/openpai:v1.0` 即成功 🎯。

### 🚀 运行容器

```bash
docker run -d --rm \
  --name CONTAINER-NAME \
  --network=openstation \
  -p HOST_PORT:8080 \
  -e OPEN_DB_HOST=DB-HOST \
  -e OPEN_DB_USER=DB-USER \
  -e OPEN_DB_PASSWORD=DB-PASSWORD \
  IMAGE-NAME:IMAGE-TAG
```

- 📌 **CONTAINER-NAME**：自定义容器名称。
- 🌐 **HOST_PORT**：宿主机访问平台的端口。
- 🖥️ **DB-HOST**：数据库IP地址。
- 👤 **DB-USER**：openpai平台数据库用户。
- 🔑 **DB-PASSWORD**：openpai平台数据库用户密码。
- 📦 **IMAGE-NAME:IMAGE-TAG**：镜像名称及其标签（一般为 `openpai:v1.0`）。

请根据实际情况修改上述参数内容。



启动后，访问 `http://<宿主机IP>:<宿主机端口>` 🚪 进入登录页面。

### 🔐 登录平台
使用 OpenStation 账号密码直接登录，登录成功后即可访问平台主页！🎊

![](doc/images/v1.0/2.png)

---

## 🌟 功能与角色

### 🔧 管理员
- ⚙️ **平台设置**：用户管理、模型管理、全局参数。
- 💬 **体验大模型**：直接测试接入模型的对话功能。

### 🗣️ 普通用户
- 🤖 **模型对话**：实时与各种接入的大模型互动。
- 🔒 **账号管理**：轻松修改个人信息及密码。

---

## 📖 后续步骤
详细指南（模型配置、插件使用等高级功能）👉 [📚 OpenPAI 使用手册](./doc/用户手册.md)

---

## 🔮 未来规划
- 🎍 **独立账户体系**：独立支持账户管理。
- 🛠️ **更丰富模型库**：持续集成更多模型服务。
- 📦 **额外插件生态**：知识库管理、智能搜索等功能增强。
- 🎛️ **精细化权限控制**：提升管理员对模型和用户的管控能力。