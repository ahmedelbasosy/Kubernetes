#!/bin/bash
################# Installing kubectx and kubectn V0.9.3 ###############
wget https://github.com/ahmetb/kubectx/releases/download/v0.9.3/kubectx_v0.9.3_linux_x86_64.tar.gz
tar xf kubectx_v0.9.3_linux_x86_64.tar.gz

wget https://github.com/ahmetb/kubectx/releases/download/v0.9.3/kubens_v0.9.3_linux_x86_64.tar.gz
tar xf kubens_v0.9.3_linux_x86_64.tar.gz

mv kubctx kubens /usr/local/sbin
