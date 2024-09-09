#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

# avoid variables to be replaced
export ref='$ref'

# Function to process each configuration file
process_conf_file() {
    local conf_file=$1
    local my_id=$2

    echo "Processing $conf_file with ID $my_id..."

    # Load the override configuration file
    if [ -f "$conf_file" ] && [ -s "$conf_file" ]; then
        echo "Loading $conf_file..."
        source "$conf_file"
    fi

    # Read the default configuration file and store the variables
    dist_vars=()
    if [ -f "gpt-values-override-conf.dist.sh" ]; then
        while IFS= read -r line; do
            # Skip commented lines
            if [[ $line == \#* ]]; then
                continue
            fi

            # Remove 'export' if it exists
            line=$(echo "$line" | sed 's/^export //')

            # Extract the variable name and value
            VAR_NAME=$(echo "$line" | cut -d'=' -f 1)
            VAR_VALUE=$(echo "$line" | cut -d'=' -f 2-)

            # Store the variable in the array
            dist_vars+=("$VAR_NAME")

            # Check if the variable name is not empty
            if [ -n "$VAR_NAME" ]; then
                # Check if the variable is set
                if [ -z "${!VAR_NAME}" ]; then
                    echo -e "\033[33mWarning: The variable $VAR_NAME is not defined in $conf_file. The fallback value will be used.\033[0m"
                    declare -x "$VAR_NAME=$VAR_VALUE"
                fi
            fi
        done <"gpt-values-override-conf.dist.sh"
    fi

    # Check for variables in the override file that are not in the dist file
    if [ -f "$conf_file" ] && [ -s "$conf_file" ]; then
        while IFS= read -r line; do
            # Skip commented lines
            if [[ $line == \#* ]]; then
                continue
            fi

            # Remove 'export' if it exists
            line=$(echo "$line" | sed 's/^export //')

            # Extract the variable name
            VAR_NAME=$(echo "$line" | cut -d'=' -f 1)

            # Check if the variable is not in the dist file
            if [ -n "$VAR_NAME" ]; then
                found=false
                for var in "${dist_vars[@]}"; do
                    if [ "$var" == "$VAR_NAME" ]; then
                        found=true
                        break
                    fi
                done
                if [ "$found" == false ]; then
                    echo -e "\033[33mWarning: The variable $VAR_NAME is defined in $conf_file but not in gpt-values-override-conf.dist.sh.\033[0m"
                fi
            fi
        done <"$conf_file"
    fi

    # Replace placeholders in the files using envsubst
    envsubst <gpt-schema.dist.yml >"out/$my_id.gpt-schema.yml"
    envsubst <gpt-instructions.dist.md >"out/$my_id.gpt-instructions.md"

    # Reset the variables
    for var in "${dist_vars[@]}"; do
        if [ -n "$var" ]; then
            unset "$var"
        fi
    done

    echo "Files $my_id.gpt-schema.yml and $my_id.gpt-instructions.md have been generated."
}

# Loop over all configuration files, skipping the .dist.sh file
for conf_file in conf/gpt-values-override-conf.*.sh; do
    # Skip the .dist.sh file
    if [[ "$conf_file" == *".dist.sh" ]]; then
        continue
    fi

    # Extract the [my_id] part from the filename
    my_id=$(echo "$conf_file" | sed 's/.*gpt-values-override-conf\.\(.*\)\.sh/\1/')

    # Process the configuration file
    process_conf_file "$conf_file" "$my_id"
done
