using Microsoft.AspNetCore.Mvc;

using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DemoAPI.Controllers
{
    [ApiController]
    public class StatusController : Controller
    {
        [HttpGet("status")]
        public IActionResult Get()
        {
            var version = "Unknown";
            var variables = Environment.GetEnvironmentVariables();
            if (variables.Contains("APPLICATION_VERSION"))
                version = variables["APPLICATION_VERSION"].ToString();
            
            var deploymentSlot = "Unknown";
            if (variables.Contains("DEPLOYMENT_SLOT"))
                deploymentSlot = variables["DEPLOYMENT_SLOT"].ToString();

            var vm = new { Version = version, DeploymentSlot = deploymentSlot };
            return new OkObjectResult(vm);
        }

        [HttpGet("status/full")]
        public IEnumerable<KeyValuePair<string, string>> GetFull()
        {
            var variables = new List<KeyValuePair<string, string>>();
            foreach (DictionaryEntry de in Environment.GetEnvironmentVariables())
                variables.Add(new KeyValuePair<string, string>(de.Key.ToString(), de.Value.ToString()));
            return variables;
        }
    }
}
