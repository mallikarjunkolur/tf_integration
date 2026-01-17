pipeline {
	agent any
	environment {
        ARM_CLIENT_ID       = credentials('ARM_CLIENT_ID')
        ARM_CLIENT_SECRET   = credentials('ARM_CLIENT_SECRET')
        ARM_TENENT_ID       = credentials('ARM_TENENT_ID')
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
				sh 'cd terraform && terraform init -upgrade'
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
