variable "ovirt_url" {
    description = "oVirt API URL"
    default = "https://ovirthostname/ovirt-engine/api"
}
variable "ovirt_username" {
    description = "oVirt Admin user"
    default     = "admin@internal"
}
variable "ovirt_password" {
    description = "oVirt Admin password"
    default     = "ovirtuserpassword"
}