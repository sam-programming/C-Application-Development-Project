using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Diagnostics;


namespace AppDev2
{
    public partial class Events : System.Web.UI.Page
    {

        SqlConnection sql_connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                txtStartTime.Text = DateTime.Now.ToShortTimeString();
            }                     
            
        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                string game_id = ((Label)row.FindControl("Label1")).Text;
                string select = "SELECT game_name FROM Game WHERE game_id = " + game_id;
                string game_name = "";
                sql_connection.Open();
                SqlCommand sel_comm = new SqlCommand(select, sql_connection);
                try
                {
                    game_name = (string)sel_comm.ExecuteScalar();
                    ((Label)row.FindControl("lblGameName")).Text = game_name;
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                }
                sql_connection.Close();
            }
        }
        //does what it says
        protected void Update_End_Date()
        {
            try
            {
                int duration = Int32.Parse(ddGame.SelectedValue);
                DateTime start = DateTime.Parse(txtStartTime.Text);
                DateTime end = start.AddHours(duration);
                string end_time = end.ToShortTimeString();
                txtEndTime.Text = end_time;
            }
            catch (Exception e)
            {
                Debug.WriteLine("catch.." + e.Message);
                //Validate();
            }

        }

        protected void ddGame_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            if (ddGame.SelectedIndex != 0)
            {
                
                Update_End_Date();
                string game = ddGame.SelectedItem.ToString();
                int game_id = 0;
                string select_str = "SELECT game_id FROM Game WHERE game_name = '" + game + "';";
               
                SqlCommand id_comm = new SqlCommand(select_str, sql_connection);
                sql_connection.Open();
                try
                {
                    
                    game_id = (Int32)id_comm.ExecuteScalar();
                    txtGameID.Text = game_id.ToString() ;
                }
                catch (Exception ex)
                {
                    Debug.WriteLine("Message: " + ex.Message);
                }
                sql_connection.Close();
            }
            
        }

        protected void ddGame_DataBound(object sender, EventArgs e)
        {
            DropDownList list = sender as DropDownList;
            if (list != null)
                list.Items.Insert(0, "-- Select a Game --");
        }

        //Doesn't allow the default value to 
        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (ddGame.SelectedIndex == 0)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        protected void txtStartTime_TextChanged(object sender, EventArgs e)
        {
            if (ddGame.SelectedIndex != 0)
            {
                Update_End_Date();
            }
        }

        protected void btnAddEvent_Click(object sender, EventArgs e)
        {

            FileUpload file = FileUpload1;
            string filename;
            string extension;
            bool valid = false;
            int event_id = 0;


            if (file.HasFile)
            {
                filename = file.PostedFile.FileName;
                extension = Path.GetExtension(filename);               

                // check for valid extension
                switch (extension.ToLower())
                {
                    case ".jpg":
                    case ".png":
                        valid = true;
                        break;
                    default:
                        valid = false;
                        break;
                }
                if (valid == true)
                {
                    try
                    {
                        SqlDataSource1.Insert();

                        string select_str = "SELECT event_id FROM Event WHERE event_name = '" + txtEvent.Text + "';";
                        SqlCommand select_comm = new SqlCommand(select_str, sql_connection);
                        sql_connection.Open();
                        event_id = (Int32)select_comm.ExecuteScalar();

                        string insert_str = "INSERT INTO event_photo VALUES('" + filename + "', '" + txtTags.Text + "', " + event_id + ");";
                        SqlCommand insert_comm = new SqlCommand(insert_str, sql_connection);
                        insert_comm.ExecuteNonQuery();

                        sql_connection.Close();
                        GridView1.DataBind();
                    }
                    catch (Exception ex)
                    {
                        lblUploadStatus.Text = "Unable to Upload photo: " + ex.Message;
                        lblUploadStatus.Visible = true;
                    }
                    try
                    {
                        FileUpload1.SaveAs(Server.MapPath("~/EventPhotos/") + filename);
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
                    lblExtension.Text = "Invalid file extension";
                    lblExtension.Visible = true;
                }
            }
            
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string event_id = GridView1.SelectedDataKey[0].ToString();
            txtEventID.Text = event_id;
        }

        protected void ddPosition_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(ddPosition.SelectedValue == "1")
            {
                CheckBox1.Visible = true;
            }
            else
            {
                CheckBox1.Visible = false;
                CheckBox1.Checked = false;
            }
        }

        protected void btnAddEventResult_Click(object sender, EventArgs e)
        {
            string medal = "";
            string comp_id = ddComp.SelectedValue;
            string event_id = txtEventID.Text;
            string position = ddPosition.SelectedValue;
            bool wr = CheckBox1.Checked;
            int record = 0;
            if(wr == true)
            {
                record = 1;
            }

            switch(ddPosition.SelectedValue)
            {
                case "1":
                    medal = "Gold";
                    break;
                case "2":
                    medal = "Silver";
                    break;
                case "3":
                    medal = "Bronze";
                    break;
                default:
                    medal = "None";
                    break;                    
            }
            string insert = "INSERT INTO Event_Result VALUES (" + event_id + ", " + comp_id + ", " + position + ", '" + medal + "', " + record + ")";
            Debug.WriteLine(insert);
            sql_connection.Open();
            SqlCommand insert_comm = new SqlCommand(insert, sql_connection);
            try
            {
                insert_comm.ExecuteNonQuery();
            }
            catch(Exception ex)
            {
                lblInsertStatus.Text = "Insert failed. Message: " + ex.Message;
                lblInsertStatus.Visible = true;
            }
            sql_connection.Close();
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
            
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            sql_connection.Close();
        }
    }
}