#!/bin/bash

TF_WORKING_DIR=$(PWD)
TF_STATE_BUCKET_DIR="tfstate-bucket"
GKE_DIR="gke"

echo

echo

cd $TF_WORKING_DIR/$TF_STATE_BUCKET_DIR

echo

echo "====PROCESSING Project: ${TF_STATE_BUCKET_DIR}: START===="

echo

terraform init && terraform apply -no-color -auto-approve -var-file=dev.tfvars

echo

echo "====PROCESSING Project: ${TF_STATE_BUCKET_DIR}: COMPLETE===="

echo

echo

cd $TF_WORKING_DIR/$GKE_DIR/layers

echo "====PROCESSING Project: ${GKE_DIR}: START===="

for dir in $(ls)
do
  echo

  echo "====PROCESSING ${GKE_DIR}/${dir} LAYER: START===="

  echo

  echo ">> cd ${dir}"
  cd ${dir}

  echo

  terraform init -backend-config backend-configs/dev.config


  terraform apply -no-color -auto-approve -var-file=environments/dev.tfvars

  echo

  echo "====PROCESSING ${GKE_DIR}/${dir} LAYER: END ===="

  cd ..

done

echo
echo "====PROCESSING Project: ${GKE_DIR}: END===="

echo
echo "Setup KubeConfig for the new K8s cluster"
echo
echo "gcloud container clusters get-credentials simple-autopilot-dev-cluster --region europe-west2"
gcloud container clusters get-credentials simple-autopilot-dev-cluster --region europe-west2
