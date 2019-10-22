pipeline {
  agent {
    kubernetes {
      label "k8s"
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    name: jenkins_job
spec:
  containers:
  - name: helm
    image: alpine/helm:2.12.1
    command:
    - cat
    tty: true
"""
    }
  }

  options {
      disableConcurrentBuilds()
      buildDiscarder(logRotator(numToKeepStr: '100', daysToKeepStr: '100'))
  }

  triggers {
      pollSCM('*/2 * * * *')
  }

  stages {
      stage("BRANCH build") {
          when {
              not { buildingTag() }
          }
          stages {
              stage("checkout") {
                  steps {
                      container("dind") {
                          checkout scm
                      }
                      script{
                          shortCommit = sh(returnStdout: true, script: "git rev-parse --short HEAD").trim()
                      }
                  }
              }

              stage("helm") {
                  steps {
                      container("helm") {
                          sh """
                              helm ls
                          """
                      }
                  }
              }
          }
      }
   }
}
