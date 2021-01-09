#!/bin/bash
sudo yum install -y bash-completion

source <(kubectl completion bash)

kubectl completion bash > ~/.kube/completion.bash.inc
printf "
  # Kubectl shell completion
  source '$HOME/.kube/completion.bash.inc'
  " >> $HOME/.bash_profile

source $HOME/.bash_profile

