#!/usr/bin/groovy

pipeline {
  agent {
    kubernetes {
      yamlFile "jenkins-agent-pod.yaml"
    }
  }

  options {
      disableConcurrentBuilds()
  }

  environment {
    PROJECT = "jenkins-demo"
    REGISTRY_USER = "vjkancherla"
    GIT_COMMIT_HASH = sh (script: "git log -n 1 --pretty=format:'%H'", returnStdout: true)
    IMAGE_REPO = "vjkancherla/go_application_jenkins"
    IMAGE_TAG = "${GIT_COMMIT_HASH}"
  }

  stages  {
    stage("Build") {
      steps {
        package_and_push_image()
      }
    }

    stage("Deploy") {
      steps {
        deploy_to_dev()
      }
    }

  }
}

def package_and_push_image() {
  container("kaniko") {
    sh "/kaniko/executor --context `pwd`/go_application --dockerfile Dockerfile --destination ${IMAGE_REPO}:${IMAGE_TAG}"
  }
}

def deploy_to_dev() {
  container("helm") {
    sh "helm upgrade --install --values-file helm-chart/namespaces/dev/values.yaml --set image.repository="${IMAGE_REPO}" --set image.tag="${IMAGE_TAG}" helm-go-dev helm-chart/ "
  }
}
