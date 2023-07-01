Creating a Container Image using Kaniko
-------

Locally
------
see: /Users/vija0326/Downloads/Learning_K8S/kaniko.txt

docker run \
    -v "${PWD}/config.json":/kaniko/.docker/config.json:ro \
    -v "${PWD}":/workspace \
    gcr.io/kaniko-project/executor:latest \
    --dockerfile /workspace/Dockerfile \
    --destination "vjkancherla/podinfo_application:v1" \
    --context dir:///workspace/
