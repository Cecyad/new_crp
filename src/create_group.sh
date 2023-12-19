#!/bin/bash
source compose/.env

# Set colors and formatting
ORANGE='\033[0;33m'
RED='\033[0;31m'
BOLD='\033[1m'
RESET='\033[0m'

echo -e "${RED}${BOLD}Where do you want to create the subgroups?(GROUP ID) ${RESET}"
read -r group_id
echo -e "${RED}${BOLD}How many subgroups do you need to create? ${RESET}"
read -r group

for ((i=1;i<="$group";i++));
do
   echo -e "${ORANGE}${BOLD}""$i"".- Subgroup Name: ${RESET}"
   read -r subgroup_name
   subgroup=$(echo "${subgroup_name,,}" | tr " " -)
   echo -e "${ORANGE}${BOLD}""$i"".- Subgroup Description: ${RESET}"
   read -r subgroup_description

   response=$(curl --request POST --header "PRIVATE-TOKEN: ${GITLAB_TOKEN}" \
     --header "Content-Type: application/json" \
      --data "{\"path\":\"${subgroup}\", \"name\":\"${subgroup_name}\",\"description\":\"${subgroup_description}\",\"parent_id\":\"${group_id}\"}" \
     "https://gitlab.com/api/v4/groups/")

   group_id=$(echo "$response" | grep -oP '(?<="id":).*(?=,"web)')
   echo -e "${RED}${BOLD}"GroupID: "$group_id"" ${RESET}"
done