using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BigPipe.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult PageLet1()
        {
            System.Threading.Thread.Sleep(new Random().Next(3000,10000));
            return View("Pagelets/Pagelet1");
        }

        public ActionResult PageLet2()
        {
            System.Threading.Thread.Sleep(new Random().Next(3000, 10000));
            return View("Pagelets/Pagelet2");
        }

    }
}
