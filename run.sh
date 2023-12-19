#!/bin/bash
#Cecilia Angulo,
#Emmanuel Felix

# Set colors and formatting
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
BOLD='\033[1m'
RESET='\033[0m'


echo -e "${RED}${BOLD}What do you want to create? ${RESET}"
echo -e "${ORANGE}${BOLD}1) Subgroup ${RESET}"
echo -e "${ORANGE}${BOLD}2) Repository ${RESET}"
echo -e "${ORANGE}${BOLD}3) Search by ID ${RESET}"
read -r response

if [ "$response" = "1" ]; then
    bash src/create_group.sh
elif [ "$response" = "2" ]; then
    echo -e "${GREEN}${BOLD}Repository Name: ${ORANGE}${BOLD}$1 ${RESET}"
    repository=$1
    export REPOSITORY=$repository

    # CHOICE TYPE
    echo -e "${RED}${BOLD}What is the type? ${RESET}"
    echo -e "${ORANGE}${BOLD}1) GRPC ${RESET}"
    echo -e "${ORANGE}${BOLD}2) API ${RESET}"
    echo -e "${ORANGE}${BOLD}3) CRON/SCRIPT ${RESET}"
    echo -e "${ORANGE}${BOLD}4) LAMBDA ${RESET}"
    echo -e "${ORANGE}${BOLD}5) EMPTY/TEMPLATE ${RESET}"
    read -r type

    if [ "$type" = "1" ]; then
        export PROJECT_TYPE="GRPC"
        project_type_format="grpc"
        echo -e "${RED}${BOLD}${PROJECT_TYPE}...${RESET}"
    elif [ "$type" = "2" ]; then
        export PROJECT_TYPE="API"
        project_type_format="bkd"
        echo -e "${RED}${BOLD}${PROJECT_TYPE}...${RESET}"
    elif [ "$type" = "3" ]; then
        export PROJECT_TYPE="CRON"
        project_type_format="cron"
        echo -e "${RED}${BOLD}${PROJECT_TYPE}...${RESET}"
    elif [ "$type" = "4" ]; then
        export PROJECT_TYPE="LAMBDA"
        project_type_format="lambda"
        echo -e "${RED}${BOLD}${PROJECT_TYPE}...${RESET}"
    elif [ "$type" = "5" ]; then
        export PROJECT_TYPE="Empty"
        project_type_format=" "
    else
        echo -e "${RED}${BOLD}option not found....${RESET}"
        exit
    fi

    export PROJECT_TYPE_FORMAT=$project_type_format

    # Run Terraform Commands
    make providers
    echo -e "${RED}${BOLD}Initialize terraform app...${RESET}"
    make init
    echo -e "${RED}${BOLD}Make plan terraform app...${RESET}"
    make plan
    echo -e "${RED}${BOLD}Formating terraform files...${RESET}"
    make fmt


    # Next Step
    echo -e "${RED}${BOLD}what is the next step? ${RESET}"
    echo -e "${ORANGE}${BOLD}1) APPLY ${RESET}"
    echo -e "${ORANGE}${BOLD}2) UPDATE ${RESET}"
    echo -e "${ORANGE}${BOLD}3) DESTROY ${RESET}"
    echo -e "${ORANGE}${BOLD}4) SKIP ${RESET}"
    read -r next

    if [ "$next" == "1" ]; then
        echo -e "${ORANGE}${BOLD}Applying application changes...${RESET}"
        make apply
        INFORMATION_OUTPUT="$(make output)"
        GROUP_ID=$(echo "$INFORMATION_OUTPUT" | grep -oP '(?<=group_id = ").*(?=")')
        PATH_REPOSITORY=$(echo "$INFORMATION_OUTPUT" | grep -oP '(?<=namespace = ").*(?=")')
    elif [ "$next" == "2" ]; then
        echo -e "${ORANGE}${BOLD}Updating...${RESET}"
        make apply
        INFORMATION_OUTPUT="$(make output)"
        PATH_REPOSITORY=$(echo "$INFORMATION_OUTPUT" | grep -oP '(?<=namespace = ").*(?=")')
    elif [ "$next" == "3" ]; then
        echo -e "${ORANGE}${BOLD}destroying application changes...${RESET}"
        make destroy
    else
        echo -e "${ORANGE}${BOLD}skip actions....${RESET}"
    fi
elif [ "$response" = "3" ]; then
    bash src/search_by_id.sh
else
    echo -e "${RED}${BOLD}option not found....${RESET}"
    exit
fi
