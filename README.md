# CICD - AWS - DevTools
CICD with AWS Developer tools for Mule application -> Cloudhub

### Setup:-

#### 1. Configure aws keys by following the interractive prompts


> ```aws configure```
OR


| EnvVariable| Value| Example(Win)|
| --- |---|---|
| AWS_DEFAULT_PROFILE| iamuser|`setx AWS_DEFAULT_PROFILE iamuser`|
| AWS_DEFAULT_REGION| region|`setx AWS_DEFAULT_REGION region`|
| AWS_ACCESS_KEY_ID| key|`setx AWS_ACCESS_KEY_ID key`|
| AWS_SECRET_ACCESS_KEY| secret|`setx AWS_SECRET_ACCESS_KEY secret`|

---

| EnvVariable| Value| Example(Linux)|
| --- |---|---|
| AWS_DEFAULT_PROFILE| iamuser|`export AWS_DEFAULT_PROFILE`=*iamuser*|


#### 2. Set system environment variables:-

| EnvVariable| Value| Example(Win)|
| --- |---|---|
| TF_VAR_cloudhubUsrValue|cloudhub_username|`SET TF_VAR_cloudhubUsrValue`=*user*|
| TF_VAR_cloudhubPwdValue|cloudhub_encrypted_pwd|`SET TF_VAR_cloudhubPwdValue`=*pass*|
| TF_VAR_github_token|personal_access_token|`SET TF_VAR_github_token`=*11aa22bb333cc44dd5e*|

#### 3. PLan & Apply terraform configuration

> terraform plan --var-file 1az\1az-dev.tfvars (For dev env with 1 availability zone)


> terraform plan --var-file 2az\2az-dev.tfvars (For dev env with 2 availability zones)


#### 4. Start build from Console or CLI

> *aws codebuild start-build --project-name=<<!codebuild-project-name>>*

> ```aws codebuild start-build --project-name=test-codebuild-prj```

## Build using AWS Developer tools

---

| Service        | Provider/Status  |
| -------------  |:----------------:|
| CodeBuild      | ![Build Status](https://codebuild.ap-southeast-2.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiYUxLdVRpenhidXlmdTFrWnlEaEhJcWZvMmpvUkorL3lYby9xeGdNcHF2alRTQlB3UzR0R1VZZy9pWWpTR0hOZm5WcnNtdlBWeU5zdElnWkgzTW5vSUNRPSIsIml2UGFyYW1ldGVyU3BlYyI6Im1nWHRFL1laYkhvUUVLK1QiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=master) |
