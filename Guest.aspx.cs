using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookingRooms
{
    public partial class Guest : Page
    {
        // Connection string - Update with your database connection
        private string connectionString = ConfigurationManager.ConnectionStrings["HotelDBConnection"]?.ConnectionString
            ?? "Data Source=.;Initial Catalog=HotelBookingDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGuests();
            }
        }

        private void LoadGuests()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "SELECT GuestID, Name, Phone, Email, Nationality FROM Guests ORDER BY GuestID DESC";
                    SqlDataAdapter da = new SqlDataAdapter(query, con);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvGuests.DataSource = dt;
                    gvGuests.DataBind();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading guests: " + ex.Message, "error");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"INSERT INTO Guests (Name, Phone, Email, Nationality, CreatedDate)
                                   VALUES (@Name, @Phone, @Email, @Nationality, @CreatedDate)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Nationality", ddlNationality.SelectedValue);
                        cmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                ShowMessage("Guest saved successfully!", "success");
                ClearForm();
                LoadGuests();
            }
            catch (Exception ex)
            {
                ShowMessage("Error saving guest: " + ex.Message, "error");
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            txtName.Text = string.Empty;
            txtPhone.Text = string.Empty;
            txtEmail.Text = string.Empty;
            ddlNationality.SelectedIndex = 0;
            lblMessage.Text = string.Empty;
        }

        protected void gvGuests_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvGuests.EditIndex = e.NewEditIndex;
            LoadGuests();
        }

        protected void gvGuests_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvGuests.EditIndex = -1;
            LoadGuests();
        }

        protected void gvGuests_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int guestId = Convert.ToInt32(gvGuests.DataKeys[e.RowIndex].Value);
                GridViewRow row = gvGuests.Rows[e.RowIndex];

                string name = ((TextBox)row.Cells[1].Controls[0]).Text;
                string phone = ((TextBox)row.Cells[2].Controls[0]).Text;
                string email = ((TextBox)row.Cells[3].Controls[0]).Text;
                string nationality = ((TextBox)row.Cells[4].Controls[0]).Text;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE Guests SET Name=@Name, Phone=@Phone, Email=@Email,
                                   Nationality=@Nationality WHERE GuestID=@GuestID";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@GuestID", guestId);
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Phone", phone);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Nationality", nationality);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                gvGuests.EditIndex = -1;
                ShowMessage("Guest updated successfully!", "success");
                LoadGuests();
            }
            catch (Exception ex)
            {
                ShowMessage("Error updating guest: " + ex.Message, "error");
            }
        }

        protected void gvGuests_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int guestId = Convert.ToInt32(gvGuests.DataKeys[e.RowIndex].Value);

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM Guests WHERE GuestID=@GuestID";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@GuestID", guestId);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                ShowMessage("Guest deleted successfully!", "success");
                LoadGuests();
            }
            catch (Exception ex)
            {
                ShowMessage("Error deleting guest: " + ex.Message, "error");
            }
        }

        private void ShowMessage(string message, string type)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = type == "success" ? System.Drawing.Color.Green : System.Drawing.Color.Red;
        }
    }
}
