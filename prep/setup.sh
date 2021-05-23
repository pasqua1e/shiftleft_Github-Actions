#!/bin/bash
repo="raw.githubusercontent.com/pasqua1e/shiftleft_Github-Actions/main"

pod=`kubectl get po -n dvwa|grep dvwa|cut -f1 -d" "`

#Within dvwa:
kubectl exec -n dvwa $pod -- bash -c "apt-get update;apt-get install curl -y"
kubectl exec -n dvwa $pod -- bash -c "curl -LO https://dl.k8s.io/release/v1.17.0/bin/linux/amd64/kubectl;chmod +x kubectl;mv kubectl /usr/bin"
kubectl exec -n dvwa $pod -- bash -c "curl -k https://$repo/files/runtime_attacks.sh -Lo /var/www/html/runtime_attacks.sh"
kubectl exec -n dvwa $pod -- bash -c "curl -k https://$repo/files/waas_attacks.sh -Lo /var/www/html/waas_attacks.sh"
kubectl exec -n dvwa $pod -- bash -c "curl -k https://$repo/files/deploy.sh -Lo /var/www/html/deploy.sh"
kubectl exec -n dvwa $pod -- bash -c "curl -k https://$repo/files/exec.php -Lo /var/www/html/exec.php"
kubectl exec -n dvwa $pod -- bash -c "curl -k https://$repo/files/deploy.yml -Lo /var/www/html/deploy.yml"
kubectl exec -n dvwa $pod -- bash -c "chown www-data:www-data /var/www/html/*;chmod +x /var/www/html/*.sh"

#kubectl create sa -n dvwa dvwa
#kubectl create clusterrole dvwa --verb=* --resource=*
#kubectl create clusterrolebinding dvwa --serviceaccount=dvwa:dvwa --clusterrole=dvwa
#kubectl exec -n dvwa -it $pod -- bash -c "mkdir /var/www/.kube;chown www-data:www-data /var/www/.kube"
#kubectl cp ~/.kube/config dvwa/${pod}:/var/www/.kube

#Delete dvwa deployment and create modified one:
#kubectl get deploy dvwa-web -n dvwa -o yaml>dvwa-web.yaml
#sed '/securityContext.*/a \ \ \ \ \ \ serviceAccount: dvwa' dvwa-web.yaml >dvwa-new.yaml
#kubectl delete deploy dvwa-web -n dvwa
#kubectl apply -f dvwa-new.yaml
