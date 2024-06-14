@Library('Jowe-shared-library')_
pipeline {
    agent any

    environment {
        dockerHubCredentialsID    = 'DockerHub'
        imageName                 = 'jowe2114/java-app'
        openshiftCredentialsID    = 'openshift'
        nameSpace                 = 'omaryousef'
        clusterUrl                = 'https://api.ocp-training.ivolve-test.com:6443'
        gitRepoName               = 'MultiCloudDevOpsProject'
        gitUserName               = 'jowe2114'
        gitUserEmail              = 'omaryoussef19999@gmail.com'
        githubToken               = 'github-token'
        sonarqubeUrl              = 'http://54.147.42.207:9000/'
        sonarTokenCredentialsID   = 'sonar-token'
        k8sCredentialsID          = 'Kubernetes'
    }

    stages {       
        stage('Build') {
            steps {
                script {
                    dir('Application') {
                        build()
                    }
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    dir('Application') {
                        sonarQubeAnalysis()
                    }
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    withCredentials([string(credentialsId: "${dockerHubCredentialsID}", variable: 'DOCKERHUB_TOKEN')]) {
                        sh "echo \$DOCKERHUB_TOKEN | docker login -u jowe2114 --password-stdin"
                        sh "docker info"
                        sh "docker build -t ${imageName} ./Application"
                        sh "docker push ${imageName}"
                    }
                }
            }
        }

       stage('Build & Push Docker Image') {
            steps {
                script {
                    dir('application') {
                        // Navigate to the directory that contains Dockerfile
                        buildAndPushDockerImage(dockerHubCredentialsID, imageName, BUILD_NUMBER)
                    }
                }
            }
        }

        stage('Deploy on OpenShift Cluster') {
            steps {
                script {
                    dir('oc') {
                        deployOnOc("${openshiftCredentialsID}", "${nameSpace}", "${clusterUrl}")
                    }
                }
            }
        }
    }

    post {
        success {
            echo "${JOB_NAME}-${BUILD_NUMBER} pipeline succeeded"
        }
        failure {
            echo "${JOB_NAME}-${BUILD_NUMBER} pipeline failed"
        }
    }
}
