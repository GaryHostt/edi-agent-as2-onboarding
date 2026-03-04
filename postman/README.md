# Postman Collections

Two collections for testing the Partner Manager Mule app and the Anypoint/Partner Manager APIs it uses.

**Deployment:** After pulling or changing Mule configs, run `mvn clean package` and redeploy the JAR (or run from Anypoint Code Builder) so the runtime loads an artifact that includes all configs (e.g. `apm-lookup-partnerInfo.xml`).

## Importing

1. Open Postman.
2. **Import** → **File** → select one or both JSON files in this folder:
   - `Partner-Manager-APIs.postman_collection.json`
   - `MCP-Partner-Manager-Tools.postman_collection.json`

## Partner Manager APIs

Direct calls to **Anypoint Platform** and **Partner Manager** REST APIs (same endpoints the Mule app uses).

### Setup

1. Open the **Partner Manager APIs** collection.
2. Edit **Variables** (collection or environment):
   - **client_id** – Anypoint Connected App client ID.
   - **client_secret** – Anypoint Connected App client secret.
   - **org_id** – Anypoint organization ID (defaults from project config).
   - **env_id** – Anypoint environment ID (defaults from project config).
3. Run **Auth → Get OAuth2 Token**. The script saves `access_token` so other requests use it automatically.
4. (Optional) Set **partner_id** when using **GET Partner Profile by ID** or **POST Create Endpoint**.

### Requests

- **Auth:** Get OAuth2 Token (saves `access_token`).
- **Partners:** GET Certificates, GET Partner Profiles, GET Partner Profile by ID, POST Create Partner Profile.
- **Endpoints:** POST Create Endpoint (example SFTP body; replace with AS2 payload for AS2 discovery).
- **Config & Tracking:** GET Custom Attributes, GET Tracking Activity Messages.

Do not commit real `client_secret` or tokens. Use Postman environment variables for secrets.

---

## MCP Partner Manager Tools

Calls to **this app’s MCP server** (Streamable HTTP). Use when the Mule app is running locally.

### Setup

1. Start the Mule app (e.g. `mvn mule:run` or run from Anypoint Code Builder). After a clean build (`mvn clean package`), redeploy by running from ACB or by copying `target/mcp-partner-manager-1.0.0-mule-application.jar` into your Mule runtime `apps/` directory.
2. Open the **MCP Partner Manager Tools** collection.
3. **Variables:**
   - **mcp_base** – Base URL (default `https://localhost:8083` from `https.port` in config).
   - **mcp_path** – Path (default `/`; change to e.g. `/mcp` if your MCP connector uses a different path).
4. For local HTTPS with a self-signed cert: **Settings** → **General** → turn off **SSL certificate verification** for this collection or for Postman.

### Requests

- **List Tools** – JSON-RPC `tools/list`; returns available tools and schemas.
- **Tool: get-b2b-partner-certificates** – No arguments.
- **Tool: get-b2b-partner-profiles** – No arguments.
- **Tool: create-b2b-partner-profile** – Example partner body; edit arguments as needed.
- **Tool: create-b2b-endpoints** – Example with one SFTP endpoint; use `partnerName` of an existing partner; for AS2, set `protocol` to `as2` and add AS2 fields.
- **Tool: search-b2b-transactions** – Required: `attribute`, `value`; optional: `partnerName`. Use attribute names from **GET Custom Attributes** in the APIs collection.

All MCP requests are POST with JSON-RPC 2.0 body and headers: `Accept: application/json, text/event-stream`, `Content-Type: application/json`.

---

## Test Prompt

Use this prompt to test end-to-end onboarding via the MCP tools (create partner profile, upload public key, create AS2 Send endpoint).

**Onboard a new B2B partner with the following details:**

**Partner Profile:**

- Name: Blue Ridge Logistics
- Type: PARTNER
- Identifiers:
  - AS2 ID: blueridge-as2
- Contact:
  - Name: Blue Ridge EDI Team
  - Email: edi@blueridgelogistics.com
  - Phone: 312-555-0198

**Public key** (upload as PUBLIC type for partner Blue Ridge Logistics; attach the generated file):

- Name: blueridgelogistics-as2-cert
- Generate the file, then attach it when uploading:

```bash
openssl req -x509 -newkey rsa:2048 -keyout key.pem -out blueridgelogistics-as2-cert.pem -days 365 -nodes \
  -subj "/CN=blueridge-as2/O=Blue Ridge Co/C=US"
```

Attach `blueridgelogistics-as2-cert.pem` when calling the upload tool.

**Endpoint:**

- Protocol: AS2
- Direction: SEND
- URL: https://as2.blueridgelogistics.com/as2
- Port: 443
- Partner AS2 ID: blueridge-as2
- Auth: BASIC — username: ediuser, password: Sunny#2026
