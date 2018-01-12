using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MvcSourceblog.Models
{
    public class MysourceBlogRepository
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

        // Insert/Delete Methods

        public void Add(ContactU contact)
        {
            db.ContactUs.AddObject(contact);
        }


        public void AddComment(string ForamMessage)
        {
            Foram foram = new Foram();
            foram.ForamMessage = ForamMessage;
            foram.ForamUser = HttpContext.Current.User.Identity.Name;
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