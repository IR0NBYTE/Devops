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

steps {
    script {
        withKubeConfig([
            credentialsId: 'jenkins',
            caCertificate: '',
            serverUrl: '<URL>',
            contextName: '',
            clusterName: '',
            namespace: ''
        ]) {
            sh("kubectl get ns development || kubectl create ns development")
        }
    }
}

        
        stage('Deploying Node container to Kubernetes') {
            script {
                withKubeConfig([
                    credentialsId: 'kind',
                    caCertificate: '',
                    serverUrl: '127.0.0.1',
                    contextName: '',
                    clusterName: '',
                    namespace: ''
                ]) {
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
