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


        stage('Deploy on OpenShift Cluster') {
    steps {
        script { 
            // Set Git configurations (if needed)
            sh 'git config user.email omaryoussef19999@gmail.com'
            sh 'git config user.name jowe2114'

            // Perform deployment using custom script or function
            dir('oc') {
                // Assuming deployOnOc is a custom script/function to handle OpenShift deployment
                deployOnOc("${openshiftCredentialsID}", "${nameSpace}", "${clusterUrl}")
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
