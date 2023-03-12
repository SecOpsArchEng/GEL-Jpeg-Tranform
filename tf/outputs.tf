output "src_bucket_arn" {
    value = aws_s3_bucket.src_bucket.arn
}

output "dest_bucket_arn" {
    value = aws_s3_bucket.dest_bucket.arn
}

output "user_a_name" {
    value = aws_iam_user.userA.name
}

output "user_b_name" {
    value = aws_iam_user.userB.name
}

output "lambda_name" {
    value = aws_lambda_function.exif_redactor_lambda_func.arn
}