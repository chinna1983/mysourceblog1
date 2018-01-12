<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Home Page
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
   
  <div id="viewText">
  <p style="font-size:x-large"><b>Welcome to MySourceblog</b></p>

  <p>This is my personal blog.</p>
  <p>Register for free  click here <%: Html.ActionLink("Register", "Register","Account") %> to view and download available components,</p>
  <p>You can read articles and messages related to technology.you can post your comments.</p>
  <p>Catch me on <a href="http://www.linkedin.com/pub/peketi-venkata-krishna-reddy/16/170/35a" target="_blank">
        &nbsp;<img src="../../Img/linkedin.jpg"  alt="LinkedIn"  /></a></p>
  
  <p style="font-size:larger">Clients:</p>
  </div>
  <div id="Cmenucontainer">
            
            <ul id="Cmenu">
            <li><a href="http://www.josephmedia.co.uk" target="_blank"><img src="../../Img/Clients/josephmedia.jpg" alt=""/></a></li>
            <li><a href="http://www.9yardscreative.com/" target="_blank"><img src="../../Img/Clients/9Y-logo.png"   alt=""/></a></li>
            <li><a href="http://www.premierituk.com" target="_blank"><img src="../../Img/Clients/premier.gif" alt=""/></a></li>
            <li><a href="http://www.etv.tv" target="_blank"><img src="../../Img/Clients/etv.png" alt=""/></a></li>
            <li><a href="http://www.tcs.com" target="_blank"><img src="../../Img/Clients/tcs.png"  alt=""/></a></li>
            <li><a href="http://www.marico.com" target="_blank"><img src="../../Img/Clients/maricoLogo-brands.jpg" alt=""/><br /></a></li>
            
            
            </ul>


            </div>
  
 
</asp:Content>
