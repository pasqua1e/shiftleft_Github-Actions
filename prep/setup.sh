#!/bin/bash
repo="raw.githubusercontent.com/pasqua1e/shiftleft_Github-Actions/main"
master=`echo $TL_CONSOLE|sed "s/console-//"|sed "s/\./-/g"`

#create sa
kubectl create sa -n dvwa dvwa
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: dvwa
rules:
- apiGroups:
  - ""
  resources:
  - '*'
  verbs:
  - '*'
- apiGroups:
  - apps
  resources:
  - deployments
  verbs:
  - '*'
EOF
kubectl create clusterrolebinding dvwa --serviceaccount=dvwa:dvwa --clusterrole=dvwa

#Delete dvwa deployment and create modified one
cat <<EOF >dvwa-web.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    apps: dvwa-web
  name: dvwa-web
  namespace: dvwa
spec:
  replicas: 1
  selector:
    matchLabels:
      app: dvwa-web
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: dvwa-web
    spec:
      containers:
      - image: vulnerables/web-dvwa
        imagePullPolicy: Always
        name: dvwa-web
        ports:
        - containerPort: 80
          name: dvwa-web
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /var/www/.kube
          name: kubedir
        - mountPath: /var/www/.kube/config
          name: kubeconf
        - mountPath: /usr/bin/kubectl
          name: kubectl-exe
      dnsPolicy: ClusterFirst
      nodeSelector:
        kubernetes.io/hostname: CHANGEME
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      serviceAccount: dvwa
      serviceAccountName: dvwa
      volumes:
      - name: kubeconf
        hostPath:
          path: /root/.kube/config
          type: FileOrCreate
      - name: kubedir
        hostPath:
          path: /root/.kube
          type: DirectoryOrCreate 
      - name: kubectl-exe
        hostPath:
          path: /usr/bin/kubectl
          type: File      
EOF
sed "s/CHANGEME/$master/" dvwa-web.yaml >dvwa-new.yaml
kubectl delete deploy dvwa-web -n dvwa
kubectl apply -f dvwa-new.yaml

sleep 15

kubectl delete -n evil svc evilpetclinic
kubectl delete -n evil deploy evilpetclinic

pod=`kubectl get po -n dvwa|grep dvwa|grep -i running|cut -f1 -d" "`
#Within dvwa:
kubectl exec -n dvwa $pod -- bash -c "apt-get update;apt-get install curl -y"
kubectl exec -n dvwa $pod -- bash -c "curl -LO https://dl.k8s.io/release/v1.17.0/bin/linux/amd64/kubectl;chmod +x kubectl;mv kubectl /usr/bin"
kubectl exec -n dvwa $pod -- bash -c "curl -k https://$repo/files/runtime_attacks.sh -Lo /var/www/html/runtime_attacks.sh"
kubectl exec -n dvwa $pod -- bash -c "curl -k https://$repo/files/waas_attacks.sh -Lo /var/www/html/waas_attacks.sh"
kubectl exec -n dvwa $pod -- bash -c "curl -k https://$repo/files/deploy.sh -Lo /var/www/html/deploy.sh"
kubectl exec -n dvwa $pod -- bash -c "curl -k https://$repo/files/exec.php -Lo /var/www/html/exec.php"
kubectl exec -n dvwa $pod -- bash -c "curl -k https://$repo/files/deploy.yml -Lo /var/www/html/deploy.yml"
kubectl exec -n dvwa $pod -- bash -c "cp /var/www/.kube/config /var/www/html/kubeconfig"
kubectl exec -n dvwa $pod -- bash -c "chown www-data:www-data /var/www/html/*;chmod +x /var/www/html/*.sh"
kubectl exec -n dvwa $pod -- bash -c "mkdir /var/www/.kube;chown www-data:www-data /var/www/.kube"