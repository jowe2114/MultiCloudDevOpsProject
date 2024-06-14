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

        stage('Edit new image in deployment.yaml file') {
            steps {
                script {
                    echo 'Setting Git configurations...'
                    sh 'git config user.email "omaryoussef19999@gmail.com"'
                    sh 'git config user.name "jowe2114"'
                    
                    echo 'Updating deployment image version...'
                    sh "sed -i 's|image:.*|image: ${imageName}:19|g' oc/deployment.yml"
                    
                    echo 'Adding modified deployment.yml to Git...'
                    sh 'git add oc/deployment.yml'
                    
                    echo 'Committing changes...'
                    sh 'git commit -m "Update deployment image to version 19"'
                    
                    echo 'Pushing changes to GitHub...'
                    withCredentials([usernamePassword(credentialsId: 'github-token', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
                        sh "git push https://$GIT_USERNAME:$GIT_PASSWORD@github.com/${gitUserName}/${gitRepoName} HEAD:dev"
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
