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

### 2.3 Agent Management

#### 2.3.1 Agent
- Agent query, display information includes: icon, name, only yourself/some users/all members, status, label, description information, creator name, creation time;![1.png](../doc/images/v1.0/agent/1.png)
- Agent creation, you can create blank agents and create based on templates;![2.png](../doc/images/v1.0/agent/2.png)
- Agent editing, you can modify the name, icon, label, and description information;
- Agent copying, copying based on existing agents;
- Agent deletion, delete existing agents;
- Agent configuration, the agent supports two configuration methods: general mode and workflow mode, 
- The configuration information of the general mode includes: model (select the model and configure the corresponding model parameters); Prompt (input the prompt word of the agent; the prompt word can be obtained from the built-in prompt word library, select it; MCP service (select the MCP service that the agent can call); tool (select the intelligent agent) Tools that can be called by the agent, and configure the corresponding tool parameters, currently supporting official tools and custom tools); knowledge base (select the knowledge base that the agent can call, and configure the corresponding parameters, the knowledge base supports multiple selections); database (select the database that the agent can call, and configure the corresponding parameters); Opening remarks and opening guide questions (after turning on the switch, the user can set an opening statement for the agent, as well as several guiding questions that he is concerned about. A maximum of 3 guiding questions can be set, and each guiding question supports a maximum length of 100 characters); Recommended questions (after turning on the switch, the agent will output up to 3 recommended questions after the conversation); ![3.png](../doc/images/v1.0/agent/3.png) 
- The agent configuration information of workflow mode includes: workflow (only supports adding one workflow); opening remarks and opening guide questions (after turning on the switch, the user can set an opening statement for the agent, as well as several guiding questions of his own concern. A maximum of 3 guiding questions can be set); recommended questions (after turning on the switch, the agent will output up to 3 recommended questions after the conversation); ![4.png](../doc/images/v1.0/agent/4.png)
- Agent preview and debugging, viewing the effect of agent dialogue based on existing configurations; tool invocation will display tool invocation status and time consumption;
- Agent release: Release the debugged agent into a callable service. After release, it will enter the approval process. Publishing supports domain name mode and IP port number mode. In the domain name mode, you need to fill in the API address name and resource configuration (CPU, memory, and number of copies); in IP port number mode, the address is automatically generated, and the resource configuration (CPU, memory, and number of copies) can be modified manually. For published agents, there will be an "API Call" button on the details page. Click this button to view the call information. Click the "Create API KEY" button to manage user access credentials, including creation, editing, disabling, and deletion. ![5.png](../doc/images/v1.0/agent/5.png)
- Agent API document. For a published agent, you can view the API document of the agent on the details page;
- Agent sharing, users can share the created and published agents. The default sharing scope is only yourself. You can select some users or all users. When selecting some users, you can click the "Add" button to add users and user groups in the pop-up interface. After the addition is completed, it will be displayed on the sharing interface, and then click "Confirm" to complete the sharing;![11.png](../doc/images/v1.0/agent/11.png)
- Agent dialogue, published agents can directly open the dialogue and jump to the agent dialogue of the dialogue module;![6.png](../doc/images/v1.0/agent/6.png)
- Agent release channel. After the agent release approval is passed, the user can set whether the UI access method requires password-free, web page embedding method, corporate WeChat configuration and DingTalk robot configuration;![7.png](../doc/images/v1.0/agent/7.png)
- Agent log. After the agent is released and approved, you will see the log, showing the update time, user, calling method, number of messages, content title, and creation time; the calling method includes UI access, agent dialogue, API access, enterprise WeChat, and DingTalk robot;![8.png](../doc/images/v1.0/agent/8.png)
- Agent data. After the agent is released and approved, you will see the data. The displayed information includes: total number of users, total calls, total number of tokens, average response time; and graphical curve display; ![9.png](../doc/images/v1.0/agent/9.png)
- Multi-model comparison, enter the multi-model comparison debugging page, the user can select different models and different prompt words to view the effect of the agent; the user can exit the comparison mode by selecting the better-performing model and prompt words;![10.png](../doc/images/v1.0/agent/10.png)
- Agent dialogue history. Users can see previous dialogue history on the debugging page, displaying the user's questions and replies; the dialogue history can be cleared;

#### 2.3.2 Worflow
- Workflow query, the display information of the workflow includes: icon, name, published/unpublished, description information, creator name, creation time; users can filter the query according to the status and name. The status can be published or unpublished, and the name supports fuzzy matching; ![12.png](../doc/images/v1.0/agent/12.png)
- Create a new workflow, you can create a blank workflow and create it based on a template; you can fill in the name, icon, and description information;![13.png](../doc/images/v1.0/agent/13.png)![14.png](../doc/images/v1.0/agent/14.png)
- Workflow editing, you can modify the name, icon, and description information;
- Workflow copy, copy based on existing workflow;
- Workflow deletion, delete existing workflow;
- Workflow details, select a workflow from the list, click to enter the workflow details, supported node types include: basic nodes: large model, knowledge base, database, end; logical nodes: problem classifier, conditional branch, result merging, iteration; component nodes: MCP, memory node, variable assignment, variable Volume aggregation, HTTP request, JSON processing, parameter extraction, document extractor, security audit; tool nodes: full network search, current time, string replacement, custom tools;![15.png](../doc/images/v1.0/agent/15.png)
- Workflow debugging, nodes in the workflow canvas can be debugged in a single step to detect problems early; overall debugging of the workflow; the user enters questions in the dialog box; waits for the workflow answer, and finally displays the answer information in the dialog box; in the dialog box, you can see the execution status, execution time and detailed information of each node execution;![16.png](../doc/images/v1.0/agent/16.png)
- Workflow publishing: publish the debugged workflow into a callable service. No approval is required after the workflow is published, and it becomes published directly on the workflow list page. Users can continue to modify the workflow and publish multiple times;
- Workflow conversation history, the user can see the previous conversation history on the debugging page, displaying the user's questions and replies; the conversation history can be cleared;

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
