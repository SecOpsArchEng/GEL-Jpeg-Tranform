variable "region" {
    default = "eu-west-2"
}

variable "user_a_name" {
    default = "userA"
}

variable "user_b_name" {
    default = "userB"
}

variable "uploader_group_name" {
    default = "uploader_group"
}

variable "viewer_group_name" {
    default = "viewer_group"
}
variable "src_bucket_name" {
    default = "img-src"
}

variable "dest_bucket_name" {
    default = "img-dest"
}

variable "function_name" {
    default = "exif_redactor"
}

variable "environment" {
    default = "dev"
}
