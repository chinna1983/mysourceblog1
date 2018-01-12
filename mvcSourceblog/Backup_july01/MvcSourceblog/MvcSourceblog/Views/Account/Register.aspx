<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MvcSourceblog.Models.RegisterModel>" %>

<asp:Content ID="registerTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Register
    
   
</asp:Content>

<asp:Content ID="registerContent" ContentPlaceHolderID="MainContent" runat="server">

<script type="text/javascript">
    var varUser = null;
    var varVoucher = null;
    var varVerefy = null;
    
    function CheckAvailability() {
        $.post("/Home/Availability",
    { UserName: $("#UserName").val() },
        function (data) {
            var AviObject = eval('(' + data + ')');
            varUser = AviObject;
            if (varUser == "1") 
            {
                $("#divAvilable").html("<font color='green'>Avilable</font>")
                $("#UserName").attr("ReadOnly", "true");
            }
            else 
            {
                $("#divAvilable").html("<font color='red'>Not Avilable</font>")
            }
        });
    }
</script>


<script type="text/javascript">
    function CreateVoucher() {
        $.post("/Home/CreateVoucher",
    { Email: $("#Email").val() },
        function (data) {
            var VoucherObject = eval('(' + data + ')');
            varVoucher = VoucherObject;
            if (varVoucher == "0") {
                $("#hdnCode").val(VoucherObject)
                $("#divVoucher").html("<font color='red'>In Valid</font>");
            }
            else {
                $("#hdnCode").val(VoucherObject)
                $("#divVoucher").html("<font color='green'>Valid</font>");
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
            varVerefy = myObject;
            if (varVerefy == "0")
             {
                $("#DivVerefy").html("<font color='green'>Valid</font>");
                if (varUser == "1") {
                    $("#Register").removeAttr("disabled");
                }
                $("#Email").attr("ReadOnly", "true");
                $("#txtCode").attr("disabled", "true");

            }
            else 
            {
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
                    <%: Html.TextBoxFor(m => m.UserName, new { @onchange = "CheckAvailability()" })%><div style="display:inline;" id="divAvilable"></div>
                    <%: Html.ValidationMessageFor(m => m.UserName) %>
                </div>
                
                <div class="editor-label">
                    <%: Html.LabelFor(m => m.Email) %>
                </div>
                <div class="editor-field">
                    <%: Html.TextBoxFor(m => m.Email, new { @onchange = "CreateVoucher()" })%><div style="display:inline;" id="divVoucher"></div>
                    <%: Html.ValidationMessageFor(m => m.Email) %>
                    <%:Html.HiddenFor(m=>m.hdnCode,null) %>
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

                 <div class="editor-label">
                    <%: Html.LabelFor(m => m.txtCode) %>
                </div>
                <div class="editor-field">
                    <%: Html.TextBoxFor(m => m.txtCode) %>
                    <%: Html.ValidationMessageFor(m => m.txtCode) %>
                </div>
                
                <p>
                    <input type="submit" id="Register" value="Register" class="myButtton" />
                       
                 </p>

                 <%--   <div style="padding:0px 0px 0px 500px">
                    <p>Check your email and verify your activation code :</p>
                    <%= Html.TextBox("txtCode", "", null)%>
                     <input type="button" value="verify" onclick="Verefy()" class="myButtton" />
                    <div style="display:inline;" id="DivVerefy"></div>
                    </div>--%>

               
            </fieldset>
        </div>
    <% } %>

   
</asp:Content>
