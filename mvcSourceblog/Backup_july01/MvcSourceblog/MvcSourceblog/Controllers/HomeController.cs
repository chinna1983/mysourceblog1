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


        public ActionResult List()
        {
            var whatsNew = mysourceblogrepository.FindAllComponents().OrderBy(d => d.Posted);


            return View("List", whatsNew);
        }

        [HttpGet,Authorize]
        public ActionResult Tools()
        {
            var Components = mysourceblogrepository.FindAllComponents().OrderBy(d => d.Posted);
               
            return View("Tools", Components);
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

        public void SendVoucher(string Email, string strRandomcode)
        {
             
            string strMailActivation = System.IO.File.ReadAllText(Server.MapPath("../Activation.htm")).Replace("XXXXX", strRandomcode);

            SendMail(strMailActivation, "Activation Code", Email);
 
        }

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
        [HttpPost]
        
      public JsonResult Components(int id)
        {

           // mysourceblogrepository.clickPlus(id);

            
            var Components = mysourceblogrepository.FindAllComponents().OrderBy(d => d.Posted);
            var result = (from p in Components where p.ID == id select p.Clicks).SingleOrDefault();

            

            return Json(result +1);
            
         
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

            return View("Contact");

            

           

        }
    }
}
