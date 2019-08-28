# S3Upload

Example of how to upload a file to S3. See [ViewController.swift](S3Upload/ViewController.swift) for the upload code and [AppDelegate.swift](S3Upload/AppDelegate.swift) for the setup code.

## Getting Credentials

The [AWSS3TransferUtility](https://aws.amazon.com/blogs/mobile/amazon-s3-transfer-utility-for-ios/) requires `AWSCognitoCredentialsProvider` to use an _Amazon Cognito Identity_.

You can create a Cognito identity in the [Amazon Cognito console](https://console.aws.amazon.com/cognito/home).

[This guide](https://docs.aws.amazon.com/cognito/latest/developerguide/getting-credentials.html) explains what the Cognito identity is all about.

Once you have created the identity, edit the role it created for you (eg `Cognito_MyAppUnauth_Role`) and attach to it a policy that allows it to upload to s3.

Below is an example policy:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:PutBucketAcl",
                "s3:PutBucketPolicy",
                "s3:CreateBucket",
                "s3:PutObjectAcl"
            ],
            "Resource": [
                "arn:aws:s3:::myBucket",
            ]
        }
    ]
}
```

## Secrets

Add your identity pool ID and bucket name to `Secrets.plist`.
