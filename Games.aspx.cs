using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using System.Diagnostics;

namespace AppDev2
{
    public partial class Games : System.Web.UI.Page
    {
        // use relative connection string
        string connection_str = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Olympic_Database.mdf;Integrated Security=True";
        string selected_game_code;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            FileUpload file = FileUpload1;
            string filename;
            string extension;
            bool valid = false;

            if (file.HasFile)
            {
                filename = file.PostedFile.FileName;
                extension = Path.GetExtension(filename);                

                // check for valid extension
                switch(extension.ToLower())
                {
                    case ".doc":
                    case ".docx":
                    case ".pdf":
                        valid = true;
                        break;
                    default:
                        valid = false;
                        break;
                }
                if (valid == true)
                {
                    SQlGames.Insert();
                    try
                    {
                        FileUpload1.SaveAs(Server.MapPath("~/RulesBooklets/") + filename);
                        lblUploadStatus.Visible = true;
                    }
                    catch (Exception ex)
                    {
                        lblUploadStatus.Text = "File could not be uploaded. Error: " + ex.Message;
                        lblUploadStatus.Visible = true;
                    }
                }
                else
                {
                    lblInvaildExtension.Visible = true;
                }
            }
        }
        
        protected void GridGame_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = GridGame.SelectedRow;
            selected_game_code = ((Label)row.Cells[1].FindControl("lblGameCode")).Text;            
            lblSelectedRow.Text = "Edit " +selected_game_code + "'s Rule Booklet";
            lblSelectedRow.Visible = true;
        }
        
        protected void BtnUploadNew_Click(object sender, EventArgs e)
        {
            FileUpload file = FileUploadEdit;
            string filename;
            string extension;
            bool valid = false;
            GridViewRow row = GridGame.SelectedRow;

            selected_game_code = ((Label)row.Cells[1].FindControl("lblGameCode")).Text;

            if (file.HasFile)
            {
                filename = file.PostedFile.FileName;
                extension = Path.GetExtension(filename);

                // check for valid extension
                switch (extension.ToLower())
                {
                    case ".doc":
                    case ".docx":
                    case ".pdf":
                        valid = true;
                        break;
                    default:
                        valid = false;
                        break;
                }
                if (valid == true)
                {
                    string file_update = "UPDATE Game SET game_rules = '" + filename +
                        "' WHERE game_code = '" + selected_game_code + "';";

                    Debug.WriteLine(file_update);
                    //connect to db using connection string
                    SqlConnection connect = new SqlConnection(connection_str);
                    connect.Open();
                    try
                    {
                        SqlCommand comm = new SqlCommand(file_update, connect);
                        comm.ExecuteNonQuery();
                        try
                        {
                            FileUploadEdit.SaveAs(Server.MapPath("~/RulesBooklets/") + filename);
                            lblUploadStatus1.Visible = true;
                        }
                        catch (Exception ex)
                        {
                            lblUploadStatus.Text = "File could not be uploaded. Error: " + ex.Message;
                            lblUploadStatus1.Visible = true;
                        }

                    }
                    catch (Exception err)
                    {
                        Debug.WriteLine(err.Message);
                        lblInsertStatus.Text = "Rules update failed. Error: " + err.Message;
                    }
                    finally
                    {
                        connect.Close();
                        GridGame.DataBind();
                    }
                }
            }
        }

        // This method exists to fix an updating error when adding a hyperlink field to a template field
        protected void GridGame_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && !e.Row.RowState.HasFlag(DataControlRowState.Edit))
            {
                HyperLink link = e.Row.FindControl("hlRules") as HyperLink;
                Label lbl = e.Row.FindControl("lblRules") as Label;
                link.Text = lbl.Text;
                link.NavigateUrl = "~/RulesBooklets/" + lbl.Text;
            }
        }
    }
}