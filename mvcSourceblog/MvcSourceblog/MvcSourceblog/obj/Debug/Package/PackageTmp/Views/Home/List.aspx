<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MvcSourceblog.Models.Component>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	About
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div id="viewText">
    

    <fieldset>
            <legend>What's New:</legend>


      

    <% foreach (var item in Model) { %>

      <p style="font-size:x-large"><b><%: item.Title %> - <%: String.Format("{0:d}", item.Posted) %> <br /><br /></b></p>
           <p style="font-size:medium"><%: Html.Encode(item.Discription) %></p>
           <br />
           <br />
           
    
    <% } %>

    </fieldset>

   </div>

</asp:Content>

