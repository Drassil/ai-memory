#!/usr/bin/env bats

# Setup function to create necessary files before each test
setup() {
    mkdir -p out
    mkdir -p conf
    echo 'export AI_MEMORY_ELASTIC_SEARCH_URL="https://hw2nl.ddns.net/elasticsearch"' >conf/gpt-values-override-conf.default.sh
    echo 'export AI_MEMORY_ELASTIC_SEARCH_WRITE_INDEX="index-ai-memory-default"' >>conf/gpt-values-override-conf.default.sh
    echo 'export AI_MEMORY_PERSONAL_NAME="Test"' >>conf/gpt-values-override-conf.default.sh
    echo 'export AI_MEMORY_EXTRA_PERSONAL_INFO="Interaction languages: English"' >>conf/gpt-values-override-conf.default.sh

    echo 'export AI_MEMORY_ELASTIC_SEARCH_URL="https://default-url.com"' >gpt-values-override-conf.dist.sh
    echo 'export AI_MEMORY_ELASTIC_SEARCH_WRITE_INDEX="default-index"' >>gpt-values-override-conf.dist.sh

    cp ../gpt-schema.dist.yml ./gpt-schema.dist.yml
    cp ../gpt-instructions.dist.md ./gpt-instructions.dist.md
}

# Teardown function to clean up after each test
teardown() {
    rm -rf out/
    rm -rf conf/

    rm gpt-values-override-conf.dist.sh

    rm gpt-schema.dist.yml
    rm gpt-instructions.dist.md
}

@test "Check if the script processes the default configuration file" {
    run bash ../generate-files.sh
    [ "$status" -eq 0 ]
    [ -f "./out/default.gpt-schema.yml" ]
    [ -f "./out/default.gpt-instructions.md" ]
}

@test "Check if warnings are displayed for missing variables in dist file" {
    run bash ../generate-files.sh
    [ "$status" -eq 0 ]
    [[ "$output" == *"Warning: The variable AI_MEMORY_PERSONAL_NAME is defined in conf/gpt-values-override-conf.default.sh but not in gpt-values-override-conf.dist.sh."* ]]
    [[ "$output" == *"Warning: The variable AI_MEMORY_EXTRA_PERSONAL_INFO is defined in conf/gpt-values-override-conf.default.sh but not in gpt-values-override-conf.dist.sh."* ]]
}

@test "Check if fallback values are used when variables are not defined in override file" {
    echo 'export AI_MEMORY_ELASTIC_SEARCH_WRITE_INDEX=""' >conf/gpt-values-override-conf.default.sh
    run bash ../generate-files.sh
    [ "$status" -eq 0 ]
    [[ "$output" == *"Warning: The variable AI_MEMORY_ELASTIC_SEARCH_WRITE_INDEX is not defined in conf/gpt-values-override-conf.default.sh. The fallback value will be used."* ]]
}
