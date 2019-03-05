pipeline {
  agent any
  stages {
    stage('Prepare environment') {
      steps {
        sh "rm -rf flutter/"
        sh "git clone -b stable https://github.com/flutter/flutter.git"
        sh "flutter/bin/flutter doctor"
      }
    }
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Get flutter packages') {
      steps {
        sh 'flutter/bin/flutter packages get'
      }
    }
    stage('Test') {
      steps {
        sh 'flutter/bin/flutter test --coverage'
      }
    }
  }
}
