#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#*      Terraform - Azure DevOps                           *# 
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

#
# - Provider Block to connect to Azure DevOps Organization
# 

provider "azuredevops" {
    version                     =       ">= 0.0.1"
    org_service_url             =       var.ado_org_service_url
    personal_access_token       =       var.ado_pat        
}


#
# - Create a Project in Azure DevOps Organization
# 

resource "azuredevops_project" "tf" {
  project_name                  =       "Terraform Ado"
  description                   =       "Terraform project on Azure DevOps"
  visibility                    =       "private"
  version_control               =       "Git"
  work_item_template            =       "Basic"
  
  features = {
    "boards"        =   "enabled"
    "repositories"  =   "enabled"
    "pipelines"     =   "enabled"
    "testplans"     =   "disabled"
    "artifacts"     =   "enabled"
  }

}

#
# - Create a new Repo
# 

resource "azuredevops_git_repository" "tf" {
  project_id                   =      azuredevops_project.tf.id
  name                         =      "Az-Terraform"
  initialization {
    init_type     =   "Clean"
  }
}

#
# - Create a Build definition
#

resource "azuredevops_build_definition" "tf" {
  project_id                  =       azuredevops_project.tf.id
  name                        =       "Terraform CI"
  ci_trigger {
    use_yaml      =   true
  }

  repository {
    repo_type     =   "TfsGit"
    repo_id       =   azuredevops_git_repository.tf.id
    branch_name   =   azuredevops_git_repository.tf.default_branch
    yml_path      =   "singlestage.yml"
  }
}

#
# - Create Users 
# 

resource "azuredevops_user_entitlement" "tf" {
  count                     =       length(var.user_principal_names)
  principal_name            =       var.user_principal_names[count.index]
  account_license_type      =       "express"
}

#
# - Create a Group 
# 

resource "azuredevops_group" "tf" {
  scope                     =     azuredevops_project.tf.id
  display_name              =     "Terraform Ado Team"
  description               =     "The default project team."
}

#
# - Add Users to the group
# 

resource "azuredevops_group_membership" "tf" {
  count                     =     length(var.user_principal_names)
  group                     =     azuredevops_group.tf.descriptor
  members   = [
    element(azuredevops_user_entitlement.tf.*.descriptor, count.index)
  ]
}

# Load Existing Project

// data "azuredevops_project" "tf" {
//     project_name            =       "Terraform"
// }

# Load all Git repositories in a Project

//  data "azuredevops_git_repositories" "tf" {
//    project_id                =       data.azuredevops_project.tf.id
// }

# Load a specific Git repository by name

// data "azuredevops_git_repositories" "tf" {
//    project_id                =       data.azuredevops_project.tf.id
//    name                      =       "Vamsi-TF"
//}