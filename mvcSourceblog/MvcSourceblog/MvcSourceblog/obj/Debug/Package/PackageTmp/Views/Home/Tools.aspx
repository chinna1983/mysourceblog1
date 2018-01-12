<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MvcSourceblog.Models.RatingViewModal>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Tools
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   <script type="text/javascript">
       function ClickPlus(id) {

           $.post("/Home/Components", { id: id }, function (data) {
               var myObject = eval('(' + data + ')');
               var newid = myObject;
               $("#Clicks" + id).html("<b><p>Clicks:" + myObject + "</p></b>");


           });

       }
</script>

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
          <legend>Download components:</legend>
            <%=Html.AntiForgeryToken()%>


            <%foreach (var item in Model.ComponentRatingModal)
            { %>


     
            <p style="font-size:x-large"><b><%: item.Title %>:</b><br /></p> 
        <p style="font-size:medium"><b><%: item.Title %> <a href="<%:item.Location %>" id="<%: item.ID %>" target="_blank" onclick="ClickPlus(this.id)">Download</a><br /></b></p>
        <p style="font-size:medium" id="Clicks<%: item.ID %>"><b>Clicks:<%: item.cClicks %></b></p><br /><p style="font-size:medium">Posted on: <%: String.Format("{0:g}", item.Posted) %> <br />Version :<%:item.version %>  <br /><br />
        
         <% double j = 0; %>
           <% string imgclass =""; %>
           
            <%if (item.starRating > 0){ %>
            <%j = item.starRating / item.starClicks;%>
            <%} %>

            <% for (int i = 0; i < item.Maxrating; i++){ %>
            
                     
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

                         
                         
                        <input type="radio"  name="<%: item.RatingItemId %>" value="<%:item.RatingTypeId %>" class="hidden"   id="<%:id%>"  />
                        <a  onclick="Rateme('<%:id%>','<%: item.RatingItemId %>','<%:item.RatingTypeId %>',<%: item.ID %>)" id="<%:imgclass %>" class="radio-picture">&nbsp;</a> 


                        <%j = j - 1; %>

   <% } %> <div id="Thanks<%: item.ID %>"></div></p>
  
   
 
 <% } %>
                
 <br />
      <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=V47DR72P9886N"><img src="https://www.paypalobjects.com/en_US/GB/i/btn/btn_donateCC_LG.gif" alt="Pay pal Donate" /></a>
         </fieldset>
         </div>
    
</asp:Content>

