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
                    withKubeConfig([
                        credentialsId: 'Kind',
                        caCertificate: '',
                        serverUrl: '172.18.0.2:6443',
                        contextName: '',
                        clusterName: '',
                        namespace: ''
                    ]) {
                        sh("kubectl apply -f deployment.yaml --validate=false && kubectl apply -f service.yaml --validate=false")
                    }
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
