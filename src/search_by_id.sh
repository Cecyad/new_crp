#!/bin/bash

source compose/.env

# Set colors and formatting
RED='\033[0;31m'
ORANGE='\033[0;33m'
BOLD='\033[1m'
RESET='\033[0m'

echo -e "${RED}${BOLD}What do you want to search? ${RESET}"
echo -e "${ORANGE}${BOLD} 1.- Group  ${RESET}"
echo -e "${ORANGE}${BOLD} 2.- Repository ${RESET}"
read -r option

if [ "$option" = "1" ]; then
    TYPE="groups"
else
    TYPE="projects"
fi

echo -e "${RED}${BOLD}What is ID? ${RESET}"
read -r response

respond=$(curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" https://gitlab.com/api/v4/"$TYPE"/"$response")

PATH=$(echo "$respond" | grep -oP '(?<=web_url":").*' | cut -d '"' -f 1)

echo -e "${RED}${BOLD}$PATH${RESET}"