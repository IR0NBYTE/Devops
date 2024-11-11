pipeline {
    agent any
    stages {
        stage('Tests') {
            steps {
//                 script {
//                    docker.image('node:10-stretch').inside { c ->
                        echo 'Building..'
                        sh 'npm install'
                        echo 'Testing..'
                        sh 'npm test'
//                         sh "docker logs ${c.id}"
//                    }
//                 }
            }
        }
        stage('Build and push docker image') {
            steps {
                script {
                    def dockerImage = docker.build("ir0nbyte/node-demo:master")
                    docker.withRegistry('', 'demo-docker') {
                        dockerImage.push('master')
                    }
                }
            }
        }
        
        stage('Deploying Node container to Kubernetes') {
            steps {
                script {
                        sh("kubectl apply -f deployment.yaml && kubectl apply -f service.yaml")
                }
            }
            post{
                success{
                    echo "Successfully deployed to Kind"
                }
                failure{
                    echo "Failed deploying to Kind"
                }
            }
        }
        
    }
}
