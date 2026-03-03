%dw 2.0
output application/json
---
{
	name: payload.certificateName,
	certificateType: "PEM",
	certificate: payload.certificatePem
} ++ (if (payload.passphrase != null and (payload.passphrase as String) != "") { passphrase: payload.passphrase } else {})
