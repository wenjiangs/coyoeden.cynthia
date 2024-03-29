﻿// Author:					Joe Audette
// Created:					2009-06-02
// Last Modified:			2009-06-07
// 
// The use and distribution terms for this software are covered by the 
// Common Public License 1.0 (http://opensource.org/licenses/cpl.php)  
// which can be found in the file CPL.TXT at the root of this distribution.
// By using this software in any fashion, you are agreeing to be bound by 
// the terms of this license.
//
// You must not remove this notice, or any other, from this software.

using System;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cynthia.Web.Editor;
using Cynthia.Web.Framework;
using Cynthia.Web.UI;
using Cynthia.Business;
using Cynthia.Business.WebHelpers;
using Resources;

namespace Cynthia.Web.AdminUI
{

    public partial class ContentTemplateEditPage : CBasePage
    {

        private Guid templateGuid = Guid.Empty;
        private bool userCanEdit = false;
        string imageBaseUrl = string.Empty;
        string defaultTemplateRoles = WebConfigSettings.DefaultContentTemplateAllowedRoles;

        protected void Page_Load(object sender, EventArgs e)
        {

            LoadSettings();
            if (!userCanEdit)
            {
                SiteUtils.RedirectToAccessDeniedPage(this, false);
                return;
            }

            PopulateLabels();
            SetupImageScript();
            PopulateControls();

        }

        private void PopulateControls()
        {
            
            if (Page.IsPostBack) { return; }

            BindImageList();

            ISettingControl rolesControl = this.arTemplate as ISettingControl;

            if (templateGuid == Guid.Empty) 
            {
                if (rolesControl != null)
                {
                    rolesControl.SetValue(defaultTemplateRoles);
                }
                return; 
            }

            ContentTemplate contentTemplate = ContentTemplate.Get(templateGuid);

            if (contentTemplate == null) { return; }
            
            txtTitle.Text = contentTemplate.Title.ToString();
            edDescription.Text = contentTemplate.Description.ToString();
            edTemplate.Text = contentTemplate.Body.ToString();
           
            if (rolesControl != null)
            {
                rolesControl.SetValue(contentTemplate.AllowedRoles);
            }

            ListItem item = ddImage.Items.FindByValue(contentTemplate.ImageFileName);
            if (item != null)
            {
                ddImage.ClearSelection();
                item.Selected = true;
            }

            imgTemplate.Src = imageBaseUrl + contentTemplate.ImageFileName;
            

        }

        private void BindImageList()
        {
            ddImage.DataSource = SiteUtils.GetContentTemplateImageList(siteSettings);
            ddImage.DataBind();

        }
        

        void btnDelete_Click(object sender, EventArgs e)
        {
            if (templateGuid == Guid.Empty)
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/Admin/ContentTemplates.aspx");
                return;
            }

            ContentTemplate.Delete(templateGuid);
            WebUtils.SetupRedirect(this, SiteRoot + "/Admin/ContentTemplates.aspx");

        }

        void btnSave_Click(object sender, EventArgs e)
        {
            ContentTemplate template;
            if (templateGuid != Guid.Empty)
            {
                template = ContentTemplate.Get(templateGuid);
            }
            else
            {
                template = ContentTemplate.GetNew(siteSettings.SiteGuid);
            }

            if (template == null) 
            {
                WebUtils.SetupRedirect(this, SiteRoot + "/Admin/ContentTemplates.aspx");
                return; 
            }

            template.Title = txtTitle.Text;
            template.Body = edTemplate.Text;
            template.Description = edDescription.Text;
            ISettingControl rolesControl = this.arTemplate as ISettingControl;
            if (rolesControl != null)
            {
                template.AllowedRoles = rolesControl.GetValue();
            }
            
            template.ImageFileName = ddImage.SelectedValue;

            SiteUser currentUser = SiteUtils.GetCurrentSiteUser();
            if (currentUser != null) { template.LastModUser = currentUser.UserGuid; }
            template.Save();

            WebUtils.SetupRedirect(this, SiteRoot + "/Admin/ContentTemplates.aspx");

        }

        private void SetupImageScript()
        {
            string script = "<script type=\"text/javascript\">"
                + "function showImage(listBox) { if(!document.images) return; "
                + "var imagePath = '" + imageBaseUrl + "'; "
                + "document.images." + imgTemplate.ClientID + ".src = imagePath + listBox.value;"
                + "}</script>";

            this.Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "showImage", script);

        }

        private void PopulateLabels()
        {
            Title = SiteUtils.FormatPageTitle(siteSettings, Resource.ContentTemplatesEditorLink);

            lnkAdminMenu.Text = Resource.AdminMenuLink;
            lnkAdminMenu.ToolTip = Resource.AdminMenuLink;
            lnkAdminMenu.NavigateUrl = SiteRoot + "/Admin/AdminMenu.aspx";

            lnkTemplates.Text = Resource.ContentTemplates;
            lnkTemplates.ToolTip = Resource.ContentTemplates;
            lnkTemplates.NavigateUrl = SiteRoot + "/Admin/ContentTemplates.aspx";

            lnkThisPage.Text = Resource.ContentTemplatesEditorLink;
            lnkThisPage.ToolTip = Resource.ContentTemplatesEditorLink;
            lnkThisPage.NavigateUrl = SiteRoot + "/Admin/ContentTemplates.aspx?t=" + templateGuid.ToString();

            litTemplateTab.Text = Resource.ContentTemplateTab;
            litDescriptionTab.Text = Resource.ContentTemplateDescriptionTab;
            litSecurityTab.Text = Resource.ContentTemplateRolesTab;

            edTemplate.WebEditor.ToolBar = ToolBar.FullWithTemplates;
            edTemplate.WebEditor.Height = Unit.Parse("350");
            edDescription.WebEditor.ToolBar = ToolBar.Full;
            edDescription.WebEditor.Height = Unit.Parse("350");

            btnSave.Text = Resource.ContentTemplateSaveButton;
            btnDelete.Text = Resource.ContentTemplateDeleteButton;
            lnkCancel.Text = Resource.CancelButton;
            lnkCancel.NavigateUrl = SiteRoot + "/Admin/ContentTemplates.aspx";

            ddImage.Attributes.Add("onchange", "javascript:showImage(this);");
            ddImage.Attributes.Add("size", "6");

        }

        private void LoadSettings()
        {
            if (WebUser.IsAdminOrContentAdmin) { userCanEdit = true; }
            else if (SiteUtils.UserIsSiteEditor()) { userCanEdit = true; }

            templateGuid = WebUtils.ParseGuidFromQueryString("t", templateGuid);
            imageBaseUrl = ImageSiteRoot + "/Data/Sites/"
                + siteSettings.SiteId.ToString(CultureInfo.InvariantCulture)
                + "/htmltemplateimages/";

            liSecurity.Visible = WebUser.IsAdmin;
            tabSecurity.Visible = liSecurity.Visible;

            btnDelete.Visible = (templateGuid != Guid.Empty);
        }

        


        #region OnInit

        protected override void OnPreInit(EventArgs e)
        {
            base.OnPreInit(e);
            
        }

        override protected void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.Load += new EventHandler(this.Page_Load);
            btnSave.Click += new EventHandler(btnSave_Click);
            btnDelete.Click += new EventHandler(btnDelete_Click);

            ScriptConfig.IncludeYuiTabs = true;
            IncludeYuiTabsCss = true;

            SiteUtils.SetupEditor(edTemplate);
            SiteUtils.SetupEditor(edDescription);

        }

        

        #endregion
    }
}
