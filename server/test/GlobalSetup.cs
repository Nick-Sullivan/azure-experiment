using NUnit.Framework;

namespace ApiTests;

[SetUpFixture]
public class GlobalSetup
{
    [OneTimeSetUp]
    public void SetUp()
    {
        DotEnv.Load();
        var url = System.Environment.GetEnvironmentVariable("AZURE_API_URL");
        Assert.NotNull(url, "Could not find environment variable AZURE_API_URL");
    }

    [OneTimeTearDown]
    public void TearDown()
    {
        // ...
    }
}
