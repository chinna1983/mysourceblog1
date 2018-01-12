<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MvcSourceblog.ContactU>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

   <%--  <table style="width:100%; height:103px;background-color:Olive; font-family:Helvetica Neue,Lucida Grande,Segoe UI,Arial,Helvetica,Verdana,sans-serif"><tr ><td ><h2>Contact</h2></td><td><h3>Get in touch with Mysourceblog<br />Fill out our form and we'll be in touch shortly</h3> </td></tr></table>--%>
   

    <% Html.EnableClientValidation(); %>
    <%: Html.ValidationSummary(true, "Please correct the errors and try again.")%>
    <% using (Html.BeginForm()) {%>
      
        <fieldset>
            <legend>Contact</legend>
            
           
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Name) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Name) %>
                <%: Html.ValidationMessageFor(model => model.Name,"*") %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Company) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Company) %>
                <%: Html.ValidationMessageFor(model => model.Company,"*") %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Email) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Email) %>
                <%: Html.ValidationMessageFor(model => model.Email, "*")%>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Help) %>
            </div>
            <div class="editor-field">
                <%: Html.TextAreaFor(model => model.Help,10,50, null)%>
                <%: Html.ValidationMessageFor(model => model.Help,"*")%>
            </div>
            
   
            
            <p>
                <input type="submit" value="Contact" />
            </p>
        </fieldset>

        <div style="margin:-400px 0px 0px 600px;width:360px; height:397px;color:#999999">
        <p style="font-size:large">Get in touch with Mysourceblog<br />Fill out our form and we'll be in touch shortly</p>
                    
                

                   <p style="font-size:medium">Proposal requests <br />
                    website requests<br />
                    questionnaires <br /><br /></p>

                   <b>info@mysourceblog.com<br />
                    hr@mysourceblog.com<br /></b> 

                    <div id="mapDiv">
                    <% Html.RenderPartial("map"); %>    
                  
                    </div>  
   
     
     

   
        </div>

    <% } %>

        

</asp:Content>

