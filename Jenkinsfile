parameters {
    string(name: 'AWS_REGION', description: 'The AWS region to deploy resources to', defaultValue: 'ap-southeast-2')
    choice(name: 'ACTION', choices: ['plan', 'apply', 'destroy'], description: 'Select the Terraform action to perform')
}

pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION = params.AWS_REGION
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
                    accessKeyVariable: '',
                    credentialsId: 'aws-access-credentials',
                    secretKeyVariable: ''
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
