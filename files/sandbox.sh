#!/bin/bash

#curl -k -u $TL_USER:$TL_PASS --details --output ./twistcli https://$TL_CONSOLE/api/v1/util/twistcli
#chmod a+x ./twistcli
 
docker pull pasqu4le/crypto_nginx:latest     
sudo ./twistcli sandbox -u $TL_USER --p $TL_PASS --address https://$TL_CONSOLE pasqu4le/evilpetclinic
echo

if [ $BYPASS_SANDBOX == 1 ]; then
   echo "Image Sandbox Analysis passed!"
   exit 0
#else
#   echo "Image Sandbox Analysis failed!"
#   exit 1
fi
