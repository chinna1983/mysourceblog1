<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MvcSourceblog.Models.RegisterModel>" %>

<asp:Content ID="registerTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Register
    
   
</asp:Content>

<asp:Content ID="registerContent" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    function CheckAvailability() {
        $.post("/Home/CheckAvailability",
    { Email: $("#Email").val() },
        function (data) {
            var myObject = eval('(' + data + ')');
            var newid = myObject;
            if (newid == "0") {
                $("#hdnCode").val(myObject)
            }
            else {
                $("#hdnCode").val(myObject)
            }
        });
}
</script>


<script type="text/javascript">
    function Verefy() {
        $.post("/Home/Verefy",
    { txtCode: $("#txtCode").val(), hdnCode: $("#hdnCode").val() },
        function (data) {
            var myObject = eval('(' + data + ')');
            var newid = myObject;
            if (newid == "0") {
                $("#DivVerefy").html("<font color='green'>Valid</font>");
                $("#Register").removeAttr("disabled");
                $("#Email").attr("ReadOnly", "true");
                $("#txtCode").attr("disabled", "true");

            }
            else {
                $("#DivVerefy").html("<font color='red'>Invalid</font>")
            }
        });
    }
</script>
   

    <h2>Create a New Account</h2>
    <p>
        Use the form below to create a new account. 
    </p>
    <p>
        Passwords are required to be a minimum of <%: ViewData["PasswordLength"] %> characters in length.
    </p>

    <% using (Html.BeginForm()) { %>
        <%: Html.ValidationSummary(true, "Account creation was unsuccessful. Please correct the errors and try again.") %>
        <div>
            <fieldset>
                <legend>Account Information</legend>
                
                <div class="editor-label">
                    <%: Html.LabelFor(m => m.UserName)%>
                </div>
                <div class="editor-field">
                    <%: Html.TextBoxFor(m => m.UserName) %>
                    <%: Html.ValidationMessageFor(m => m.UserName) %>
                </div>
                
                <div class="editor-label">
                    <%: Html.LabelFor(m => m.Email) %>
                </div>
                <div class="editor-field">
                    <%: Html.TextBoxFor(m => m.Email, new { @onchange = "CheckAvailability()" })%>
                    <%: Html.ValidationMessageFor(m => m.Email) %>
                    <%:Html.Hidden("hdnCode","",null) %>
                </div>

               
                
                <div class="editor-label">
                    <%: Html.LabelFor(m => m.Password) %>
                </div>
                <div class="editor-field">
                    <%: Html.PasswordFor(m => m.Password) %>
                    <%: Html.ValidationMessageFor(m => m.Password) %>
                </div>
                
                <div class="editor-label">
                    <%: Html.LabelFor(m => m.ConfirmPassword) %>
                </div>
                <div class="editor-field">
                    <%: Html.PasswordFor(m => m.ConfirmPassword) %>
                    <%: Html.ValidationMessageFor(m => m.ConfirmPassword) %>
                </div>
                
                <p>
                    <input type="submit" id="Register" value="Register" disabled="disabled"  />
                       
                 </p>

                    <div style="padding:0px 0px 0px 500px">
                    <p>Check your email and verify your activation code :</p>
                    <%= Html.TextBox("txtCode", "", null)%>
                     <input type="button" value="verify" onclick="Verefy()" />
                    <div style="display:inline;" id="DivVerefy"></div>
                    </div>

               
            </fieldset>
        </div>
    <% } %>

   
</asp:Content>
