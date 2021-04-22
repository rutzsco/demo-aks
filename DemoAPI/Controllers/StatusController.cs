using Microsoft.AspNetCore.Mvc;

using System;
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
        public string Get()
        {
            return "OK";
        }
    }
}
