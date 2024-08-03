#!/bin/bash

website="https://shivishbrahma.github.io/NotePub/"

for dir in . */; do
    if [ "$dir" == "." ] || [ "$dir" == ".git" ] || [ ! -d "$dir" ]; then
        continue
    fi
    cd "$dir"
    echo $(date +"%Y-%m-%d %H:%M:%S:") "Updating links in $dir"

    # Check if dir has .md
    if [ $(ls -1 *.md | grep -v "^index.md$" | wc -l) -gt 0 ]; then
        ls -1 *.md | grep -v "^index.md$" | { read name; name=${name/.md/};echo "- [$name](/$dir$name)"; } >index.md
    fi
    sed -i -e 's/^/# Links\n\n/' index.md

    echo $(date +"%Y-%m-%d %H:%M:%S:") "Updated links in $dir!"
done
