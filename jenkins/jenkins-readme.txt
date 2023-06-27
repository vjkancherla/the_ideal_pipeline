**** JENKINS ON MAC ******
>> export HOMEBREW_NO_AUTO_UPDATE=1
>> brew install jenkins-lts
>> brew services start jenkins-lts
>> browse to http://localhost:8080
>> brew services stop jenkins-lts


***** JENKINS ON K3d K8s ***************
[1] Install Jenkins using Skaffold:

>> skaffold deploy --port-forward

a. Skaffold creates a Helm release - my-jenkins - in jenkins namespace

b. A serviceAccount called "my-jenkins" is created, as part of the Helm release.
    The SA has the RBAC permissions to do everything on the K8s cluster.
    The RBAC permission are set using - tmp/jenkins/K8s-objects/jenkins-rbac.yaml

c. A service - my-jenkins-agent-listener:50000 - will be created for build agents/slaves to connect to Master

<<<NO LONGER REQUIRED. Now Part of skaffold>>
d. k port-forward svc/my-jenkins 9000:80 -n jenkins
    username: user
    password: kubectl get secret --namespace jenkins my-jenkins -o jsonpath="{.data.jenkins-password}" | base64 -d
<---->

<<<NO LONGER REQUIRED. Now Part of skaffold>>
[2] Create a K8s secret in jenkins namespace to allow for Kaniko builds from within Jenkins + K8s.

>> kubectl --namespace jenkins \
    create secret \
    docker-registry regcred \
    --docker-server "https://index.docker.io/v1/" \
    --docker-username "vjkancherla" \
    --docker-password "D0ck3rhubp4ssw0rd" \
    --docker-email "vj_kancherla@yahoo.com"
<---->

[3] Login to Jenkins Console and
a. go to Dashboard>>Manage Jenkins>>Configure Global Security
b. Agents>>TCP port for inbound agents, select "Fixed" and set it to 50000
The jenkins agents/slaves, which execute the build jobs, will connect to Jenkins master using this port


[4] Go to Dashboard>>Manage Jenkins>>Manage Nodes and Clouds>> Configure Clouds (top-left-hand-side)
Name: K3D-K8s
Kubernetes URL & Kubernetes server certificate key: Leave Empty (because we are running Jenkins the K8s cluster that we will also be deploying stuff to. We use the "my-jenkins" SA for this)
<Click Test-Connection button to verify connectivity>
Jenkins URL: http://my-jenkins.jenkins.svc.cluster.local:80
Jenkins Tunnel: my-jenkins-agent-listener.jenkins.svc.cluster.local:50000


[5] There are 2 jenkinsfiles defined for the_ideal_pipeline repo
- the_ideal_pipeline/jenkinsfiles/pre-merge/Jenkinsfile
    This file is used to defining the pipeline that will be triggered when PRs are created.
    Build-Image -> Deploy-To-Dev -> Verify-Depoloyment-To-Dev

- the_ideal_pipeline/jenkinsfiles/post-merge/Jenkinsfile
    This file is used for defining the pipeline that will be triggered when PRs are merged into Master
    Build-Image -> Deploy-To-Uat -> Verify-Depoloyment-To-Uat -> Deploy-To-Canary -> Verify-Depoloyment-To-Canary -> Deploy-To-Prod -> Verify-Depoloyment-To-Prod

[6] Login the Jenkins console and create the following Pre-Merge job
- Follow instruction from here, but make below changes: https://devopscube.com/jenkins-multibranch-pipeline-tutorial/
- For Step-6 [Behaviours], we are only interested in "Discover Pull requests from origin"
  - select Stragety: " The current pull request revision"
    we are only interested in PRs.
- For Step-7 [Mode], by jenkisfile, use script - jenkinsfiles/pre-merge/Jenkinsfile

[7] Login the Jenkins console and create the following Post-Merge job
- Follow instruction from here, but make below changes: https://devopscube.com/jenkins-multibranch-pipeline-tutorial/
- For Step-6 [Behaviours], we are only interested in "Discover branches"
  - select Stragety: " Exclude branches that are also filed as PRs"
    we are only interested in PRs.
- For Step-7 [Mode], by jenkisfile, use script - jenkinsfiles/post-merge/Jenkinsfile
