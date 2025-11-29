# Hotel Booking System - DarkPan Dashboard

A comprehensive hotel booking management system built with ASP.NET Web Forms and SQL Server, featuring a modern DarkPan dashboard interface.

## Features

- **Guest Management**: Add, edit, and manage guest information including name, phone, email, and nationality
- **Reservations System**: Create and manage room reservations with check-in/out dates, room types, and guest counts
- **Room Catalog**: Display available room types with images, descriptions, and pricing
- **Modern UI**: DarkPan dashboard template with responsive design
- **Database Integration**: Full SQL Server database with sample data

## Project Structure

```
booking-rooms/
├── assets/
│   ├── css/
│   │   └── darkpan.css          # Dashboard styles
│   ├── js/
│   │   └── darkpan.js           # Dashboard JavaScript
│   └── images/                  # Image assets
├── Site.Master                  # Master page template
├── Site.Master.cs              # Master page code-behind
├── index.html                  # Dashboard home page
├── Guest.aspx                  # Guest management page
├── Guest.aspx.cs              # Guest page code-behind
├── Reservations.aspx          # Reservations management page
├── Reservations.aspx.cs       # Reservations page code-behind
├── Rooms.aspx                 # Room catalog page
├── Rooms.aspx.cs              # Rooms page code-behind
├── Web.config                 # Application configuration
├── DatabaseSetup.sql          # Database creation script
└── README.md                  # This file
```

## Database Setup

### Option 1: Local SQL Server

1. **Install SQL Server** (if not already installed)
   - Download SQL Server Express from Microsoft
   - Install SQL Server Management Studio (SSMS)

2. **Run Database Setup Script**
   - Open SQL Server Management Studio
   - Connect to your SQL Server instance
   - Open `DatabaseSetup.sql`
   - Execute the script (F5)
   - This will create:
     - Database: `HotelBookingDB`
     - Tables: `Guests`, `Reservations`, `RoomInventory`
     - Sample data for testing
     - Views and stored procedures

3. **Update Connection String** in `Web.config`:
   ```xml
   <add name="HotelDBConnection"
        connectionString="Data Source=.\SQLEXPRESS;Initial Catalog=HotelBookingDB;Integrated Security=True"
        providerName="System.Data.SqlClient" />
   ```

### Option 2: SmarterASP.NET Hosting

1. **Create Database on SmarterASP.NET**
   - Log in to your SmarterASP.NET control panel
   - Navigate to "Database Manager"
   - Click "Add New Database"
   - Select "MS SQL" as database type
   - Note the database credentials provided

2. **Import Database Schema**
   - Use the SQL Script Manager in SmarterASP.NET
   - Copy and paste the content from `DatabaseSetup.sql`
   - Execute the script

3. **Update Connection String** in `Web.config`:
   ```xml
   <add name="HotelDBConnection"
        connectionString="Data Source=YOUR_SERVER_NAME;Initial Catalog=YOUR_DATABASE_NAME;User ID=YOUR_USERNAME;Password=YOUR_PASSWORD"
        providerName="System.Data.SqlClient" />
   ```
   Replace:
   - `YOUR_SERVER_NAME`: Your SQL Server hostname from SmarterASP.NET
   - `YOUR_DATABASE_NAME`: Your database name
   - `YOUR_USERNAME`: Your database username
   - `YOUR_PASSWORD`: Your database password

## Database Tables

### Guests Table
- `GuestID` (INT, Primary Key, Identity)
- `Name` (NVARCHAR(100))
- `Phone` (NVARCHAR(20))
- `Email` (NVARCHAR(100))
- `Nationality` (NVARCHAR(50))
- `CreatedDate` (DATETIME)
- `UpdatedDate` (DATETIME)

### Reservations Table
- `ReservationID` (INT, Primary Key, Identity)
- `GuestID` (INT, Foreign Key to Guests)
- `RoomType` (NVARCHAR(50))
- `CheckInDate` (DATE)
- `CheckOutDate` (DATE)
- `Adults` (INT)
- `Children` (INT)
- `SpecialRequests` (NVARCHAR(500))
- `Status` (NVARCHAR(20))
- `CreatedDate` (DATETIME)
- `UpdatedDate` (DATETIME)

### RoomInventory Table
- `RoomInventoryID` (INT, Primary Key, Identity)
- `RoomType` (NVARCHAR(50))
- `TotalRooms` (INT)
- `AvailableRooms` (INT)
- `OccupiedRooms` (INT)
- `PricePerNight` (DECIMAL(10,2))
- `Description` (NVARCHAR(500))
- `ImageURL` (NVARCHAR(255))
- `Status` (NVARCHAR(20))
- `CreatedDate` (DATETIME)
- `UpdatedDate` (DATETIME)

## Application Setup

1. **Open in Visual Studio**
   - Open Visual Studio 2019 or later
   - File → Open → Web Site
   - Select the project folder

2. **Restore NuGet Packages** (if needed)
   - Right-click on the solution
   - Select "Restore NuGet Packages"

3. **Build the Project**
   - Build → Build Solution (Ctrl+Shift+B)

4. **Run the Application**
   - Press F5 to run with debugging
   - Or Ctrl+F5 to run without debugging

## Pages Overview

### index.html
- Dashboard home page
- Empty content area ready for customization
- Navigation to all other pages

### Guest.aspx
- Add new guests with validation
- View all guests in a grid
- Edit and delete existing guests
- Search functionality
- Fields:
  - Full Name (required)
  - Phone Number (required, validated)
  - Email Address (required, validated)
  - Nationality (required, dropdown)

### Reservations.aspx
- Create new reservations
- Select guest from existing guests
- Choose room type (Single, Double, Triple, Suite, Deluxe)
- Set check-in and check-out dates with validation
- Specify number of adults (1-10, required)
- Specify number of children (0-10, optional)
- Add special requests
- View all reservations in a grid
- Statistics cards showing:
  - Total reservations
  - Active reservations
  - Today's check-ins
  - Today's check-outs

### Rooms.aspx
- Visual catalog of available room types
- Room cards with images and descriptions
- Room features and amenities
- Pricing information
- Direct booking links
- Room inventory management grid

## Technologies Used

- **ASP.NET Web Forms** (.NET Framework 4.8)
- **C#** for server-side code
- **SQL Server** for database
- **HTML5/CSS3** for layout and styling
- **JavaScript** for client-side interactions
- **Font Awesome** for icons
- **DarkPan** dashboard template

## Features

### Validation
- Client-side and server-side validation
- Required field validators
- Email format validation
- Phone number format validation
- Date range validation
- Number range validation

### Security
- SQL injection prevention using parameterized queries
- Input validation on all forms
- Data type validation

### User Experience
- Responsive design
- Modern dark theme
- Intuitive navigation
- Search functionality
- Real-time validation feedback

## Customization

### Changing Colors
Edit `assets/css/darkpan.css` and modify the CSS variables:
```css
:root {
    --primary-color: #009CFF;
    --secondary-color: #0E2238;
    --dark-bg: #000000;
    --sidebar-bg: #0E2238;
    --content-bg: #191C24;
}
```

### Adding New Pages
1. Create new `.aspx` file
2. Add `MasterPageFile="~/Site.Master"` to the Page directive
3. Use `ContentPlaceHolder ID="MainContent"` for page content
4. Add navigation link in `Site.Master`

## Troubleshooting

### Database Connection Issues
- Verify SQL Server is running
- Check connection string in Web.config
- Ensure database exists
- Verify user permissions

### Build Errors
- Ensure .NET Framework 4.8 is installed
- Restore NuGet packages
- Clean and rebuild solution

### Runtime Errors
- Check Application Event Log
- Enable detailed error messages in Web.config
- Verify database schema matches code

## Support

For issues or questions:
1. Check the database setup script
2. Verify all configuration settings
3. Review error logs
4. Contact your hosting provider for server-specific issues

## License

This project is created for educational and commercial use.

## Credits

- **Dashboard Template**: DarkPan
- **Icons**: Font Awesome
- **Images**: Unsplash (placeholder images)
