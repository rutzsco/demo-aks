using Microsoft.AspNetCore.Mvc;

using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DemoAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class StatusController : Controller
    {
        [HttpGet]
        public IEnumerable<KeyValuePair<string, string>> Get()
        {
            var variables = new List<KeyValuePair<string,string>>();
            foreach (DictionaryEntry de in Environment.GetEnvironmentVariables())
                variables.Add(new KeyValuePair<string, string>(de.Key.ToString(), de.Value.ToString()));
            return variables;
        }
    }
}
