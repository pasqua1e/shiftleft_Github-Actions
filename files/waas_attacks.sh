#!/bin/bash -l

export KUBECONFIG=/var/www/html/kubeconfig

CHECKSVC=$(kubectl get svc -n evil|grep evil)
if [[ $CHECKSVC == *"No resources found"* ]]; then
   echo "nada"
else
   kubectl delete svc evilpetclinic -n evil
fi

kubectl expose deploy evilpetclinic -n evil --port=80 --target-port=8080
SVC=$(kubectl get svc -n evil|grep evil| awk '{ print $3 }')

echo "testing SQLi attack"
xff=$(printf %d.%d.%d.%d $((RANDOM%223+1)) $((RANDOM%256)){,,})
curl -H "X-Forwarded-For: $xff" $SVC?id=%25%27+and+1%3D0+union+select+null%2C+table_name+from+information_schema.tables+%23&Submit=Submit
if test "$status" == "0"; then
   echo "No error code. Is WAAS configured properly?"
else
   echo "Test exited WAAS protection with error code $status"
fi

echo "testing XSS attack"
xff=$(printf %d.%d.%d.%d $((RANDOM%223+1)) $((RANDOM%256)){,,})
curl -H "X-Forwarded-For: $xff" $SVC -d "<script>alert(1);</script>"

echo "testing OS Command Injection attack"
xff=$(printf %d.%d.%d.%d $((RANDOM%223+1)) $((RANDOM%256)){,,})
curl -H "X-Forwarded-For: $xff" $SVC -H "X-Original-Uri: /?id=&%20echo%20aiwefwlguh%20&"

echo "testing Code Injection attack"
xff=$(printf %d.%d.%d.%d $((RANDOM%223+1)) $((RANDOM%256)){,,})
curl -H "X-Forwarded-For: $xff" $SVC -d "?arg=1; phpinfo()"

echo "testing Local File Inclusion"
xff=$(printf %d.%d.%d.%d $((RANDOM%223+1)) $((RANDOM%256)){,,})
curl -H "X-Forwarded-For: $xff" $SVC -d "8.8.8.8; cat /etc/passwd"

echo "testing Shellshock Protection"
xff=$(printf %d.%d.%d.%d $((RANDOM%223+1)) $((RANDOM%256)){,,})
curl -H "X-Forwarded-For: $xff" $SVC --referer "() { :; }; ping -c 3 209.126.230.74"

echo "testing Malformed HTTP Request attack"
xff=$(printf %d.%d.%d.%d $((RANDOM%223+1)) $((RANDOM%256)){,,})
curl -H "X-Forwarded-For: $xff" $SVC -d "echo 'hello'"

echo "Testing DoS protection. (Remember to tweak the DoS settings...)"
xff=$(printf %d.%d.%d.%d $((RANDOM%223+1)) $((RANDOM%256)){,,})
for i in {1..51}; do curl -H "X-Forwarded-For: $xff" $SVC; done
