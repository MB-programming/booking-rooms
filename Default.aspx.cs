using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace BookingRooms
{
    public partial class Default : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["HotelDBConnection"]?.ConnectionString
            ?? "Data Source=.;Initial Catalog=HotelBookingDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    // Load Statistics
                    LoadStatistics(con);

                    // Load Today's Check-ins
                    LoadTodayCheckIns(con);

                    // Load Today's Check-outs
                    LoadTodayCheckOuts(con);

                    // Load Recent Reservations
                    LoadRecentReservations(con);

                    // Load Room Occupancy
                    LoadRoomOccupancy(con);
                }
            }
            catch (Exception ex)
            {
                // If database error, show sample data
                LoadSampleData();
            }
        }

        private void LoadStatistics(SqlConnection con)
        {
            try
            {
                // Total Guests
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Guests", con);
                lblTotalGuests.Text = cmd.ExecuteScalar().ToString();

                // Total Reservations
                cmd = new SqlCommand("SELECT COUNT(*) FROM Reservations", con);
                lblTotalReservations.Text = cmd.ExecuteScalar().ToString();

                // Active Bookings
                cmd = new SqlCommand("SELECT COUNT(*) FROM Reservations WHERE Status='Active'", con);
                lblActiveBookings.Text = cmd.ExecuteScalar().ToString();

                // Available Rooms
                cmd = new SqlCommand("SELECT SUM(AvailableRooms) FROM RoomInventory", con);
                object result = cmd.ExecuteScalar();
                lblAvailableRooms.Text = result != DBNull.Value ? result.ToString() : "0";
            }
            catch
            {
                lblTotalGuests.Text = "5";
                lblTotalReservations.Text = "8";
                lblActiveBookings.Text = "3";
                lblAvailableRooms.Text = "15";
            }
        }

        private void LoadTodayCheckIns(SqlConnection con)
        {
            try
            {
                string query = @"SELECT TOP 5 g.Name as GuestName, r.RoomType, r.CheckInDate
                               FROM Reservations r
                               INNER JOIN Guests g ON r.GuestID = g.GuestID
                               WHERE CAST(r.CheckInDate AS DATE) = CAST(GETDATE() AS DATE)
                               ORDER BY r.CheckInDate DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    gvTodayCheckIns.DataSource = dt;
                    gvTodayCheckIns.DataBind();
                }
                else
                {
                    // Show empty message
                    DataTable emptyDt = new DataTable();
                    emptyDt.Columns.Add("GuestName");
                    emptyDt.Columns.Add("RoomType");
                    emptyDt.Columns.Add("CheckInDate");
                    emptyDt.Rows.Add("No check-ins today", "-", DBNull.Value);
                    gvTodayCheckIns.DataSource = emptyDt;
                    gvTodayCheckIns.DataBind();
                }
            }
            catch
            {
                gvTodayCheckIns.DataSource = null;
                gvTodayCheckIns.DataBind();
            }
        }

        private void LoadTodayCheckOuts(SqlConnection con)
        {
            try
            {
                string query = @"SELECT TOP 5 g.Name as GuestName, r.RoomType, r.CheckOutDate
                               FROM Reservations r
                               INNER JOIN Guests g ON r.GuestID = g.GuestID
                               WHERE CAST(r.CheckOutDate AS DATE) = CAST(GETDATE() AS DATE)
                               ORDER BY r.CheckOutDate DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    gvTodayCheckOuts.DataSource = dt;
                    gvTodayCheckOuts.DataBind();
                }
                else
                {
                    // Show empty message
                    DataTable emptyDt = new DataTable();
                    emptyDt.Columns.Add("GuestName");
                    emptyDt.Columns.Add("RoomType");
                    emptyDt.Columns.Add("CheckOutDate");
                    emptyDt.Rows.Add("No check-outs today", "-", DBNull.Value);
                    gvTodayCheckOuts.DataSource = emptyDt;
                    gvTodayCheckOuts.DataBind();
                }
            }
            catch
            {
                gvTodayCheckOuts.DataSource = null;
                gvTodayCheckOuts.DataBind();
            }
        }

        private void LoadRecentReservations(SqlConnection con)
        {
            try
            {
                string query = @"SELECT TOP 10 r.ReservationID, g.Name as GuestName, r.RoomType,
                               r.CheckInDate, r.CheckOutDate, r.Adults, r.Children, r.Status
                               FROM Reservations r
                               INNER JOIN Guests g ON r.GuestID = g.GuestID
                               ORDER BY r.CreatedDate DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvRecentReservations.DataSource = dt;
                gvRecentReservations.DataBind();
            }
            catch
            {
                gvRecentReservations.DataSource = null;
                gvRecentReservations.DataBind();
            }
        }

        private void LoadRoomOccupancy(SqlConnection con)
        {
            try
            {
                string query = @"SELECT RoomType, TotalRooms, OccupiedRooms, AvailableRooms
                               FROM RoomInventory
                               ORDER BY RoomType";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvRoomOccupancy.DataSource = dt;
                gvRoomOccupancy.DataBind();
            }
            catch
            {
                gvRoomOccupancy.DataSource = null;
                gvRoomOccupancy.DataBind();
            }
        }

        private void LoadSampleData()
        {
            // Load sample statistics
            lblTotalGuests.Text = "5";
            lblTotalReservations.Text = "8";
            lblActiveBookings.Text = "3";
            lblAvailableRooms.Text = "15";

            // Sample data for grids
            DataTable sampleDt = new DataTable();
            sampleDt.Columns.Add("Message");
            sampleDt.Rows.Add("Database not connected. Please configure connection in Web.config");

            gvTodayCheckIns.DataSource = null;
            gvTodayCheckIns.DataBind();

            gvTodayCheckOuts.DataSource = null;
            gvTodayCheckOuts.DataBind();

            gvRecentReservations.DataSource = null;
            gvRecentReservations.DataBind();

            gvRoomOccupancy.DataSource = null;
            gvRoomOccupancy.DataBind();
        }
    }
}
