#!/bin/bash

website="https://shivishbrahma.github.io/NotePub/"

# for dir in . */; do
#     if [ "$dir" == "." ] || [ "$dir" == ".git" ] || [ ! -d "$dir" ]; then
#         continue
#     fi
#     cd "$dir"
#     echo $(date +"%Y-%m-%d %H:%M:%S:") "Updating links in $dir"

#     # Check if dir has .md
#     if [ $(ls -1 *.md | grep -v "^index.md$" | wc -l) -gt 0 ]; then
#         ls -1 *.md | grep -v "^index.md$" | { read name; name=${name/.md/};echo "- [$name]($website$dir$name)"; } >index.md
#     fi
#     sed -i -e 's/^/# Links\n\n/' index.md

#     echo $(date +"%Y-%m-%d %H:%M:%S:") "Updated links in $dir!"
# done

# Set the root directory to start from
ROOT_DIR="."

get_yaml_value() {
    MD_FILE="$1"
    YAML_KEY="$2"
    YAML_FRONT_MATTER=$(sed -n '/^---/,/^---/p' "$MD_FILE")
    YAML_FRONT_MATTER=${YAML_FRONT_MATTER/---/}
    YAML_FRONT_MATTER=${YAML_FRONT_MATTER/---/}

    VALUE=$(echo "$YAML_FRONT_MATTER" | yq e ".$YAML_KEY")

    echo "$VALUE"
}

# Function to create index.md file
create_index() {
    local dir="$1"
    local index_file="$dir/index.md"
    if [ "$dir" == "$ROOT_DIR" ]; then
        index_file="README.md"
        sed '/## Links/,$d' -i "$index_file"
        echo "" >>"$index_file"
    else
        rm -f "$index_file"
    fi

    echo "$dir" "$(ls -1 "$dir" | grep .md | grep -v "^index.md$" | wc -l)"
    # Create the index.md file if md files exist in the directory
    if [ $(ls -1 "$dir" | grep .md | grep -v "^index.md$" | wc -l) -gt 0 ]; then
        # Write the header
        touch "$index_file"
        printf "## Links\n\n" >>"$index_file"
    fi

    # Iterate over subdirectories and files
    for item in "$dir"/*; do
        if [ -d "$item" ]; then
            # Subdirectory
            # filter out if dir starts with .
            basename "$item" | grep -v "^." && continue
            
            printf "* [%s](%s)\n" "$(basename "$item")" "$website${item#./}" >>"$index_file"
            create_index "$item"
        elif [ -f "$item" ] && [ "$item" != "$index_file" ] && [ "$(basename "$item")" != "README.md" ] && [ "${item##*.}" = "md" ]; then
            # File
            title="$(get_yaml_value "$item" "title")"
            if [ -z "$title" ] || [ ! -f "$index_file" ]; then
                continue
            fi
            printf "* [%s](%s)\n" "$title" "$website${item#./}" >>"$index_file"
        fi
    done
}

# Start the recursion from the root directory
create_index "$ROOT_DIR"
