using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;

namespace Company.Function;

public class OtherFunction
{
    private readonly ILogger<OtherFunction> _logger;

    public OtherFunction(ILogger<OtherFunction> logger)
    {
        _logger = logger;
    }

    [Function("OtherFunction")]
    public IActionResult Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post")] HttpRequest req)
    {
        return new OkObjectResult("Hello!");
    }
}
