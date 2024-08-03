#!/bin/bash

website="https://shivishbrahma.github.io/NotePub/"

for dir in . */; do
    if [ "$dir" == "." ] || [ ! -d "$dir" ]; then
        continue
    fi
    cd "$dir"
    echo $(date +"%Y-%m-%d %H:%M:%S:") "Updating links in $dir"

    # Check if dir has .md
    if [ $(ls -1 *.md | grep -v "^README.md$" | wc -l) -gt 0 ]; then
        ls -1 *.md | grep -v "^README.md$" | { read name; echo "- [$name](\"$website$dir$name\")"; } >README.md
    fi
    sed -i -e 's/^/# Links\n\n/' README.md

    echo $(date +"%Y-%m-%d %H:%M:%S:") "Updated links in $dir!"
done
