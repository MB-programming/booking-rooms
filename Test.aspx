<%@ Page Title="System Test" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="BookingRooms.Test" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="page-title">🧪 System Test & Diagnostics</h1>

    <div class="card">
        <div class="card-header">
            <i class="fas fa-vial"></i> DarkPan Dashboard Test Suite
        </div>
        <div style="padding: 25px;">
            <p style="color: var(--text-secondary); margin-bottom: 20px;">
                This page tests all components of the Hotel Booking System. Check the browser console (F12) for detailed test results.
            </p>

            <div class="row g-3">
                <div class="col-md-6">
                    <button type="button" class="btn btn-primary w-100" onclick="DarkPan.runComprehensiveTest()">
                        <i class="fas fa-flask"></i> Run Comprehensive Test
                    </button>
                </div>
                <div class="col-md-6">
                    <button type="button" class="btn btn-secondary w-100" onclick="DarkPan.testConnectivity()">
                        <i class="fas fa-network-wired"></i> Test Connectivity Only
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Test Results Grid -->
    <div class="stats-grid" style="margin-top: 30px;">
        <div class="stat-card">
            <div class="stat-info">
                <h3 id="testCount">0</h3>
                <p>Tests Run</p>
            </div>
            <div class="stat-icon">
                <i class="fas fa-clipboard-check"></i>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-info">
                <h3 id="passCount">0</h3>
                <p>Tests Passed</p>
            </div>
            <div class="stat-icon">
                <i class="fas fa-check-circle"></i>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-info">
                <h3 id="failCount">0</h3>
                <p>Tests Failed</p>
            </div>
            <div class="stat-icon">
                <i class="fas fa-times-circle"></i>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-info">
                <h3 id="dbStatus">Checking...</h3>
                <p>Database Status</p>
            </div>
            <div class="stat-icon">
                <i class="fas fa-database"></i>
            </div>
        </div>
    </div>

    <!-- Validation Tests -->
    <div class="card" style="margin-top: 30px;">
        <div class="card-header">
            <i class="fas fa-check-double"></i> Validation Tests
        </div>
        <div style="padding: 25px;">
            <div class="row g-3">
                <div class="col-md-6">
                    <h5 style="color: var(--primary); margin-bottom: 15px;">Email Validation</h5>
                    <input type="text" class="form-control mb-2" id="testEmail" value="test@hotel.com" placeholder="Enter email to test">
                    <button class="btn btn-primary btn-sm" onclick="testEmailInput()">Test Email</button>
                    <span id="emailResult" style="margin-left: 10px;"></span>
                </div>

                <div class="col-md-6">
                    <h5 style="color: var(--primary); margin-bottom: 15px;">Phone Validation</h5>
                    <input type="text" class="form-control mb-2" id="testPhone" value="+1234567890" placeholder="Enter phone to test">
                    <button class="btn btn-primary btn-sm" onclick="testPhoneInput()">Test Phone</button>
                    <span id="phoneResult" style="margin-left: 10px;"></span>
                </div>
            </div>
        </div>
    </div>

    <!-- Database Connection Test -->
    <div class="card" style="margin-top: 30px;">
        <div class="card-header">
            <i class="fas fa-database"></i> Database Connection Test
        </div>
        <div style="padding: 25px;">
            <p style="color: var(--text-secondary); margin-bottom: 15px;">
                Test the database connection and verify all tables exist.
            </p>
            <asp:Button ID="btnTestDatabase" runat="server" Text="Test Database Connection"
                CssClass="btn btn-primary" OnClick="btnTestDatabase_Click" />
            <asp:Label ID="lblDatabaseResult" runat="server" CssClass="ms-3"></asp:Label>

            <div id="databaseInfo" style="margin-top: 20px;">
                <!-- Database test results will appear here -->
            </div>
        </div>
    </div>

    <!-- Page Navigation Test -->
    <div class="card" style="margin-top: 30px;">
        <div class="card-header">
            <i class="fas fa-sitemap"></i> Page Navigation Test
        </div>
        <div style="padding: 25px;">
            <p style="color: var(--text-secondary); margin-bottom: 20px;">
                Test navigation to all pages in the system.
            </p>
            <div class="row g-2">
                <div class="col-md-4">
                    <a href="index.html" class="btn btn-secondary w-100">
                        <i class="fas fa-home"></i> Dashboard
                    </a>
                </div>
                <div class="col-md-4">
                    <a href="Guest.aspx" class="btn btn-secondary w-100">
                        <i class="fas fa-users"></i> Guests
                    </a>
                </div>
                <div class="col-md-4">
                    <a href="Reservations.aspx" class="btn btn-secondary w-100">
                        <i class="fas fa-calendar-check"></i> Reservations
                    </a>
                </div>
                <div class="col-md-4">
                    <a href="Rooms.aspx" class="btn btn-secondary w-100">
                        <i class="fas fa-bed"></i> Rooms
                    </a>
                </div>
                <div class="col-md-4">
                    <a href="Test.aspx" class="btn btn-primary w-100">
                        <i class="fas fa-vial"></i> Test Page
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- System Information -->
    <div class="card" style="margin-top: 30px;">
        <div class="card-header">
            <i class="fas fa-info-circle"></i> System Information
        </div>
        <div style="padding: 25px;">
            <table class="table" style="color: var(--text-secondary);">
                <tr>
                    <td><strong>Server Time:</strong></td>
                    <td><asp:Label ID="lblServerTime" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td><strong>ASP.NET Version:</strong></td>
                    <td><asp:Label ID="lblAspNetVersion" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td><strong>Application Path:</strong></td>
                    <td><asp:Label ID="lblAppPath" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td><strong>Browser:</strong></td>
                    <td><span id="browserInfo"></span></td>
                </tr>
                <tr>
                    <td><strong>Screen Resolution:</strong></td>
                    <td><span id="screenInfo"></span></td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    <script>
        // Test counter
        let testsPassed = 0;
        let testsFailed = 0;

        // Email validation test
        function testEmailInput() {
            const email = document.getElementById('testEmail').value;
            const result = DarkPan.validateEmail(email);
            const resultSpan = document.getElementById('emailResult');
            resultSpan.innerHTML = result
                ? '<span style="color: #28a745;">✅ Valid</span>'
                : '<span style="color: #dc3545;">❌ Invalid</span>';

            if (result) testsPassed++; else testsFailed++;
            updateTestCounts();
        }

        // Phone validation test
        function testPhoneInput() {
            const phone = document.getElementById('testPhone').value;
            const result = DarkPan.validatePhone(phone);
            const resultSpan = document.getElementById('phoneResult');
            resultSpan.innerHTML = result
                ? '<span style="color: #28a745;">✅ Valid</span>'
                : '<span style="color: #dc3545;">❌ Invalid</span>';

            if (result) testsPassed++; else testsFailed++;
            updateTestCounts();
        }

        // Update test counts
        function updateTestCounts() {
            document.getElementById('testCount').textContent = testsPassed + testsFailed;
            document.getElementById('passCount').textContent = testsPassed;
            document.getElementById('failCount').textContent = testsFailed;
        }

        // Get browser info
        function getBrowserInfo() {
            const browserInfo = document.getElementById('browserInfo');
            browserInfo.textContent = navigator.userAgent;

            const screenInfo = document.getElementById('screenInfo');
            screenInfo.textContent = `${screen.width} x ${screen.height}`;
        }

        // Run on page load
        window.addEventListener('load', function() {
            getBrowserInfo();
            DarkPan.showNotification('Test page loaded successfully!', 'success');

            // Auto-run connectivity test
            setTimeout(() => {
                DarkPan.testConnectivity();
            }, 500);
        });
    </script>
</asp:Content>
