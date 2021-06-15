ETCDCTL_API=3 etcdctl --endpoints 10.128.0.8:2379 \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--write-out=table snapshot status $1
