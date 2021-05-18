!/bin/bash
kubectl create ns evil
kubectl delete --ignore-not-found=true -f /var/www/html/deploy.yml -n evil'
kubectl apply -f /var/www/html/deploy.yml -n evil
sleep 20
