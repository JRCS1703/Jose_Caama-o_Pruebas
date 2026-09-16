pipeline {
    agent any

    tools {
        jdk 'JDK17'
        maven 'Maven3'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests package'
            }
        }

        stage('Unit Tests') {
            steps {
                sh 'mvn -B test'
            }
        }

        stage('Integration Tests') {
            steps {
                sh 'mvn -B verify'
            }
        }

        stage('Acceptance Tests') {
            steps {
                sh 'mvn -B -Dtest=PurchaseFlowAT test'
            }
        }

        stage('Deploy Staging - Green') {
            steps {
                sh 'chmod +x scripts/*.sh'
                sh './scripts/deploy-blue-green.sh green'
            }
        }

        stage('Rollback Drill - Blue') {
            steps {
                sh './scripts/rollback.sh blue'
                sh "test \"$(cat deployment/active_environment.txt)\" = \"blue\""
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'deployment/evidence/**', allowEmptyArchive: true
            junit allowEmptyResults: true, testResults: 'target/surefire-reports/*.xml,target/failsafe-reports/*.xml'
        }
    }
}
