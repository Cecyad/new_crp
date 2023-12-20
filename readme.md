
# GitLab with Terraform

This project is to facilitate the creation and initial configuration of repositories and groups in GitLab

## Pre-requisites

- [Gitlab username and access token profile](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)

## Deployment

To deploy this project run

```bash
  ./run.sh <app_name>
```

## Structure
```bash
├──compose
│  ├──Dockerfile
│  ├──docker-compose.yml
│  ├──repositories
│  │  ├──api
│  │  │  └──variables.tfvars
│  │  ├──cron
│  │  │  └──variables.tfvars
│  │  ├──lambda
│  │  │  └──variables.tfvars
│  │  ├──example
│  │  │  └──variables.tfvars
├──src
│  ├──icons
│  ├── create_group.sh
│  ├── search_by_id.sh
│  ├── locals.tf
│  ├── main.tf
│  ├── provider.tf
│  ├── outputs.tf
│  ├── backend.tf
│  └── variables.tf
├──Makefile
├──readme.md
└──run.sh
```

## Step by step

### Choose if you want to create a new subgroup or repository
### New subgroup option
- Requests the GroupID
- Requests the number of linked subgroups to create
- Requests the subgroup name
- Requests the subgroup description
- If it shows us the GroupID, the group was created successfully
### New repository option
- Choice type app

- Choose the action to perform
There are 4 options of actions to make:

  - The first is **APPLY**, this action is only used the first time you want to create a new repository, the action creates the configuration file resources in GitLab platform, also connects to the Gitlab API to create and extract the access token of the project and create the connection with vault to create the secrets engines and the variables GITLAB_PASSWORD, GITLAB_USERNAME and SENTRY_DSN in the development, staging and production environments, also sends notification to Microsoft Teams about the information of the created repository

  - The second option is **UPDATE**, this action creates or updates the resources specified in the GitLab platform, it is used for modifications, as it does not create a token, also sends notification to Microsoft Teams about the information of the created repository

  - The third option is **DESTROY**, this action deletes the resources specified in the GitLab platform, also delete the connection with vault and at the same time delete the secrets engines and the variables GITLAB_PASSWORD, GITLAB_USERNAME and SENTRY_DSN in the development, staging and production environments

  - The fourth option is **SKIP**, to exit the execution file


## Integrations created
- GitLab with microsoft teams -> Send notifications in microsoft teams about GitLab projects

- GitLab with sentry -> Integrate a new project and new alert in sentry
- Sentry with microsoft teams -> Send notifications in microsoft teams about Sentry projects

## Authors
<table>
    <tr>
        <td align="center">
            <a href="https://gitlab.com/Cecyad">
                <img src="https://gitlab.com/uploads/-/system/user/avatar/15160640/avatar.png?width=400" width="100px;" alt="Cecilia Angulo"/>
                <br />
                <sub>
                    <b>Cecilia Angulo</b>
                </sub>
            </a>
        </td>
    </tr>
</table>


