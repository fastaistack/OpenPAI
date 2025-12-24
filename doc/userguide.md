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

#### 1.2.1 Model Provider

#### 1.2.2 Model Service

### 1.3 MCP


### 1.4 APP

#### 1.4.1 Agent Manage

#### 1.4.2 Approval Manage


#### 1.4.3 Prompt

#### 1.4.4 App Eval

### 1.5 Data

#### 1.5.1 KBase

#### 1.5.2 DataBase

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
