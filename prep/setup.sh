#!/bin/bash
repo="raw.githubusercontent.com/pasqua1e/shiftleft_Github-Actions/blob/main"

pod=`kubectl get po -n dvwa|grep dvwa|cut -f1 -d" "`
#Within dvwa:
kubectl exec -n dvwa $pod -- bash -c "apt-get update;apt-get install curl -y"
kubctl exec -n dvwa $pod -- bash -c "curl -LO https://dl.k8s.io/release/v1.17.0/bin/linux/amd64/kubectl;chmod +x kubectl;mv kubectl /usr/bin"
kubectl exec -n dvwa -it $pod -- bash -c "curl -k https://$repo/files/runtime_attacks.sh -Lo /var/www/html/runtime_attacks.sh"
kubectl exec -n dvwa -it $pod -- bash -c "curl -k https://$repo/files/waas_attacks.sh -Lo /var/www/html/waas_attacks.sh"
kubectl exec -n dvwa -it $pod -- bash -c "curl -k https://$repo/files/deploy.sh -Lo /var/www/html/deploy.sh"
kubectl exec -n dvwa -it $pod -- bash -c "curl -k https://$repo/files/exec.php -Lo /var/www/html/exec.php"
kubectl exec -n dvwa -it $pod -- bash -c "curl -k https://$repo/files/deploy.yml -Lo /var/www/html/deploy.yml"
kubectl exec -n dvwa -it $pod -- bash -c "chown www-data:www-data /var/www/html/*;chmod +x /var/www/html/*.sh"

kubectl create sa -n dvwa dvwa
kubectl create clusterrole dvwa --verb=* --resource=*
kubectl create clusterrolebinding dvwa --serviceaccount=dvwa:dvwa --clusterrole=dvwa

#Delete dvwa deployment and create modified one:
kubectl create deploy dvwa-sa --image=vulnerables/web-dvwa -n dvwa --dry-run -o yaml>dvwa.yaml
sed '/securityContext.*/a \ \ \ \ \ \ \ \ serviceAccount: test' dvwa.yaml >dvwa_sa.yaml
kubectl delete deploy dvwa -n dvwa
kubectl apply -f dvwa_sa.yaml
