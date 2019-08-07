	# Configure the AWS Provider

	provider "aws" {
		version = "~> 2.0"
		region = "${var.aws_region}"
	}

	# Configure the GitHub Provider
	provider "github" {
		token        = "${var.githubToken}"
		organization = "${var.githubOrganization}"
	}

	provider  "template" {
		
	}