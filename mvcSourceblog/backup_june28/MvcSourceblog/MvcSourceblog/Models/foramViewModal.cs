using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;
using MvcSourceblog;


namespace MvcSourceblog.Models
{
    public class foramViewModal
    {
        MysourceBlogRepository mysourceblogrepository = new MysourceBlogRepository();
        public IQueryable<Foram> Foram { get; set; }
        public IQueryable<Artical> Artical { get; set; }

        [Required(ErrorMessage = "Message is required")]
        [StringLength(500,MinimumLength=3,ErrorMessage = "ForamMessage may not be longer than 500 characters")]
        public string ForamMessage { get; set; }

        public foramViewModal()
        {
            Foram = mysourceblogrepository.FindAllComments().OrderBy(d => d.Posted);
            Artical = mysourceblogrepository.FindAllArticals().OrderBy(d => d.Posted);
            ForamMessage = string.Empty;

        }
    }

    
}