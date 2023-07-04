pipeline {
    agent any 
    stages{
        stage('git checkout') {
            script{
                git branch: 'main', url: 'https://github.com/maroof16/ci-cd.git'
            }
        }
    }
}