<%@ Page Language="C#" AutoEventWireup="false" MasterPageFile="~/App_MasterPages/layout.Master"
    Codebehind="OrderDetail.aspx.cs" Inherits="WebStore.UI.OrderDetailPage" %>

<asp:Content ContentPlaceHolderID="leftContent" ID="MPLeftPane" runat="server" />
<asp:Content ContentPlaceHolderID="mainContent" ID="MPContent" runat="server">
<portal:CPanel ID="mp1" runat="server" ArtisteerCssClass="art-Post" RenderArtisteerBlockContentDivs="true">
    <cy:CornerRounderTop id="ctop1" runat="server" />
    <asp:Panel ID="pnlOrderDetail" runat="server" CssClass="art-Post-inner panelwrapper webstore webstoreorderdetail">
        <h2 class="moduletitle">
            <asp:Literal ID="litOrderHeader" runat="server" /></h2>
            <portal:CPanel ID="CynPanel1" runat="server" ArtisteerCssClass="art-PostContent">
        <div class="modulecontent">
        <div class="floatpanel ordersummarywrapper">
            <div class="storerow">
                <cy:SiteLabel ID="SiteLabel3" runat="server" CssClass="settinglabel" ConfigKey="OrderIdLabel"
                    ResourceFile="WebStoreResources" />
                <asp:Label ID="lblOrderId" runat="server" />
            </div>
            <div class="storerow">
                <cy:SiteLabel ID="SiteLabel2" runat="server" CssClass="settinglabel" ConfigKey="OrderDetailOrderDateLabel"
                    ResourceFile="WebStoreResources" />
                <asp:Literal ID="litOrderDate" runat="server" />
            </div>
            <asp:Panel ID="pnlSubTotal" runat="server" CssClass="storerow">
                <cy:SiteLabel ID="SiteLabel1" runat="server" CssClass="settinglabel" ConfigKey="OrderDetailSubTotalLabel"
                    ResourceFile="WebStoreResources" />
                <asp:Literal ID="litSubTotal" runat="server" />
            </asp:Panel>
            <asp:Panel ID="pnlDiscount" runat="server" CssClass="storerow">
                    <cy:SiteLabel ID="SiteLabel11" runat="server" CssClass="settinglabel" ConfigKey="CartDiscountTotalLabel" ResourceFile="WebStoreResources" />
                    <asp:Literal ID="litDiscount" runat="server" />
                </asp:Panel>
            <asp:Panel ID="pnlShippingTotal" runat="server" CssClass="storerow">
                <cy:SiteLabel ID="SiteLabel5" runat="server" CssClass="settinglabel" ConfigKey="OrderDetailShippingTotalLabel"
                    ResourceFile="WebStoreResources" />
                <asp:Literal ID="litShippingTotal" runat="server" />
            </asp:Panel>
            <asp:Panel ID="pnlTaxTotal" runat="server" CssClass="storerow">
                <cy:SiteLabel ID="SiteLabel6" runat="server" CssClass="settinglabel" ConfigKey="OrderDetailTaxTotalLabel"
                    ResourceFile="WebStoreResources" />
                <asp:Literal ID="litTaxTotal" runat="server" />
            </asp:Panel>
            <asp:Panel ID="pnlOrderTotal" runat="server" CssClass="storerow">
                <cy:SiteLabel ID="SiteLabel7" runat="server" CssClass="settinglabel" ConfigKey="OrderDetailOrderTotalLabel"
                    ResourceFile="WebStoreResources" />
                <asp:Literal ID="litOrderTotal" runat="server" />
            </asp:Panel>
            
        </div>
        <asp:Panel ID="pnlCustomer" runat="server" Visible="false" CssClass="floatpanel ordersummarywrapper">
            <asp:Panel ID="pnlBillingAddress" runat="server">
                    <h3>
                        <asp:Literal ID="litBillingHeader" runat="server" /></h3>
                    <asp:Literal ID="litBillingName" runat="server" />
                    <asp:Literal ID="litBillingCompany" runat="server" />
                    <asp:Literal ID="litBillingAddress1" runat="server" />
                    <asp:Literal ID="litBillingAddress2" runat="server" />
                    <asp:Literal ID="litBillingSuburb" runat="server" />
                    <asp:Literal ID="litBillingCity" runat="server" />
                    <asp:Literal ID="litBillingState" runat="server" />
                    <asp:Literal ID="litBillingPostalCode" runat="server" />
                    <asp:Literal ID="litBillingCountry" runat="server" />
                </asp:Panel>
                <asp:Panel ID="pnlShippingAddress" runat="server" Visible="false">
                    <h3>
                        <asp:Literal ID="litShippingHeader" runat="server" /></h3>
                    <asp:Literal ID="litShippingName" runat="server" />
                    <asp:Literal ID="litShippingCompany" runat="server" />
                    <asp:Literal ID="litShippingAddress1" runat="server" />
                    <asp:Literal ID="litShippingAddress2" runat="server" />
                    <asp:Literal ID="litShippingSuburb" runat="server" />
                    <asp:Literal ID="litShippingCity" runat="server" />
                    <asp:Literal ID="litShippingState" runat="server" />
                    <asp:Literal ID="litShippingPostalCode" runat="server" />
                    <asp:Literal ID="litShippingCountry" runat="server" />
                </asp:Panel>
            </asp:Panel>
        <div class="clearpanel ordersummarywrapper">
        <h3 class="itemsheader"><asp:Literal ID="litItemsHeader" runat="server" /></h3>
        
        <asp:Repeater ID="rptOffers" runat="server" >
        <ItemTemplate>
                <div class="offeritemheading"><strong><%# Eval("Name") %> <%# string.Format(currencyCulture, "{0:c}",Convert.ToDecimal(Eval("OfferPrice"))) %></strong></div>
                <asp:Repeater id="rptProducts" runat="server">
                <HeaderTemplate><ul class="simplelist"></HeaderTemplate>
                <ItemTemplate>
                <li>
                <%# Eval("Name") %>
                </li>
                </ItemTemplate>
                <FooterTemplate></ul></FooterTemplate>
                </asp:Repeater>
            
        </ItemTemplate>
    </asp:Repeater>
        
        <span class="txterror"><asp:Literal ID="litPaymentPending" runat="server" /></span>
        <cy:SiteLabel ID="lblMustSignInToDownload" runat="server" CssClass="txterror" ConfigKey="MustSigninToDownload" ResourceFile="WebStoreResources" Visible="false" />
        <asp:Panel ID="pnlDownloadItems" runat="server" Visible="false" >
            <h2>
                <asp:Literal ID="litDownloadItemsHeader" runat="server" /></h2>
                
            <asp:Repeater ID="rptDownloadItems" runat="server">
                <ItemTemplate>
                    <div>
                        <a href='<%# Page.ResolveUrl(SiteRoot + "/WebStore/ProductDownload.aspx?pageid=" + pageId.ToString() + "&mid=" + moduleId.ToString() + "&ticket=" + Eval("Guid")) %>'>
                            <%# Eval("ProductName") %>
                        </a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </asp:Panel>
        </div>
        </div>
        </portal:CPanel>
        <div class="cleared"></div>
    </asp:Panel>
    
    <cy:CornerRounderBottom id="cbottom1" runat="server" />
    </portal:CPanel>
</asp:Content>
<asp:Content ContentPlaceHolderID="rightContent" ID="MPRightPane" runat="server" />
<asp:Content ContentPlaceHolderID="pageEditContent" ID="MPPageEdit" runat="server" />
