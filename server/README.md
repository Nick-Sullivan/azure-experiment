## Setting up

Create a `.env` file with the following:
```
# Do not commit this to source control
ENVIRONMENT=dev
CLIENT_ID=...
CLIENT_SECRET=...
TENANT_ID=...
SUBSCRIPTION_ID=...

# Created by terraform, but not automatically updated
AZURE_API_URL=...
```

Install the following:
- .NET8
- VSCode extensions (C# Dev Kit, Azure Functions, Azure Resources)
- Azure CLI (for terraform deployment)

## Building locally

VSCode:
When running, it will automatically build.

Command line:
```
cd src
dotnet build
```

## Running locally

VSCode:
Use `Run and Debug` tab and run the `Local server` project.

Command line:
```
cd src
func host start
```

Then use Bruno (or Postman) to send API requests to your local server.

## Testing locally

VSCode:
Use `Testing` tab. To get more informative test build failures, use `Run and Debug` tab and run the `Build tests` project.

Command line:
```
cd test
dotnet test
```

## Deployment

CICD controls the deployment when pushing to `main`.

To manually deploy, run the steps:
- Build
```
cd src
dotnet publish -c Release -o build
```

- Deploy
```
cd terraform
terraform apply
```

Alternatively, use the Azure extension. Right click the Function App and select "Deploy to Function App"


## Notes

https://github.com/marketplace/actions/azure-login#login-with-openid-connect-oidc-recommended