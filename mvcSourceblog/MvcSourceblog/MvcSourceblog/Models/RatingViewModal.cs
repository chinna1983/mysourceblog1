using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;


namespace MvcSourceblog.Models
{
    public class RatingViewModal
    {

        MysourceBlogRepository mysourceblogrepository = new MysourceBlogRepository();

        public IQueryable<Component> Component { get; set; }

        public IQueryable<Rating> ComponentRating { get; set; }

        public IQueryable<RatingModal> ComponentRatingModal { get; set; }


        public RatingViewModal()
        {

            Component = mysourceblogrepository.FindAllComponents();

            ComponentRating = mysourceblogrepository.getComponentRating();

            ComponentRatingModal = mysourceblogrepository.fillComponentRatingModal(Component, ComponentRating);

        }


    }

    public class RatingModal
    {
        public int ID { get; set; }
        public string Title { get; set; }
        public string Location { get; set; }
        public Nullable<global::System.DateTime> Posted { get; set; }
        public string version { get; set; }
        public Nullable<global::System.Int32> cClicks { get; set; }
        public int starClicks { get; set; }
        public int Maxrating { get; set; }
        public int starRating { get; set; }
        public int RatingItemId { get; set; }
        public int RatingTypeId { get; set; }
        public string ArticalUrl { get; set; }
        public string ArticalMessage { get; set; }
        public global::System.Decimal ArticalID { get; set; }



    }

}