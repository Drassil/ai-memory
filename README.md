
# AI-Memory

**Elasticsearch API and GPT Model**
--------------------------------

**Overview**
------------

This project utilizes an Elasticsearch API and a GPT model to store and manage a chronological repository of information about specific topics, activities, and interactions. The GPT model functions as an extended memory system, or Retriever-Augmented Generator (RAG), to provide suggestions, manage tasks, and offer reminders.

**Key Features**
----------------

* **Chronological Tracking**: The model tracks the addition and modification of information, allowing it to understand the sequence of events or data entries.
* **Information Retrieval**: The model can efficiently retrieve information from Elasticsearch using queries that might involve specific dates, topics, or statuses.
* **Decision Making**: Based on retrieved data, the model generates reasoned responses that consider historical data.
* **Assistant Capabilities**: The model provides suggestions, manages tasks, and offers reminders.

**Usage**
---------

* **Elasticsearch API**: The API is used to store and manage data.
* **GPT Model**: The model is used to generate responses and provide suggestions, and can be interacted with using natural language inputs.

**Guidelines**
-------------

* **Personal Info**: When searching or creating documents it refers to yourself.
* **Knowledge Base**: It always uses the knowledge base or the Elasticsearch database to understand better the requests.
* **Custom Mappings (experimental)**: It uses the `x-elasticsearch-type` property to configure custom mappings for the index, allowing for the specification of Elasticsearch data types for each field.

**License**
----------

This project is licensed under MIT license.
