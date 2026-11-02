pipeline {
    agent any

    // options {
    //     timestamps()
    //     disableConcurrentBuilds()
    //     timeout(time: 15, unit: 'MINUTES')
    // }

    environment {
        COMPOSE_PROJECT_NAME = 'node-api'
        APP_URL = 'http://localhost:4010/users'
    }

    stages {

        stage('Checkout') {
            steps {
                echo '===== Checking out source code ====='
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo '===== Installing dependencies ====='
                // Drop --omit=dev if validate.sh runs tests or linters
                sh 'npm ci'
            }
        }

        stage('Bash Validation') {
            steps {
                echo '===== Running Bash validation ====='
                sh 'bash validate.sh'
            }
        }

        stage('Docker Compose Build & Run') {
            steps {
                echo '===== Building and starting containers ====='
                // --wait blocks until the healthcheck in docker-compose.yml passes
                sh 'docker compose up -d --build --remove-orphans --wait'
            }
        }

        stage('Verify Deployment') {
            steps {
                echo '===== Verifying deployment ====='
                sh '''
                    docker compose ps
                    curl --fail --silent --show-error \
                         --retry 5 --retry-delay 2 --retry-connrefused \
                         "$APP_URL"
                '''
            }
        }
    }

    post {
        always {
            echo '===== Pipeline execution finished ====='
        }
        success {
            echo '===== Deployment successful ====='
        }
        failure {
            echo '===== Pipeline failed – dumping container logs ====='
            sh 'docker compose ps || true'
            sh 'docker compose logs --tail=100 || true'
            // Uncomment to tear down a failed deployment:
            // sh 'docker compose down || true'
        }
    }
}