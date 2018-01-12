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

        mysourceblogdbEntities db = new mysourceblogdbEntities();

        public IQueryable<Component> FindAllComponents()
        {
            return db.Components.OrderBy(d=>d.Posted);
        }

        public IQueryable<Artical> FindAllArticals()
        {
            return db.Articals.OrderBy(d => d.Posted);
        }

        public IQueryable<Foram> FindAllComments()
        {
            return db.Forams.OrderBy(d => d.Posted);
        }

        public IQueryable<Rating> getComponentRating()
        {
            var Id = (from p in db.RatingTypes where p.RatingItem.Contains("Components") select p.Id).SingleOrDefault();

            return (from p in db.Ratings where p.RatingTypeId.Equals(Id) && p.Isactive==1 select p);

        }
        public IQueryable<RatingModal> fillComponentRatingModal(IQueryable<Component> component, IQueryable<Rating> ComponentRating)
        {

            return (from p in component join q in ComponentRating on p.ID equals q.RatingItemId select new RatingModal { ID = p.ID, Title = p.Title, Location = p.Location, Posted = p.Posted, version = p.version, cClicks = p.Clicks, starClicks = q.StarClicks, Maxrating = q.Maxrating, starRating = q.StarRating, RatingItemId = q.RatingItemId, RatingTypeId = q.RatingTypeId }).OrderBy(d => d.Posted);

        }

        public IQueryable<Rating> getArticalRating()
        {
            var Id = (from p in db.RatingTypes where p.RatingItem.Contains("Articals") select p.Id).SingleOrDefault();

            return (from p in db.Ratings where p.RatingTypeId.Equals(Id) && p.Isactive == 1 select p);

        }
        public IQueryable<RatingModal> fillArticalRatingModal(IQueryable<Artical> artical, IQueryable<Rating> ArticalRating)
        {

            return (from p in artical join q in ArticalRating on p.ArticalId equals q.RatingItemId select new RatingModal { ArticalID=p.ArticalId,ArticalUrl=p.ArticalUrl, ArticalMessage = p.ArticalMessage, Posted = p.Posted,starClicks = q.StarClicks, Maxrating = q.Maxrating, starRating = q.StarRating, RatingItemId = q.RatingItemId, RatingTypeId = q.RatingTypeId }).OrderBy(d=>d.Posted);
        
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

        public void StarRatingClick(int id, int name, int value)
        {
            int data = 0;
            var r = (from p in db.Ratings where p.RatingItemId.Equals(name) && p.RatingTypeId.Equals(value) select p).SingleOrDefault();

            r.StarClicks = r.StarClicks + 1;
            r.StarRating = r.StarRating + id;

            data = db.SaveChanges();
        
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