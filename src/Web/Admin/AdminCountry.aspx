﻿<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    CodeBehind="AdminCountry.aspx.cs" Inherits="Cynthia.Web.AdminUI.AdminCountryPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
    <div class="breadcrumbs">
        <asp:HyperLink ID="lnkAdminMenu" runat="server" NavigateUrl="~/Admin/AdminMenu.aspx" />&nbsp;&gt;
        <asp:HyperLink ID="lnkCoreData" runat="server" NavigateUrl="~/Admin/AdminMenu.aspx" />&nbsp;&gt;
        <asp:HyperLink ID="lnkCurrentPage" runat="server" CssClass="selectedcrumb" />
    </div>
    <portal:CPanel ID="mp1" runat="server" ArtisteerCssClass="art-Post" RenderArtisteerBlockContentDivs="true">
    <cy:CornerRounderTop ID="ctop1" runat="server" />
    <asp:Panel ID="pnl1" runat="server" CssClass="art-Post-inner panelwrapper admin admincountry ">
        <h2 class="moduletitle heading">
            <asp:Literal ID="litHeading" runat="server" /></h2>
            <portal:CPanel ID="CynPanel1" runat="server" ArtisteerCssClass="art-PostContent">
        <div class="modulecontent ">
            <cy:CGridView ID="grdCountry" runat="server" AllowPaging="false" AllowSorting="true"
                AutoGenerateColumns="false" CssClass="" DataKeyNames="Guid" EnableTheming="false">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" CommandName="Edit" CssClass="buttonlink" Text='<%# Resources.Resource.CountryGridEditButton %>' />
                            &nbsp;&nbsp;
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Button ID="btnGridUpdate" runat="server" Text='<%# Resources.Resource.CountryGridUpdateButton %>'
                                CommandName="Update" />
                            <asp:Button ID="btnGridDelete" runat="server" Text='<%# Resources.Resource.CountryGridDeleteButton %>'
                                CommandName="Delete" />
                            <asp:Button ID="btnGridCancel" runat="server" Text='<%# Resources.Resource.CountryGridCancelButton %>'
                                CommandName="Cancel" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <%# Eval("Name") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtName" Columns="40" Text='<%# Eval("Name") %>' runat="server"
                                MaxLength="255" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <%# Eval("ISOCode2")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtISOCode2" Columns="5" Text='<%# Eval("ISOCode2") %>' runat="server"
                                MaxLength="2" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <%# Eval("ISOCode3")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtISOCode3" Columns="5" Text='<%# Eval("ISOCode3") %>' runat="server"
                                MaxLength="3" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </cy:CGridView>
            <div class="settingrow">
                &nbsp;<portal:CButton ID="btnAddNew" runat="server" />
            </div>
            <div class="modulepager">
                <portal:CCutePager ID="pgrCountry" runat="server" />
            </div>
            <div>
                <br class="clear" />
            </div>
        </div>
        </portal:CPanel>
        <div class="cleared"></div>
    </asp:Panel>
    <cy:CornerRounderBottom ID="cbottom1" runat="server" />
    </portal:CPanel>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
