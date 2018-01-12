<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MvcSourceblog.Models.foramViewModal>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Foram
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div id="viewText">
            <% foreach (var artical in Model.Artical) { %>

             <fieldset>
            <legend>Articals:</legend>
            <a href="<%: artical.ArticalUrl%>" target="_blank"><%: artical.ArticalMessage%></a> <%: String.Format("{0:d}", artical.Posted)%>
        </fieldset>
        
            <% } %>

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
