﻿<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master" CodeBehind="OpenIdRpxHandler.aspx.cs" Inherits="Cynthia.Web.UI.OpenIdRpxHandlerPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
<cy:CornerRounderTop id="ctop1" runat="server" EnableViewState="false"  />
<asp:Panel ID="pnlRegister" runat="server" CssClass="panelwrapper register" >
<div class="modulecontent">
<fieldset>
    <legend>
        <asp:Literal ID="litHeading" runat="server" />
    </legend>

<asp:Panel ID="pnlOpenID" runat="server" CssClass="floatpanel" Visible="true">
<div id="divAgreement" runat="server" ></div>

<asp:Label ID="lblLoginFailed" runat="server" EnableViewState="False" Visible="False" />
<asp:Label ID="lblLoginCanceled" runat="server" EnableViewState="False" Visible="False" />
<asp:Literal ID="litResult" runat="server" />

</asp:Panel>
<asp:Panel ID="pnlNeededProfileProperties" runat="server" Visible="false">
<div class="settingrow">
    <cy:SiteLabel id="SiteLabel1" runat="server"  CssClass="settinglabel" ConfigKey="OpenIDLabel"> </cy:SiteLabel>
    <asp:Literal ID="litOpenIDURI" runat="server" />
</div>
<div id="divEmailDisplay" runat="server" class="settingrow">
    <cy:SiteLabel id="SiteLabel2" runat="server"  CssClass="settinglabel" ConfigKey="RegisterEmailLabel"> </cy:SiteLabel>
    <asp:Literal ID="litEmail" runat="server" />
</div>
<div id="divEmailInput" runat="server" class="settingrow">
    <cy:SiteLabel id="lblRegisterEmail1" runat="server" ForControl="txtEmail" CssClass="settinglabel" ConfigKey="RegisterEmailLabel"> </cy:SiteLabel>
    <asp:TextBox id="txtEmail" runat="server" columns="30" MaxLength="100"></asp:TextBox>
    <asp:RequiredFieldValidator  ControlToValidate="txtEmail"  ID="EmailRequired" runat="server" Display="Dynamic"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="regexEmail" runat="server" ControlToValidate="txtEmail" Display="Dynamic"></asp:RegularExpressionValidator>       
</div>
<asp:Panel ID="pnlRequiredProfileProperties" runat="server"></asp:Panel>
<div class="modulebuttonrow">
<asp:HiddenField ID="hdnIdentifier" runat="server" />
<asp:HiddenField ID="hdnPreferredUsername" runat="server" />
<asp:HiddenField ID="hdnDisplayName" runat="server" />
<asp:Button ID="btnCreateUser" runat="server" Text="Register" />
</div>
<div>
<asp:Literal ID="litInfoNeededMessage" runat="server" />
</div>
</asp:Panel>
<div class="clearpanel">
<asp:Label ID="lblError" runat="server" CssClass="txterror" />
</div>
</fieldset>
</div>
</asp:Panel>
<cy:CornerRounderBottom id="cbottom1" runat="server" EnableViewState="false" />	
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />