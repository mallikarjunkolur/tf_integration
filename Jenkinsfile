pipeline {
	agent any 
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
