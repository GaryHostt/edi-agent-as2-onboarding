%dw 2.0
import modules::APMLookups
output application/json
---
{
	id: "",
	name: "SFTP-Receive-from-" ++ vars.endpointsList.partnerName,
	description: "SFTP Receive endpoint created by MCP Tool",
	endpointType: payload.protocol,
	endpointTypeId: APMLookups::endpointTypes[?($.endpointType == payload.protocol)].endpointTypeId[0],
	endpointRole: payload.direction,
	partnerId: vars.apmPartners[?($.partnerName == vars.endpointsList.partnerName)].partnerId[0],
	environmentId: p('anypoint.apm.envid'),
	visibility: "EXTERNAL",
	supportedFormatTypes: payload.supportedFormats default "",
	config: {
		authMode: {
			authType: payload.authType,
			username: payload.username,
			password: payload.password
		},
		fileNamePattern: payload.fileNamePattern default "",
		path: payload.path,
		serverAddress: payload.serverAddress,
		serverPort: payload.port,
		configName: payload.protocol,
		credentials: {
			authType: "NONE"
		},
		pollingFrequency: payload.pollingFrequency,
		sizeCheckWaitTime: 1000
	}
}