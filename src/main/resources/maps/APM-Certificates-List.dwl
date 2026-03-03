%dw 2.0
output application/json
---
{
	certificates: payload map ( payload01 , indexOfPayload01 ) -> {
		id: payload01.id,
		name: payload01.name,
		certificateType: payload01.certificateType,
		csmSecretType: payload01.csmSecret.secretType,
		usedInAs2: payload01.usedInAs2,
		expires: payload01.expires as Date as String {format: 'yyyy-MM-dd'},
		serialNumber: payload01.serialNumber,
		authority: payload01.authority,
		partnerId: payload01.partnerId,
		partnerPageUrl: "https://anypoint.mulesoft.com/partnermanager/#/organizations/" ++ p('anypoint.apm.orgid') ++ '/environments/' ++ p('anypoint.apm.envid') ++ '/partners/' ++ payload01.partnerId,
		partnerName: if(vars.apmProfilesFound == 'true') vars.apmPartners[?($.partnerId == payload01.partnerId)][0].partnerName else (lookup("apm-lookup-partnerInfoFlow", {partnerId: payload01.partnerId}, 5000)).name default "UNKNOWN",
		partnerEmail:  if(vars.apmProfilesFound == 'true') vars.apmPartners[?($.partnerId == payload01.partnerId)][0].partnerEmail else ((lookup("apm-lookup-partnerInfoFlow", {partnerId: payload01.partnerId}, 5000)).contacts[?($.contactType.label == "Technical Contact")].email joinBy ",") default "UNKNOWN",
		partnerPhone:  if(vars.apmProfilesFound == 'true') vars.apmPartners[?($.partnerId == payload01.partnerId)][0].partnerPhone else ((lookup("apm-lookup-partnerInfoFlow", {partnerId: payload01.partnerId}, 5000)).contacts[?($.contactType.label == "Technical Contact")].phoneNumber joinBy ",") default "UNKNOWN",
		//partnerName: (lookup("apm-lookup-partnerInfoFlow", {partnerId: payload01.partnerId}, 5000)).name default "UNKNOWN",
		//partnerEmail: ((lookup("apm-lookup-partnerInfoFlow", {partnerId: payload01.partnerId}, 5000)).contacts[?($.contactType.label == "Technical Contact")].email joinBy ",") default "UNKNOWN",
		//partnerPhone: ((lookup("apm-lookup-partnerInfoFlow", {partnerId: payload01.partnerId}, 5000)).contacts[?($.contactType.label == "Technical Contact")].phoneNumber joinBy ",") default "UNKNOWN",
		startDate: payload01.startDate
	}
}