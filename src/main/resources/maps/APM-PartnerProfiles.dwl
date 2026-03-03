%dw 2.0
output application/json
---
{
	partnerprofiles: payload map ( payload01 , indexOfPayload01 ) -> {
		id: payload01.id,
		name: payload01.name,
		partnerType: payload01.partnerType,
		status: {
			status: payload01.status.status
		},
		contacts: payload01.contacts map ( contact , indexOfContact ) -> {
			id: contact.id,
			name: contact.name,
			email: contact.email,
			phoneNumber: contact.phoneNumber,
			status: contact.status,
			contactType: contact.contactType
		},
		identifiers: payload01.identifiers map ( identifier , indexOfIdentifier ) -> {
			id: identifier.id,
			identifierTypeQualifierId: identifier.identifierTypeQualifierId,
			status: identifier.status,
			qualifierLabel: identifier.qualifierLabel,
			typeLabel: identifier.typeLabel,
			typeName: identifier.typeName,
			code: identifier.code,
			value: identifier.value
		},
		protocols: payload01.protocols map ( protocol , indexOfProtocol ) -> protocol,
		usedInDeployments: payload01.usedInDeployments
	}
}