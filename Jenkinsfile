pipeline {
    agent any

    environment {
        BASE_URL = 'http://127.0.0.1:8080'
    }

    stages {
        stage('Checkout') {
            steps { checkout scm }
        }

        stage('Build') {
            steps { sh 'mvn -B -DskipTests clean package' }
        }

        stage('Unit Tests') {
            steps { sh 'mvn -B test' }
            post {
                always { junit 'target/surefire-reports/*.xml' }
            }
        }

        stage('Deploy Staging') {
            steps { sh 'bash scripts/deploy-staging.sh' }
        }

        stage('Acceptance Tests') {
            steps { sh 'mvn -B failsafe:integration-test failsafe:verify' }
        }

        stage('Canary') {
            when { branch 'main' }
            steps { sh 'bash scripts/deploy-canary.sh' }
        }

        stage('Rollback Validation') {
            when { branch 'main' }
            steps { sh 'bash scripts/rollback.sh' }
        }
    }
}
