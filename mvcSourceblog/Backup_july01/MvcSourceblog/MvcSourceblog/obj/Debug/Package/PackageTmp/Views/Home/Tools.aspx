<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MvcSourceblog.Models.Component>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Tools
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   <script type="text/javascript">
       function ClickPlus(id) 
       {

           $.post("/Home/Components", { id: id }, function (data) {
               var myObject = eval('(' + data + ')');
               var newid = myObject;
               $("#Clicks" + id).html("<b>Clicks:" + myObject + "</b>");

               
           });
           
       }
</script>

<div id="viewText">

   
         <fieldset> 
          <legend>Download components:</legend>
            <%=Html.AntiForgeryToken()%>
                
    <% foreach (var item in Model) { %>
    
       <p style="font-size:x-large"><b><%: item.Title %>:</b><br /></p> 
        <p style="font-size:medium"><b><%: item.Title %> <a href="<%:item.Location %>" id="<%: item.ID %>" target="_blank" onclick="ClickPlus(this.id)">Download</a><br /></b></p>
        <p style="font-size:medium" id="Clicks<%: item.ID %>"><b>Clicks:<%: item.Clicks %></b></p><br /><p style="font-size:medium">Posted on: <%: String.Format("{0:g}", item.Posted) %> <br /><br /></b></p>
        
       
                

      
    
    <% } %>
      <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=V47DR72P9886N"><img src="https://www.paypalobjects.com/en_US/GB/i/btn/btn_donateCC_LG.gif" alt="Pay pal Donate" /></a>
         </fieldset>
         </div>
    
</asp:Content>

