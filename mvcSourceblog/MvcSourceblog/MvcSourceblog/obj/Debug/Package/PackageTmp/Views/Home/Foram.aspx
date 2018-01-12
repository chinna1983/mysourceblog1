<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MvcSourceblog.Models.foramViewModal>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Foram
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

 <script type="text/javascript">
     function Rateme(id, name, value, item) {

         $.post("/Home/Rate", { id: id, name: name, value: value }, function (data) {
             var myObject = eval('(' + data + ')');
             var newid = myObject;
             if (newid != 0) {

                 $("#Thanks" + item).html("<font color='olive'><b>Thanks! for your  " + id + "  rating </b></font>");

             }

         });

     }
</script>

<div id="viewText">
             <fieldset>
            <legend>Articals:</legend>
           
            <% foreach (var artical in Model.ArticalRatingModal) { %>

           
            <a href="<%: artical.ArticalUrl%>" target="_blank"><%: artical.ArticalMessage%></a> <%: String.Format("{0:d}", artical.Posted)%><br /> <br />

            <% double j = 0; %>
           <% string imgclass =""; %>
           
            <%if (artical.starRating > 0)
              { %>
            <%j = artical.starRating / artical.starClicks;%>
            <%} %>

            <% for (int i = 0; i < artical.Maxrating; i++)
               { %>
            
                     
                       <%int id=i+1; %>
                       
                        <%if(j>=1) { %>

                        <%imgclass = "full"; %>

                        <%} %>
                        <%else if(j>0){ %>

                        <%imgclass = "half"; %>

                        <%} %>
                        <%else { %>

                        <%imgclass = "empty"; %>

                         <%} %>

                         
                         
                        <input type="radio"  name="<%: artical.RatingItemId %>" value="<%:artical.RatingTypeId %>" class="hidden"   id="<%:id%>"  />
                        <a  onclick="Rateme('<%:id%>','<%: artical.RatingItemId %>','<%:artical.RatingTypeId %>','<%: artical.ArticalID %>')" id="<%:imgclass %>" class="radio-picture">&nbsp;</a>


                        <%j = j - 1; %>

   <% } %>
   <div id="Thanks<%: artical.ArticalID %>"></div>
   
            
            
            <br /><br />
       
        
            <% } %>
             </fieldset>

        <% Html.EnableClientValidation(); %>
        <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>

        <fieldset>
            <legend>Post Your comments:</legend>
          
        <p>
            <%: Html.TextAreaFor(m => Model.ForamMessage, 15, 134, null)%>
            <%: Html.ValidationMessageFor(model => model.ForamMessage)%>
        </p>


            <p>
                <input type="submit" value="Comment!" class="myButtton" />
            </p>
        </fieldset>

    <% } %>







         <% foreach (var foram in Model.Foram) { %>
              
<fieldset><legend><%: foram.ForamUser%> posted on <%: String.Format("{0:d}", foram.Posted)%></legend>
          

                <%: foram.ForamMessage%>
              
        </fieldset>
            <% } %>



</div>
</asp:Content>
