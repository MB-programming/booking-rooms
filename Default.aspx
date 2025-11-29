<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BookingRooms.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Statistics Start -->
    <div class="container-fluid pt-4 px-4">
        <div class="row g-4">
            <div class="col-sm-6 col-xl-3">
                <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
                    <i class="fa fa-users fa-3x text-primary"></i>
                    <div class="ms-3">
                        <p class="mb-2">Total Guests</p>
                        <h6 class="mb-0"><asp:Label ID="lblTotalGuests" runat="server" Text="0"></asp:Label></h6>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
                    <i class="fa fa-calendar-check fa-3x text-primary"></i>
                    <div class="ms-3">
                        <p class="mb-2">Total Reservations</p>
                        <h6 class="mb-0"><asp:Label ID="lblTotalReservations" runat="server" Text="0"></asp:Label></h6>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
                    <i class="fa fa-door-open fa-3x text-primary"></i>
                    <div class="ms-3">
                        <p class="mb-2">Active Bookings</p>
                        <h6 class="mb-0"><asp:Label ID="lblActiveBookings" runat="server" Text="0"></asp:Label></h6>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
                    <i class="fa fa-bed fa-3x text-primary"></i>
                    <div class="ms-3">
                        <p class="mb-2">Available Rooms</p>
                        <h6 class="mb-0"><asp:Label ID="lblAvailableRooms" runat="server" Text="0"></asp:Label></h6>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Statistics End -->

    <!-- Today's Activity Start -->
    <div class="container-fluid pt-4 px-4">
        <div class="row g-4">
            <div class="col-sm-12 col-xl-6">
                <div class="bg-secondary rounded h-100 p-4">
                    <h6 class="mb-4">Today's Check-ins</h6>
                    <asp:GridView ID="gvTodayCheckIns" runat="server" CssClass="table table-dark table-striped" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="GuestName" HeaderText="Guest" />
                            <asp:BoundField DataField="RoomType" HeaderText="Room Type" />
                            <asp:BoundField DataField="CheckInDate" HeaderText="Check-in" DataFormatString="{0:HH:mm}" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <div class="col-sm-12 col-xl-6">
                <div class="bg-secondary rounded h-100 p-4">
                    <h6 class="mb-4">Today's Check-outs</h6>
                    <asp:GridView ID="gvTodayCheckOuts" runat="server" CssClass="table table-dark table-striped" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="GuestName" HeaderText="Guest" />
                            <asp:BoundField DataField="RoomType" HeaderText="Room Type" />
                            <asp:BoundField DataField="CheckOutDate" HeaderText="Check-out" DataFormatString="{0:HH:mm}" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
    <!-- Today's Activity End -->

    <!-- Recent Reservations Start -->
    <div class="container-fluid pt-4 px-4">
        <div class="bg-secondary text-center rounded p-4">
            <div class="d-flex align-items-center justify-content-between mb-4">
                <h6 class="mb-0">Recent Reservations</h6>
                <a href="Reservations.aspx">Show All</a>
            </div>
            <div class="table-responsive">
                <asp:GridView ID="gvRecentReservations" runat="server" CssClass="table text-start align-middle table-bordered table-hover mb-0" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="ReservationID" HeaderText="ID" />
                        <asp:BoundField DataField="GuestName" HeaderText="Guest Name" />
                        <asp:BoundField DataField="RoomType" HeaderText="Room Type" />
                        <asp:BoundField DataField="CheckInDate" HeaderText="Check-in" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="CheckOutDate" HeaderText="Check-out" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="Adults" HeaderText="Adults" />
                        <asp:BoundField DataField="Children" HeaderText="Children" />
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class="badge bg-success"><%# Eval("Status") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
    <!-- Recent Reservations End -->

    <!-- Room Occupancy Start -->
    <div class="container-fluid pt-4 px-4">
        <div class="row g-4">
            <div class="col-sm-12 col-xl-12">
                <div class="bg-secondary rounded h-100 p-4">
                    <h6 class="mb-4">Room Occupancy Status</h6>
                    <div class="table-responsive">
                        <asp:GridView ID="gvRoomOccupancy" runat="server" CssClass="table table-dark table-bordered" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="RoomType" HeaderText="Room Type" />
                                <asp:BoundField DataField="TotalRooms" HeaderText="Total" />
                                <asp:BoundField DataField="OccupiedRooms" HeaderText="Occupied" />
                                <asp:BoundField DataField="AvailableRooms" HeaderText="Available" />
                                <asp:TemplateField HeaderText="Occupancy Rate">
                                    <ItemTemplate>
                                        <div class="progress">
                                            <div class="progress-bar bg-primary" role="progressbar"
                                                 style='<%# "width: " + ((int)Eval("OccupiedRooms") * 100 / (int)Eval("TotalRooms")) + "%" %>'
                                                 aria-valuenow='<%# ((int)Eval("OccupiedRooms") * 100 / (int)Eval("TotalRooms")) %>'
                                                 aria-valuemin="0" aria-valuemax="100">
                                                <%# ((int)Eval("OccupiedRooms") * 100 / (int)Eval("TotalRooms")) %>%
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Room Occupancy End -->

    <!-- Quick Actions Start -->
    <div class="container-fluid pt-4 px-4">
        <div class="row g-4">
            <div class="col-sm-12 col-md-6 col-xl-4">
                <div class="h-100 bg-secondary rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">Quick Actions</h6>
                    </div>
                    <div class="d-flex flex-column gap-3">
                        <a href="Guest.aspx" class="btn btn-primary w-100">
                            <i class="fa fa-user-plus me-2"></i>Add New Guest
                        </a>
                        <a href="Reservations.aspx" class="btn btn-primary w-100">
                            <i class="fa fa-calendar-plus me-2"></i>New Reservation
                        </a>
                        <a href="Rooms.aspx" class="btn btn-primary w-100">
                            <i class="fa fa-bed me-2"></i>View Rooms
                        </a>
                        <a href="Test.aspx" class="btn btn-outline-primary w-100">
                            <i class="fa fa-vial me-2"></i>System Test
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 col-md-6 col-xl-4">
                <div class="h-100 bg-secondary rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <h6 class="mb-0">System Status</h6>
                        <span class="badge bg-success">Online</span>
                    </div>
                    <div class="d-flex flex-column gap-2 mt-4">
                        <div class="d-flex justify-content-between">
                            <span>Database:</span>
                            <span id="dbStatus" class="text-success">Connected</span>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span>Server Time:</span>
                            <span><%= DateTime.Now.ToString("HH:mm:ss") %></span>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span>Version:</span>
                            <span>v1.0.0</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-12 col-md-6 col-xl-4">
                <div class="h-100 bg-secondary rounded p-4">
                    <h6 class="mb-4">System Information</h6>
                    <div class="d-flex flex-column gap-2">
                        <div class="d-flex justify-content-between">
                            <span>ASP.NET:</span>
                            <span><%= Environment.Version %></span>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span>Today's Date:</span>
                            <span><%= DateTime.Now.ToString("yyyy-MM-dd") %></span>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span>Template:</span>
                            <span>DarkPan v1.0</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Quick Actions End -->
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    <script>
        // Test database connection on load
        window.addEventListener('load', function () {
            fetch('Test.aspx')
                .then(() => {
                    document.getElementById('dbStatus').textContent = 'Connected';
                    document.getElementById('dbStatus').className = 'text-success';
                })
                .catch(() => {
                    document.getElementById('dbStatus').textContent = 'Error';
                    document.getElementById('dbStatus').className = 'text-danger';
                });
        });
    </script>
</asp:Content>
