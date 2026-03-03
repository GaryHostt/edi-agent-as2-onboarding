%dw 2.0
output application/json
var toTime = now() as DateTime
var fromTime = (now() - |P7D|) as DateTime
---
{
	(partnerId: vars.partnerId default 'UNKNOWN')  if(payload.partnerName?),
	customAttributeId1: vars.apmCustAttributes[?($.label == payload.attribute)].id[0],
	customAttributeValue1: payload.value,
	dateReceivedFrom: (fromTime  as String {
		format: "yyyy-MM-dd"
	}) ++ "T" ++ (fromTime as String {
		format: "HH:mm:ssxxx"
	} as String),
	dateReceivedTo: (toTime  as String {
		format: "yyyy-MM-dd"
	}) ++ "T" ++ (toTime as String {
		format: "HH:mm:ssxxx"
	} as String),
	expandCustomAttributes: "true",
	viewType: "messages",
	pageSize: "100"
}