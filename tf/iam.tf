resource "aws_iam_user" "userA" {
    name = var.user_a_name
}

resource "aws_iam_user" "userB" { 
    name = var.user_b_name
}

data "aws_iam_policy_document" "read_write_policyA"{
    statement {
        actions = [
            "s3:getObject",
            "s3:putObject"
            ]
        resources = [
            "*"
        ]
        effect = "Allow"
    
    }
}

data "aws_iam_policy_document" "read_policyB"{
    statement {
        actions = ["s3:getObject"]
        resources = [
            "*"
        ]
        effect = "Allow"
    }
}

resource "aws_iam_policy" "user_a_policy" {
    name        = "${var.src_bucket_name}-policy"
    description = "read/write access to source bucket"
    policy      = data.aws_iam_policy_document.read_write_policyA.json
}

resource "aws_iam_policy" "user_b_policy" {
    name        = "${var.dest_bucket_name}-policy" 
    description = "read access to destination bucket"
    policy      = data.aws_iam_policy_document.read_policyB.json
}


resource "aws_iam_group" "img_upload_group" {
    name = var.uploader_group_name
}


resource "aws_iam_group" "img_view_group" {
    name = var.viewer_group_name
}

resource "aws_iam_group_policy_attachment" "img_uploader_group_att" {
    group      = aws_iam_group.img_upload_group.name
    policy_arn = aws_iam_policy.user_a_policy.arn
}


resource "aws_iam_group_policy_attachment" "img_viewer_group_att" {
    group      = aws_iam_group.img_view_group.name
    policy_arn = aws_iam_policy.user_b_policy.arn
}

resource "aws_iam_group_membership" "uploader_membership"{
    name = "uploader_group_member" 

    users = [
        aws_iam_user.userA.name,
    ]

    group = aws_iam_group.img_upload_group.name
}

resource "aws_iam_group_membership" "viewer_membership"{
    name = "viewer_group_member" 

    users = [
        aws_iam_user.userB.name,
    ]

    group = aws_iam_group.img_view_group.name
}
