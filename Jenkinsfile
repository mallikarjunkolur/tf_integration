p4ipeline {
	agent any 
		stages {
			stage('checkout') {
				steps {
				git branch: 'master', url: 'https://github.com/mallikarjunkolur/tf_integration.git'
				}
			}
			stage('initialise tf') {
				steps {
				sh 'terraform init'
				}
			}
			stage('validate') {
				steps {
				sh 'terraform validate'
				}
			}
			stage('plan') {
				steps {
				sh 'terraform plan'
				}
			}
			stage('apply') {
				steps {
				sh 'terraform apply -auto-approve'
				}
			}
		}
}
