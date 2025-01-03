_Author_:  Pranavan Subendiran \
_Created_: 17th Dec 2024 \
_Updated_: 19th Dec 2024 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from HubSpot CRM Commerce Discounts. 
The OpenAPI specification is obtained from (TODO: Add source link).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.


1. `date-time` type mentioned in `discounts.json` was changed to `datetime`.
2. Change the url property of the servers object:

    * Original: `https://api.hubapi.com`
    * Updated: `https://api.hubapi.com/crm/v3/objects/discounts`
    * Reason: This change is made to ensure that    all API paths are relative to the versioned base URL (crm/v3/objects/taxes), which improves the consistency and usability of the APIs.

3. Update API Paths:

    * Original: `/crm/v3/objects/discounts`
    * Updated: `/`
    * Reason: This modification simplifies the API paths, making them shorter and more readable. It also centralizes the versioning to the base URL, which is a common best practice.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/discounts.json --mode client -o ballerina
```
Note: The license year is hardcoded to 2024, change if necessary.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
# TODO: Add OpenAPI CLI command used to generate the client
```
Note: The license year is hardcoded to 2024, change if necessary.
