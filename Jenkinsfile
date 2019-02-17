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
      steps {
        sh 'flutter test --coverage'
      }
    }
  }
}
