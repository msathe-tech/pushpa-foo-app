#!/bin/bash

echo "GitHub Username:${GITHUB_USERNAME}"
echo "CommitSHA:${COMMIT_SHA}"
render_app_and_service() 
{
    pwd
    cd config-ci-cd

    sed -i 's/__VERSION__/'"$SHORT_SHA"'/g' overlays/deployment/kustomization.yaml
    kubectl kustomize overlays/deployment > ../sp1-config-sync-app-owner/gateway-api-demo-app.yaml

    cd ../sp1-config-sync-app-owner 

    echo "Update foo-app to version: ${SHORT_SHA}" > README.md
    

    git add gateway-api-demo-app.yaml && \
    git commit -m "Rendered: ${SHORT_SHA}
    Built from commit ${COMMIT_SHA} of repository foo-config-source - main branch 
    Author: $(git log --format='%an <%ae>' -n 1 HEAD)" && \

    echo "---Updated foo-app to version: ${SHORT_SHA}---"
    cd ..
}

git_push() 
{
    pwd
    cd sp1-config-sync-app-owner 
    #git tag ${SHORT_SHA}
    git push origin main #${SHORT_SHA}
    cd ..
}    

git_clone() 
{
    git clone https://github.com/${GITHUB_USERNAME}/sp1-config-sync-app-owner && \
    cd sp1-config-sync-app-owner 
    git config user.email ${GITHUB_EMAIL}
    git config user.name ${GITHUB_USERNAME}
    git remote set-url origin https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/${GITHUB_USERNAME}/sp1-config-sync-app-owner.git
    cd ..
}

echo "Deploying new service to receive 100% traffic"
# Git clone the app owner repo
git_clone
# Render app/service yamls
render_app_and_service
# git push to app owner repo
git_push
    