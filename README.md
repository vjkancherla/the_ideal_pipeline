# The Ideal Pipeline

An end-to-end **GitOps CI/CD** reference implementation — "the ideal pipeline" —
combining Jenkins, Argo CD, Helm, Skaffold, and Terraform to deploy a Go
podinfo application.

## What's inside

- `go_application/` — the Go podinfo application source.
- `helm-chart/`, `helm-chart-podinfo-backend/`, `helm-chart-podinfo-frontend/` —
  Helm charts for the apps.
- `argo-cd/`, `argocd-app-of-apps/`, `podinfo-application-backend/`,
  `podinfo-application-frontend/` — Argo CD Application manifests.
- `jenkins/`, `jenkinsfiles/`, `Jenkinsfile-do-not-use`, `old_jenkinsfile/` —
  Jenkins pipeline definitions.
- `skaffold.yaml` — Skaffold dev pipeline config.
- `terraform/` — Terraform for the cluster/infra.
- `.sops.yaml` — SOPS-encrypted secrets config.

## Tools covered

- Jenkins (CI), Argo CD (GitOps CD)
- Helm, Skaffold
- Go, Terraform, SOPS

## How to use

This is a reference architecture. Review each component (Jenkins -> build/skaffold
-> Helm -> Argo CD) to understand the full delivery pipeline.
