using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.Data;
using System.Configuration;
using System.IO;
using System.Diagnostics;

namespace AppDev2
{
    public partial class Competitors : System.Web.UI.Page
    {
        // Reference: https://www.youtube.com/watch?v=2UnL-_EHfiA for guidance with Excel to SQL

        OleDbConnection excel_con;
        string connection_str = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\Olympic_Database.mdf;Integrated Security=True";
        SqlConnection sql_connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                lblInsertError.Visible = false;
                Validate();
            }
        }

        private void Excel_Connect(string filepath)
        {
            string construct = string.Format(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source ={0};Extended Properties=""Excel 12.0 Xml;HDR=YES;""", filepath);
            excel_con = new OleDbConnection(construct);
        }

        private void Excel_Insert(string filepath, string filename)
        {
            string full_path = Server.MapPath("/ExcelFiles/") + filename;
            Excel_Connect(full_path);
            string query = string.Format("SELECT * FROM [{0}]", "Sheet1$");
            OleDbCommand excel_command = new OleDbCommand(query, excel_con);
            excel_con.Open();

            DataSet dataset = new DataSet();
            OleDbDataAdapter data_adapter = new OleDbDataAdapter(query, excel_con);
            excel_con.Close();
            data_adapter.Fill(dataset);

            DataTable dt = dataset.Tables[0];

            SqlBulkCopy sql_bulk = new SqlBulkCopy(sql_connection);
            sql_bulk.DestinationTableName = "Competitor";
            sql_bulk.ColumnMappings.Add("comp_salutation", "comp_salutation");
            sql_bulk.ColumnMappings.Add("comp_name", "comp_name");
            sql_bulk.ColumnMappings.Add("comp_dob", "comp_dob");
            sql_bulk.ColumnMappings.Add("comp_email", "comp_email");
            sql_bulk.ColumnMappings.Add("comp_desc", "comp_desc");
            sql_bulk.ColumnMappings.Add("comp_country", "comp_country");
            sql_bulk.ColumnMappings.Add("comp_gender", "comp_gender");
            sql_bulk.ColumnMappings.Add("comp_ph", "comp_ph");
            sql_bulk.ColumnMappings.Add("comp_website", "comp_website");

            sql_connection.Open();
            sql_bulk.WriteToServer(dt);
            sql_connection.Close();


        }

        protected void btnUploadExcel_Click(object sender, EventArgs e)
        {
            FileUpload file = fuExcel;
            string filename;
            string extension;
            string filepath;
            bool valid = false;

            if (file.HasFile)
            {
                filename = Guid.NewGuid() + Path.GetExtension(file.FileName);
                extension = Path.GetExtension(filename);
                filepath = "/ExcelFiles/" + filename;
                // check for valid extension
                switch (extension.ToLower())
                {
                    case ".xlsx":
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
                        // save the file to excel files folder
                        file.SaveAs(Path.Combine(Server.MapPath("~/ExcelFiles/"), filename));
                        //Call the insert excel data method
                        Excel_Insert(filepath, filename);
                        gvCompView.DataBind();
                    }
                    catch (Exception ex)
                    {
                        lblErrorMsg.Text = "Error importing file. Error message: " + ex.Message;
                    }
                }
                else
                {
                    lblInvalidExtension.Visible = true;
                }
            }
        }
        
        protected void CustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            //Validate for unique email - search through rows
            foreach (GridViewRow row in gvCompView.Rows)
            {
                Debug.WriteLine("In the validator");
                if (row.RowType == DataControlRowType.DataRow && !row.RowState.HasFlag(DataControlRowState.Edit))
                {
                    Label comp_email = row.FindControl("lblCompEmail") as Label;
                    if (comp_email.Text.Trim() == args.Value)
                    {
                        Debug.WriteLine("False " + comp_email.Text.Trim() + " = " + args.Value);
                        args.IsValid = false;
                    }
                    else
                    {
                        Debug.WriteLine("True " + comp_email.Text.Trim() + " = " + args.Value);
                        args.IsValid = true;
                    }
                }
            }

        }
        
        
        protected void btnAddComp_Click(object sender, EventArgs e)
        {
            FileUpload file = FileUpload1;
            string filename;
            string extension;
            bool valid = false;
            string comp_name = txtName.Text;
            int comp_id = 0;
            int game_id = 0;

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
                        SqlCompView.Insert();

                        // After the competitor insert, find the comp and game ID and insert into Game_Competitor
                        string select_comp_id = "SELECT comp_id FROM Competitor WHERE comp_name = '" + comp_name + "';";
                        string select_game_id = "SELECT game_id FROM Game WHERE game_name = '" + ddGames.SelectedValue + "';";
                        SqlCommand comp_comm = new SqlCommand(select_comp_id, sql_connection);
                        SqlCommand game_comm = new SqlCommand(select_game_id, sql_connection);

                        sql_connection.Open();
                        SqlDataReader dr = comp_comm.ExecuteReader();
                        while (dr.Read())
                        {
                            comp_id = dr.GetInt32(0);
                        }
                        dr.Close();

                        dr = game_comm.ExecuteReader();
                        while (dr.Read())
                        {
                            game_id = dr.GetInt32(0);
                        }
                        dr.Close();

                        string insert_game_comp = "INSERT INTO Game_Competitor VALUES(" + game_id + ", " + comp_id + ");";
                        SqlCommand insert_comm = new SqlCommand(insert_game_comp, sql_connection);
                        insert_comm.ExecuteNonQuery();
                        sql_connection.Close();
                    }
                    catch(Exception ex)
                    {
                        lblInsertError.Text = "There was a problem adding the competitor. Error: " + ex.Message;
                        lblInsertError.Visible = true;
                    }
                    try
                    {
                        FileUpload1.SaveAs(Server.MapPath("~/CompPhotos/") + filename);
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
                    lblInvalidFile.Visible = true;
                }
            }
        }

        //Get the comp_id for photo upload via select button
        protected void gvCompView_SelectedIndexChanged(object sender, EventArgs e)
        {
            // gets the comp_name from the grid view - SelectedDataKey[0] has the comp_id
            string comp_name = gvCompView.SelectedDataKey[1].ToString();
            lblSelectCompetitor.Text = "Upload photo for " + comp_name;
        }
        //doesn't work
        protected void txtEmail_TextChanged(object sender, EventArgs e)
        {
            lblInsertError.Visible = false;
        }

        protected void btnUploadExPhoto_Click(object sender, EventArgs e)
        {
            FileUpload file = FileUpload2;
            string filename;
            string extension;
            bool valid = false;
            string comp_id = "";
            

            if (file.HasFile)
            {
                filename = file.PostedFile.FileName;
                extension = Path.GetExtension(filename);
                try
                {
                    comp_id = gvCompView.SelectedDataKey[0].ToString();
                }
                catch
                {
                    lblFileStatus.Text = "No competitor selected";
                    lblFileStatus.Visible = true;
                }

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

                        string update_command = "UPDATE Competitor SET comp_photo = '" + filename + "' WHERE comp_id = " + comp_id;
                        Debug.WriteLine(update_command);
                        sql_connection.Open();
                        SqlCommand update_com = new SqlCommand(update_command, sql_connection);
                        update_com.ExecuteNonQuery();
                        sql_connection.Close();
                        gvCompView.DataBind();
                    }
                    catch (Exception ex)
                    {
                        lblFileStatus.Text = "Unable to Upload photo: " + ex.Message;
                        lblFileStatus.Visible = true;
                    }
                    try
                    {
                        FileUpload2.SaveAs(Server.MapPath("~/CompPhotos/") + filename);
                        lblFileStatus.Visible = true;
                    }
                    catch (Exception ex)
                    {
                        lblFileStatus.Text = "File could not be uploaded. Error: " + ex.Message;
                        lblFileStatus.Visible = true;
                    }
                }
                else
                {
                    lblInvalidEx.Text = "Invalid file extension";
                    lblInvalidEx.Visible = true;
                }            
            }
        }
    }

}