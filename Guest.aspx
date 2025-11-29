<%@ Page Title="Guest Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Guest.aspx.cs" Inherits="BookingRooms.Guest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="page-title">Guest Management</h1>

    <!-- Guest Registration Form -->
    <div class="card">
        <div class="card-header">
            <i class="fas fa-user-plus"></i> Add New Guest
        </div>
        <div style="padding: 20px;">
            <div class="form-group">
                <label for="txtName">
                    <i class="fas fa-user"></i> Full Name *
                </label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter guest full name" required="required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                    ErrorMessage="Name is required" ForeColor="#ff4444" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label for="txtPhone">
                    <i class="fas fa-phone"></i> Phone Number *
                </label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="+1234567890" required="required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone"
                    ErrorMessage="Phone number is required" ForeColor="#ff4444" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone"
                    ValidationExpression="^[+]?[\d\s\-()]+$" ErrorMessage="Invalid phone number format"
                    ForeColor="#ff4444" Display="Dynamic"></asp:RegularExpressionValidator>
            </div>

            <div class="form-group">
                <label for="txtEmail">
                    <i class="fas fa-envelope"></i> Email Address *
                </label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="guest@example.com" required="required"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Email is required" ForeColor="#ff4444" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                    ValidationExpression="^[^\s@]+@[^\s@]+\.[^\s@]+$" ErrorMessage="Invalid email format"
                    ForeColor="#ff4444" Display="Dynamic"></asp:RegularExpressionValidator>
            </div>

            <div class="form-group">
                <label for="ddlNationality">
                    <i class="fas fa-globe"></i> Nationality *
                </label>
                <asp:DropDownList ID="ddlNationality" runat="server" CssClass="form-control" required="required">
                    <asp:ListItem Value="">-- Select Nationality --</asp:ListItem>
                    <asp:ListItem Value="USA">United States</asp:ListItem>
                    <asp:ListItem Value="UK">United Kingdom</asp:ListItem>
                    <asp:ListItem Value="Canada">Canada</asp:ListItem>
                    <asp:ListItem Value="Australia">Australia</asp:ListItem>
                    <asp:ListItem Value="Germany">Germany</asp:ListItem>
                    <asp:ListItem Value="France">France</asp:ListItem>
                    <asp:ListItem Value="Italy">Italy</asp:ListItem>
                    <asp:ListItem Value="Spain">Spain</asp:ListItem>
                    <asp:ListItem Value="Japan">Japan</asp:ListItem>
                    <asp:ListItem Value="China">China</asp:ListItem>
                    <asp:ListItem Value="India">India</asp:ListItem>
                    <asp:ListItem Value="Brazil">Brazil</asp:ListItem>
                    <asp:ListItem Value="Mexico">Mexico</asp:ListItem>
                    <asp:ListItem Value="Egypt">Egypt</asp:ListItem>
                    <asp:ListItem Value="UAE">United Arab Emirates</asp:ListItem>
                    <asp:ListItem Value="Saudi Arabia">Saudi Arabia</asp:ListItem>
                    <asp:ListItem Value="Other">Other</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvNationality" runat="server" ControlToValidate="ddlNationality"
                    InitialValue="" ErrorMessage="Nationality is required" ForeColor="#ff4444" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div style="display: flex; gap: 10px; margin-top: 20px;">
                <asp:Button ID="btnSave" runat="server" Text="Save Guest" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                <asp:Button ID="btnClear" runat="server" Text="Clear Form" CssClass="btn btn-secondary" OnClick="btnClear_Click" CausesValidation="false" />
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="message" style="display: block; margin-top: 15px; padding: 10px; border-radius: 5px;"></asp:Label>
        </div>
    </div>

    <!-- Guest List -->
    <div class="card" style="margin-top: 30px;">
        <div class="card-header">
            <i class="fas fa-users"></i> Guest List
        </div>
        <div style="padding: 20px;">
            <div class="form-group" style="max-width: 400px;">
                <input type="text" id="searchInput" placeholder="Search guests..." class="form-control" onkeyup="searchTable('searchInput', 'gvGuests')" />
            </div>

            <asp:GridView ID="gvGuests" runat="server" CssClass="data-table" AutoGenerateColumns="False"
                OnRowEditing="gvGuests_RowEditing" OnRowDeleting="gvGuests_RowDeleting"
                OnRowUpdating="gvGuests_RowUpdating" OnRowCancelingEdit="gvGuests_RowCancelingEdit"
                DataKeyNames="GuestID">
                <Columns>
                    <asp:BoundField DataField="GuestID" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="Phone" HeaderText="Phone" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Nationality" HeaderText="Nationality" />
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ButtonType="Button" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="scripts" runat="server">
    <script>
        function searchTable(inputId, tableId) {
            const input = document.getElementById(inputId);
            const table = document.getElementById('<%= gvGuests.ClientID %>');
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
    </script>
</asp:Content>
