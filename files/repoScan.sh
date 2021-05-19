#!/bin/bash -l


curl -k -u $TL_USER:$TL_PASS "https://$TL_CONSOLE/api/v1/util/twistcli" -v -o twistcli
chmod +x twistcli
./twistcli coderepo scan --address https://console-master-pasq.prussiello.demo.twistlock.com -u $TL_USER -p $TL_PASS .  
