#!/usr/bin/env bash
#CLOUDFORMATIONSTACK -- stack name
export VPC_ID=$(aws ec2 describe-vpcs --query "Vpcs[0].VpcId" --output text)

export SUBNET_ID=$(aws ec2 describe-subnets --filters "Name=vpc-id, Values=$VPC_ID" --query "Subnets[0].SubnetId" --output text)
export SUBNET_ID_2=$(aws ec2 describe-subnets --filters "Name=vpc-id, Values=$VPC_ID" --query "Subnets[1].SubnetId" --output text)
export CERTIFICATE_ARN=$(aws iam list-server-certificates --query "ServerCertificateMetadataList[0].Arn" --output text)

export z_id=$(aws route53 list-hosted-zones --query 'HostedZones[0].Id' --output text)
z_id=${z_id#*e/}
export NAME=$(aws route53 list-hosted-zones --query "HostedZones[0].Name" --output text)
export GROUP_NAME=csye6225-webapp
export RDS_GROUP_NAME=csye6225-rds
export ALLOCATED_STORAGE=10
export DB_INSTANCE_CLASS=db.t2.medium
export ENGINE=MySQL
export ENGINE_VERSION=5.6.35
export DB_INSTANCE_IDENTIFIER=csye6225-fall2017
export DB_USER=$2
export DB_PASSWORD=$3
export DB_NAME=csye6225
export PRIMARY_KEYNAME=id
export TABLE_NAME=csye6225
export NAME1=${NAME:0:${#NAME}-1}
export S3_BUCKET_NAME="code-deploy."$NAME1
export TagKey=name
export TagValue=csye6225
export CODEDEPLOY_EC2_SERVICE_ROLE_NAME=CodeDeployEC2ServiceRole
export CODEDEPLOY_EC2_SERVICE_ROLE_SERVICE=ec2.amazonaws.com
export CODEDEPLOY_SERVICE_ROLE_NAME=CodeDeployServiceRole
export CODEDEPLOY_SERVICE_ROLE_SERVICE=codedeploy.amazonaws.com
export CODEDEPLOY_EC2_S3_POLICY_NAME=CodeDeploy-EC2-S3
export RDS_CONNECT_POLICY_POLICY_NAME=RDSConnectPolicy
export TOPIC_NAME="password_reset"
export LOADBALANCERNAME="csyeLoadBalancer"

aws cloudformation create-stack --stack-name $1 --template-body file://ec2-instance-securitygroup-cloudformation-stack.json --parameters ParameterKey=ImageId,ParameterValue=ami-cd0f5cb6 ParameterKey=VpcId,ParameterValue=$VPC_ID ParameterKey=SubnetId,ParameterValue=$SUBNET_ID ParameterKey=HostedZoneId,ParameterValue=$z_id ParameterKey=InstanceType,ParameterValue=t2.micro ParameterKey=KeyName,ParameterValue=csye6225-aws ParameterKey=GroupName,ParameterValue=$GROUP_NAME ParameterKey=Name,ParameterValue=$NAME ParameterKey=RDSGroupName,ParameterValue=$RDS_GROUP_NAME ParameterKey=AllocatedStorage,ParameterValue=$ALLOCATED_STORAGE ParameterKey=DBInstanceClass,ParameterValue=$DB_INSTANCE_CLASS ParameterKey=Engine,ParameterValue=$ENGINE ParameterKey=EngineVersion,ParameterValue=$ENGINE_VERSION ParameterKey=DBInstanceIdentifier,ParameterValue=$DB_INSTANCE_IDENTIFIER ParameterKey=DBUser,ParameterValue=$DB_USER ParameterKey=DBPassword,ParameterValue=$DB_PASSWORD ParameterKey=DBName,ParameterValue=$DB_NAME ParameterKey=SubnetId2,ParameterValue=$SUBNET_ID_2 ParameterKey=PrimaryKeyName,ParameterValue=$PRIMARY_KEYNAME ParameterKey=TableName,ParameterValue=$TABLE_NAME ParameterKey=S3BucketName,ParameterValue=$S3_BUCKET_NAME ParameterKey=TagKey,ParameterValue=$TagKey ParameterKey=TagValue,ParameterValue=$TagValue ParameterKey=CodeDeployEC2ServiceRoleName,ParameterValue=$CODEDEPLOY_EC2_SERVICE_ROLE_NAME  ParameterKey=CodeDeployEC2ServiceRoleService,ParameterValue=$CODEDEPLOY_EC2_SERVICE_ROLE_SERVICE ParameterKey=CodeDeployServiceRoleName,ParameterValue=$CODEDEPLOY_SERVICE_ROLE_NAME  ParameterKey=CodeDeployServiceRoleService,ParameterValue=$CODEDEPLOY_SERVICE_ROLE_SERVICE ParameterKey=CodeDeployEC2S3PolicyName,ParameterValue=$CODEDEPLOY_EC2_S3_POLICY_NAME ParameterKey=RDSConnectPolicyName,ParameterValue=$RDS_CONNECT_POLICY_POLICY_NAME  ParameterKey=TopicName,ParameterValue=$TOPIC_NAME ParameterKey=LoadBalancerName,ParameterValue=$LOADBALANCERNAME ParameterKey=CertificateArn1,ParameterValue=$CERTIFICATE_ARN  --capabilities CAPABILITY_IAM --capabilities CAPABILITY_NAMED_IAM
