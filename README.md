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
