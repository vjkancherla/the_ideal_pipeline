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
          sh "/kaniko/executor --dockerfile `pwd`/go_application/Dockerfile  --context `pwd` --destination vjkancherla/go_application_jenkins:v1"
        }
      }
    }
  }
}
