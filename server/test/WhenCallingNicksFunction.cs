using Microsoft.Playwright;
using Microsoft.Playwright.NUnit;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Text.Json;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace ApiTests;

[TestFixture]
public class WhenCallingNicksFunction
{
    private IPlaywright _playwright;
    private IAPIResponse _response;

    [OneTimeSetUp]
    public async Task SetUp()
    {
        _playwright = await Playwright.CreateAsync();
        var request = await _playwright.APIRequest.NewContextAsync(new() {
            BaseURL = "https://azureexperiment-dev.azurewebsites.net",
            ExtraHTTPHeaders = new Dictionary<string, string>(),
        });
        _response = await request.GetAsync("/api/NicksFunction");
    }

    [Test]
    public void ItShouldReturnStatus200()
    {
        Assert.True(_response.Ok);
    }

    [Test]
    public async Task ItShouldReturnExpectedString()
    {
        var text = await _response.TextAsync();
        Assert.That(text, Is.EqualTo("Welcome to Azure Functions!"))
    }

    [Test]
    public async Task DeliberateFailure()
    {
        var text = await _response.TextAsync();
        Assert.That(text, Is.EqualTo("Something else!"))
    }

}