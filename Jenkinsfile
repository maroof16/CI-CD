@Library('Jenkins-shared-library') _
pipeline {
    agent any 
    stages{
        stage('git checkout') {
            steps{
                script{
                    git branch: "main",
                    url: "https://github.com/maroof16/ci-cd.git"
                }
            }
        }
    }
}