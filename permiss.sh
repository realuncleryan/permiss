#!/bin/bash

# Function to translate permission string
translate_permission() {
    perm=$1

    # Determine permission type (File or Directory)
    first_char=${perm:0:1}
    if [ "$first_char" = "-" ]; then
        owner_type="File"
    elif [ "$first_char" = "d" ]; then
        owner_type="Directory"
    else
        owner_type="Unknown"
    fi

    # Translate permission characters with color formatting
    translate_char() {
        case $1 in
            "r")
                echo -e "\e[32mAble\e[0m"  # Green color for Able
                ;;
            "w")
                echo -e "\e[32mAble\e[0m"  # Green color for Able
                ;;
            "x")
                echo -e "\e[31mUnable\e[0m"  # Red color for Unable
                ;;
            "-")
                echo -e "\e[31mUnable\e[0m"  # Red color for Unable
                ;;
            *)
                echo "Unknown"
                ;;
        esac
    }

    owner_perm="Read: $(translate_char ${perm:1:1}) Write: $(translate_char ${perm:2:1}) Execute: $(translate_char ${perm:3:1})"
    group_perm="Read: $(translate_char ${perm:4:1}) Write: $(translate_char ${perm:5:1}) Execute: $(translate_char ${perm:6:1})"
    others_perm="Read: $(translate_char ${perm:7:1}) Write: $(translate_char ${perm:8:1}) Execute: $(translate_char ${perm:9:1})"

    # Print formatted output with equal signs
    echo "----------------------------------------------------------"
    printf "Owner  = %-40s \n" "$owner_type $owner_perm"
    printf "Group  = %-40s \n" "$group_perm"
    printf "Others = %-40s \n" "$others_perm"
    echo "----------------------------------------------------------"
}

# Check if a permission string is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <permission_string>"
    exit 1
fi
