﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;



namespace MvcSourceblog.Models
{
    public class foramViewModal
    {
        MysourceBlogRepository mysourceblogrepository = new MysourceBlogRepository();
        public IQueryable<Foram> Foram { get; set; }
        public IQueryable<Artical> Artical { get; set; }
        public IQueryable<Rating> ArticalRating { get; set; }
        public IQueryable<RatingModal> ArticalRatingModal { get; set; }

        [Required(ErrorMessage = "Message is required")]
        [StringLength(500,MinimumLength=3,ErrorMessage = "ForamMessage 3 < 500 characters")]
        public string ForamMessage { get; set; }

        public foramViewModal()
        {
            Foram = mysourceblogrepository.FindAllComments().OrderBy(d => d.Posted);
            Artical = mysourceblogrepository.FindAllArticals().OrderBy(d => d.Posted);
            ArticalRating = mysourceblogrepository.getArticalRating();
            ArticalRatingModal = mysourceblogrepository.fillArticalRatingModal(Artical, ArticalRating);

            ForamMessage = string.Empty;

        }
    }

    
}