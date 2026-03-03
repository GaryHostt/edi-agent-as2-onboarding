%dw 2.0
output application/json
---
payload map (msg, indexOfMsg) -> {
    timestamp: (msg.receivedTime >> "US/Pacific") as String {format: "yyyy/MM/dd HH:mm:ss"},
    direction: msg.direction,
    from: msg.partnerFrom.name,
    to: msg.partnerTo.name,
    messageType: msg.messageType,
    flowName: msg.documentFlowName,
    businessKey: msg.businessDocumentKey,
    ackStatus: msg.functionalAck.ackStatus,
    messageDetailUrl: "https://anypoint.mulesoft.com/partnermanager/#/organizations/" ++ p('anypoint.apm.orgid') ++ '/environments/' ++ p('anypoint.apm.envid') ++ '/activity/message/' ++ msg.id,
    attributes: msg.customAttributes map (att, indexOfAtt) -> {
        attribute: att.label,
        values: att.values
    }
}