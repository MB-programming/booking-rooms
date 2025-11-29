<%@ Page Title="Rooms Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Rooms.aspx.cs" Inherits="BookingRooms.Rooms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="page-title">Rooms Management</h1>

    <!-- Room Types Display -->
    <div class="room-grid">
        <!-- Single Room -->
        <div class="room-card">
            <img src="https://images.unsplash.com/photo-1590490360182-c33d57733427?w=400" alt="Single Room" />
            <div class="room-card-body">
                <h3 class="room-card-title">Single Room</h3>
                <p class="room-card-text">
                    Cozy and comfortable room perfect for solo travelers. Features a comfortable single bed,
                    modern amenities, and a peaceful atmosphere.
                </p>
                <div class="room-features">
                    <div class="room-feature">
                        <i class="fas fa-bed"></i>
                        <span>1 Bed</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-user"></i>
                        <span>1 Guest</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-wifi"></i>
                        <span>Free WiFi</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-tv"></i>
                        <span>TV</span>
                    </div>
                </div>
                <div style="margin-top: 15px; padding-top: 15px; border-top: 1px solid #2C3E50; display: flex; justify-content: space-between; align-items: center;">
                    <span style="font-size: 24px; font-weight: bold; color: #009CFF;">$99/night</span>
                    <a href="Reservations.aspx" class="btn btn-primary" style="padding: 8px 20px;">Book Now</a>
                </div>
            </div>
        </div>

        <!-- Double Room -->
        <div class="room-card">
            <img src="https://images.unsplash.com/photo-1566665797739-1674de7a421a?w=400" alt="Double Room" />
            <div class="room-card-body">
                <h3 class="room-card-title">Double Room</h3>
                <p class="room-card-text">
                    Spacious room with a comfortable double bed, ideal for couples or business travelers
                    seeking extra comfort and space.
                </p>
                <div class="room-features">
                    <div class="room-feature">
                        <i class="fas fa-bed"></i>
                        <span>1 Double Bed</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-users"></i>
                        <span>2 Guests</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-wifi"></i>
                        <span>Free WiFi</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-coffee"></i>
                        <span>Coffee Maker</span>
                    </div>
                </div>
                <div style="margin-top: 15px; padding-top: 15px; border-top: 1px solid #2C3E50; display: flex; justify-content: space-between; align-items: center;">
                    <span style="font-size: 24px; font-weight: bold; color: #009CFF;">$149/night</span>
                    <a href="Reservations.aspx" class="btn btn-primary" style="padding: 8px 20px;">Book Now</a>
                </div>
            </div>
        </div>

        <!-- Triple Room -->
        <div class="room-card">
            <img src="https://images.unsplash.com/photo-1598928506311-c55ded91a20c?w=400" alt="Triple Room" />
            <div class="room-card-body">
                <h3 class="room-card-title">Triple Room</h3>
                <p class="room-card-text">
                    Perfect for families or groups, featuring three comfortable beds with ample space
                    for everyone to relax and unwind.
                </p>
                <div class="room-features">
                    <div class="room-feature">
                        <i class="fas fa-bed"></i>
                        <span>3 Beds</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-users"></i>
                        <span>3 Guests</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-wifi"></i>
                        <span>Free WiFi</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-bath"></i>
                        <span>Private Bath</span>
                    </div>
                </div>
                <div style="margin-top: 15px; padding-top: 15px; border-top: 1px solid #2C3E50; display: flex; justify-content: space-between; align-items: center;">
                    <span style="font-size: 24px; font-weight: bold; color: #009CFF;">$199/night</span>
                    <a href="Reservations.aspx" class="btn btn-primary" style="padding: 8px 20px;">Book Now</a>
                </div>
            </div>
        </div>

        <!-- Suite Room -->
        <div class="room-card">
            <img src="https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=400" alt="Suite Room" />
            <div class="room-card-body">
                <h3 class="room-card-title">Suite</h3>
                <p class="room-card-text">
                    Luxurious suite with separate living area, king-size bed, and premium amenities
                    for the ultimate comfort experience.
                </p>
                <div class="room-features">
                    <div class="room-feature">
                        <i class="fas fa-bed"></i>
                        <span>King Bed</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-couch"></i>
                        <span>Living Room</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-concierge-bell"></i>
                        <span>Room Service</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-spa"></i>
                        <span>Spa Access</span>
                    </div>
                </div>
                <div style="margin-top: 15px; padding-top: 15px; border-top: 1px solid #2C3E50; display: flex; justify-content: space-between; align-items: center;">
                    <span style="font-size: 24px; font-weight: bold; color: #009CFF;">$299/night</span>
                    <a href="Reservations.aspx" class="btn btn-primary" style="padding: 8px 20px;">Book Now</a>
                </div>
            </div>
        </div>

        <!-- Deluxe Room -->
        <div class="room-card">
            <img src="https://images.unsplash.com/photo-1591088398332-8a7791972843?w=400" alt="Deluxe Room" />
            <div class="room-card-body">
                <h3 class="room-card-title">Deluxe Room</h3>
                <p class="room-card-text">
                    Premium deluxe room with stunning views, elegant decor, and exclusive access to
                    hotel's finest facilities and services.
                </p>
                <div class="room-features">
                    <div class="room-feature">
                        <i class="fas fa-bed"></i>
                        <span>Queen Bed</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-mountain"></i>
                        <span>City View</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-cocktail"></i>
                        <span>Mini Bar</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-dumbbell"></i>
                        <span>Gym Access</span>
                    </div>
                </div>
                <div style="margin-top: 15px; padding-top: 15px; border-top: 1px solid #2C3E50; display: flex; justify-content: space-between; align-items: center;">
                    <span style="font-size: 24px; font-weight: bold; color: #009CFF;">$249/night</span>
                    <a href="Reservations.aspx" class="btn btn-primary" style="padding: 8px 20px;">Book Now</a>
                </div>
            </div>
        </div>

        <!-- Presidential Suite -->
        <div class="room-card">
            <img src="https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=400" alt="Presidential Suite" />
            <div class="room-card-body">
                <h3 class="room-card-title">Presidential Suite</h3>
                <p class="room-card-text">
                    The epitome of luxury - spacious suite with multiple rooms, premium furnishings,
                    and personalized concierge service.
                </p>
                <div class="room-features">
                    <div class="room-feature">
                        <i class="fas fa-crown"></i>
                        <span>VIP Service</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-hot-tub"></i>
                        <span>Jacuzzi</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-utensils"></i>
                        <span>Dining Area</span>
                    </div>
                    <div class="room-feature">
                        <i class="fas fa-wifi"></i>
                        <span>Premium WiFi</span>
                    </div>
                </div>
                <div style="margin-top: 15px; padding-top: 15px; border-top: 1px solid #2C3E50; display: flex; justify-content: space-between; align-items: center;">
                    <span style="font-size: 24px; font-weight: bold; color: #009CFF;">$599/night</span>
                    <a href="Reservations.aspx" class="btn btn-primary" style="padding: 8px 20px;">Book Now</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Room Management Section -->
    <div class="card" style="margin-top: 40px;">
        <div class="card-header">
            <i class="fas fa-cogs"></i> Room Inventory Management
        </div>
        <div style="padding: 20px;">
            <asp:GridView ID="gvRooms" runat="server" CssClass="data-table" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="RoomType" HeaderText="Room Type" />
                    <asp:BoundField DataField="TotalRooms" HeaderText="Total Rooms" />
                    <asp:BoundField DataField="AvailableRooms" HeaderText="Available" />
                    <asp:BoundField DataField="OccupiedRooms" HeaderText="Occupied" />
                    <asp:BoundField DataField="PricePerNight" HeaderText="Price/Night" DataFormatString="${0}" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
</asp:Content>
