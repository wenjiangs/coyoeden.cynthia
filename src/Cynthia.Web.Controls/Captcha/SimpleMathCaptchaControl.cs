using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Globalization;
using Cynthia.Web.Controls.Captcha;

namespace Cynthia.Web.Controls
{
    /// <summary>
    /// Author:		        Joe Audette
    /// Created:            2007-08-16
    /// Last Modified:      2007-08-16
    /// 
    /// Licensed under the terms of the GNU Lesser General Public License:
    ///	http://www.opensource.org/licenses/lgpl-license.php
    ///
    /// You must not remove this notice, or any other, from this software.
    /// 
    /// </summary>
    public class SimpleMathCaptchaControl : WebControl, INamingContainer
    {
        #region Constructors

        public SimpleMathCaptchaControl()
		{
			EnsureChildControls();
		
            this.txtAnswerInput.ID = this.txtAnswerInput.UniqueID;
            this.txtAnswerInput.MaxLength = 10;
            this.txtAnswerInput.CssClass = this.CssClass;
            this.lblInstructions.AssociatedControlID = this.txtAnswerInput.ID;
            
		}

		#endregion

        public string ResourceFile
        {
            get { return (ViewState["ResourceFile"] != null ? (string)ViewState["ResourceFile"] : "Resource"); }
            set { ViewState["ResourceFile"] = value; }
        }

        public string ResourceKey
        {
            get { return (ViewState["ResourceKey"] != null ? (string)ViewState["ResourceKey"] : "SimpleMatchCaptchaControlInstructions"); }
            set { ViewState["ResourceKey"] = value; }
        }

        public bool IsValid
		{
            get
            {
                if (SpamPreventionQuestion != null)
                {
                    
                    return SpamPreventionQuestion.IsCorrectAnswer(txtAnswerInput.Text);
                   
                }

                return false;

            }

		}

        

		#region Control Declarations

		protected TextBox txtAnswerInput;
        protected Literal litQuestionExpression;
        protected Label lblInstructions;
        

        public SimpleMathQuestion SpamPreventionQuestion
        {
            get { return (ViewState["SpamPreventionQuestion"] != null ? (SimpleMathQuestion)ViewState["SpamPreventionQuestion"] : null); }
            set { ViewState["SpamPreventionQuestion"] = value; }
        }
		

		#endregion

        protected override void OnPreRender(EventArgs e)
        {
            Localize();
            if (SpamPreventionQuestion == null) SpamPreventionQuestion = new SimpleMathQuestion();

            litQuestionExpression.Text = SpamPreventionQuestion.QuestionExpression;

        }

       
        private void Localize()
        {
         
            try
            {
                object resource = HttpContext.GetGlobalResourceObject(
                    this.ResourceFile, this.ResourceKey);

                if (resource != null)
                {
                    this.lblInstructions.Text = "<strong>" 
                        + resource.ToString() + "</strong>";
                }
                else
                {
                    this.lblInstructions.Text = "<strong>Solve This To Prove You are a Real Person, not a SPAM script.</strong>";
                }
            }
            catch { }

            

        }

        protected override void Render(HtmlTextWriter writer)
        {
            if (this.Site != null && this.Site.DesignMode)
            {
                // render to the designer
                this.txtAnswerInput.RenderControl(writer);
                writer.Write("[" + this.ID + "]");
            }
            else
            {
                // render to the response stream
                base.Render(writer);
            }
        }

        protected override void CreateChildControls()
        {
            litQuestionExpression = new Literal();
            txtAnswerInput = new TextBox();
            lblInstructions = new Label();
            
            if (this.Site != null && this.Site.DesignMode)
            {

            }
            else
            {
                this.Controls.Add(this.litQuestionExpression);
                this.Controls.Add(this.txtAnswerInput);
                Literal space = new Literal();
                space.Text = "&nbsp;";
                this.Controls.Add(space);
                this.Controls.Add(this.lblInstructions);
                
            }

        }

    }
}
