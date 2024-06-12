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
        sonarqubeUrl              = 'http://192.168.100.103:9000/'
        sonarTokenCredentialsID   = 'sonar-token'
        k8sCredentialsID          = 'Kubernetes'
    }

    stages {       

        stage('Run Unit Test') {
            steps {
                script {
                    dir('Application') {	
                	         runUnitTests()
                    }
        	}
    	    }
	}
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
                dir('Application') {
                        buildandPushDockerImage("${dockerHubCredentialsID}", "${imageName}")
                }	
            }
        }
    }
    stage('Edit new image in deployment.yaml file') {
            steps {
                script {
                    withCredentials([string(credentialsId: githubToken, variable: 'GITHUB_TOKEN')]) {
                        editNewImage(
                            "${env.GITHUB_TOKEN}",
                            "${imageName}",
                            "${gitUserEmail}",
                            "${gitUserName}",
                            "${gitRepoName}"
                        )
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
