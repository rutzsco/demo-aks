using Microsoft.AspNetCore.Mvc;

using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace DemoAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SimulateController : ControllerBase
    {

        // GET api/simulate/5
        [HttpGet("{percentage}")]
        public string Get(int percentage, int duration = 60000)
        {
            if (percentage < 0 || percentage > 100)
                throw new ArgumentException("percentage");

            Stopwatch durationWatch = new Stopwatch();
            Stopwatch watch = new Stopwatch();
            watch.Start();
            durationWatch.Start();
            while (durationWatch.ElapsedMilliseconds < duration)
            {
                // Make the loop go on for "percentage" milliseconds then sleep the 
                // remaining percentage milliseconds. So 40% utilization means work 40ms and sleep 60ms
                if (watch.ElapsedMilliseconds > percentage)
                {
                    Thread.Sleep(100 - percentage);
                    watch.Reset();
                    watch.Start();
                }
            }

            return "OK";
        }
    }
}
