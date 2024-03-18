## Setting up

Create a `.env` file with the following:
```
# Do not commit this to source control, as it can contain secrets.

# Used by automated tests
AZURE_API_URL=https://azureexperiment-dev.azurewebsites.net
```

Install the following:
- .NET8
- VSCode extensions (C# Dev Kit, Azure Functions, Azure Resources)
- Azure CLI (for terraform deployment)

It will take some manual effort to provide OIDC for your local environment.

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

CICD controls the deployment when pushing to `main`. It will deploy to the `stage` environment. There is a manual trigger in GitHub actions to deploy to `prod` environment.

To manually deploy, run the steps:
- Build
```
cd src
dotnet publish -c Release -o build
```

- Initialise terraform (only needs to be run once)
```
cd terraform
terraform init -backend-config "key=azure_experiment.dev.terraform.tfstate"
```

- Deploy
```
cd terraform
terraform apply
```

Alternatively, use the Azure extension. Right click the Function App and select "Deploy to Function App"

## Notes

https://github.com/marketplace/actions/azure-login#login-with-openid-connect-oidc-recommended