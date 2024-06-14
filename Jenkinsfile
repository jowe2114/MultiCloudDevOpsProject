pipeline {
    agent any

    stages {
        stage('Example Stage') {
            steps {
                script {
                    try {
                        // Example commands or steps
                        sh "echo 'Hello Jenkins'"
                        sh "ls -l"
                        // Remove or comment out exit 1 to prevent intentional failure
                        // sh "exit 1"
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        echo "Failed: ${e.message}"
                        error(e.message)
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
