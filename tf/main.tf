provider "aws" {
    region = var.region
    access_key =  "${var.environment == "dev" ? "test": ""}"
    secret_key =  "${var.environment == "dev" ? "test": ""}" 
    skip_credentials_validation = "${var.environment == "dev" ? true: false}"
    skip_metadata_api_check     = "${var.environment == "dev" ? true: false}"
    skip_requesting_account_id  = "${var.environment == "dev" ? true: false}"

    endpoints {
        s3 = "${var.environment == "dev" ? "http://localhost:4566": ""}"
        iam = "${var.environment == "dev" ? "http://localhost:4566": ""}"
        lambda = "${var.environment == "dev" ? "http://localhost:4566": ""}"
    }
}



