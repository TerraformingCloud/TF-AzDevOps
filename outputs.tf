// // #*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
// // #*      Terraform - Azure DevOps - Outputs                 *# 
// // #*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

// // # ADO Project Details

// output "ado-project" {
//     description     =   "Exiting Project details in ADO"
//     value           =   {
//         "ID"                    =       data.azuredevops_project.tf.id
//         "Project-Name"          =       data.azuredevops_project.tf.project_name
//         "Visibility"            =       data.azuredevops_project.tf.visibility
//         "Version-Control"       =       data.azuredevops_project.tf.version_control
//         "Work-Item-Template"    =       data.azuredevops_project.tf.work_item_template 
//         "Process-Template-ID"   =       data.azuredevops_project.tf.process_template_id
//     }
// }

// // # Azure Git Repos Outputs

// // output "azure-git-repos" {
// //     description                 =       "Print Azure Git Repo properties"
// //     value                       =       [data.azuredevops_git_repositories.tf.repositories]
// // }

# Project Outputs

output "project-details" {
    description     =   "Project details"
    value           =   {
        ID                      =   azuredevops_project.tf.id
        Process-Template-Id     =   azuredevops_project.tf.process_template_id
    }
}


# Repo Outputs

output "repo-details" {
    description     =   "Print the sample repo outputs"
    value           =   {
        ID                    =       azuredevops_git_repository.tf.id
        Default-Branch        =       azuredevops_git_repository.tf.default_branch
        Is-Fork               =       azuredevops_git_repository.tf.is_fork
        Remote-Url            =       azuredevops_git_repository.tf.remote_url
        Url                   =       azuredevops_git_repository.tf.url
        Web-Url               =       azuredevops_git_repository.tf.web_url       

    }
}

# User Entitlement Outputs

output "user-details" {
    description     =   "Print the user details"
    value           =   {
        ID          =   azuredevops_user_entitlement.tf.*.id
        Descriptor  =   azuredevops_user_entitlement.tf.*.descriptor
    }
}

# Group Outputs

output "group-details" {
    description     =   "Print the group details"
    value           =   {
        ID                    =       azuredevops_group.tf.id
        Url                   =       azuredevops_group.tf.url
        Origin                =       azuredevops_group.tf.origin
        Subject-Kind          =       azuredevops_group.tf.subject_kind
        Domain                =       azuredevops_group.tf.domain       

    }
}