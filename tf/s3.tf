resource "aws_s3_bucket" "src_bucket" {
    bucket = var.src_bucket_name

    tags = {
        name  = "environment"
        value = var.environment
    }

}

resource "aws_s3_bucket" "dest_bucket" {
    bucket = var.dest_bucket_name

    tags = {
        name  = "environment"
        value = var.environment
    }

}

resource "aws_s3_bucket_notification" "new_obj_notification" {
    bucket  =  aws_s3_bucket.src_bucket.bucket
    lambda_function {
        lambda_function_arn = "${aws_lambda_function.exif_redactor_lambda_func.arn}"
        events              = ["s3:ObjectCreated:*"]
        filter_suffix       = "jpeg"
    }
        lambda_function {
        lambda_function_arn = "${aws_lambda_function.exif_redactor_lambda_func.arn}"
        events              = ["s3:ObjectCreated:*"]
        filter_suffix       = "jpg"
    }
}
