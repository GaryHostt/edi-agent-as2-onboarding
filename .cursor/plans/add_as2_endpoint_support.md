# Add AS2 Endpoint Support (plan pointer)

**Full plan (refinements, DWL templates, schema, otherwise):** [docs/AS2-Endpoint-Support-Plan.md](../../docs/AS2-Endpoint-Support-Plan.md)

**Implementation order:** API discovery → Cert strategy → DataWeave maps → Schema (if-then) → Flow (choice + otherwise).

**Touchpoints:**
- [src/main/mule/mcp-b2b-partners-tools.xml](src/main/mule/mcp-b2b-partners-tools.xml) — choice router, schema, otherwise
- [src/main/resources/maps/](src/main/resources/maps/) — AS2 Receive/Send DWLs
- [src/main/resources/modules/APMLookups.dwl](src/main/resources/modules/APMLookups.dwl) — AS2 endpointTypeId (verify via GET endpoint-types)
