# IAM

This section discuss aspects of IAM

## Core Concepts

**Users**: Represent individual people or applications that need access to AWS resources. Users have long-term credentials (access keys, passwords).

**Groups**: Collections of users. Groups make it easier to manage permissions for multiple users at once.

**Roles**: Identities that can be assumed by AWS services (like EC2 instances or Lambda functions) or by IAM users. Roles provide temporary credentials and are preferred over long-term credentials for services and applications.

**Policies**: Define permissions in JSON format. Policies specify which actions are allowed or denied on which resources.

**Permissions**: The specific actions that a user, group, or role is allowed to perform on a resource.

**Authentication**: The process of verifying the identity of a user or service.

**Authorization**: The process of determining whether an authenticated user or service has permission to perform a specific action.

## Policy Types

**Identity-Based Policies**: Attached directly to IAM users, groups, or roles. They define what the identity can do.

**Resource-Based Policies**: Attached directly to AWS resources (like S3 buckets or SQS queues). They define who can access the resource.

**Service Control Policies (SCPs)**: Used in AWS Organizations to set organization-wide permissions boundaries. They limit the maximum permissions that can be granted to IAM identities within an account.

**Permissions Boundaries**: Used to set the maximum permissions that an IAM identity can have. They act as a guardrail, even if a policy attached to the identity grants more permissions.

## Policy Structure:

IAM policies are JSON documents with the following key elements:

**Version**: Specifies the policy language version (usually "2012-10-17").

**Statement**: An array of statements, each defining a specific permission.

**Effect**: "Allow" or "Deny".

**Action**: The specific AWS API actions that are being allowed or denied (e.g., "s3:GetObject", "ec2:RunInstances").

**Resource**: The AWS resources that the action applies to (e.g., "arn:aws:s3:::my-bucket/", "arn:aws:ec2:::instance/").

**Condition (Optional)**: Specifies conditions under which the statement applies (e.g., based on IP address, time of day, or other attributes).