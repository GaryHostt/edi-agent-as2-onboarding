%dw 2.0
import modules::APMLookups
output application/json
---
{
	id: "",
	name: (payload.endpointName default "AS2-Send-to-" ++ vars.endpointsList.partnerName),
	description: payload.description default "AS2 Send endpoint created by MCP Tool",
	endpointType: "as2",
	endpointTypeId: APMLookups::endpointTypes[?($.endpointType == "as2")].endpointTypeId[0],
	endpointRole: "SEND",
	partnerId: vars.apmPartners[?($.partnerName == vars.endpointsList.partnerName)].partnerId[0],
	environmentId: p('anypoint.apm.envid'),
	visibility: "EXTERNAL",
	supportedFormatTypes: payload.supportedFormats default "",
	config: {
		partnerAs2Identifier: payload.partnerAs2Identifier,
		partnerAs2Url: payload.partnerAs2Url,
		hostAs2Identifier: payload.hostAs2Identifier,
		encryptionAlgorithm: payload.encryptionAlgorithm default "AES256_CBC",
		signatureAlgorithm: payload.signatureAlgorithm default "SHA256",
		messageSubject: payload.messageSubject default "AS2 Message from MuleSoft",
		requestReceipt: if (payload.requireMdn == true) "SIGNED" else "NONE",
		mdnSignatureAlgorithm: payload.mdnSignatureAlgorithm default "SHA256",
		isReceiptAsynchronous: payload.isAsyncMdn default false,
		receiptDeliveryUrl: payload.receiptDeliveryUrl default null,
		certificateId: payload.partnerCertificateId,
		connectionTimeout: payload.connectionTimeout default 30000,
		retryInterval: payload.retryInterval default 60,
		maxRetryAttempts: payload.maxRetryAttempts default 3
	}
}
