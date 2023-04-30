pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION = 'ap-southeast-2'
    }
    parameters {
        string(name: 'AWS_REGION', description: 'The AWS region to deploy resources to', defaultValue: 'ap-southeast-2')
        choice(name: 'ACTION', choices: ['plan', 'apply', 'destroy'], description: 'Select the Terraform action to perform')
    }
    stages {
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }
        stage('Terraform Action') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    credentialsId: 'aws-access-credentials',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    script {
                        switch (params.ACTION) {
                            case 'plan':
                                sh 'terraform plan'
                                break
                            case 'apply':
                                sh 'terraform apply -auto-approve'
                                break
                            case 'destroy':
                                sh 'terraform destroy -auto-approve'
                                break
                            default:
                                error "Invalid Terraform action selected: ${params.ACTION}"
                        }
                    }
                }
            }
        }
    }
}
