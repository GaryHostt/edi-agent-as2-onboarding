The template contains flows outside of the MCP tools enabling the tools to perform the tasks that the agents and users want to accomplish.

## Anypoint login flow 
- The flow 'anypoint-loginFlow' executes a scheduler that refreshes the Anypoint login token every 15 minutes into an Object Store entry
- Various MCP tools included within this template use the access token to call Partner Manager platform APIs.

## Lookup partner flow
- The 'flow apm-lookup-partnerInfoFlow' is called from different MCP tools to retrieve the partner id and partner name cross reference lookup.
