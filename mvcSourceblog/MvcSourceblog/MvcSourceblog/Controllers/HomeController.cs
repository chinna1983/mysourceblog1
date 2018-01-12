using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net;
using System.Net.Mail;
using System.Security;
using System.Web.Security;
using System.Web.Routing;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using MvcSourceblog.Models;
using MvcSourceblog.GeocodeServices;
using MvcSourceblog.ImageryServices;


namespace MvcSourceblog.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        MysourceBlogRepository mysourceblogrepository = new MysourceBlogRepository();

        
       
        public ActionResult Index()
        {
         
            return View();
        }

        public ActionResult Privacy()
        {

            return View();
        }

        public ActionResult Games()
        {

            return View();
        }

        public JsonResult Rate(int id, int name, int value)
        {
            int data = 0;
            try
            {
                mysourceblogrepository.StarRatingClick(id, name, value);
                data = 1;
            }
            catch
            {
                data = 0;
            
            }

            return Json(data);
        }

        public ActionResult List()
        {
            var whatsNew = mysourceblogrepository.FindAllComponents().OrderBy(d => d.Posted);


            return View("List", whatsNew);
        }

        [HttpGet]
        public ActionResult Tools()
        {
            //var Components = mysourceblogrepository.FindAllComponents().OrderBy(d => d.Posted);
               
            //return View("Tools", Components);



            RatingViewModal ComponentViewModal = new RatingViewModal();
            return View(ComponentViewModal);
        }

        public JsonResult Availability(string UserName)
        {
            string Taken = "0";


            if (mysourceblogrepository.IsUserAvilable(UserName))
            {
                Taken = "0";
            }
            else
            {
                Taken = "1";

            }


            return Json(Taken);
        }

        public JsonResult Verefy(string txtCode,string hdnCode)
        {
            string Taken = "0";

            
            if (txtCode == StringCipher.Decrypt(hdnCode.ToString(),"A123b789"))
            {
                Taken = "0";
            }
            else
            {
                Taken = "1";
            
            }


            return Json(Taken);
        }


        public JsonResult CreateVoucher(string Email)
        {
            string Taken = "0";
            
            try
            {
               string strRandomcode = getRandomString(8).ToString();
               SendVoucher(Email, strRandomcode);
                
                           
                Taken = StringCipher.Encrypt(strRandomcode.ToString(), Email+"A123b789");
            
            }
            catch (Exception ex)
            {
                Taken = "0";
            }
            
            return Json(Taken,"MIME");
        }

        [NonAction]
        public void SendVoucher(string Email, string strRandomcode)
        {
             
            string strMailActivation = System.IO.File.ReadAllText(Server.MapPath("../Activation.htm")).Replace("XXXXX", strRandomcode);

            SendMail(strMailActivation, "Activation Code", Email);
 
        }

        [NonAction]
        private string getRandomString(int seed)
        {
         
            var chars = "abcdefghijklmnopqrstuvwxyz0123456789";
            var random = new Random();
            var result = new string(
                Enumerable.Repeat(chars, seed)
                          .Select(s => s[random.Next(s.Length)])
                          .ToArray());

            return result;
        }

        [NonAction]
        public void SendMail(string strBody, string strsubject, string Address)
        {


            string fromEmail = "info@mysourceblog.com";
            string toEmail = Address;
            MailMessage message = new MailMessage(fromEmail, Address);
            message.Subject = strsubject;
            message.Body = strBody;
            message.IsBodyHtml = true;

            SmtpClient smtp = new SmtpClient();


            smtp.Send(message);


        }


      [HttpPost, Authorize]
      public JsonResult Components(int id)
        {

              // mysourceblogrepository.clickPlus(id);
           

                var Components = mysourceblogrepository.FindAllComponents().OrderBy(d => d.Posted);
                var result = (from p in Components where p.ID == id select p.Clicks).SingleOrDefault();



                return Json(result);


            
         
        }
  

        public ActionResult Foram()
        {
            foramViewModal formViewModal = new foramViewModal();
       

            return View(formViewModal);
        }


        [HttpPost, Authorize]
        public ActionResult Foram(foramViewModal collection)
        {

          
            foramViewModal formViewModal = new foramViewModal();
            if (ModelState.IsValid)
            {
               
                mysourceblogrepository.AddComment(collection.ForamMessage,User.Identity.Name);
                mysourceblogrepository.Save();
                
                return View(formViewModal);
            }
            else
            {
                return View(formViewModal);
            }
            

        }

        

        public ActionResult Contact()
        {


            ViewData["map"] = displayMap("Bangalore,Karnataka,India", 17, "HYBRID", 240, 320);
            
            return View();
        
        }

        [HttpPost]
        public ActionResult Contact(ContactU contact)
        {

            if (ModelState.IsValid)
            {
                mysourceblogrepository.Add(contact);
                mysourceblogrepository.Save();

             

                return RedirectToAction("Index");
            }
            ViewData["map"] = displayMap("Bangalore,Karnataka,India", 17, "HYBRID", 240, 320);
            return View("Contact");

            

           

        }


        private GeocodeServices.Location GeocodeAddress(string address)
        {
            GeocodeRequest geocodeRequest = new GeocodeRequest();
            // Set the credentials using a valid Bing Maps Key
            geocodeRequest.Credentials = new GeocodeServices.Credentials();
            geocodeRequest.Credentials.ApplicationId = "AhjlMbKnHDlgTASkyk750YRs5wR3_1gN2hEz6pahnE7Iiurq_DzrE4hDUgBxrtfN";
            // Set the full address query
            geocodeRequest.Query = address;

            // Set the options to only return high confidence results
            ConfidenceFilter[] filters = new ConfidenceFilter[1];
            filters[0] = new ConfidenceFilter();
            filters[0].MinimumConfidence = GeocodeServices.Confidence.High;
            GeocodeOptions geocodeOptions = new GeocodeOptions();
            geocodeOptions.Filters = filters;
            geocodeRequest.Options = geocodeOptions;
            // Make the geocode request
            GeocodeServiceClient geocodeService = new GeocodeServiceClient("BasicHttpBinding_IGeocodeService");
            GeocodeResponse geocodeResponse = geocodeService.Geocode(geocodeRequest);

            if (geocodeResponse.Results.Length > 0)
                if (geocodeResponse.Results[0].Locations.Length > 0)
                    return geocodeResponse.Results[0].Locations[0];
            return null;
        }

        private string GetMapUri(double latitude, double longitude, int zoom, string mapStyle, int width, int height)
        {
            MvcSourceblog.ImageryServices.Pushpin[] pins = new MvcSourceblog.ImageryServices.Pushpin[1];
            MvcSourceblog.ImageryServices.Pushpin pushpin = new MvcSourceblog.ImageryServices.Pushpin();
            pushpin.Location = new MvcSourceblog.ImageryServices.Location();
            pushpin.Location.Latitude = latitude;
            pushpin.Location.Longitude = longitude;
            pushpin.IconStyle = "2";
            pins[0] = pushpin;
            MapUriRequest mapUriRequest = new MapUriRequest();
            // Set credentials using a valid Bing Maps Key
            mapUriRequest.Credentials = new ImageryServices.Credentials();
            mapUriRequest.Credentials.ApplicationId = "AhjlMbKnHDlgTASkyk750YRs5wR3_1gN2hEz6pahnE7Iiurq_DzrE4hDUgBxrtfN";
            

            // Set the location of the requested image
            mapUriRequest.Pushpins = pins;
            // Set the map style and zoom level
            MapUriOptions mapUriOptions = new MapUriOptions();
            //mapUriOptions.ZoomLevel = 17;
            switch (mapStyle.ToUpper())
            {
                case "HYBRID":
                    mapUriOptions.Style = MvcSourceblog.ImageryServices.MapStyle.AerialWithLabels;
                    break;
                case "ROAD":
                    mapUriOptions.Style = MvcSourceblog.ImageryServices.MapStyle.Road;
                    break;
                case "AERIAL":
                    mapUriOptions.Style = MvcSourceblog.ImageryServices.MapStyle.Aerial;
                    break;
                case "BirdseyeWithLabels_v1":
                    mapUriOptions.Style = MvcSourceblog.ImageryServices.MapStyle.BirdseyeWithLabels_v1;
                    break;
                default:
                    mapUriOptions.Style = MvcSourceblog.ImageryServices.MapStyle.Road;
                    break;
            }

            mapUriOptions.ZoomLevel = 10;
            // Set the size of the requested image to match the size of the image control
            mapUriOptions.ImageSize = new MvcSourceblog.ImageryServices.SizeOfint();
            mapUriOptions.ImageSize.Height = height;
            mapUriOptions.ImageSize.Width = width;
            mapUriRequest.Options = mapUriOptions;

            ImageryServiceClient imageryService = new ImageryServiceClient("BasicHttpBinding_IImageryService");
            MapUriResponse mapUriResponse = imageryService.GetMapUri(mapUriRequest);

            return mapUriResponse.Uri;
        }
        private string displayMap(string address, int zoom, string mapStyle, int width, int height)
        {
            GeocodeServices.Location latlong = GeocodeAddress(address);
            double latitude = latlong.Latitude;
            double longitude = latlong.Longitude;
            return GetMapUri(latitude, longitude, zoom, mapStyle, width, height);
        }




    }
}
