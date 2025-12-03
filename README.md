# devops-cicd-k8s

A demo project showing an end-to-end CI/CD pipeline: FastAPI app → Docker → AWS ECR → EKS (Helm) with monitoring.

## What's included

- Simple FastAPI app with health check and tests
- Dockerfile for containerization
- Helm chart for Kubernetes deployment + HPA
- GitHub Actions workflow: test → build → push to ECR → deploy to EKS
- Monitoring via prometheus-community/kube-prometheus-stack

## Prerequisites

- AWS account
- `aws` CLI configured
- `eksctl`, `kubectl`, `helm`, `docker` installed
- GitHub repo with secrets: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `EKS_CLUSTER_NAME`

## Quick start (dev)

1. Create ECR repository:
aws ecr create-repository --repository-name devops-cicd-k8s --region us-east-1

2. Create EKS cluster:
eksctl create cluster --name devops-cicd-cluster --region us-east-1 --node-type t3.medium --nodes 2

3. Build and run locally:
docker build -t devops-cicd-k8s:local .
docker run -p 8000:8000 devops-cicd-k8s:local
visit <http://localhost:8000>

4. Push code to GitHub and let Actions run CI/CD (ensure secrets added).

## How CI/CD works

- On push to `main`, GitHub Actions:

1. Runs pytest
2. Builds Docker image, tags it with the commit SHA
3. Pushes image to ECR
4. Updates Helm release on EKS

## Monitoring

### Install Prometheus & Grafana (using helm)

helm repo add prometheus-community <https://prometheus-community.github.io/helm-charts>

helm repo update

helm install monitoring prometheus-community/kube-prometheus-stack -n monitoring --create-namespace

Access Grafana dashboard via port-forward.

## Next steps / improvements

- Add automated image tag promotion between environments
- Integrate Snyk / tfsec / benchmark scans
- Add GitOps with ArgoCD for declarative deployments
- Use IRSA for secure secret access

## License

MIT
