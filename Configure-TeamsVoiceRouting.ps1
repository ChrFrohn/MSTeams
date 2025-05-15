Set-CsOnlinePstnUsage -Identity Global -Usage @{Add=""}

New-CsOnlineVoiceRoutingPolicy -Identity "" -OnlinePstnUsages ""

New-CsOnlineVoiceRoute -Identity "" `
    -NumberPattern ".*" `
    -OnlinePstnGatewayList "" `
    -Priority 1 `
    -OnlinePstnUsages ""
