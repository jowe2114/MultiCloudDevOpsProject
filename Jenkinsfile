pipeline {
    agent any

    environment {
        githubTokenCredentialsID = 'github-token'
        // Other environment variables...
    }

    stages {
        stage('Example Stage') {
            steps {
                script {
                    // Example usage of GitHub token
                    withCredentials([string(credentialsId: "${githubTokenCredentialsID}", variable: 'GITHUB_TOKEN')]) {
                        // Use GITHUB_TOKEN in your Git operations or API requests
                        sh "git config --global credential.helper store"  // Optional: Configure Git credential helper
                        sh "git clone https://github.com/your/repository.git"
                        sh "git pull origin master"
                        sh "git push origin master"
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline succeeded"
        }
        failure {
            echo "Pipeline failed"
        }
    }
}
