pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Flutter Doctor') {
      steps {
        sh 'flutter doctor'
      }
    }
    stage('Get flutter packages') {
      steps {
        sh 'flutter packages get'
      }
    }
    stage('Test') {
      post {
        always {
          sh 'python3 lcov_cobertura.py coverage/lcov.info --output coverage/coverage.xml'
          step([$class: 'CoberturaPublisher', coberturaReportFile: 'coverage/coverage.xml'])
        }
      }
      steps {
        sh 'flutter test --coverage'
      }
    }
  }
}
