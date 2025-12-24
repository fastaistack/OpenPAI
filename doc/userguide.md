<a href="../README_en.md">Back</a>  

# OpenPAI User Guide

---

This user manual is intended for administrators and standard users to help understand and proficiently operate various features provided by OpenPAI. This manual assumes you have successfully installed and launched OpenPAI.

![](../doc/images/v1.0/login.png)

After the platform is successfully installed and deployed, enter the platform access address in the browser to open the platform login page. After entering the correct username and password, you can access the OpenPAI homepage and experience and use the various functions of OpenPAI.

## 1. Administrator Functions

Administrators have advanced management permissions, able to configure users, models, and global parameters in the "Settings" section, and manage applications, datas, and so on.

### 1.1 Platform Home Page
After successful login, the **OpenPAI** homepage is displayed. Administrators can click the left or top menu to access core modules like "Model Service", "MCP", "APP", "Data", "System", etc.

### 1.2 Model Service

On the homepage, you can click the **`Model Service`** submenu under **「Model Service」** to enter the model service management module.

Administrators can introduce their own service providers by clicking "Add Model Service Provider". The model addition feature includes multiple built-in templates. Users can select a template and fill in the API-KEY for quick addition, or manually enter the service provider name, API-KEY, and service URL.

![](../doc/images/v1.0/admin/modelprovideradd.png)

If the URL is accessible and supports obtaining the model list via the OpenAI protocol, the corresponding model services will be automatically added to the platform during the addition process; if not, the corresponding model service list will be empty. If the URL does not support obtaining the model list, users can manually add model services under the corresponding model service provider using the add function, which requires filling in the correct model name and URL.

Administrators can modify the parameters of added model service providers through the settings function. After saving, the system will re-obtain the model service list via the URL. Users can also delete the corresponding model service providers through the settings > remove function. The service synchronization function is used to obtain the latest model service list from the service provider. If a model service saved on the platform is not in the service provider's new model service list, it will be removed from the platform's list; if there are new model services in the service provider's new list, they will be added to the platform. After a model is added to the platform, administrators can configure its sharing scope through the sharing function, setting it to be visible to all users or only to specific users. When set to be visible to specific users, only those within the sharing scope can use the corresponding model for conversations.

### 1.3 MCP
On the homepage, you can click the `MCP` submenu under **「MCP」** to enter the MCP management module. The MCP module is divided into two parts: `MCP Manager` and `MCP Resource`, corresponding to the lifecycle management of MCP severs and resource recommendations, site navigation, and other functions.

#### 1.3.1 MCP Manager
The MCP Manager module includes operations such as Create, Check, Edit, Start/Stop, and Delete. Administrators can use this module to maintain and manage all MCP servers provided to users.
![](../doc/images/v1.0/admin/mcp_list_en.png)

Click "Create" to add a MCP server, filling in the parameters of the MCP, or pasting JSON configuration for one-click entry.
![](../doc/images/v1.0/admin/mcp_add_en.png)
Click "Confirm", and the system will automatically validate the parameters and attempt to initialize the MCP server. After successful initialization, the server status will display as "Normal" and the tool list will be automatically retrieved; if it fails, you can modify the parameters and resubmit.

Click the "Check" button to view the basic configuration information of the MCP server, including server name, server description, keywords, and tool list.
![](../doc/images/v1.0/admin/mcp_detail_en.png)

Click the "Stop" or "Start" button to switch the running status of the MCP server (Normal/Stop). After an MCP is stopped, users cannot select it in the chat interface.

#### 1.3.2 MCP Resource
MCP Resource provides administrators with MCP resource acquisition and site navigation functions, mainly including `MCP Recommend` and `MCP Site`.
The MCP Recommend page centrally displays MCPs curated and recommended by the platform. These recommended resources feature high availability, rich tool capabilities, and strong community support, making them suitable for new users to quickly get started.
![](../doc/images/v1.0/admin/mcp_recom_en.png)

For MCPs that support "one-click installation", an "Install" button will be displayed on the card; users can click the "Install" button for one-click installation. If the installation is successful, it will prompt "Installation Successful", otherwise it will prompt "Installation Failed"; users can "Uninstall" already installed MCPs. Successfully installed MCPs can be viewed in the MCP management list.

For recommended MCPs that do not support "one-click installation", users need to obtain API KEY, ACCESS TOKEN, or other information from the respective MCP documentation as instructed, and manually add them through the "Create" interface on the MCP management page.

The MCP Site page aggregates commonly used MCP resource platforms, server repositories, official documentation sites, etc., facilitating administrators to quickly access, search for, and configure required MCPs and related resources.
![](../doc/images/v1.0/admin/mcp_site_en.png)

Note: Recommended MCPs and site resources are for reference only. It is recommended that administrators verify their availability and security before actual use.


### 1.4 APP

#### 1.4.1 Agent Manage

#### 1.4.2 Approval Manage


#### 1.4.3 Prompt

#### 1.4.4 App Eval

### 1.5 Data

#### 1.5.1 KBase

#### 1.5.2 DataBase

Administrators can access the database connection management page through the database module. The database connection management interface displays a list of database connections created by users, showing details including connection name, database type, database name, server address, port, number of tables, creator, sharing scope, and connection time. Users can filter database connections by connection type, connection name, and creator.

When the number of tables in a user's database changes, administrators can use the refresh function to update the table count for the corresponding database connection. Administrators can share database connections with other users, specifying either all users or specific users/groups. Shared connections will be visible and available for database conversations in the connection list of the target users or groups.

The transfer function allows administrators to transfer a specified database connection to another user. The target user list during transfer displays all users in the system. After the transfer, the creator of the database connection will be updated to the new user.

![](../doc/images/v1.0/admin/database.png)

#### 1.5.3 Professional Lexicon


### 1.6 System

System Menu includes `Log Management`, `System Setting`, `User Management`.

#### 1.6.1 Log Management

After logging in, the administrator clicks **“Log Management”** on the left side of the page to enter this module.
The log list displays the following information: Operator, Module, Target, Operation type, Result, Feedback, Operation time, and Operations. The Operations include the data before and after the operation.

The administrator can perform combined queries based on criteria such as module, operation type, result, start time, end time, and operator. They can also click **“Reset”** to display the default results. In addition, the administrator can sort the following fields individually: module, operation type, result, and operation time.

The administrator can export the query results based on the selected conditions, with a maximum of 1,000 records per export. The exported file is in **.csv** format.

#### 1.6.2 System Setting
System settings include two tabs: business configuration and page configuration. Business configuration mainly involves basic business settings for various business modules in the system, aiming to better allocate system resources and utilize system capabilities effectively.

##### Business Config

##### Page Config
Page configuration primarily involves flexible configuration of the system to meet the personalized needs of various systems. It mainly involves configuring the browser title name, product logo, homepage logo, etc., which can be modified or reset.
![](../doc/images/v1.0/admin/web_config_en.png)

#### 1.6.3 User Management


---

## 2. Standard User Functions

After successfully logging in as a Standard user, you can view an overview of the intelligent agents, engage in dialog interactions, and manage intelligent agents and prompt within the system. Additionally, you can evaluate various applications and manage various data, primarily including knowledge bases, databases, and professional lexicon. Regarding system usage, users can configure system settings to meet their personal preferences.

### 2.1 Home


### 2.2 Chats

 **「Chats」** module user can experience interaction between large models, intelligent agents, and databases. Users can choose to have conversations with large models, intelligent agents, databases, and manage conversation information.

![](../doc/images/v1.0/user/chat_en.png)

#### 2.1.1 New Chat

Click **「New Chat」**, the system will open a new chat window. Users can:
- Quickly enter chat mode

Open the page for creating a new chat, where users can see the object you want to interact with, such as a model, intelligent agent, or a database. If there is no intelligent agent, you can create one under the Agent module; If no database has been selected or created, database information can be created in advance under the Database module.

- Browse basic information of interactive objects

For different interaction objects, different information is displayed. If conversing with a large model, the model information is displayed and the model parameters can be modified; If conversing with an intelligent agent, display the agent's information; Similar database chat, displaying database connection information for users to choose from.

![](../doc/images/v1.0/user/chat_agent_en.png)


![](../doc/images/v1.0/user/chat_db_en.png)


- Diversified chat and interaction to obtain results

Users can send questions and wait for the system to reply, and the reply content will be streamed out. The system supports uploading files, audio, and images in multiple formats and reply answers for them.

![](../doc/images/v1.0/user/chat_multi_en.png)

- Set interaction details to achieve precise and customized interactions

Users can change model parameters and select tools (such as sensitive filter, web search, knowledge base, MCP , etc.) for more detailed and accurate responses.

![](../doc/images/v1.0/user/chat_tool_en.png)


#### 2.1.2 chat management

- The system supports operations such as adding, deleting, modifying, and querying chat, changing names, and deleting chat
- Copy chat, for a certain chat, you can copy a new chat that contains all the configuration information of the current chat, without including the interaction history
- Export chat records. For chat interaction history, it can be exported as a markdown format file to the local device


![](../doc/images/v1.0/user/chat_manage_en.png)

#### 2.1.3 chat content management

- Copy content: Users can quickly copy questions or answers
- Reference content: You can reference the previous content and continue to chat
- Regenerate the chat, users can regenerate the question of any chat
- Delete question-answer pairs: Users can delete multiple question-answer pairs and no longer display them
- Collection: Collect question-answer to Knowledge Base Module
- User evaluation answer quality: Support users to evaluate the answer results, like or dislike them

![](../doc/images/v1.0/user/chat_content_manage1_cn.png)


![](../doc/images/v1.0/user/chat_content_manage_en.png)

#### 2.1.4 MCP
Click the "Clieck to Add MCP Service" button to display all currently available MCP servers and add them to the chat. Click the "Check" button to view the tools, resources, and prompt list of the MCP server.
![](../doc/images/v1.0/user/mcp_select_en.png)

After completing the selection, engage in conversation. The model will selectively invoke tools based on the tool information and return the answers.
![](../doc/images/v1.0/user/mcp_use_en.png)
![](../doc/images/v1.0/user/mcp_use_en_2.png)

### 2.3 Agent Management

#### 2.3.1 Agent

#### 2.3.2 Worflow

#### 2.3.3 Tool

Tab tool shows user's tool list used in agent or workflow.

![](../doc/images/v1.0/user/tool-list-en.jpg)

User can:

- add tool (BY **API**)
- delete tool
- edit tool

### 2.4 Prompt Management

### 2.5 App Eval Management

### 2.6 KBase Management

### 2.7 Database Management

The database connection management interface allows users to view the list of database connections created by themselves or shared by others. The list displays details including connection name, database type, database name, server address, port, creator, sharing scope, and connection time. Users can filter database connections by the criteria of Only Me, connection type, connection name, and creator.

![](../doc/images/v1.0/user/databaselist.png)

Users can add a database connection via the **Create Database Connection** function. They need to select the database type (supported types include MySQL, PostgreSQL, MariaDB, SQL Server, Oracle, and Dameng), and fill in the connection name, server address, port, username, password, and database name. After confirmation, the system will perform a connection test using the selected database type and the entered server address, port, username, password, and database name. If the database connection fails, the creation will be aborted; if the connection succeeds, the creation will be completed. Once created, the platform will automatically retrieve the table information of the database. Users can view the newly created database connection by refreshing the list.

![](../doc/images/v1.0/user/databasecreate.png)

When the number of tables in a user's database changes, the user can use the refresh function to update the table count for the corresponding database connection. The creator of a database connection can share the connection with other users, and can specify to share it with all users or specific users. For specific users, the connection can be shared with designated users or user groups. The shared users can view the connection in their connection list and use it for database conversations. The transfer function is used to transfer a specified database connection to another user. During the transfer, the target user list displays all users. After the transfer, the creator of the database connection will be updated to the new user.

The data in the AI Learning Respositiry is used to provide prompts for large models during conversations, which can improve the accuracy of the models' responses. Users can view the learning respositiry data corresponding to the database and add their own learning data through the add function.

AI Learning The data in the AI Learning Respositiry data is divided into three types: SQL QS, Terminology, DDL .SQL QS includes question descriptions and their corresponding SQL answers.Terminology refers to descriptive language that characterizes the database, where users can fill in information related to the database structure, usage scenarios, and more.DDL  consists of SQL statements for creating or modifying data tables in the database. When a database is added, the system automatically reads the table creation statements in the database and adds them to the learning library. Users can  delete, or add to this part of the data.

### 2.8 Professional Lexicon Management

### 2.4 Prompt Management

### 2.9 Preferences Management

Users can set the system language, with options currently supporting Chinese and English; it also supports the display of system themes, such as light/dark mode, etc. The use of the system requires compliance with the user agreement, which can be viewed here.

![](../doc/images/v1.0/user/preference_user_en.png)

---

### 3. FAQ and Support
Resolve common issues like login problems, unavailable models, and web search errors. For technical support, contact administrators.

### 4. Version Updates
Upcoming enhancements include increased model support, a richer plugin ecosystem, and enhanced user interactions.

---

## OpenPAI: Simplifying and accelerating LLM application development!
