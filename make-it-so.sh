#!/bin/bash

# This script lists the current markdown files, prints out their names (sans .md file extensions)
# and asks you to pick one. Highlight the name, paste it into the prompt, and bam.
# Then it asks for which kind of layout you want (landscape or portrait).
# Next, the script loops, and waits for you to run it again, or kill it. It will run on the same
# markdown file, using the same layout, so you don't have to keep messing with copying and pasting commands.

echo " "
echo "Markdown files in the current directory:"
echo " "
ls -a *.md | cut -d "." -f 1

echo " "

echo "Copy the name of a file in the list above, then paste it at the prompt below:"

read filename

PS3='Which format do you want? '
options=("Landscape" "Portrait")
select opt in "${options[@]}"
do
    case $opt in
        "Landscape")
            while true; do
#            filename='README'

            pandoc -s --template="templates/default.html" -f markdown-smart --toc -c style-landscape.css "$filename.md" -o "$filename.html"
            python3 -m weasyprint "$filename.html" "$filename.pdf"

            echo " "
            echo " "
            read -p "Press [Enter] key to make another PDF, or [Ctrl + C] to kill the script"

            done
            ;;
        "Portrait")
            while true; do
#            filename='README'

            pandoc -s --template="templates/default.html" -f markdown-smart --toc -c style-portrait.css "$filename.md" -o "$filename.html"
            python3 -m weasyprint "$filename.html" "$filename.pdf"

            echo " "
            echo " "
            read -p "Press [Enter] key to make another PDF, or [Ctrl + C] to kill the script"

            done
            ;;
        *) echo "invalid option $REPLY";;
    esac

done
