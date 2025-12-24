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

The knowledge base management feature is available to system administrators. In this module, administrators can view all knowledge bases across the entire platform and perform operations such as querying, sharing, transferring, scaling capacity up or down, and deleting knowledge bases.

![Knowledge Base](../doc/images/v1.0/knowledge/admin_kb_list_en.png)

#### 1.5.1 Knowledge Base List

The Knowledge Base List page displays all knowledge bases on the platform. It supports search and filtering by knowledge base type, language, and name. Sorting in ascending or descending order is supported by name, creation time, quantity, and size. Knowledge bases can be shared, transferred, scaled up or down, and deleted, and all of these operations support batch actions.

#### 1.5.2 Knowledge Base Sharing

Through the knowledge base sharing operation, a knowledge base can be shared with other users or user groups.

After entering the knowledge base sharing page, you can select the sharing scope and permissions. The default scope of each knowledge base is [All Users]. The sharing scope can be set to specific users or all users. Permissions can be set to Query or View. Query means that the user can only use the knowledge base but cannot view the document contents within it; View means that the user can not only use the knowledge base but also view the documents inside it.

When the sharing scope is set to [All Users], it means the knowledge base is shared with all users. The default permission is [View], and users can modify the permission as needed.

When the sharing scope is set to specific users, it means the knowledge base is shared with designated users or user groups. The initial sharing list is empty, indicating that it has not been shared with any users. Click the [Add] button to open the Add User page, which displays all user groups and all users under the user groups to which the current user belongs. The knowledge base can be shared with a user group or an individual user. The default permission is View, with Query and View as selectable options. After confirmation, you will return to the sharing page, where the selected users or user groups and their permission information are displayed. Selected users or user groups can be removed. Click Confirm on the sharing page to apply the sharing operation.

Sharing supports batch operations. On the list page, you can select multiple knowledge bases and click the Share button to enter the sharing page. When performing batch sharing, the original sharing records of the selected knowledge bases will be cleared and replaced by the latest sharing settings. Therefore, please pay attention to this behavior when performing batch sharing.

After the sharing operation takes effect, the shared users or members of shared user groups can view the corresponding knowledge bases under Knowledge Base - Shared by Others. They can also view the corresponding knowledge bases through the Knowledge Base List, and see their permission scope for each knowledge base based on the sharing permissions.

#### 1.5.3 Knowledge Base Permission Transfer

Through the knowledge base permission transfer operation, knowledge bases created by a user can be transferred to other users. Batch transfer is also supported.

After entering the knowledge base permission transfer page, you can select a user from the user list to transfer ownership, or search by name and select a user from the search results for transfer.

After the transfer operation takes effect, the target user can view the corresponding knowledge base under the Knowledge Directory. The transfer function does not affect the original sharing scope of the knowledge base. That is, if a knowledge base has been shared with other users before being transferred, the access permissions of those users will remain unchanged.

#### 1.5.4 Knowledge Base Capacity Scaling

Knowledge base capacity scaling allows capacity control for a single knowledge base. By default, a single knowledge base allows uploading up to 500 files. Administrator users can apply different capacity limits to different knowledge bases, with a capacity range of 200 to 1000. Administrator users can also perform batch capacity scaling for multiple knowledge bases.

#### 1.5.5 Delete Knowledge Base

Administrator users can delete all knowledge bases except built-in knowledge bases. Please note that deleting a knowledge base will delete both the knowledge base itself and all documents within it. Therefore, please delete knowledge bases with caution.


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

A knowledge base enables Retrieval-Augmented Generation (RAG) to enhance large model inference. Users can click on the [Knowledge Base] navigation menu on the left side to enter the knowledge base page, where they can create and manage their own knowledge bases. Documents can be uploaded to the knowledge base, and documents of different formats are processed uniformly for easy management. Currently, the knowledge base menu includes three tabs: [Knowledge Base], [All Documents], and [Retrieval Testing].

![Knowledge Base](../doc/images/v1.0/knowledge/kb_list_en.png)

#### 2.6.1 Knowledge Base Directory Management
The knowledge base introduces the concept of directory hierarchy, allowing users to create directories at different levels and create knowledge bases under directories at different levels. In the Knowledge Base tab, the left side displays a directory tree structure of the knowledge base.

##### 2.6.1.1 Directory List
The top-level directory is [All], which is divided into two root directories: [Shared by Others] and [Knowledge Directory]. As the names suggest, the [Shared by Others] directory contains knowledge bases shared or made public by other users, while the [Knowledge Directory] contains knowledge bases created by the current user.

##### 2.6.1.2 Directory Creation
Currently, subdirectories can be created under [Knowledge Directory], with a default support for creating 7 levels of subdirectories. Each directory level can contain no more than 100 subdirectories at the same level. These default parameters can be modified by administrators in system settings. The [Shared by Others] directory does not support creating subdirectories.

##### 2.6.1.3 Directory Modification
Users can modify subdirectories created under [Knowledge Directory], including changing the directory name and parent directory. Changing the parent directory achieves the effect of moving the directory. Root directories cannot be modified.

##### 2.6.1.4 Directory Deletion
Users can delete subdirectories created under [Knowledge Directory]. When a directory contains subdirectories, it cannot be deleted. When a directory contains knowledge bases, deleting the directory will move the knowledge bases up one directory level by default. Root directories cannot be deleted.

#### 2.6.2 Knowledge Base Management

##### 2.6.2.1 Knowledge Base List
This UI interface displays all knowledge base lists that users can access, including those created by themselves, shared with them, and publicly available document knowledge bases and question-answer knowledge bases. Information displayed for each knowledge base includes: name, type, language, keywords, description, parent directory, sharing scope, permissions, creator, creation time, document count, size, and operations. Retrieval and filtering by knowledge base type, language, and name are supported. Knowledge base types include document knowledge bases and question-answer knowledge bases; knowledge base languages include Simplified Chinese, Chinese-English, Japanese, Korean, and multilingual.

In the list view, sorting by name, creation time, document count, and size in ascending and descending order is supported. Operations such as sharing, transferring, deleting, and merging knowledge bases can be performed on selected knowledge bases, and all operations support batch processing.

##### 2.6.2.2 Built-in Knowledge Base
Each user has a built-in knowledge base named [Q&A Favorites]. On the regular conversation page, when you select a conversation and click the favorite button below the model's response, it automatically syncs to the Q&A Favorites knowledge base. This knowledge base does not support name modification, sharing, transferring, deletion, or merging operations.

In the Q&A Favorites knowledge base, only Q&A pairs collected from the conversation page are allowed to sync to the knowledge base. There is no document parsing upload function, and users cannot manually add Q&A pairs.

Additionally, on the Shared by Others page, there is a built-in knowledge base named [Product Documentation Knowledge Base] that is shared across all users. Regular users can directly use this knowledge base for Q&A testing, and can also use question-answer templates in agents based on the knowledge base. The template defaults to using [Product Documentation Knowledge Base]. Note that this is a built-in knowledge base and does not support name modification, sharing, transferring, deletion, or merging operations.

##### 2.6.2.3 Creating a New Knowledge Base
Click the "Create Knowledge Base" button to enter the knowledge base creation interface and fill in the following information:

Select the knowledge base type: [Document Knowledge Base] or [Question-Answer Knowledge Base]

Enter the name of the knowledge base. The knowledge base name should comply with the prompts shown on the UI and can be modified later. Knowledge base names cannot be duplicated for the same user.

Select the knowledge base language. The language option represents the primary language of the document content. The default is Simplified Chinese, with options including Simplified Chinese, Chinese-English, Japanese, Korean, and multilingual. Note that different languages correspond to different encoding models. If the language of the uploaded documents does not match the knowledge base language setting, parsing will fail. Once the knowledge base language is set, it cannot be changed. Please note this carefully.

Enter the knowledge base description (optional, can be left blank).

Select the parent directory.

Enter knowledge base keywords (can be left blank).

Click "Complete Creation" to return to the card list page. Click "Create and Upload Files" to go directly to the document upload page.

##### 2.6.2.4 Editing a Knowledge Base

On the knowledge base list page or knowledge base card page, click the [Edit] button to enter the knowledge base editing page. On the editing page, you can modify the name, description, parent directory, and keywords information.

##### 2.6.2.5 Knowledge Base Configuration

Click on Knowledge Base to enter the Knowledge Base details page.

The Document Knowledge Base has two tabs: File Management and Setting;

The Question and Answer Knowledge Base has three tabs: File Management, Question List, and Setting;

Clicking the Configuration tab allows you to edit the knowledge base's configuration of analysis, chunking, storage, and search.

 (1) Analysis Configuration

**Language Detect**: Enabling this button will cause the backend to check if the language of the parsed document matches the knowledge base's language configuration; if they do not match, parsing will fail and an error message will be displayed; when disabled, the backend will no longer check the language of the parsed document and will directly use the language-setting of the knowledge base for processing. It should be noted that this configuration only takes effect when the "**Precision Priority**" is selected during PDF file parsing. This configuration has no effect when "Speed Priority" or "VLM(Visual Language Model)" is selected.

**Parsing Strategy**: PDF file parsing offers three strategies: "**Accuracy Priority**," "**Speed Priority**," and "**VLM**." Only one strategy can be selected during parsing; the default is "Accuracy Priority Strategy." This configuration can be modified after PDF parsing.

1) When "Accuracy Priority" is selected, the background uses a pipeline of components such as layout detection, formula recognition and detection, table recognition, and text recognition for PDF parsing. This results in high accuracy, strong versatility, and faster parsing speed when deployed on GPUs. When this configuration is selected, there are two sub-configuration options: "Photocopies" and "Formula Recognition."

   

- Enabling the "Photocopies" button uses an OCR model for text recognition in the background. It is recommended to select this configuration for photocopy PDFs. The backend automatically determines whether the PDF document is a photocopy when Disabling the "Photocopies". If it is not a photocopy, it uses Python library functions to directly extract text from the PDF, resulting in faster parsing. However, automatically determining whether a PDF document is a photocopy is not 100% accurate. If you are certain it is a photocopy, it is recommended to directly select this button. This configuration is disabled by default.
- Enabling the "Formula Recognition" button will cause the background to call a formula detection model to check if there are formulas in the PDF file. For PDF files with formulas, or if you are unsure whether there are formulas, it is recommended to select this button. If you are certain there are no formulas in the PDF, disable this configuration option, which will improve parsing speed. This configuration is enabled by default.



2) When selecting the "Speed Priority," the background calls smaller-scale layout detection and text recognition models for parsing, resulting in slightly lower accuracy, but faster parsing speed when deployed on CPU. When this configuration is selected, there is a selectable sub-configuration option: "Photocopies."

- Enabling the "Photocopies" button uses an OCR model for text recognition in the background. It's recommended to select this configuration for photocopied PDFs. Disabling the "Photocopies" button allows the background to directly extract text from the PDF using Python library functions, resulting in faster parsing. If you are certain it's a photocopy PDF, it's recommended to select this button directly. This configuration is disabled by default.



3) Selecting "VLM(Visual Language Model)" uses a visual language model for PDF parsing, resulting in higher parsing accuracy and handling PDFs with complex formats and multiple languages (Chinese, English, Japanese, Korean). However, it requires more resources and is slightly slower; it's recommended for GPU deployments.

**Image Comprehension**: Enabling this configuration uses an AI model to accurately understand image content, which takes more time.



 (2) Chunking Configuration

Chewing strategies include **general chunk** and **multi-level chunk**. General chunk is used by default.

**General Chunk**: The system splits the content into independent chunks according to user-defined rules. When the system retrieves a chunk for question-answering, the content of the chunk will be returned as the context.

This configuration has only one parameter:

**Chunk Size**: The limit on the number of chunk tokens after splitting a long text into multiple chunks; the value range is 0-1000, with a default of 128.



**Multi-level Chunk**: The multi-level chunk uses a two-tier data structure to balance the search accuracy and context information. When answering questions, the system retrieves the second-level chunk, but the first-level content will be returned, which can provide richer context.

This configuration has two parameters:

**Second-level chunk size**: The limit on the number of second-level chunk tokens after splitting a long text into multiple chunks; Its value range is 0-1000, with a default of 128.

**First-level chunk size**: The limit for the first-level-chunk tokens. Each first-level chunk contains multiple second-level chunk; The second-level chunk is used in searching , but the first-level chunk  will be returned for question answering; Its value range 512-4096, default 1024.

(3) Knowledge Base Indexing Configuration

- Indexing Parameters: Encoding Model (Embedding Model)

    Note: This content can only be modified when documents have not been parsed. If there are already successfully parsed documents or documents in the parsing queue, the indexing parameters cannot be modified.

The encoding model can be selected from: bce-embedding-base_v1, bge-m3, or Yuan-embedding-1.0. You can choose the appropriate encoding model based on the content requirements of your documents.

    - bce-embedding-base_v1: Excels in bilingual Chinese-English and cross-lingual semantic representation capability, with vector dimension of 768. BCE-Embedding is an open-source model released by NetEase Youdao, specifically optimized for RAG scenarios in various domains such as education, law, finance, and healthcare.
    - bge-m3: Released by the Beijing Academy of Artificial Intelligence, supports multiple languages including Chinese, English, Japanese, and Korean, with excellent capabilities in multilingual and cross-lingual representation and retrieval. Supports input text length up to 8192, with vector dimension of 1024.
    - Yuan-embedding-1.0: Released by Inspur Information, specifically designed to enhance Chinese text retrieval capability. The default vector dimension is 1792, with excellent performance across multiple domains such as healthcare, news, and encyclopedic knowledge. Compared to other models of the same scale, it often has better retrieval precision and recall.

(4) Knowledge Base Retrieval Configuration

Retrieval Parameters: Include: number of results, retrieval type (hybrid retrieval, keyword retrieval, vector retrieval), recommended weights for each retrieval type, and similarity threshold.

Hybrid Retrieval: Uses both keyword query and vector query methods for querying, employing multi-path recall. Query results and the question are analyzed using relevance algorithms and ranked by relevance score from highest to lowest.

Keyword Retrieval: Also called full-text retrieval, performs matching queries based on keywords only. Keyword extraction algorithms are used to extract keywords from both knowledge segments and user questions, then retrieval is performed based on these keywords.

Vector Retrieval: Analyzes the semantic vector of user questions and queries semantically related knowledge segments from the knowledge base. It can understand the semantics of query content and perform similarity queries, supporting multimodal queries with strong error tolerance.

    Note: Different retrieval strategies correspond to different knowledge base languages. Chinese and Chinese-English: default to hybrid retrieval, with options to select other retrieval methods. Japanese, Korean, and multilingual: default to vector retrieval and cannot be changed. Detailed parameter descriptions can be found in the "Retrieval Testing" section.

##### 2.6.2.6 Deleting a Knowledge Base
Deleting a knowledge base will delete both the knowledge base and the documents within it. Users can only delete knowledge bases they have created. They do not have deletion permissions for knowledge bases shared with them or those for which they have public access.

##### 2.6.2.7 Knowledge Base Sharing
Through the knowledge base sharing operation, you can share knowledge bases created by you with other users or user groups, and assign different permissions to different users or user groups. For regular users, there are two access points for knowledge base sharing: one is on the knowledge base card page where you can select a knowledge base, click the dropdown menu under knowledge base operations, and find the share button; the other is on the knowledge base list page where there is a share button in the operations column. Both lead to the knowledge base sharing page. Administrator users can also perform sharing operations on all knowledge bases from the knowledge base page.

After entering the knowledge base sharing page, you can select the sharing scope and permissions. The default scope for each knowledge base is [Only Self], with options for Only Self/Specific Users/All Users. Permissions can be either View Query or View Content. View Query means the user can only use the knowledge base without viewing document contents. View Content means the user can both use the knowledge base and view its document contents.

When the sharing scope is set to [Only Self], it means the knowledge base is not shared with other users, and the creator has all permissions for the knowledge base.

When the sharing scope is set to [All Users], it means the knowledge base is shared with all users. The default permission is [View Content], but you can modify it according to your needs.

When the sharing scope is set to specific users, it means the knowledge base is shared with particular users or user groups. The initial sharing list is empty, indicating no users have been granted access. Click the [Add] button to open the add users page, which displays all user groups and all users in the current user's group. You can share with either user groups or individual users, with the default permission being View Content, and options for View Query and View Content. After confirmation, you return to the sharing page where you can see the selected users or groups and their permissions. You can remove selected users/groups. Click Confirm on the sharing page to apply the sharing operation.

Sharing supports batch operations, allowing you to select multiple knowledge bases on the list page and click the share button to enter the sharing page. When performing batch sharing, the original sharing records of the selected knowledge bases will be cleared, with the latest sharing records taking effect. Therefore, if you perform batch sharing, please note this carefully.

After the sharing operation takes effect, shared users/group members can see the corresponding knowledge bases in the Knowledge Base - Shared by Others directory and can view them through the knowledge base list. Based on different sharing permissions, they can see their permission scope for that knowledge base.

##### 2.6.2.8 Knowledge Base Ownership Transfer
Through the knowledge base ownership transfer operation, you can transfer knowledge bases you have created to other users. The access points for knowledge base ownership transfer for regular users are similar to those for knowledge base sharing. Please refer to the [Knowledge Base Sharing] section for details.

After entering the knowledge base ownership transfer page, you can choose to transfer to a group member or specify a user.

When selecting a group member, you can choose one user from the group member list to perform the transfer.

When specifying a user, directly input the username. The system will verify whether the username exists and whether the transfer is possible.

Transfer supports batch operations, allowing you to select multiple knowledge bases on the list page and click the transfer button to enter the transfer page.

After the transfer operation takes effect, the receiving user can see the corresponding knowledge base under [Knowledge Directory] in the Knowledge Base. The transfer function does not affect the original sharing scope of the knowledge base. If a knowledge base is transferred after being shared with other users, it does not affect other users' access permissions.

##### 2.6.2.9 Merging Knowledge Bases
Users can select two or more knowledge bases of the same type that they have created and merge them. During merging, you need to set the new knowledge base name, language, and parent directory. You can also enter keywords and description. The other configurations of the merged knowledge base will be the same as the first selected knowledge base. The new knowledge base will import documents from the original knowledge bases. If documents in the original knowledge bases have been parsed or are pending parsing, the corresponding documents in the new knowledge base are added to the parsing queue; otherwise, they remain in an unparsed state. The information and documents in the original knowledge bases remain unchanged.

##### 2.6.2.10 Splitting a Knowledge Base
Users can select files from a knowledge base to split off as a new knowledge base. During splitting, you need to set the new knowledge base name, language, and parent directory. You can also enter keywords and description. The other configurations of the split knowledge base will be the same as the original knowledge base. Selected documents will be imported into the new knowledge base. If documents in the original knowledge base have been parsed or are pending parsing, the corresponding documents in the new knowledge base are added to the parsing queue; otherwise, they remain in an unparsed state. The information and documents in the original knowledge base remain unchanged.

#### 2.6.3 Document Management

##### 2.6.3.1 Uploading Documents
When creating a [Document Knowledge Base], click on the knowledge base to enter the knowledge base details page, which has 2 tabs: File Management and Configuration. Click the File Management tab to upload documents. Currently supported formats include: pdf, docx, doc, txt, html, htm, md, json, jsonl, epub, mobi, xml, pptx, chm, xlsx, jpeg, jpg, and png. For a single upload, the total document size cannot exceed 500MB, with a maximum of 200 files. Upload progress can be viewed during the upload process. The default capacity for a single knowledge base is 500 documents, which can be modified by administrators in the system settings page.

On the import document page, you can check [Auto Start Parsing Upon Import Complete], which is enabled by default. This means documents are parsed immediately after successful upload without requiring manual parsing triggers on the document management page.

    [Note]: File names cannot exceed 80 characters, otherwise parsing may fail.

Two import methods are supported: local file import and SFTP server import.

###### 2.6.3.1.1 Local File Import
Local file import supports selecting multiple files and selecting folders for import. This is illustrated using [Document Knowledge Base] as an example:

###### 2.6.3.1.2 SFTP Server Import
SFTP server import requires users to fill in server address, port, file directory, and authentication information. Authentication methods include both username + password and username + secret key.

After SFTP import, document upload operations are performed in the backend. You can view background tasks on the document management page.

After clicking View, you enter the task details page, which displays task number, server address, port, file directory, total number of files, task progress, number of imported files, task status, and currently importing files.

When the task completes, progress reaches 100% and the status is also updated accordingly.

When creating a [Document Knowledge Base], click on the knowledge base to enter the knowledge base details page, which has 2 tabs: File Management and Configuration. Click the File Management tab to upload documents. Currently supported formats include: pdf, docx, doc, txt, html, htm, md, json, jsonl, epub, mobi, xml, pptx, chm, xlsx, jpeg, jpg, and png.

When creating a [Question-Answer Knowledge Base], click on the knowledge base to enter the knowledge base details page, which has 3 tabs: File Management, Question List, and Configuration. Click the File Management tab to upload documents. Currently supported formats are xlsx and csv, with a single upload not exceeding 500MB and a maximum of 200 files. The import document page for [Question-Answer Knowledge Base] supports template download. You should edit your files according to the template before uploading. Upload progress can be viewed during the upload process:

[Template Download] downloads an faq_template.csv format document containing two columns: Question column and Answer column. When using Q&A knowledge base document parsing, you must construct your documents according to this template format with both question and answer columns; otherwise, parsing will fail.

##### 2.6.3.2 File Management
When creating a [Document Knowledge Base], in the list view, sorting by name, file size, and update time in ascending and descending order is supported. Filtering and querying by name and document status is supported.

When creating a [Question-Answer Knowledge Base], in the list view, sorting by document name, file size, and update time in ascending and descending order is supported. Filtering and querying by name and document status is supported. The page includes functions for splitting the knowledge base, parsing, canceling parsing, deleting, and importing documents.

##### 2.6.3.3 Document Parsing
Document parsing refers to parsing the specific content of documents, extracting text and chunking it. Text chunking is also called "knowledge". This creates a three-tier knowledge system: knowledge base - document - knowledge.

After successful document upload, parsing all files and parsing selected files are supported. Batch cancellation of parsing is also supported. During the parsing process, you may see queuing. If parsing fails, the failure reason will be displayed in the status. Documents that fail to parse can be re-parsed, but successfully parsed documents cannot be parsed again to avoid wasting platform resources.

##### 2.6.3.4 Viewing Parsing Results
After knowledge base document parsing is successful, click [Parsing Results] to enter the parsing results viewing interface. Parsing results are displayed in pages as follows:

Click on the thumbnail to view chunk content in its source file location;

Click on each chunk content to locate its page number in the source file, making it convenient for viewing;

After parsing is complete, the document will automatically complete knowledge encoding and database storage according to the configuration parameters of its knowledge base.

##### 2.6.3.5 Parsing Results Operations
Parsing results operations include:

- Enabling/Disabling knowledge chunks: Disabled chunks will not appear in retrieval results;
- Editing knowledge chunks: Users can modify the text content of knowledge chunks;
- Batch operations: Batch enable, disable, or delete knowledge chunks;
- Adding knowledge chunks: Users can add new chunks to the document for knowledge base retrieval;
- Replace All: If some parsing results are inaccurate, users can use the Replace All function to replace all inaccurate content in the parsed chunks. [Original Content] length limit: 1-100 characters; [Replace With] length limit: 0-100 characters.

##### 2.6.3.6 Question List - Question-Answer Knowledge Base
Enter the question-answer knowledge base details page, which has 3 tabs: File Management, Question List, and Configuration. Click the [Question List] tab to display all question information in this knowledge base, including: question, answer, source document, character count, and update time.

You can sort by question, character count, and update time in ascending or descending order. You can edit each question, add new questions, and batch delete questions.

Click the edit button to modify the question and answer. Question length limit: 1-100 characters; Answer length limit: 1-1000 characters.

#### 2.6.4 All Documents

##### 2.6.4.1 Document List
Regular users click on the [Knowledge Base] menu to enter the knowledge base page and click the [All Documents] tab to display all knowledge bases created by that user, documents uploaded in conversations, and documents from public knowledge bases. The list displays information including: name, upload time, document size, creator, source, status, chunk count, and operations. Sorting by name, upload time, and creator in ascending or descending order is supported. Querying by name and filtering by status is supported. You can check [View Only My Documents] and click the query button to filter documents uploaded by the user. In the operations column, users can delete their own documents, with batch deletion supported.

##### 2.6.4.2 Reference Navigation
Click on a document to display a dropdown menu showing the document's reference information in conversations. Clicking on a specific record jumps to the reference location in the corresponding conversation.

#### 2.6.5 Retrieval Testing

##### 2.6.5.1 Retrieval Testing
Regular users click on the [Knowledge Base] menu to enter the knowledge base page and click the [Retrieval Testing] tab. From the retrieval scope, select knowledge bases created by the user with non-empty content (must contain either successfully parsed documents or manually added Q&A pairs). In the retrieval settings, configure the retrieval strategy, number of results, and similarity threshold. You can perform retrieval testing on documents in the selected knowledge bases to quickly verify document chunking and retrieval effectiveness. Select an appropriate retrieval strategy (hybrid retrieval, keyword retrieval, vector retrieval), set weights, set an appropriate similarity threshold, add test text, and the system will retrieve the most relevant text blocks from the knowledge base.

Retrieval result display includes: document name, page number, similarity, semantic similarity, keyword similarity, content thumbnail, and content text;

In the retrieval results, if you want to modify text blocks, you can click the [Edit] button next to the text block to edit it. Updated results will automatically sync to the text block list in the knowledge base.

After testing, if you feel the retrieval parameters are appropriate, you can click the [Sync] button to save this configuration information to the knowledge base configuration.

The retrieval process consists of two stages: coarse ranking and fine ranking.

The coarse ranking stage primarily removes text that does not meet criteria and returns the first stage retrieval results. In the fine ranking stage, further similarity calculations are performed based on coarse ranking results to obtain qualified text results.

- Number of Results: Represents the final recall results, returning the top N text blocks ranked by combined similarity score.
- Retrieval Type: Includes three types: [Hybrid Retrieval] [Keyword Retrieval] [Vector Retrieval], with each type having additional parameters.

  [Hybrid Retrieval]: Combines keyword similarity and vector cosine similarity. The keyword similarity weight defaults to 0.2. Hybrid similarity score = α × keyword similarity score + (1-α) × semantic similarity score.

  [Keyword Retrieval]: Uses only keyword similarity, with keyword similarity weight defaulting to 1. This is transparent to users.

  [Vector Retrieval]: Uses only vector cosine similarity, with keyword similarity weight defaulting to 0. This is transparent to users.

- Hybrid Similarity Threshold: Uses hybrid similarity score to evaluate the distance between two text segments. It is a weighted combination of keyword similarity and vector cosine similarity. If the similarity between a query and a chunk falls below this threshold, the chunk will be filtered out. The hybrid similarity threshold defaults to 0.5.

- Keyword Similarity Weight: The keyword similarity weight range is [0,1], and the sum of keyword similarity weight and semantic (vector) similarity weight equals 1.0. [Keyword] and [Semantic] here represent keyword similarity weight and vector similarity weight respectively.

    > Note: If uncertain, use the default parameters.

You can adjust parameters based on your specific situation. The following are parameter adjustment scenarios:
1. When the text to be retrieved contains many similar texts, you can appropriately increase the [Hybrid Similarity Threshold] to retrieve higher similarity text segments.
2. When you prefer to use keywords to filter text, you can directly use [Keyword Retrieval]. Conversely, when you prefer to use semantics to retrieve text, you can directly use [Vector Retrieval].
3. When the user's questions relate more to keywords with your document content, that is, keywords are few but precise, you can increase the [Keyword Similarity Weight] or try [Keyword Retrieval].
4. When the user's questions and document content clearly have no keyword connection but have semantic similarity, try to use [Vector Retrieval] or reduce the [Keyword Similarity Weight].
5. When the knowledge base language is set to Japanese or Korean, [Vector Retrieval] is used by default and cannot be changed.

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
