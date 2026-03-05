%dw 2.0
import modules::APMLookups
output application/json
---
{
	id: "",
	name: (payload.endpointName default ("AS2-Receive-from-" ++ vars.endpointsList.partnerName)),
	description: payload.description default "AS2 Receive endpoint created by MCP Tool",
	endpointType: "as2",
	endpointTypeId: APMLookups::endpointTypes[?($.endpointType == "as2")].endpointTypeId[0],
	endpointRole: "RECEIVE",
	partnerId: vars.apmPartners[?($.partnerName == vars.endpointsList.partnerName)].partnerId[0],
	environmentId: p('anypoint.apm.envid'),
	visibility: "EXTERNAL",
	supportedFormatTypes: payload.supportedFormats default "EDI",
	config: {
		hostAs2Identifier: payload.hostAs2Identifier,
		partnerAs2Identifier: payload.partnerAs2Identifier default null,
		enforceSecurity: payload.enforceSecurity default "SIGNED_ENCRYPTED",
		requireEncryptedMdn: payload.requireEncryptedMdn default false,
		mdnSignatureAlgorithm: payload.mdnSignatureAlgorithm default "SHA256",
		hostKeystoreId: payload.hostKeystoreId,
		partnerCertificateId: payload.partnerCertificateId default null,
		apiManagerId: payload.apiManagerId default null
	}
}
