# terraform plan -var project_name=test-codebuild-prj -var bucket_name=testbucker -var repo_type=GITHUB -var repo_url=https://github.com/sriharsha-inthub/mule-http-echo.git
#################################################################################

################ CODEBUILD #######################
resource "aws_codebuild_project" "mule-http-echo" {
  count = "${var.create_mule-http-echo}" ? 1 : 0
  name          	= "mule-http-echo"
  description  		= "Mule application http endpoint echo"
  build_timeout 	= "${var.build_timeout}"
  service_role  	= "${aws_iam_role.cicd_codebuild_role.arn}"
  badge_enabled 	= true
  encryption_key 	= "${aws_kms_key.s3Key.key_id}"
  
  artifacts {
    type     		= "S3"
    location 		= "${var.bucket_name}"
    packaging 		= "NONE"
    namespace_type 	= "NONE"
    name 			= "target"
    path 			= "mulehttpecho"
    encryption_disabled = false
  }
  
  cache {
    type     	= "NO_CACHE"
    location 	= ""
    modes 		= [""]	
  }

  environment {
    compute_type 				= "BUILD_GENERAL1_SMALL"
    image        				= "${var.image}"
	  privileged_mode 			= true
    type         				= "LINUX_CONTAINER"
	  image_pull_credentials_type = "CODEBUILD"
	
	environment_variable {
      name  = "APP_NAME"
      value = "httpecho-v1"
	  type 	= "PLAINTEXT"
    }
    environment_variable {
      name  = "MULE_VERSION"
      value = "4.1.5"
      type  = "PLAINTEXT"
    }
	environment_variable {
      name  = "CLOUDHUB_ENV"
      value = "${var.cloudhubEnv}"
      type  = "PLAINTEXT"
    }
	environment_variable {
      name  = "ANYPOINT_LOGIN_URI"
      value = "${var.cloudhubUrl}"
      type  = "PLAINTEXT"
    }
	environment_variable {
      name  = "CLOUDHUB_USERNAME"
      value = "${var.cloudhubUsername}"
      type  = "PARAMETER_STORE"
    }
	environment_variable {
      name  = "CLOUDHUB_PASSWORD"
      value = "${var.cloudhubPassword}"
      type  = "PARAMETER_STORE"
    }
	environment_variable {
      name  = "EFS_ID"
      value = "${var.efs_id}"
      type  = "PARAMETER_STORE"
    }
	
  }

  source {
    type     			= "${var.repo_type}"
    location 			= "https://github.com/sriharsha-inthub/mule-http-echo.git"
    git_clone_depth 	= 1
    report_build_status = true
    buildspec 			= "cicd/build/buildspec-for-terraform.yml"
	insecure_ssl 		= false
	
	auth {
	  type 		= "OAUTH"
	  resource 	= "${var.github_token}"
	}
  
  }
  
  vpc_config {
    vpc_id = "${aws_vpc.vpc.id}"

    subnets = [
      "${aws_subnet.private_1a.id}",
    ]

    security_group_ids = [
      "${aws_security_group.sg-private-subnet.id}"
    ]
  }
  
  logs_config {
    cloudwatch_logs {
      group_name 	= "mule-http-echo"
      stream_name 	= "mule-http-echo"
    }
    s3_logs {
      status 				= "ENABLED"
      location 				= "${aws_s3_bucket.bucket.id}/build-logs"
	  encryption_disabled 	= "false"
    }
  }

}

#####	CODEBUILD	#####

output "badge_url-mule-http-echo" {
	value       =  "${join(",",aws_codebuild_project.mule-http-echo.*.badge_url)}"
}