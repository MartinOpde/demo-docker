# demo-docker

## Azure Container Task
Create Task
az acr task create --registry $ACR_NAME --name automatic-build --image demo:latest --context https://github.com/$GIT_USER/demo-docker.git --branch master --file Dockerfile --git-access-token $GIT_PAT

Run Task
az acr task run --registry $ACR_NAME --name automatic-build

List runs
az acr task list-runs --registry $ACR_NAME --output table   

Log currently executing task or last executed 
az acr task logs --registry $ACR_NAME   