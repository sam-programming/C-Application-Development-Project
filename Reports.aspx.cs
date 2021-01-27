using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Diagnostics;
using System.Data;

namespace AppDev2
{
    public partial class Reports : System.Web.UI.Page
    {
        // Class for medal tally
        public class Medal_Tally
        {
            private string country;
            private int gold = 0;
            private int silver = 0;
            private int bronze = 0;

            public string Country
            {
                get { return country; }
                set { country = value; }
            }
            public int Gold
            {
                get { return gold; }
                set { gold = value; }
            }
            public int Silver
            {
                get { return silver; }
                set { silver = value; }
            }
            public int Bronze
            {
                get { return bronze; }
                set { bronze = value; }
            }

            public int Total()
            {
                int total = gold + silver + bronze;
                return total;
            }
        }

        // If item in list matches form input, return list index, else return -1
        public int Find_Country(List<Medal_Tally> medals, string country, int entries)
        {
            int index = -1;
            for (int x = 0; x < entries; x++)
            {
                if (medals[x].Country == country)
                {
                    index = x;
                    return index;
                }
            }
            return index;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)// only need to do this once
            {
                // Create the world record table
                DataView record_view = (DataView)sqlMedal_Country.Select(new DataSourceSelectArguments());
                DataTable record_table = record_view.ToTable();                
                string medal_won = "";
                string country = "";
                int tally_index = 0;
                List<Medal_Tally> medal_tallies = new List<Medal_Tally>();

                foreach (DataRow row in record_table.Rows)
                {
                    bool found = false;
                    Medal_Tally medal_tally = new Medal_Tally();
                    //0 is country, 2 is medal
                    country = row[0].ToString();
                    medal_won = row[2].ToString().ToLower();

                    // find country in list or store new tally index
                    int temp_index = Find_Country(medal_tallies, country, medal_tallies.Count());
                    if (temp_index == -1)
                        medal_tally.Country = country;
                    else
                    {
                        tally_index = temp_index;
                        found = true;
                    }
                    // add medal to tally
                    switch (medal_won)
                    {
                        case "gold":
                            if (found == true)
                                medal_tallies[tally_index].Gold++;
                            else
                                medal_tally.Gold++;
                            break;
                        case "silver":
                            if (found == true)
                                medal_tallies[tally_index].Silver++;
                            else
                                medal_tally.Silver++;
                            break;
                        case "bronze":
                            if (found == true)
                                medal_tallies[tally_index].Bronze++;
                            else
                                medal_tally.Bronze++;
                            break;
                        default:
                            break;
                    }

                    if (found == false)
                    {
                        medal_tallies.Add(medal_tally);
                    }
                }
                // end foreach
                // Sort the medal list lambda expression using a comparison delegate and the Medal_Tally.Total() method
                // if the totals are equal, sorts by country name
                medal_tallies.Sort((a, b) =>
                {
                    int comp = b.Total().CompareTo(a.Total());
                    if (comp == 0)
                        comp = a.Country.CompareTo(b.Country);
                    return comp;
                });

                // create a datatable
                DataTable mdt = new DataTable();
                DataColumn[] cols =
                    {
                    new DataColumn("Standing", typeof(string)),
                    new DataColumn("Country", typeof(string)),
                    new DataColumn("Gold", typeof(string)),
                    new DataColumn("Silver", typeof(string)),
                    new DataColumn("Bronze", typeof(string)),
                    new DataColumn("Total", typeof(string))
                };
                mdt.Columns.AddRange(cols);
                int standing = 1;
                int y = 1;
                // for each tally add a corresponding row
                foreach (Medal_Tally tally in medal_tallies)
                {
                    DataRow dr = mdt.NewRow();
                    dr["Standing"] = standing.ToString();
                    dr["Country"] = tally.Country.ToString();
                    dr["Gold"] = tally.Gold.ToString();
                    dr["Silver"] = tally.Silver.ToString();
                    dr["Bronze"] = tally.Bronze.ToString();
                    dr["Total"] = tally.Total().ToString();
                    mdt.Rows.Add(dr);

                    if (y < medal_tallies.Count() && tally.Total() > medal_tallies[y].Total())
                    {
                        standing++;
                    }
                    y++;
                }
                DataSet dataSet = new DataSet();
                dataSet.Tables.Add(mdt);
                gvTally.DataSource = mdt;
                gvTally.DataBind();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
        }
    }
}