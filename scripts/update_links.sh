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

# Function to create index.md file
create_index() {
    local dir="$1"
    local index_file="$dir/index.md"

    # Create the index.md file if it doesn't exist
    if [ ! -f "$index_file" ] && [ $(ls -1 *.md | grep -v "^index.md$" | wc -l) -gt 0 ]; then
        touch "$index_file"
    fi

    # Write the header
    echo "# Links" >"$index_file"

    # Iterate over subdirectories and files
    for item in "$dir"/*; do
        if [ -d "$item" ]; then
            # Subdirectory
            echo "## $item" >>"$index_file"
            create_index "$item"
        elif [ -f "$item" ] && [ "$item" != "$index_file" ] && [ "${item##*.}" = "md" ]; then
            # File
            echo "* [$item](./$(basename "$item"))" >>"$index_file"
        fi
    done
}

# Start the recursion from the root directory
create_index "$ROOT_DIR"
