<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MvcSourceblog.Models.ContactU>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">



</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     
   <div id="viewText">

    <% using (Html.BeginForm()) {%>
        <%: Html.ValidationSummary(true) %>

        <fieldset>
            <legend>Contact:</legend>
            
    
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Name) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Name) %>
                <%: Html.ValidationMessageFor(model => model.Name) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Company) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Company) %>
                <%: Html.ValidationMessageFor(model => model.Company) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Email) %>
            </div>
            <div class="editor-field">
                <%: Html.TextBoxFor(model => model.Email) %>
                <%: Html.ValidationMessageFor(model => model.Email) %>
            </div>
            
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Help) %>
            </div>
            <div class="editor-field">
                <%: Html.TextAreaFor(model => model.Help, 10, 25, null)%>
                <%: Html.ValidationMessageFor(model => model.Help) %>
            </div>
            
       
            
            <p>
                <input type="submit" value="Contact" class="myButtton" />
            </p>

              <div style="margin:-400px 0px 0px 300px;width:360px; height:397px;color:#999999">
        <p style="font-size:large">Get in touch with Mysourceblog<br />Fill out our form and we'll be in touch shortly</p>
              
                   <p style="font-size:medium">Proposal requests <br />
                    website requests<br />
                    questionnaires <br /><br /></p>

                   <b>info@mysourceblog.com<br />
                    hr@mysourceblog.com<br /></b> 
           
                    </div>
              <div style="margin:-450px 0px 0px 700px;width:360px; height:397px;color:#999999">
                   <p style="font-size:large">Current location:</p>
                   <a href="<%: ViewData["map"] %>" target="_blank"><img src="<%: ViewData["map"] %>" alt="" /></a>
                  
              </div>
        </fieldset>
       

    <% } %>
    </div>
</asp:Content>

