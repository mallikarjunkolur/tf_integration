pipeline {
	agent any
	environment {
        ARM_CLIENT_ID       = credentials('ARM_CLIENT_ID')
        ARM_CLIENT_SECRET   = credentials('ARM_CLIENT_SECRET')
        ARM_TENANT_ID       = credentials('ARM_TENANT_ID')
        ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID')
    } 
		stages {
			stage('checkout') {
				steps {
				git branch: 'master', url: 'https://github.com/mallikarjunkolur/tf_integration.git'
				}
			}
			stage('initialise tf') {
				steps {
				sh 'cd terraform && terraform init'
				}
			}
			stage('validate') {
				steps {
				sh 'cd terraform && terraform validate'
				}
			}
			stage('plan') {
				steps {
				sh 'cd terraform && terraform plan'
				}
			}
			stage('apply') {
				steps {
				sh 'cd terraform && terraform apply -auto-approve'
				}
			}
		}
}
