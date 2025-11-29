using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace BookingRooms
{
    public partial class Rooms : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["HotelDBConnection"]?.ConnectionString
            ?? "Data Source=.;Initial Catalog=HotelBookingDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRoomInventory();
            }
        }

        private void LoadRoomInventory()
        {
            try
            {
                // Create sample room inventory data
                DataTable dt = new DataTable();
                dt.Columns.Add("RoomType", typeof(string));
                dt.Columns.Add("TotalRooms", typeof(int));
                dt.Columns.Add("AvailableRooms", typeof(int));
                dt.Columns.Add("OccupiedRooms", typeof(int));
                dt.Columns.Add("PricePerNight", typeof(decimal));
                dt.Columns.Add("Status", typeof(string));

                // Add sample data
                dt.Rows.Add("Single Room", 20, 15, 5, 99.00, "Active");
                dt.Rows.Add("Double Room", 30, 22, 8, 149.00, "Active");
                dt.Rows.Add("Triple Room", 15, 10, 5, 199.00, "Active");
                dt.Rows.Add("Suite", 10, 7, 3, 299.00, "Active");
                dt.Rows.Add("Deluxe Room", 12, 8, 4, 249.00, "Active");
                dt.Rows.Add("Presidential Suite", 5, 4, 1, 599.00, "Active");

                gvRooms.DataSource = dt;
                gvRooms.DataBind();

                // If you want to load from database, uncomment this:
                /*
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"SELECT RoomType, TotalRooms, AvailableRooms, OccupiedRooms,
                                   PricePerNight, Status FROM RoomInventory ORDER BY RoomType";

                    SqlDataAdapter da = new SqlDataAdapter(query, con);
                    DataTable dtRooms = new DataTable();
                    da.Fill(dtRooms);

                    gvRooms.DataSource = dtRooms;
                    gvRooms.DataBind();
                }
                */
            }
            catch (Exception ex)
            {
                // Log error
                Response.Write($"Error loading room inventory: {ex.Message}");
            }
        }
    }
}
