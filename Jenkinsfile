@Library('Jenkins-Shared-Library')_
pipeline {
    agent any
    
    environment {
    dockerHubCredentialsID	    = 'DockerHub'  		    			// DockerHub credentials ID.
    imageName   		        = 'alikhames/java-app'     			        // DockerHub repo/image name.
	openshiftCredentialsID	    = 'openshift'	    				// KubeConfig credentials ID.   
	nameSpace                   = 'alikhames'
	clusterUrl                  = 'https://api.ocp-training.ivolve-test.com:6443'
	gitRepoName 	            = 'MultiCloudDevOpsProject'
    gitUserName 	            = 'Alikhamed'
	gitUserEmail                = 'Alikhames566@gmail.com'
	githubToken                 = 'github-token'
	sonarqubeUrl                = 'http://3.80.238.182:9000/'
	sonarTokenCredentialsID     = 'sonar-token'
	k8sCredentialsID	        = 'kubernetes'
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
                dir('Application') {
                        buildandPushDockerImage("${dockerHubCredentialsID}", "${imageName}")
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
