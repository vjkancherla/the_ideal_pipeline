pipeline {
  agent {
    kubernetes {
      yamlFile "jenkins-agent-pod.yaml"
    }
  }
  environment {
    PROJECT = "jenkins-demo"
    REGISTRY_USER = "vjkancherla"
  }
  stages  {
    stage("Build") {
      steps {
        container("kaniko") {
          sh "/kaniko/executor --context `pwd`/go_application --dockerfile Dockerfile --destination vjkancherla/go_application_jenkins:v1"
        }
      }
    }
  }
}
