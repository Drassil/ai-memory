# Environment variables for the AI-Memory application

# Elasticsearch URL
# This is the base URL for your Elasticsearch instance
# Example: https://your-elastic-search-url
export AI_MEMORY_ELASTIC_SEARCH_URL="https://your-elastic-search-url"

# Elasticsearch write index name
# This is the suffix of the index where the documents will be stored
# The final index name will be: index-ai-memory-${AI_MEMORY_ELASTIC_SEARCH_WRITE_INDEX_SUFFIX}
# Example: default
export AI_MEMORY_ELASTIC_SEARCH_WRITE_INDEX_SUFFIX="default"

# Elasticsearch read index name
# This is the suffix of the index where the documents will be read from
# The final index name will be: index-ai-memory-${AI_MEMORY_ELASTIC_SEARCH_READ_INDEX_SUFFIX}
# Example: default
export AI_MEMORY_ELASTIC_SEARCH_READ_INDEX_SUFFIX=*

# Personal name
# This is the name that will be used in the model's responses
# Example: Foo bar
export AI_MEMORY_PERSONAL_NAME="Foo bar"

# Extra personal information
# This is additional information that will be used in the model's responses
# Example: Interaction languages: English
export AI_MEMORY_EXTRA_PERSONAL_INFO="Interaction languages: English"
