using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookingRooms
{
    public partial class Reservations : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["HotelDBConnection"]?.ConnectionString
            ?? "Data Source=.;Initial Catalog=HotelBookingDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGuests();
                LoadReservations();
                LoadStatistics();
                SetDefaultValues();
            }
        }

        private void SetDefaultValues()
        {
            txtCheckIn.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtCheckOut.Text = DateTime.Now.AddDays(1).ToString("yyyy-MM-dd");
            txtAdults.Text = "1";
            txtChildren.Text = "0";
        }

        private void LoadGuests()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "SELECT GuestID, Name FROM Guests ORDER BY Name";
                    SqlDataAdapter da = new SqlDataAdapter(query, con);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    ddlGuest.DataSource = dt;
                    ddlGuest.DataTextField = "Name";
                    ddlGuest.DataValueField = "GuestID";
                    ddlGuest.DataBind();

                    ddlGuest.Items.Insert(0, new ListItem("-- Select Guest --", ""));
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading guests: " + ex.Message, "error");
            }
        }

        private void LoadReservations()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"SELECT r.ReservationID, g.Name as GuestName, r.RoomType,
                                   r.CheckInDate, r.CheckOutDate, r.Adults, r.Children, r.Status
                                   FROM Reservations r
                                   INNER JOIN Guests g ON r.GuestID = g.GuestID
                                   ORDER BY r.ReservationID DESC";

                    SqlDataAdapter da = new SqlDataAdapter(query, con);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvReservations.DataSource = dt;
                    gvReservations.DataBind();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading reservations: " + ex.Message, "error");
            }
        }

        private void LoadStatistics()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    // Total Reservations
                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Reservations", con);
                    lblTotalReservations.Text = cmd.ExecuteScalar().ToString();

                    // Active Reservations
                    cmd = new SqlCommand("SELECT COUNT(*) FROM Reservations WHERE Status='Active'", con);
                    lblActiveReservations.Text = cmd.ExecuteScalar().ToString();

                    // Today's Check-ins
                    cmd = new SqlCommand("SELECT COUNT(*) FROM Reservations WHERE CAST(CheckInDate AS DATE) = CAST(GETDATE() AS DATE)", con);
                    lblTodayCheckIns.Text = cmd.ExecuteScalar().ToString();

                    // Today's Check-outs
                    cmd = new SqlCommand("SELECT COUNT(*) FROM Reservations WHERE CAST(CheckOutDate AS DATE) = CAST(GETDATE() AS DATE)", con);
                    lblTodayCheckOuts.Text = cmd.ExecuteScalar().ToString();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading statistics: " + ex.Message, "error");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                DateTime checkIn = Convert.ToDateTime(txtCheckIn.Text);
                DateTime checkOut = Convert.ToDateTime(txtCheckOut.Text);

                if (checkOut <= checkIn)
                {
                    ShowMessage("Check-out date must be after check-in date", "error");
                    return;
                }

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"INSERT INTO Reservations (GuestID, RoomType, CheckInDate, CheckOutDate,
                                   Adults, Children, SpecialRequests, Status, CreatedDate)
                                   VALUES (@GuestID, @RoomType, @CheckInDate, @CheckOutDate,
                                   @Adults, @Children, @SpecialRequests, @Status, @CreatedDate)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@GuestID", ddlGuest.SelectedValue);
                        cmd.Parameters.AddWithValue("@RoomType", ddlRoomType.SelectedValue);
                        cmd.Parameters.AddWithValue("@CheckInDate", checkIn);
                        cmd.Parameters.AddWithValue("@CheckOutDate", checkOut);
                        cmd.Parameters.AddWithValue("@Adults", txtAdults.Text);
                        cmd.Parameters.AddWithValue("@Children", string.IsNullOrEmpty(txtChildren.Text) ? "0" : txtChildren.Text);
                        cmd.Parameters.AddWithValue("@SpecialRequests", txtSpecialRequests.Text.Trim());
                        cmd.Parameters.AddWithValue("@Status", "Active");
                        cmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                ShowMessage("Reservation created successfully!", "success");
                ClearForm();
                LoadReservations();
                LoadStatistics();
            }
            catch (Exception ex)
            {
                ShowMessage("Error creating reservation: " + ex.Message, "error");
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            ddlGuest.SelectedIndex = 0;
            ddlRoomType.SelectedIndex = 0;
            SetDefaultValues();
            txtSpecialRequests.Text = string.Empty;
            lblMessage.Text = string.Empty;
        }

        protected void gvReservations_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvReservations.EditIndex = e.NewEditIndex;
            LoadReservations();
        }

        protected void gvReservations_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvReservations.EditIndex = -1;
            LoadReservations();
        }

        protected void gvReservations_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int reservationId = Convert.ToInt32(gvReservations.DataKeys[e.RowIndex].Value);
                GridViewRow row = gvReservations.Rows[e.RowIndex];

                string roomType = ((TextBox)row.Cells[2].Controls[0]).Text;
                string checkIn = ((TextBox)row.Cells[3].Controls[0]).Text;
                string checkOut = ((TextBox)row.Cells[4].Controls[0]).Text;
                string adults = ((TextBox)row.Cells[5].Controls[0]).Text;
                string children = ((TextBox)row.Cells[6].Controls[0]).Text;
                string status = ((TextBox)row.Cells[7].Controls[0]).Text;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE Reservations SET RoomType=@RoomType, CheckInDate=@CheckInDate,
                                   CheckOutDate=@CheckOutDate, Adults=@Adults, Children=@Children,
                                   Status=@Status WHERE ReservationID=@ReservationID";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ReservationID", reservationId);
                        cmd.Parameters.AddWithValue("@RoomType", roomType);
                        cmd.Parameters.AddWithValue("@CheckInDate", checkIn);
                        cmd.Parameters.AddWithValue("@CheckOutDate", checkOut);
                        cmd.Parameters.AddWithValue("@Adults", adults);
                        cmd.Parameters.AddWithValue("@Children", children);
                        cmd.Parameters.AddWithValue("@Status", status);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                gvReservations.EditIndex = -1;
                ShowMessage("Reservation updated successfully!", "success");
                LoadReservations();
                LoadStatistics();
            }
            catch (Exception ex)
            {
                ShowMessage("Error updating reservation: " + ex.Message, "error");
            }
        }

        protected void gvReservations_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int reservationId = Convert.ToInt32(gvReservations.DataKeys[e.RowIndex].Value);

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM Reservations WHERE ReservationID=@ReservationID";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ReservationID", reservationId);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                ShowMessage("Reservation deleted successfully!", "success");
                LoadReservations();
                LoadStatistics();
            }
            catch (Exception ex)
            {
                ShowMessage("Error deleting reservation: " + ex.Message, "error");
            }
        }

        private void ShowMessage(string message, string type)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = type == "success" ? System.Drawing.Color.Green : System.Drawing.Color.Red;
        }
    }
}
