using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Text;

namespace BookingRooms
{
    public partial class Test : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["HotelDBConnection"]?.ConnectionString
            ?? "Data Source=.;Initial Catalog=HotelBookingDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSystemInfo();
            }
        }

        private void LoadSystemInfo()
        {
            lblServerTime.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            lblAspNetVersion.Text = Environment.Version.ToString();
            lblAppPath.Text = Request.ApplicationPath;
        }

        protected void btnTestDatabase_Click(object sender, EventArgs e)
        {
            StringBuilder result = new StringBuilder();
            result.Append("<div style='background: rgba(0, 156, 255, 0.05); padding: 20px; border-radius: 8px; border: 1px solid var(--border-color); margin-top: 15px;'>");

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    result.Append("<h5 style='color: #28a745; margin-bottom: 15px;'><i class='fas fa-check-circle'></i> Database Connection Successful!</h5>");
                    result.Append($"<p style='color: var(--text-secondary);'><strong>Connection String:</strong> {MaskConnectionString(connectionString)}</p>");

                    // Test Guests table
                    result.Append("<hr style='border-color: var(--border-color); margin: 20px 0;'/>");
                    result.Append("<h6 style='color: var(--primary);'><i class='fas fa-table'></i> Database Tables Status:</h6>");

                    result.Append(TestTable(con, "Guests", "SELECT COUNT(*) FROM Guests"));
                    result.Append(TestTable(con, "Reservations", "SELECT COUNT(*) FROM Reservations"));
                    result.Append(TestTable(con, "RoomInventory", "SELECT COUNT(*) FROM RoomInventory"));

                    // Get table schemas
                    result.Append("<hr style='border-color: var(--border-color); margin: 20px 0;'/>");
                    result.Append("<h6 style='color: var(--primary);'><i class='fas fa-database'></i> Table Schemas:</h6>");

                    result.Append(GetTableSchema(con, "Guests"));
                    result.Append(GetTableSchema(con, "Reservations"));
                    result.Append(GetTableSchema(con, "RoomInventory"));

                    lblDatabaseResult.ForeColor = System.Drawing.Color.Green;
                    lblDatabaseResult.Text = "✅ Database test completed successfully!";
                }
            }
            catch (Exception ex)
            {
                result.Append($"<h5 style='color: #dc3545;'><i class='fas fa-exclamation-triangle'></i> Database Connection Failed!</h5>");
                result.Append($"<p style='color: var(--text-secondary);'><strong>Error:</strong> {ex.Message}</p>");
                result.Append($"<p style='color: var(--text-muted); font-size: 12px; margin-top: 10px;'><strong>Stack Trace:</strong><br/>{ex.StackTrace.Replace("\n", "<br/>")}</p>");

                result.Append("<div style='background: rgba(220, 53, 69, 0.1); padding: 15px; border-radius: 8px; margin-top: 15px;'>");
                result.Append("<h6 style='color: #dc3545;'>💡 Troubleshooting Tips:</h6>");
                result.Append("<ul style='color: var(--text-secondary); font-size: 13px;'>");
                result.Append("<li>Verify SQL Server is running</li>");
                result.Append("<li>Check connection string in Web.config</li>");
                result.Append("<li>Ensure database 'HotelBookingDB' exists</li>");
                result.Append("<li>Run DatabaseSetup.sql script to create database</li>");
                result.Append("<li>Verify user permissions on the database</li>");
                result.Append("</ul>");
                result.Append("</div>");

                lblDatabaseResult.ForeColor = System.Drawing.Color.Red;
                lblDatabaseResult.Text = "❌ Database test failed!";
            }

            result.Append("</div>");
            Page.ClientScript.RegisterStartupScript(this.GetType(), "dbResult",
                $"document.getElementById('databaseInfo').innerHTML = {Newtonsoft.Json.JsonConvert.SerializeObject(result.ToString())};", true);
        }

        private string TestTable(SqlConnection con, string tableName, string query)
        {
            StringBuilder result = new StringBuilder();
            try
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    int count = (int)cmd.ExecuteScalar();
                    result.Append($"<div style='padding: 8px 0; color: var(--text-secondary);'>");
                    result.Append($"<span style='color: #28a745;'>✅</span> <strong>{tableName}</strong>: {count} records");
                    result.Append("</div>");
                }
            }
            catch (Exception ex)
            {
                result.Append($"<div style='padding: 8px 0; color: var(--text-secondary);'>");
                result.Append($"<span style='color: #dc3545;'>❌</span> <strong>{tableName}</strong>: {ex.Message}");
                result.Append("</div>");
            }
            return result.ToString();
        }

        private string GetTableSchema(SqlConnection con, string tableName)
        {
            StringBuilder result = new StringBuilder();
            result.Append($"<div style='margin: 15px 0; padding: 15px; background: rgba(0, 0, 0, 0.2); border-radius: 8px;'>");
            result.Append($"<h6 style='color: var(--primary); margin-bottom: 10px;'>{tableName}</h6>");

            try
            {
                string query = $@"
                    SELECT
                        COLUMN_NAME,
                        DATA_TYPE,
                        CHARACTER_MAXIMUM_LENGTH,
                        IS_NULLABLE
                    FROM INFORMATION_SCHEMA.COLUMNS
                    WHERE TABLE_NAME = '{tableName}'
                    ORDER BY ORDINAL_POSITION";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        result.Append("<div style='font-size: 12px; font-family: monospace; color: var(--text-secondary);'>");
                        while (reader.Read())
                        {
                            string column = reader["COLUMN_NAME"].ToString();
                            string dataType = reader["DATA_TYPE"].ToString();
                            string maxLength = reader["CHARACTER_MAXIMUM_LENGTH"]?.ToString() ?? "";
                            string nullable = reader["IS_NULLABLE"].ToString();

                            if (!string.IsNullOrEmpty(maxLength))
                                dataType += $"({maxLength})";

                            string nullableText = nullable == "YES" ? "NULL" : "NOT NULL";
                            result.Append($"<div style='padding: 3px 0;'>• {column}: {dataType} {nullableText}</div>");
                        }
                        result.Append("</div>");
                    }
                }
            }
            catch (Exception ex)
            {
                result.Append($"<div style='color: #dc3545; font-size: 13px;'>Error: {ex.Message}</div>");
            }

            result.Append("</div>");
            return result.ToString();
        }

        private string MaskConnectionString(string connectionStr)
        {
            if (string.IsNullOrEmpty(connectionStr))
                return "Not configured";

            // Mask password if exists
            if (connectionStr.ToLower().Contains("password"))
            {
                int pwdIndex = connectionStr.ToLower().IndexOf("password");
                int semicolonIndex = connectionStr.IndexOf(';', pwdIndex);
                if (semicolonIndex > 0)
                {
                    connectionStr = connectionStr.Substring(0, pwdIndex) +
                        "Password=****" +
                        connectionStr.Substring(semicolonIndex);
                }
            }

            return connectionStr;
        }
    }
}
