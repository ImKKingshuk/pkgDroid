#!/bin/bash


GREEN='\033[1;32m'
ORANGE='\033[38;5;214m'
PURPLE='\033[38;5;140m'
PEACH='\033[38;2;255;204;153m'
BLUE='\033[1;34m'
RED='\033[31m'
NC='\033[0m' 


print_banner() {
    echo "******************************************"
    echo "*                 pkgDroid               *"
    echo "*      The Ultimate Android APK Tool     *"
    echo "*                  v1.0.1                *"
    echo "*      ----------------------------      *"
    echo "*                        by @ImKKingshuk *"
    echo "* Github- https://github.com/ImKKingshuk *"
    echo "******************************************"
    echo
}


command_exists() {
    command -v "$1" >/dev/null 2>&1
}


ensure_tools_installed() {
    local tools=("apktool" "diff" "zipalign" "apksigner" "aapt")
    for tool in "${tools[@]}"; do
        if ! command_exists "$tool"; then
            echo -e "${RED}Error: $tool is not installed.${NC}"
            exit 1
        fi
    done
}


select_apk_file() {
    local prompt="$1"
    echo -e "${ORANGE}$prompt${NC}"
    select apk_file in *.apk; do
        if [ -f "$apk_file" ]; then
            echo -e "${GREEN}You selected: $apk_file${NC}"
            echo ""
            sleep 2
            echo "$apk_file"
            return
        else
            echo -e "${RED}Invalid selection! Enter the right choice:${NC}"
            echo ""
        fi
    done
}


compare_apks() {
    local first_dir="$1"
    local second_dir="$2"
    local choice="$3"
    local log_file="$4"
    local output=""

    case $choice in
        1)
            echo -e "${BLUE}Comparing resources...${NC}"
            output=$(diff --color=always -r "$first_dir/res" "$second_dir/res")
            ;;
        2)
            echo -e "${BLUE}Comparing smali files...${NC}"
            output=$(diff --color=always -r "$first_dir/smali" "$second_dir/smali")
            ;;
        3)
            echo -e "${BLUE}Comparing manifest files...${NC}"
            output=$(diff --color=always -r "$first_dir/AndroidManifest.xml" "$second_dir/AndroidManifest.xml")
            ;;
        4)
            echo -e "${BLUE}Comparing everything...${NC}"
            output=$(diff --color=always -r "$first_dir" "$second_dir")
            ;;
        *)
            echo -e "${RED}Invalid input${NC}"
            return 1
            ;;
    esac

    if [ -z "$output" ]; then
        echo -e "${BLUE}No changes were found${NC}"
    else
        echo "$output" | tee "$log_file"
        echo -e "${GREEN}The comparison result's logs are saved. You can find them here:${NC}"
        echo "$log_file"
    fi
}


decompile_apk() {
    local apk_file="$1"
    local output_dir="$2"
    echo -e "${GREEN}Decompiling $apk_file...${NC}"
    apktool d -f -o "$output_dir" "$apk_file" >/dev/null 2>&1
}


get_apk_info() {
    local apk_file="$1"
    echo -e "${ORANGE}Information for $apk_file:${NC}"
    aapt dump badging "$apk_file" | grep -E "package:|launchable-activity:|application-label:|sdkVersion:|targetSdkVersion:|uses-permission:"
    echo ""
}


rebuild_apk() {
    local dir="$1"
    echo -e "${GREEN}Rebuilding APK from $dir...${NC}"
    apktool b "$dir" -o "${dir}_rebuild.apk" >/dev/null 2>&1
    echo -e "${GREEN}Rebuilt APK saved as ${dir}_rebuild.apk${NC}"
}


sign_apk() {
    local apk_file="$1"
    local keystore="$2"
    local alias="$3"
    local storepass="$4"
    local keypass="$5"
    echo -e "${GREEN}Signing $apk_file...${NC}"
    zipalign -v -p 4 "$apk_file" "${apk_file}_aligned.apk" >/dev/null 2>&1
    apksigner sign --ks "$keystore" --ks-key-alias "$alias" --ks-pass pass:"$storepass" --key-pass pass:"$keypass" --out "${apk_file}_signed.apk" "${apk_file}_aligned.apk"
    echo -e "${GREEN}Signed APK saved as ${apk_file}_signed.apk${NC}"
}


apk_comparison_menu() {
    local first_apk second_apk log_file

    first_apk=$(select_apk_file "Please select the first apk file:")
    second_apk=$(select_apk_file "Please select the second apk file:")

  
    log_file="$dir/$(date +%Y-%m-%d_%H-%M-%S).log"

   
    decompile_apk "$first_apk" "first_apk_dir"
    decompile_apk "$second_apk" "second_apk_dir"

   
    echo -e "${ORANGE}Which changes do you want to compare?${NC}"
    echo "1. Resources"
    echo "2. Smali"
    echo "3. Manifest"
    echo "4. Everything"
    read -p "Enter your choice: " choice
    echo ""
    echo -e "${PEACH}Here is the comparison result:${NC}"

    compare_apks "first_apk_dir" "second_apk_dir" "$choice" "$log_file"
    comparison_result=$?

 
    if [ $comparison_result -eq 0 ]; then
        rm -rf first_apk_dir second_apk_dir
    fi
}


apk_rebuild_menu() {
    local apk_file apk_dir

    apk_file=$(select_apk_file "Please select the apk file to rebuild:")
    decompile_apk "$apk_file" "apk_rebuild_dir"
    rebuild_apk "apk_rebuild_dir"
    rm -rf apk_rebuild_dir
}


apk_signing_menu() {
    local apk_file keystore alias storepass keypass

    apk_file=$(select_apk_file "Please select the apk file to sign:")
    read -p "Enter keystore path: " keystore
    read -p "Enter keystore alias: " alias
    read -sp "Enter keystore password: " storepass
    echo ""
    read -sp "Enter key password: " keypass
    echo ""
    sign_apk "$apk_file" "$keystore" "$alias" "$storepass" "$keypass"
}


apk_extraction_menu() {
    local apk_file

    apk_file=$(select_apk_file "Please select the apk file to extract information from:")
    get_apk_info "$apk_file"
}


main_menu() {
    while true; do
        echo -e "${PURPLE}pkgDroid:${NC}"
        echo "1. APK Compare"
        echo "2. APK Rebuild"
        echo "3. APK Sign"
        echo "4. APK Extract"
        echo "5. Exit"
        read -p "Enter your choice: " main_choice
        echo ""

        case $main_choice in
            1)
                apk_comparison_menu
                ;;
            2)
                apk_rebuild_menu
                ;;
            3)
                apk_signing_menu
                ;;
            4)
                apk_extraction_menu
                ;;
            5)
                echo -e "${GREEN}Exiting...${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}Invalid input. Please enter a number between 1 and 5.${NC}"
                ;;
        esac
    done
}


print_banner


ensure_tools_installed


main_menu
