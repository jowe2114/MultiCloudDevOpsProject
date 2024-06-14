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
                        sh "exit 1"  // Simulate a failure condition
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
