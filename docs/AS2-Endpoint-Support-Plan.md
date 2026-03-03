# AS2 Endpoint Support — Updated Implementation Plan

This document extends the original AS2 plan with refinements from Gemini and **codebase-aligned** snippets so implementation matches this MCP template (partner name at flow level, `vars.apmPartners` / `vars.endpointsList`, `p('anypoint.apm.envid')`).

---

## Refinements (from Gemini)

### 1. Certificate management (“self-signed trap”)

- AS2 requires the **partner’s public certificate** for encryption/signature verification.
- **Clarify:** Does the API expect a `certificateId` (UUID) of a certificate already in Partner Manager, or an inline reference?
- **Recommendation:** Treat certificates as **pre-provisioned**. Either:
  - Document that users must upload the certificate via Partner Manager (Certificates) first and pass `certificateId` / `keystoreId`, or
  - Add a separate MCP tool that calls `POST /organizations/{orgId}/environments/{envId}/certificates` to upload certificates, then reference the returned id in endpoint creation.

### 2. Schema strategy: `if`-`then` / `dependentSchemas`

- Use **conditional required** so that when `protocol == 'as2'`, AS2 fields are required and SFTP fields are not (and vice versa).
- Example pattern: `if`/`then` (or `dependentSchemas` in JSON Schema draft 2019-09+) so the MCP client/LLM knows:
  - `protocol == 'as2'` → require e.g. `partnerAs2Identifier`, `hostAs2Identifier`, `partnerAs2Url`, `partnerCertificateId` (and optional enums for algorithms).
  - `protocol == 'sftp'` → require `serverAddress`, `port`, `username`, `path`.

### 3. AS2 identifier validation

- AS2 IDs are **case-sensitive** and often disallow spaces or special characters; bad values can cause MDN failures later.
- In the **otherwise** block (or a validation step before the choice), add a check: reject or sanitize `as2Identifier` values that contain spaces or illegal characters, and return a clear error.

### 4. `endpointTypeId` verification

- The value `ab4c76b7-01b0-4bba-8f04-31c1487a3708` in `APMLookups.dwl` may differ by **control plane (US vs EU)** or Partner Manager release.
- **Action:** Run `GET .../endpoint-types` (or equivalent in your environment) and confirm the AS2 UUID before locking it in the DWL.

### 5. MDN: async vs sync and `receiptDeliveryUrl`

- For **Send** endpoints, if the partner requires an **asynchronous MDN**, the API may need:
  - A boolean (e.g. `isAsyncMdn`) and
  - A listener URL for the partner to send the receipt back (`receiptDeliveryUrl`).
- Include these in the schema and in the AS2 Send DWL so they can be mapped once the exact API keys are known.

---

## Optimized implementation order

| Step | Task | Why |
|------|------|-----|
| 1 | **API discovery** | Capture exact JSON for AS2 Send/Receive (and cert/keystore references). |
| 2 | **Cert management** | Decide: certificate IDs only (pre-provisioned) or add an upload tool. |
| 3 | **DataWeave maps** | Build AS2-Receive and AS2-Send DWLs using discovered keys and codebase conventions. |
| 4 | **Schema update** | Update `parameters-schema` with if-then and protocol-specific required/properties. |
| 5 | **Flow logic** | Add AS2 when branches + otherwise with `raise-error`. |

---

## Codebase-aligned conventions

In this template:

- **Partner name** is at **flow level:** `vars.endpointsList.partnerName` (not on each endpoint item).
- **Partner lookup:** `vars.apmPartners[?($.partnerName == vars.endpointsList.partnerName)].partnerId[0]`.
- **Environment ID:** `p('anypoint.apm.envid')` (no `vars.environmentId`).
- **Endpoint type ID:** Use `APMLookups::endpointTypes[?($.endpointType == 'as2')].endpointTypeId[0]` for consistency with SFTP (and verify UUID per section above).
- **Name:** SFTP uses a built name like `"SFTP-Receive-from-" ++ vars.endpointsList.partnerName`; for AS2 you can use `payload.endpointName` if added to the schema, or the same pattern for consistency.
- **supportedFormatTypes:** Existing SFTP uses a string (`payload.supportedFormats default ""`). Confirm with API whether it expects string or array; if array, use e.g. `(payload.supportedFormats default "EDI") as String` then split, or add array support in schema.

---

## DataWeave templates (aligned to this codebase)

**Important:** Config key names (`as2Identifier`, `url`, `enforceSecurity`, etc.) are placeholders until Phase 1 API discovery confirms the actual Partner Manager v2 API request body. Adjust the `config` object to match the discovered JSON.

### AS2 Send — `maps/MCP-Endpoint-Create-Obj-to-APM-AS2-Send-Endpoint-Create.dwl`

```dataweave
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
		// TODO: align keys with API discovery (e.g. as2Identifier, url, selfAs2Identifier, certificateId, etc.)
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
```

### AS2 Receive — `maps/MCP-Endpoint-Create-Obj-to-APM-AS2-Receive-Endpoint-Create.dwl`

```dataweave
%dw 2.0
import modules::APMLookups
output application/json
---
{
	id: "",
	name: (payload.endpointName default "AS2-Receive-from-" ++ vars.endpointsList.partnerName),
	description: payload.description default "AS2 Receive endpoint created by MCP Tool",
	endpointType: "as2",
	endpointTypeId: APMLookups::endpointTypes[?($.endpointType == "as2")].endpointTypeId[0],
	endpointRole: "RECEIVE",
	partnerId: vars.apmPartners[?($.partnerName == vars.endpointsList.partnerName)].partnerId[0],
	environmentId: p('anypoint.apm.envid'),
	visibility: "EXTERNAL",
	supportedFormatTypes: payload.supportedFormats default "",
	config: {
		// TODO: align keys with API discovery (e.g. as2Identifier, enforceSecurity, keystoreId, certificateId, apiManagerId)
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
```

---

## Schema: if-then logic (example)

Use inside the `endpoints.items` definition in `create-b2b-endpoints` parameters-schema. Relax the current global `required` so SFTP-only fields are not required for AS2.

```json
"allOf": [
  {
    "if": { "properties": { "protocol": { "const": "as2" } }, "required": ["protocol"] },
    "then": {
      "required": ["partnerAs2Identifier", "hostAs2Identifier", "partnerAs2Url", "partnerCertificateId"],
      "properties": {
        "encryptionAlgorithm": { "type": "string", "enum": ["AES128_CBC", "AES256_CBC", "DES_EDE3", "UNENCRYPTED"] },
        "signatureAlgorithm": { "type": "string", "enum": ["SHA1", "SHA256", "SHA512", "UNSIGNED"] },
        "isAsyncMdn": { "type": "boolean" },
        "receiptDeliveryUrl": { "type": "string", "format": "uri" }
      }
    }
  },
  {
    "if": { "properties": { "protocol": { "const": "sftp" } }, "required": ["protocol"] },
    "then": {
      "required": ["serverAddress", "port", "username", "path"]
    }
  }
]
```

Adjust `required` at the top level of `endpoints.items` so that only `endpointName`, `protocol`, and `direction` are always required; protocol-specific required come from the if-then above.

---

## Otherwise block (unsupported protocol/direction)

Add an **otherwise** branch so that unsupported combinations do not hit the POST with raw MCP payload:

```xml
<otherwise>
    <raise-error
        type="APP:UNSUPPORTED_PROTOCOL"
        description="#['The protocol ''' ++ (payload.protocol default 'unknown') ++ ''' with direction ''' ++ (payload.direction default 'unknown') ++ ''' is not currently supported by this onboarding tool.']" />
</otherwise>
```

Ensure the error type `APP:UNSUPPORTED_PROTOCOL` is defined in the app's error namespace if required by your Mule version.

---

## Checklist before implementation

- [ ] Run GET on endpoint-types (or equivalent) and confirm AS2 `endpointTypeId` for your environment.
- [ ] From Partner Manager v2 API / Exchange, capture exact POST body for AS2 Receive and AS2 Send (including config key names).
- [ ] Decide certificate strategy: pre-provisioned only vs. MCP tool for certificate upload.
- [ ] Add AS2 identifier validation (no spaces/illegal chars) in flow or DWL.
- [ ] Implement AS2 when branches + otherwise in [mcp-b2b-partners-tools.xml](src/main/mule/mcp-b2b-partners-tools.xml).
- [ ] Create the two DWL files and align `config` keys with discovered API.
- [ ] Update parameters-schema with if-then and AS2/SFTP-specific required and enums.
