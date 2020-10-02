resource "aws_iam_role" "IamRole" {
  name = "Ec2RoleForSSM"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_instance_profile" "ec2InstanceProfile" {
  role = aws_iam_role.IamRole.name
  name = "Ec2RoleForSSM"
}
resource "aws_iam_role_policy_attachment" "IamRoleManagedPolicyRoleAttachment0" {
  role = aws_iam_role.IamRole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}



resource "aws_iam_user" "eks-admin" {
  name = var.eks-admin
}

resource "aws_iam_user" "eks-user" {
  name = var.eks-user
}