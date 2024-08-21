# Environment variables for the AI-Memory application

# Elasticsearch URL
# This is the base URL for your Elasticsearch instance
# Example: https://your-elastic-search-url
export AI_MEMORY_ELASTIC_SEARCH_URL="https://your-elastic-search-url"

# Elasticsearch index name
# This is the name of the index where the documents will be stored
# Example: index-ai-memory-default
export AI_MEMORY_ELASTIC_SEARCH_INDEX="index-ai-memory-default"

# Personal name
# This is the name that will be used in the model's responses
# Example: Foo bar
export AI_MEMORY_PERSONAL_NAME="Foo bar"

# Extra personal information
# This is additional information that will be used in the model's responses
# Example: Interaction languages: English
export AI_MEMORY_EXTRA_PERSONAL_INFO="Interaction languages: English"
