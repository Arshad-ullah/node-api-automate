
pipeline {
    agent any

    stages {

        // 1. Checkout source code
        stage("Checkout") {
            steps {
                echo "===== Checking out source code ====="
                checkout scm
            }
        }

        // 2. Install Node.js dependencies
        stage("Install Dependencies") {
            steps {
                echo "===== Installing dependencies ====="
                sh "npm ci"
            }
        }

        // 3. Run Bash validation
        stage("Bash Validation") {
            steps {
                echo "===== Running Bash validation ====="
                sh "bash validate.sh"
            }
        }

        // 4. Run Node.js tests
        stage("Run Tests") {
            steps {
                echo "===== Running Node.js tests ====="
                sh "npm test"
            }
        }

        // 5. Build Docker image
        stage("Docker Build") {
            steps {
                echo "===== Building Docker image ====="

                sh """
                    docker build -t node-api:${BUILD_NUMBER} .
                    docker tag node-api:${BUILD_NUMBER} node-api:latest
                """
            }
        }

        // 6. Run Docker container
        stage("Docker Run") {
            steps {
                echo "===== Running Docker container ====="

                sh """
                    docker rm -f node-api-container || true

                    docker run -d \
                        --name node-api-container \
                        --restart unless-stopped \
                        -p 4010:4010 \
                        node-api:${BUILD_NUMBER}
                """
            }
        }

        // 7. Verify container
        stage("Verify Deployment") {
            steps {
                echo "===== Checking Docker container ====="

                sh """
                    sleep 5

                    docker ps

                    docker logs node-api-container

                    curl --fail http://localhost:4010/users
                """
            }
        }
    }

    post {

        always {
            echo "===== Pipeline execution finished ====="
        }

        success {
            echo "===== Deployment successful ====="
        }

        failure {
            echo "===== Pipeline failed ====="
        }
    }
}
