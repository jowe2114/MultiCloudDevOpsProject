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
        
         stage('Verify Branch') {
            steps {
                echo "$GIT_BRANCH"
            }
        }
                stage('List Tasks') {
                            steps {
                                 
                                sh '''
                                    cd Application
                                    chmod +x ./gradlew
                                    ./gradlew tasks
                                    '''
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
            // Assuming you have a function or script defined to handle Docker login and image build/push
            withCredentials([usernamePassword(credentialsId: "${dockerHubCredentialsID}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                // Login to Docker Hub
                sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin"

                // Build and push Docker image
                sh "docker build -t ${imageName} ./Application"
                sh "docker push ${imageName}"
            }
        }
    }
}

    stage('Edit new image in deployment.yaml file') {
            steps {
                script { 
                    
                    editNewImage("${githubToken}", "${imageName}", "${gitUserEmail}", "${gitUserName}", "${gitRepoName}")
                
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
