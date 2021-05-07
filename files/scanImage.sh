#!/bin/bash

curl -k -u $TL_USER:$TL_PASS --output ./twistcli https://$TL_CONSOLE/api/v1/util/twistcli
chmod a+x ./twistcli
 {
    docker pull pasqu4le/evilpetclinic:latest     
    curl -k -u $TL_USER:$TL_PASS --output ./twistcli https://$TL_CONSOLE/api/v1/util/twistcli
    ./twistcli images scan --u $TL_USER --p $TL_PASS --address https://$TL_CONSOLE --details pasqu4le/evilpetclinic
        
 } || {
            echo "Error detected"
	    echo "Build failed for some specific reason!"
      }
