

resource "aws_iam_role" "exif_redactor_lambda_role" {
    name = "${var.function_name}-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Sid    = ""
                Principal = {
                    Service = "lambda.amazonaws.com"
            }
        },
    ]
  })
}

resource "aws_iam_policy" "exif_redactor_lambda_policy" {
    name        = "${var.function_name}-policy"
    path        = "/"
    description = "getObject access for source bucket and putObject for destinationBucket"
    policy      = jsonencode({
       Version = "2012-10-17"
       Statement = [ 
           {
              Action = [
                   "s3:getObject",
               ]
               Resource = "${aws_s3_bucket.src_bucket.id}"
               Effect = "Allow"
           },
           {
               Action = [
                   "s3:putObject",
               ]
               Resource = "${aws_s3_bucket.dest_bucket.id}"
               Effect = "Allow"
           } 
       ]
    })
}

resource "aws_iam_role_policy_attachment" "exif_redactor_lambda_policy_att" {
 role        = aws_iam_role.exif_redactor_lambda_role.name
 policy_arn  = aws_iam_policy.exif_redactor_lambda_policy.arn
}


data "archive_file" "zip_exif_redactor_lambda" {
    type        = "zip"
    source_dir  = "${path.module}/exiflambda/src/"
    output_path = "${path.module}/exiflambda/exif_redactor.zip"
}

resource "aws_lambda_function" "exif_redactor_lambda_func" {
    filename      = "${path.module}/exiflambda/exif_redactor.zip"
    function_name = var.function_name
    role          = aws_iam_role.exif_redactor_lambda_role.arn
    handler       = "jpegTransform.lambda_handler"
    runtime       = "python3.9"
    layers        = ["arn:aws:lambda:eu-west-2:770693421928:layer:Klayers-p39-pillow:1"]
    depends_on    = [aws_iam_role_policy_attachment.exif_redactor_lambda_policy_att]
    environment {
        variables = {
            destination_bucket = "${aws_s3_bucket.dest_bucket.id}"
        }
    }
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.exif_redactor_lambda_func.arn}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${aws_s3_bucket.src_bucket.arn}"
}