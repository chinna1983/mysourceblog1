using System;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web.Mvc;

namespace MvcSourceblog.Models
{
    [Bind(Include = "Name,Company,Email,Help")]
    [MetadataType(typeof(ContactU_Validation))]
    public partial class ContactU
    {


    }

   public class ContactU_Validation
   {

       //[HiddenInput(DisplayValue = false)]
       //public int ContactId { get; set; }

       //[HiddenInput(DisplayValue = false)]
       //public int IsActive { get; set; }
       
       [Required(ErrorMessage = "Name is required")]
       [StringLength(50, ErrorMessage = "Name may not be longer than 50 characters")]
       public string Name{get;set;}

       [Required(ErrorMessage = "Company is required")]
       [StringLength(50, ErrorMessage = "Company may not be longer than 50 characters")]
       public string Company {get;set;}

       [Required(ErrorMessage = "Email is required")]
       [StringLength(50, ErrorMessage = "Email may not be longer than 50 characters")]
       [DataType(DataType.EmailAddress)]
       public string Email {get;set;}

       [Required(ErrorMessage = "Help is required")]
       [StringLength(50, ErrorMessage = "Help may not be longer than 50 characters")]
       public string Help { get; set; }
   }
}