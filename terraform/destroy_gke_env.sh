#!/bin/bash

TF_WORKING_DIR=$(PWD)
TF_STATE_BUCKET_DIR="tfstate-bucket"
GKE_DIR="gke"

echo

echo

cd $TF_WORKING_DIR/$GKE_DIR/layers

echo "====PROCESSING Project: ${GKE_DIR}: START===="

for dir in $(ls | sort -nr)
do
  echo

  echo "====PROCESSING ${GKE_DIR}/${dir} LAYER: START===="

  echo

  echo ">> cd ${dir}"
  cd ${dir}

  echo

  terraform destroy -auto-approve -var-file=environments/dev.tfvars

  rm -rf ./.terraform
  rm .terraform.*

  echo

  echo "====PROCESSING ${GKE_DIR}/${dir} LAYER: END ===="

  cd ..

done

echo "====PROCESSING Project: ${GKE_DIR}: END===="

cd $TF_WORKING_DIR/$TF_STATE_BUCKET_DIR

echo

echo "====PROCESSING Project: ${TF_STATE_BUCKET_DIR}: START===="

echo

terraform destroy -auto-approve -var-file=dev.tfvars

rm -rf ./.terraform
rm .terraform.*

echo

echo "====PROCESSING Project: ${TF_STATE_BUCKET_DIR}: COMPLETE===="

echo

echo
