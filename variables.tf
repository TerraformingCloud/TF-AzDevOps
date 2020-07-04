#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#*      Terraform - Azure DevOps - Variables               *# 
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

variable "ado_org_service_url" {}
variable "ado_pat" {}

variable "user_principal_names" {
    default = ["abc@xyz.onmicrosoft.com", "def@xyz.onmicrosoft.com"]
}
