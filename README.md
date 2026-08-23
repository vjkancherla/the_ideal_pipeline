# The Ideal Pipeline

A reference implementation of a modern, end-to-end GitOps pipeline: Jenkins runs
the CI build, Skaffold deploys the Go application to a local cluster, Helm charts
package the services, and Argo CD performs GitOps-based delivery.

## What's inside

- `go_application/` — the Go application source.
- `helm-chart/`, `helm-chart-podinfo-backend/`, `helm-chart-podinfo-frontend/` —
  Helm charts for the app and its services.
- `podinfo-application-backend/`, `podinfo-application-frontend/` — Argo CD
  `Application` resources.
- `argo-cd/`, `argocd-app-of-apps/` — Argo CD server and app-of-apps manifests.
- `jenkins/`, `jenkinsfiles/`, `Jenkinsfile-do-not-use`, `old_jenkinsfile/` — the
  Jenkins CI configuration and pipeline definitions.
- `skaffold.yaml` — local development deployment.
- `terraform/` — the IaC used provision the cluster.

## What you'll learn

- Wiring Jenkins (CI) to Skaffold/Helm (build+deploy) to Argo CD (GitOps delivery).
- App-of-apps Argo CD patterns.
- Structuring Helm charts for backend/frontend services.
- Terraform-driven cluster provisioning.

## Tools covered

- Jenkins, Skaffold, Helm, Argo CD, Go, Terraform, Kubernetes.

## How to use

Follow the flow left to right: `terraform` provisions the cluster, `jenkinsfiles`
build and test `go_application`, Helm charts package it, and the `argocd-`
manifests deliver it via GitOps.

## Related

- Argo CD docs: https://argo-cd.readthedocs.io/
- Skaffold docs: https://skaffold.dev/docs/
