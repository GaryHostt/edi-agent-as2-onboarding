%dw 2.0
import modules::APMLookups
output application/json
---
{
	partnerType: payload.partnerType,
	environmentId: p('anypoint.apm.envid'),
    name: payload.partnerName,
    contacts: [
        {
            name: payload.contact.name,
            email: payload.contact.email,
            phoneNumber: payload.contact.phoneNumber,
            contactType: {
                id: "020f4c28-a0c2-4e70-b25d-8ab68f1a2020",
                name: "Technical",
                label: "Technical contact",
                description: "Technical contact"
            }
        }
    ],
     identifiers: payload.identifiers map (identifier, indexOfIdentifier) -> {
        identifierTypeQualifierId: APMLookups::APMIdentifiers[?($.qualifierCode) == identifier.identifierCode].qualifierId[0],
        value: identifier.value,
        status: "ACTIVE"
    }
}