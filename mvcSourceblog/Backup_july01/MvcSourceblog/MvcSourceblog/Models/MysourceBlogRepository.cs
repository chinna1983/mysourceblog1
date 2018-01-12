using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using System.Globalization;

using System.Security.Principal;

using System.Web.Security;
using System.Web.UI;

namespace MvcSourceblog.Models
{
    public class MysourceBlogRepository:Controller
    {
       
        MysourceblogEntities db = new MysourceblogEntities();

        public IQueryable<Component> FindAllComponents()
        {
            return db.Components;
        }

        public IQueryable<Artical> FindAllArticals()
        {
            return db.Articals;
        }

        public IQueryable<Foram> FindAllComments()
        {
            return db.Forams;
        }

        public Boolean IsUserAvilable(string Username)
        {

           var strUser =db.aspnet_Users.SingleOrDefault(d => d.UserName == Username);

           if (strUser != null)
           {
               return true;

           }
           else
           {

               return false;
           }
        }

        // Insert/Delete Methods

        public void Add(ContactU contact)
        {
           db.ContactUs.AddObject(contact);
        }


        public void AddComment(string ForamMessage,string UserName)
        {
          
            
            Foram foram = new Foram();
            foram.ForamMessage = ForamMessage;
            foram.ForamUser = UserName;
            foram.Posted = System.DateTime.Now;
            foram.IsActive = 1;
            db.Forams.AddObject(foram);
        }

        public void clickPlus(int id)
        {

            Component cmp = db.Components.SingleOrDefault(d => d.ID == id);

            if (cmp != null)
            {

               

                cmp.Clicks = cmp.Clicks + 1;


                

                int num = db.SaveChanges();
            }

        
        }

        
        public void strclickPlus(string filename)
        {
           
           
                Component cmp = db.Components.SingleOrDefault(d => d.Location == filename);

                if (cmp != null)
                {

                    cmp.Clicks = cmp.Clicks + 1;

                    int num = db.SaveChanges();
                }

         

        }

        public void Save()
        {
            db.SaveChanges();
        }

    }
}