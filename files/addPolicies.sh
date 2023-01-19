version=$(curl -s -q -k -u $TL_USER:$TL_PASS -H 'Content-Type: application/json' -X GET https://$TL_CONSOLE/api/v1/version | sed -e 's/"//' |cut -d. -f1)

 #version>=21
runtime_payload='{"_id":"containerRuntime","rules":[{"advancedProtectionEffect":"disable","kubernetesEnforcementEffect":"disable","cloudMetadataEnforcementEffect":"disable","wildFireAnalysis":"disable","processes":{"modifiedProcessEffect":"disable","cryptoMinersEffect":"alert","lateralMovementEffect":"alert","reverseShellEffect":"alert","suidBinariesEffect":"disable","defaultEffect":"alert","checkParentChild":false,"deniedList":{"effect":"disable","paths":[]},"allowedList":[],"disabled":true},"network":{"modifiedProcEffect":"disable","portScanEffect":"alert","rawSocketsEffect":"disable","defaultEffect":"alert","listeningPorts":{"allowed":[],"denied":[],"effect":"disable"},"outboundPorts":{"allowed":[],"denied":[],"effect":"disable"},"deniedIPsEffect":"disable","deniedIPs":[],"allowedIPs":[],"disabled":true},"dns":{"disabled":true,"defaultEffect":"alert","domainList":{"allowed":[],"denied":[],"effect":"disable"}},"filesystem":{"newFilesEffect":"alert","backdoorFilesEffect":"alert","encryptedBinariesEffect":"alert","suspiciousELFHeadersEffect":"alert","defaultEffect":"alert","deniedList":{"effect":"disable","paths":[]},"allowedList":[],"disabled":true},"customRules":[],"collections":[{"hosts":["*"],"images":["*gogs*","*jenkins*","*maildev*","*nexus3*","*openldap*","*postgres*","*selenium*","*splunk*","*twistlock/defender*","*twistlock/console*"],"labels":["*"],"containers":["*"],"namespaces":["*"],"accountIDs":["*"],"clusters":["*"],"name":"Infrastructure-Components","owner":"prussiello_paloaltonetworks_com","modified":"2022-12-05T09:14:12.071Z","color":"#1abae8","description":"Infrastructure Components","system":false,"prisma":false}],"name":"Demo_build - Ignore Infra","notes":"Demo_build - Ignore Infra","owner":"prussiello_paloaltonetworks_com","modified":"2023-01-19T14:39:32.376Z"},{"modified":"2023-01-19T14:32:22.358Z","owner":"prussiello_paloaltonetworks_com","name":"Demo_Rule_Runtime","previousName":"","collections":[{"hosts":["*"],"images":["*evilpetclinic*"],"labels":["*"],"containers":["*"],"functions":["*"],"namespaces":["*"],"appIDs":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"name":"evilpetclinic","owner":"prussiello_paloaltonetworks_com","modified":"2022-12-05T10:02:25.209Z","color":"#68DCFC","system":false,"prisma":false}],"advancedProtectionEffect":"alert","processes":{"disabled":false,"deniedList":{"effect":"prevent","paths":[]},"allowedList":["bash"],"modifiedProcessEffect":"prevent","cryptoMinersEffect":"prevent","lateralMovementEffect":"alert","reverseShellEffect":"alert","suidBinariesEffect":"prevent","defaultEffect":"prevent"},"network":{"disabled":false,"deniedIPsEffect":"alert","deniedIPs":[],"allowedIPs":[],"listeningPorts":{"allowed":[],"denied":[],"effect":"alert"},"outboundPorts":{"allowed":[],"denied":[],"effect":"alert"},"modifiedProcEffect":"alert","portScanEffect":"alert","rawSocketsEffect":"alert","defaultEffect":"alert"},"dns":{"disabled":false,"defaultEffect":"prevent","domainList":{"allowed":["cdn.twistlock.com","storage.googleapis.com","*paloaltonetworks.com"],"denied":["github.com"],"effect":"prevent"}},"filesystem":{"disabled":false,"deniedList":{"effect":"disable","paths":["/secret"]},"allowedList":[],"newFilesEffect":"prevent","backdoorFilesEffect":"prevent","encryptedBinariesEffect":"prevent","suspiciousELFHeadersEffect":"prevent","defaultEffect":"alert"},"kubernetesEnforcementEffect":"alert","cloudMetadataEnforcementEffect":"alert","customRules":[{"_id":18,"action":"incident","effect":"alert"}],"wildFireAnalysis":"alert","skipExecSessions":false},{"modified":"2022-12-05T09:14:27.521Z","owner":"prussiello_paloaltonetworks_com","name":"Default - alert on suspicious runtime behavior","previousName":"","collections":[{"hosts":["*"],"images":["*"],"labels":["*"],"containers":["*"],"functions":["*"],"namespaces":["*"],"appIDs":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"name":"All","owner":"system","modified":"2022-12-05T08:56:15.737Z","color":"#3FA2F7","description":"System - all resources collection","system":true,"prisma":false}],"advancedProtectionEffect":"alert","processes":{"disabled":false,"deniedList":{"effect":"alert","paths":[]},"allowedList":[],"modifiedProcessEffect":"alert","cryptoMinersEffect":"alert","lateralMovementEffect":"alert","reverseShellEffect":"alert","suidBinariesEffect":"alert","defaultEffect":"alert"},"network":{"disabled":false,"deniedIPsEffect":"alert","deniedIPs":[],"allowedIPs":[],"listeningPorts":{"allowed":[],"denied":[],"effect":"alert"},"outboundPorts":{"allowed":[],"denied":[],"effect":"alert"},"modifiedProcEffect":"alert","portScanEffect":"alert","rawSocketsEffect":"alert","defaultEffect":"alert"},"dns":{"disabled":true,"defaultEffect":"alert","domainList":{"allowed":[],"denied":[],"effect":"disable"}},"filesystem":{"disabled":false,"deniedList":{"effect":"alert","paths":[]},"allowedList":[],"newFilesEffect":"alert","backdoorFilesEffect":"alert","encryptedBinariesEffect":"alert","suspiciousELFHeadersEffect":"alert","defaultEffect":"alert"},"kubernetesEnforcementEffect":"alert","cloudMetadataEnforcementEffect":"alert","wildFireAnalysis":"alert","skipExecSessions":false}],"learningDisabled":false}' 
waas_payload1='{"_id":"containerAppFirewall","rules":[{"applicationsSpec":[],"readTimeoutSeconds":5,"skipAPILearning":false,"unprotectedAPIDiscoveryConfig":{},"windows":false,"collections":[{"hosts":["*"],"images":["*evilpetclinic*"],"labels":["*"],"containers":["*"],"functions":["*"],"namespaces":["*"],"appIDs":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"name":"evilpetclinic","owner":"prussiello_paloaltonetworks_com","modified":"2022-12-05T10:02:25.209Z","color":"#68DCFC","system":false,"prisma":false}],"name":"Evil_WAAS_Rule","notes":"Evil_WAAS_Rule","autoProtectPorts":true,"owner":"prussiello_paloaltonetworks_com","modified":"2023-01-19T14:49:19.258Z"}],"minPort":30000,"maxPort":31000}'
waas_payload2='{"_id":"containerAppFirewall","rules":[{"modified":"2023-01-19T16:13:30.205Z","owner":"prussiello_paloaltonetworks_com","name":"Evil_WAAS_Rule","previousName":"","notes":"Evil_WAAS_Rule","collections":[{"hosts":["*"],"images":["*evilpetclinic*"],"labels":["*"],"containers":["*"],"functions":["*"],"namespaces":["*"],"appIDs":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"name":"evilpetclinic","owner":"prussiello_paloaltonetworks_com","modified":"2022-12-05T10:02:25.209Z","color":"#68DCFC","system":false,"prisma":false}],"readTimeoutSeconds":5,"windows":false,"skipAPILearning":false,"autoProtectPorts":true,"trafficMirroring":{},"outOfBandScope":"","expandDetails":true,"applicationsSpec":[{"appID":"evilpet","sessionCookieSameSite":"Lax","sessionCookieSecure":false,"banDurationMinutes":2,"apiSpec":{"endpoints":[{"host":"*","basePath":"*","tls":false,"http2":false,"grpc":false}],"effect":"disable","fallbackEffect":"disable","queryParamFallbackEffect":"disable","paths":[]},"botProtectionSpec":{"userDefinedBots":[],"knownBotProtectionsSpec":{"searchEngineCrawlers":"disable","businessAnalytics":"disable","educational":"disable","news":"disable","financial":"disable","contentFeedClients":"disable","archiving":"disable","careerSearch":"disable","mediaSearch":"disable"},"unknownBotProtectionSpec":{"generic":"disable","webAutomationTools":"disable","webScrapers":"disable","apiLibraries":"disable","httpLibraries":"disable","botImpersonation":"disable","browserImpersonation":"disable","requestAnomalies":{"effect":"disable","threshold":9}},"sessionValidation":"disable","jsInjectionSpec":{"enabled":false,"timeoutEffect":"disable"},"reCAPTCHASpec":{"enabled":false,"secretKey":{},"type":"checkbox","allSessions":true,"successExpirationHours":24}},"dosConfig":{"enabled":true,"alert":{"burst":3,"average":2},"ban":{"burst":5,"average":4},"matchCriteria":[],"matchConditions":[]},"tlsConfig":{"minTLSVersion":"1.2","metadata":{},"HSTSConfig":{"enabled":false,"maxAgeSeconds":31536000,"includeSubdomains":false,"preload":false}},"networkControls":{"advancedProtectionEffect":"prevent","subnets":{"enabled":false,"allowMode":true,"allow":[],"fallbackEffect":"alert","alert":null,"prevent":null,"blockingMode":"allowed"},"countries":{"enabled":false,"allowMode":true,"allow":[],"fallbackEffect":"alert","alert":null,"prevent":null,"blockingMode":"allowed"},"exceptionSubnets":[]},"xss":{"effect":"prevent","exceptionFields":[]},"sqli":{"effect":"prevent","exceptionFields":[]},"cmdi":{"effect":"prevent","exceptionFields":[]},"lfi":{"effect":"prevent","exceptionFields":[]},"codeInjection":{"effect":"prevent","exceptionFields":[]},"attackTools":{"effect":"prevent","exceptionFields":[]},"shellshock":{"effect":"prevent"},"malformedReq":{"effect":"prevent"},"customBlockResponse":{},"headerSpecs":[],"csrfEnabled":true,"clickjackingEnabled":true,"intelGathering":{"infoLeakageEffect":"prevent","removeFingerprintsEnabled":true},"maliciousUpload":{"effect":"disable","allowedFileTypes":[],"allowedExtensions":[]},"body":{"skip":false,"inspectionSizeBytes":131072,"inspectionLimitExceededEffect":"disable"},"remoteHostForwarding":{"enabled":false,"target":""},"disableEventIDHeader":false,"autoApplyPatchesSpec":{"effect":"disable"},"certificate":{},"responseHeaderSpecs":[],"customRules":[]}]}],"minPort":30000,"maxPort":31000}'


curl -k -s \
  -u $TL_USER:$TL_PASS \
  -H 'Content-Type: application/json' \
  -X POST \
  -d '{"name":"evilpetclinic","containers":["*"],"hosts":["*"],"images":["*evilpetclinic*"],"labels":["*"],"appIDs":["*"],"functions":["*"],"namespaces":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"color":"#68DCFC"}' \
  https://$TL_CONSOLE/api/v1/collections

#add customer malware signature
curl -s -k \
  -u $TL_USER:$TL_PASS \
  -H 'Content-Type: application/json' \
  -X PUT \
  -d '{"feed":[{"name":"evil","md5":"b927cd908b58e703ab86f484b44a3791","allowed":false}]}' \
  https://$TL_CONSOLE/api/v1/feeds/custom/malware
  
curl -s -k \
  -u $TL_USER:$TL_PASS \
  -H 'Content-Type: application/json' \
  -X PUT \
  -d "$runtime_payload" \
  https://$TL_CONSOLE/api/v1/policies/runtime/container

status=$?

if [ $status -eq 0 ]
then
  echo "Successfully installed Runtime policies, among which Demo_Rule"
else
  echo "Runtime policy install failed, $status"
fi


curl -s -k \
  -u $TL_USER:$TL_PASS \
  -H 'Content-Type: application/json' \
  -X PUT \
  -d '{"rules":[{"modified":"2021-01-20T10:10:13.396Z","owner":"prussiello_paloaltonetworks_com","name":"Demo_Vuln_Rule","previousName":"Demo_Vuln_Rule","effect":"alert","collections":[{"hosts":["*"],"images":["*evilpetclinic*"],"labels":["*"],"containers":["*"],"functions":["*"],"namespaces":["*"],"appIDs":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"name":"evilpetclinic","owner":"prussiello_paloaltonetworks_com","modified":"2021-01-20T09:55:41.982Z","color":"#68DCFC","system":false}],"action":["*"],"condition":{"readonly":false,"device":"","vulnerabilities":[]},"group":["*"],"alertThreshold":{"disabled":false,"value":1},"blockThreshold":{"enabled":false,"value":0},"graceDays":0,"verbose":false,"allCompliance":false,"onlyFixed":false,"cveRules":[],"tags":[]},{"modified":"2020-12-31T16:25:29.357Z","owner":"prussiello_paloaltonetworks_com","name":"ATO-FrontEnd","previousName":"","disabled":true,"effect":"alert","collections":[{"hosts":["*"],"images":["*"],"labels":["ato:ATO-FrontEnd"],"containers":["*"],"accountIDs":["*"],"name":"ATO-FrontEnd","owner":"prussiello_paloaltonetworks_com","modified":"2021-01-19T17:21:40.415Z","color":"#207f62","description":"ATO for all containers accessed through the NGINX ingress controller","system":false}],"action":["*"],"condition":{"readonly":false,"device":"","vulnerabilities":[]},"group":["*"],"alertThreshold":{"disabled":false,"value":1},"blockThreshold":{"enabled":true,"value":1},"onlyFixed":true,"tags":[{"effect":"ignore","name":"ATO-FrontEnd-Mitigating_Controls","description":"Ignore mitigating controls for 1 yr","expiration":{"enabled":true,"date":"2021-07-02T05:00:00Z"}},{"effect":"ignore","name":"ATO-FrontEnd-POAM","description":"Ignore POAMed vulnerabilities for 6 months","expiration":{"enabled":true,"date":"2021-01-02T06:00:00Z"}}],"graceDays":0},{"modified":"2020-12-31T16:25:29.357Z","owner":"prussiello_paloaltonetworks_com","name":"demo_build - Product Sock Shop","previousName":"","effect":"alert","collections":[{"hosts":["*"],"images":["*"],"labels":["*"],"containers":["*"],"namespaces":["sock-shop"],"accountIDs":["*"],"name":"Sock-Shop","owner":"prussiello_paloaltonetworks_com","modified":"2021-01-19T17:21:40.548Z","color":"#86a21a","description":"Sock-Shop Namespace","system":false}],"action":["*"],"condition":{"readonly":false,"device":"","vulnerabilities":[]},"group":["*"],"alertThreshold":{"disabled":false,"value":4},"blockThreshold":{"enabled":false,"value":0},"onlyFixed":true,"graceDays":0},{"modified":"2020-12-31T16:25:29.357Z","owner":"system","name":"Default - ignore Twistlock components","previousName":"","effect":"alert","collections":[{"hosts":["*"],"images":["*twistlock*"],"labels":["*"],"containers":["*"],"functions":["*"],"namespaces":["*"],"appIDs":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"name":"Prisma Cloud resources","owner":"system","modified":"2021-01-19T17:04:04.288Z","color":"#021745","description":"System - Prisma Cloud images and containers collection","system":true}],"action":["*"],"condition":{"readonly":false,"device":"","vulnerabilities":[]},"group":["*"],"alertThreshold":{"disabled":false,"value":4},"blockThreshold":{"enabled":false,"value":0},"onlyFixed":true,"graceDays":0},{"modified":"2020-12-31T16:25:29.357Z","owner":"system","name":"Default - alert all components","previousName":"","effect":"alert","collections":[{"hosts":["*"],"images":["*"],"labels":["*"],"containers":["*"],"functions":["*"],"namespaces":["*"],"appIDs":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"name":"All","owner":"system","modified":"2021-01-19T17:04:04.288Z","color":"#3FA2F7","description":"System - all resources collection","system":true}],"condition":{"readonly":false,"device":"","vulnerabilities":[]},"alertThreshold":{"disabled":false,"value":0},"blockThreshold":{"enabled":false,"value":0},"graceDays":0}],"policyType":"containerVulnerability","_id":"containerVulnerability","type":"vulnerability","policyContext":"images"}' \
  https://$TL_CONSOLE/api/v1/policies/vulnerability/images

status=$?

if [ $status -eq 0 ]
then
  echo "Successfully installed image vulnerability policies, among which Demo_Vuln_Rule"
else
  echo "Vulnerability policy install failed, $status"
fi


curl -s -k \
  -u $TL_USER:$TL_PASS \
  -H 'Content-Type: application/json' \
  -X PUT \
  -d "$waas_payload1" \
   https://$TL_CONSOLE/api/v1/policies/firewall/app/container

curl -s -k \
  -u $TL_USER:$TL_PASS \
  -H 'Content-Type: application/json' \
  -X PUT \
  -d "$waas_payload2" \
   https://$TL_CONSOLE/api/v1/policies/firewall/app/container

status=$?

if [ $status -eq 0 ]
then
  echo "Successfully installed container WAAS policies, among which Demo_WAAS_Rule"
else
  echo "Container WAAS policy install failed, $status"
fi
