## Generate a new token with read/write permissions
https://github.com/settings/tokens


```
export GITHUB_TOKEN="your-generated-token-here"
./run.sh
```

## To decrypt ssh keys
```
cp ssh_keys/github.rsa ~/.ssh/
ansible-vault decrypt --ask-vault-pass ~/.ssh/github.rsa
```

# Medallia specific

## Artifactory
get api key from
https://artifactory.eng.medallia.com/ui/admin/artifactory/user_profile

`docker login virtual-docker.artifactory.eng.medallia.com`
