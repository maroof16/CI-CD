@Library('Jenkins-shared-library') _
pipeline {
    agent any 
    parameters{
        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
        string(name: 'ImageName',description: 'Name of the docker image', defaultValue:'javapp')
        string(name: 'ImageTag',description: 'Tag of the docker image', defaultValue:'v1')
        string(name: 'DockerHubUser',description: 'Name of the Application', defaultValue:'maroofshaikh09')
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
                    //def StaticCodeAnalysisID = 'sonar-token'
                    StaticCodeAnalysis()
                }
            }
        }
        stage('Static Code Quality') {
            when { expression { params.action == 'create' }}  
            steps{
                script{
                    StaticCodeAnalysis()
                }
           }
        }
        stage('mvn build') {
            when { expression { params.action == 'create' }}
            steps{
                script{
                    mvnCleanInstall()
                }
            }
        }
        stage('Docker image build') {
            when { expression { params.action == 'create' }}
            steps{
                script{
                   dockerBuild("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
               }
            }
        }
        stage('Docker image Scan') {
            when { expression { params.action == 'create' }}
            steps{
                script{
                   dockerImageScan("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
               }
            }
        }
        stage('Docker image push: Dockerhub') {
            when { expression { params.action == 'create' }}
            steps{
                script{
                   dockerImagePush("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
               }
            }
        }
        stage('Docker image delete') {
            when { expression { params.action == 'create' }}
            steps{
                script{
                   dockerdelete("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
               }
            }
        }
    }
}