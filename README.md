# AI-Memory

This project utilizes an Elasticsearch API and a GPT model to store and manage a chronological repository of information about specific topics, activities, and interactions. The GPT model functions as an extended memory system, or Retriever-Augmented Generator (RAG), to provide suggestions, manage tasks, and offer reminders.

## Features

* **Chronological Tracking**: The model tracks the addition and modification of information, allowing it to understand the sequence of events or data entries.
* **Information Retrieval**: The model can efficiently retrieve information from Elasticsearch using queries that might involve specific dates, topics, or statuses.
* **Decision Making**: Based on retrieved data, the model generates reasoned responses that consider historical data.
* **Assistant Capabilities**: The model provides suggestions, manages tasks, and offers reminders.

## Getting Started

This guide will help you set up and use the AI-Memory project.

### 1. Install Elasticsearch

To install Elasticsearch, follow the official [Elasticsearch documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/install-elasticsearch.html). You can choose between a self-hosted solution (for free) or a cloud-managed one.

### 2. Create the Index

You need to create an index with the prefix `index-ai-memory-` and a suffix that you can set in the configuration file under the `AI_MEMORY_ELASTIC_SEARCH_INDEX_SUFFIX` variable. This can be done via the Elasticsearch CLI or Kibana.

Example using Elasticsearch CLI:
```sh
curl -X PUT "localhost:9200/index-ai-memory-your_suffix?pretty"
```

### 3. Create an API Key

You need to create an API key for your Elasticsearch index. This can be done via the Elasticsearch CLI or Kibana.

Example using Elasticsearch CLI:
```sh
curl -X POST "localhost:9200/_security/api_key?pretty" -H 'Content-Type: application/json' -d'
{
  "name": "ai-memory-key",
  "role_descriptors": {
    "ai_memory_role": {
      "cluster": ["all"],
      "index": [
        {
          "names": ["index-ai-memory-*"],
          "privileges": ["all"]
        }
      ]
    }
  }
}
'
```

### 4. Configure Environment Variables

Copy the `gpt-values-override-conf.dist.sh` file and replace `dist` with the ID you want. Set the needed values in the new file.

Example:
```sh
cp gpt-values-override-conf.dist.sh gpt-values-override-conf.myid.sh
```

Edit `gpt-values-override-conf.myid.sh` and set your values

### 5. Generate Files

Run the `generate-files.sh` script. This will generate the necessary YAML and Markdown files for the GPT Builder. The script also checks if the environment files are not in sync with the dist file.

```sh
bash generate-files.sh
```

### 6. Use GPT Builder

Once the files have been generated under the `/out` folder, go to ChatGPT (a Plus subscription is needed) and use the GPT Builder. Fill the "instructions" box with the content of the generated `gpt-instructions.md` file and create a new action with the content of the generated `gpt-schema.yml` file.

### 7. Set API Key for the Action

Set the API key for the action using the one generated from Elasticsearch. It's important to

 select

 the Authentication type: `ApiKey`. The API key box should contain the value `ApiKey <yourapikey>` (the prefix `ApiKey` is fundamental) and the Auth should be set to `Custom` with the value `Authorization`

### Using the GPT

Once everything is ready, you can use the created GPT by asking it to store or read from its memory.

#### Examples of Requests

- **Store Information**:
  ```sh
  Store the following information: "Meeting with John on Monday at 10 AM."
  ```

- **Retrieve Information**:
  ```sh
  What meetings do I have scheduled for Monday?
  ```

- **Personal Information**:
  ```sh
  What is my name?
  ```

- **Extra Personal Information**:
  ```sh
  What languages do I speak?
  ```

## Components

* **Elasticsearch API**: The API is used to store and manage data.
* **GPT Model**: The model is used to generate responses and provide suggestions, and can be interacted with using natural language inputs.

### License

This project is licensed under the MIT license.
