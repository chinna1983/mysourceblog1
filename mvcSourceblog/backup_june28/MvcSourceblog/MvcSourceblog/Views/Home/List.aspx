<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MvcSourceblog.Component>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	About
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div id="viewText">
    <h2>What's New</h2>

  
      

    <% foreach (var item in Model) { %>

      <%: item.Title %> - <%: String.Format("{0:g}", item.Posted) %> <br />
           <%: item.Discription %>
           <br />
           <br />
           
    
    <% } %>



   </div>

</asp:Content>

