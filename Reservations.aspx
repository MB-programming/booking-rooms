<%@ Page Title="Reservations Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reservations.aspx.cs" Inherits="BookingRooms.Reservations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="page-title">Reservations Management</h1>

    <!-- Reservation Form -->
    <div class="card">
        <div class="card-header">
            <i class="fas fa-calendar-plus"></i> New Reservation
        </div>
        <div style="padding: 20px;">
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px;">
                <!-- Guest Selection -->
                <div class="form-group">
                    <label for="ddlGuest">
                        <i class="fas fa-user"></i> Guest *
                    </label>
                    <asp:DropDownList ID="ddlGuest" runat="server" CssClass="form-control" required="required">
                        <asp:ListItem Value="">-- Select Guest --</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvGuest" runat="server" ControlToValidate="ddlGuest"
                        InitialValue="" ErrorMessage="Guest selection is required" ForeColor="#ff4444" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <!-- Room Type -->
                <div class="form-group">
                    <label for="ddlRoomType">
                        <i class="fas fa-bed"></i> Room Type *
                    </label>
                    <asp:DropDownList ID="ddlRoomType" runat="server" CssClass="form-control" required="required">
                        <asp:ListItem Value="">-- Select Room Type --</asp:ListItem>
                        <asp:ListItem Value="Single">Single Room</asp:ListItem>
                        <asp:ListItem Value="Double">Double Room</asp:ListItem>
                        <asp:ListItem Value="Triple">Triple Room</asp:ListItem>
                        <asp:ListItem Value="Suite">Suite</asp:ListItem>
                        <asp:ListItem Value="Deluxe">Deluxe Room</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvRoomType" runat="server" ControlToValidate="ddlRoomType"
                        InitialValue="" ErrorMessage="Room type is required" ForeColor="#ff4444" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <!-- Check-in Date -->
                <div class="form-group">
                    <label for="txtCheckIn">
                        <i class="fas fa-calendar-check"></i> Check-in Date *
                    </label>
                    <asp:TextBox ID="txtCheckIn" runat="server" CssClass="form-control" TextMode="Date" required="required"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCheckIn" runat="server" ControlToValidate="txtCheckIn"
                        ErrorMessage="Check-in date is required" ForeColor="#ff4444" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <!-- Check-out Date -->
                <div class="form-group">
                    <label for="txtCheckOut">
                        <i class="fas fa-calendar-times"></i> Check-out Date *
                    </label>
                    <asp:TextBox ID="txtCheckOut" runat="server" CssClass="form-control" TextMode="Date" required="required"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCheckOut" runat="server" ControlToValidate="txtCheckOut"
                        ErrorMessage="Check-out date is required" ForeColor="#ff4444" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cvCheckOut" runat="server" ControlToValidate="txtCheckOut"
                        ControlToCompare="txtCheckIn" Operator="GreaterThan" Type="Date"
                        ErrorMessage="Check-out date must be after check-in date" ForeColor="#ff4444" Display="Dynamic"></asp:CompareValidator>
                </div>

                <!-- Number of Adults -->
                <div class="form-group">
                    <label for="txtAdults">
                        <i class="fas fa-user-friends"></i> Number of Adults *
                    </label>
                    <asp:TextBox ID="txtAdults" runat="server" CssClass="form-control" TextMode="Number" min="1" max="10" placeholder="1" required="required"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvAdults" runat="server" ControlToValidate="txtAdults"
                        ErrorMessage="Number of adults is required" ForeColor="#ff4444" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="rvAdults" runat="server" ControlToValidate="txtAdults"
                        MinimumValue="1" MaximumValue="10" Type="Integer"
                        ErrorMessage="Adults must be between 1 and 10" ForeColor="#ff4444" Display="Dynamic"></asp:RangeValidator>
                </div>

                <!-- Number of Children -->
                <div class="form-group">
                    <label for="txtChildren">
                        <i class="fas fa-child"></i> Number of Children
                    </label>
                    <asp:TextBox ID="txtChildren" runat="server" CssClass="form-control" TextMode="Number" min="0" max="10" placeholder="0"></asp:TextBox>
                    <asp:RangeValidator ID="rvChildren" runat="server" ControlToValidate="txtChildren"
                        MinimumValue="0" MaximumValue="10" Type="Integer"
                        ErrorMessage="Children must be between 0 and 10" ForeColor="#ff4444" Display="Dynamic"></asp:RangeValidator>
                </div>
            </div>

            <!-- Additional Information -->
            <div class="form-group" style="margin-top: 20px;">
                <label for="txtSpecialRequests">
                    <i class="fas fa-comment"></i> Special Requests
                </label>
                <asp:TextBox ID="txtSpecialRequests" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Any special requests or notes..."></asp:TextBox>
            </div>

            <div style="display: flex; gap: 10px; margin-top: 20px;">
                <asp:Button ID="btnSave" runat="server" Text="Create Reservation" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                <asp:Button ID="btnClear" runat="server" Text="Clear Form" CssClass="btn btn-secondary" OnClick="btnClear_Click" CausesValidation="false" />
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="message" style="display: block; margin-top: 15px; padding: 10px; border-radius: 5px;"></asp:Label>
        </div>
    </div>

    <!-- Reservations List -->
    <div class="card" style="margin-top: 30px;">
        <div class="card-header">
            <i class="fas fa-list"></i> Reservations List
        </div>
        <div style="padding: 20px;">
            <div class="form-group" style="max-width: 400px;">
                <input type="text" id="searchInput" placeholder="Search reservations..." class="form-control" onkeyup="searchReservations()" />
            </div>

            <asp:GridView ID="gvReservations" runat="server" CssClass="data-table" AutoGenerateColumns="False"
                OnRowEditing="gvReservations_RowEditing" OnRowDeleting="gvReservations_RowDeleting"
                OnRowUpdating="gvReservations_RowUpdating" OnRowCancelingEdit="gvReservations_RowCancelingEdit"
                DataKeyNames="ReservationID">
                <Columns>
                    <asp:BoundField DataField="ReservationID" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="GuestName" HeaderText="Guest" ReadOnly="True" />
                    <asp:BoundField DataField="RoomType" HeaderText="Room Type" />
                    <asp:BoundField DataField="CheckInDate" HeaderText="Check-in" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="CheckOutDate" HeaderText="Check-out" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="Adults" HeaderText="Adults" />
                    <asp:BoundField DataField="Children" HeaderText="Children" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ButtonType="Button" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="stats-grid" style="margin-top: 30px;">
        <div class="stat-card">
            <div class="stat-info">
                <h3>
                    <asp:Label ID="lblTotalReservations" runat="server" Text="0"></asp:Label>
                </h3>
                <p>Total Reservations</p>
            </div>
            <div class="stat-icon">
                <i class="fas fa-calendar-check"></i>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-info">
                <h3>
                    <asp:Label ID="lblActiveReservations" runat="server" Text="0"></asp:Label>
                </h3>
                <p>Active Reservations</p>
            </div>
            <div class="stat-icon">
                <i class="fas fa-door-open"></i>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-info">
                <h3>
                    <asp:Label ID="lblTodayCheckIns" runat="server" Text="0"></asp:Label>
                </h3>
                <p>Today's Check-ins</p>
            </div>
            <div class="stat-icon">
                <i class="fas fa-sign-in-alt"></i>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-info">
                <h3>
                    <asp:Label ID="lblTodayCheckOuts" runat="server" Text="0"></asp:Label>
                </h3>
                <p>Today's Check-outs</p>
            </div>
            <div class="stat-icon">
                <i class="fas fa-sign-out-alt"></i>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    <script>
        function searchReservations() {
            const input = document.getElementById('searchInput');
            const table = document.getElementById('<%= gvReservations.ClientID %>');
            const filter = input.value.toUpperCase();
            const rows = table.getElementsByTagName('tr');

            for (let i = 1; i < rows.length; i++) {
                const row = rows[i];
                const cells = row.getElementsByTagName('td');
                let found = false;

                for (let j = 0; j < cells.length; j++) {
                    const cell = cells[j];
                    if (cell) {
                        const textValue = cell.textContent || cell.innerText;
                        if (textValue.toUpperCase().indexOf(filter) > -1) {
                            found = true;
                            break;
                        }
                    }
                }

                row.style.display = found ? '' : 'none';
            }
        }

        // Set minimum date for check-in to today
        window.addEventListener('load', function () {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('<%= txtCheckIn.ClientID %>').setAttribute('min', today);
            document.getElementById('<%= txtCheckOut.ClientID %>').setAttribute('min', today);
        });
    </script>
</asp:Content>
