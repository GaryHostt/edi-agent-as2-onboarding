%dw 2.0
output application/json
---
{
	partners: payload map ( payload01 , indexOfPayload01 ) -> {
		id: payload01.id,
		name: payload01.name,
		description: payload01.description,
		websiteUrl: payload01.websiteUrl,
		partnerType: payload01.partnerType,
		contacts: payload01.contacts,
		identifiers: payload01.identifiers map ( identifier , indexOfIdentifier ) -> {
			id: identifier.id,
			qualifierLabel: identifier.qualifierLabel,
			typeLabel: identifier.typeLabel,
			typeName: identifier.typeName,
			code: identifier.code,
			value: identifier.value,
			identifierTypeQualifierId: identifier.identifierTypeQualifierId
		},
		addresses: payload01.addresses map ( address , indexOfAddress ) -> address,
		createdAt: payload01.createdAt,
		createdBy: payload01.createdBy,
		updatedAt: payload01.updatedAt,
		updatedBy: payload01.updatedBy
	}
}