﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using System.Web.Routing;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Security;
using MvcSourceblog.Models;

namespace MvcSourceblog
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        MysourceBlogRepository mysourceblogrepository = new MysourceBlogRepository();
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );

   

        }

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            RegisterRoutes(RouteTable.Routes);
        }


        protected void Application_BeginRequest()
        {
            string path = HttpContext.Current.Request.FilePath;

            if (path.Contains("Components/DownLoads/"))
            {

              

                    mysourceblogrepository.strclickPlus(path);
                


            }
         
        
        }
    }
}