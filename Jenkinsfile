pipeline {
  agent {
    kubernetes {
      yamlFile "jenkins-agent-pod.yaml"
    }
  }
  environment {
    PROJECT = "jenkins-demo"
    REGISTRY_USER = "vjkancherla"
    GIT_COMMIT_HASH = sh (script: "git log -n 1 --pretty=format:'%H'", returnStdout: true)
    IMAGE_TAG = "vjkancherla/go_application_jenkins:${GIT_COMMIT_HASH}"
  }
  stages  {
    stage("Build") {
      steps {
        container("kaniko") {
          sh "/kaniko/executor --context `pwd`/go_application --dockerfile Dockerfile --destination ${IMAGE_TAG}"
        }
      }
    }
  }
}
