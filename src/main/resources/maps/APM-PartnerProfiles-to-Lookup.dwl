%dw 2.0
output application/json
---
payload map ( payload01 , indexOfPayload01 ) -> {
	partnerId: payload01.id,
	partnerName: payload01.name,
	partnerEmail: payload01.contacts[?($.contactType.label == 'Technical Contact')][0].email default 'NONE',
	partnerPhone: payload01.contacts[?($.contactType.label == 'Technical Contact')][0].phoneNumber default 'NONE'
}