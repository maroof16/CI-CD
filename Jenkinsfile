@Library('Jenkins-shared-library') _
pipeline {
    agent any 
    parameters{
        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
    }
    stages{
        stage('git checkout') {
            when { expression { params.action == 'create' }}
            steps{
                script{
                    git branch: "main",
                    url: "https://github.com/maroof16/ci-cd.git"
                }
            }
        }
        stage('unit mvn test') {
            when { expression { params.action == 'create' }}
            steps{
                script{
                    mvntest()
                }
            }
        }
        stage('mvn integration test') {
            when { expression { params.action == 'create' }}  
            steps{
                script{
                    mvnintegrationtest()
                }
            }
        }
        stage('Sonar Static Code Analysis') {
            when { expression { params.action == 'create' }}  
            steps{
                script{
                    StaticCodeAnalysis()
                }
            }
        }
    }
}