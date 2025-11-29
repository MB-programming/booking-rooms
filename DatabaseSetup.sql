-- =============================================
-- Hotel Booking System Database Setup
-- Database: HotelBookingDB
-- =============================================

-- Create Database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'HotelBookingDB')
BEGIN
    CREATE DATABASE HotelBookingDB;
END
GO

USE HotelBookingDB;
GO

-- =============================================
-- Create Tables
-- =============================================

-- Guests Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Guests]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Guests] (
        [GuestID] INT IDENTITY(1,1) PRIMARY KEY,
        [Name] NVARCHAR(100) NOT NULL,
        [Phone] NVARCHAR(20) NOT NULL,
        [Email] NVARCHAR(100) NOT NULL,
        [Nationality] NVARCHAR(50) NOT NULL,
        [CreatedDate] DATETIME NOT NULL DEFAULT GETDATE(),
        [UpdatedDate] DATETIME NULL
    );
END
GO

-- Reservations Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Reservations]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Reservations] (
        [ReservationID] INT IDENTITY(1,1) PRIMARY KEY,
        [GuestID] INT NOT NULL,
        [RoomType] NVARCHAR(50) NOT NULL,
        [CheckInDate] DATE NOT NULL,
        [CheckOutDate] DATE NOT NULL,
        [Adults] INT NOT NULL,
        [Children] INT NOT NULL DEFAULT 0,
        [SpecialRequests] NVARCHAR(500) NULL,
        [Status] NVARCHAR(20) NOT NULL DEFAULT 'Active',
        [CreatedDate] DATETIME NOT NULL DEFAULT GETDATE(),
        [UpdatedDate] DATETIME NULL,
        CONSTRAINT [FK_Reservations_Guests] FOREIGN KEY ([GuestID])
            REFERENCES [dbo].[Guests]([GuestID]) ON DELETE CASCADE
    );
END
GO

-- Room Inventory Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RoomInventory]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[RoomInventory] (
        [RoomInventoryID] INT IDENTITY(1,1) PRIMARY KEY,
        [RoomType] NVARCHAR(50) NOT NULL UNIQUE,
        [TotalRooms] INT NOT NULL,
        [AvailableRooms] INT NOT NULL,
        [OccupiedRooms] INT NOT NULL,
        [PricePerNight] DECIMAL(10,2) NOT NULL,
        [Description] NVARCHAR(500) NULL,
        [ImageURL] NVARCHAR(255) NULL,
        [Status] NVARCHAR(20) NOT NULL DEFAULT 'Active',
        [CreatedDate] DATETIME NOT NULL DEFAULT GETDATE(),
        [UpdatedDate] DATETIME NULL
    );
END
GO

-- =============================================
-- Insert Sample Data
-- =============================================

-- Insert Sample Guests
IF NOT EXISTS (SELECT * FROM [dbo].[Guests])
BEGIN
    INSERT INTO [dbo].[Guests] ([Name], [Phone], [Email], [Nationality], [CreatedDate])
    VALUES
        ('John Smith', '+1-555-0101', 'john.smith@email.com', 'USA', GETDATE()),
        ('Sarah Johnson', '+1-555-0102', 'sarah.johnson@email.com', 'Canada', GETDATE()),
        ('Mohammed Al-Rashid', '+971-555-0103', 'mohammed.rashid@email.com', 'UAE', GETDATE()),
        ('Maria Garcia', '+34-555-0104', 'maria.garcia@email.com', 'Spain', GETDATE()),
        ('David Chen', '+86-555-0105', 'david.chen@email.com', 'China', GETDATE());
END
GO

-- Insert Sample Room Inventory
IF NOT EXISTS (SELECT * FROM [dbo].[RoomInventory])
BEGIN
    INSERT INTO [dbo].[RoomInventory]
        ([RoomType], [TotalRooms], [AvailableRooms], [OccupiedRooms], [PricePerNight], [Description], [Status])
    VALUES
        ('Single', 20, 15, 5, 99.00, 'Cozy and comfortable room perfect for solo travelers', 'Active'),
        ('Double', 30, 22, 8, 149.00, 'Spacious room with a comfortable double bed', 'Active'),
        ('Triple', 15, 10, 5, 199.00, 'Perfect for families or groups with three beds', 'Active'),
        ('Suite', 10, 7, 3, 299.00, 'Luxurious suite with separate living area', 'Active'),
        ('Deluxe', 12, 8, 4, 249.00, 'Premium deluxe room with stunning views', 'Active');
END
GO

-- Insert Sample Reservations
IF NOT EXISTS (SELECT * FROM [dbo].[Reservations])
BEGIN
    INSERT INTO [dbo].[Reservations]
        ([GuestID], [RoomType], [CheckInDate], [CheckOutDate], [Adults], [Children], [Status], [CreatedDate])
    VALUES
        (1, 'Double', DATEADD(day, 1, GETDATE()), DATEADD(day, 4, GETDATE()), 2, 0, 'Active', GETDATE()),
        (2, 'Suite', DATEADD(day, 2, GETDATE()), DATEADD(day, 7, GETDATE()), 2, 1, 'Active', GETDATE()),
        (3, 'Single', DATEADD(day, 0, GETDATE()), DATEADD(day, 3, GETDATE()), 1, 0, 'Active', GETDATE()),
        (4, 'Triple', DATEADD(day, 3, GETDATE()), DATEADD(day, 8, GETDATE()), 2, 2, 'Active', GETDATE()),
        (5, 'Deluxe', DATEADD(day, 1, GETDATE()), DATEADD(day, 5, GETDATE()), 2, 0, 'Active', GETDATE());
END
GO

-- =============================================
-- Create Indexes for Better Performance
-- =============================================

-- Index on Guest Email (for quick lookups)
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Guests_Email')
BEGIN
    CREATE INDEX IX_Guests_Email ON [dbo].[Guests]([Email]);
END
GO

-- Index on Reservation Status
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Reservations_Status')
BEGIN
    CREATE INDEX IX_Reservations_Status ON [dbo].[Reservations]([Status]);
END
GO

-- Index on Reservation Dates
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Reservations_Dates')
BEGIN
    CREATE INDEX IX_Reservations_Dates ON [dbo].[Reservations]([CheckInDate], [CheckOutDate]);
END
GO

-- =============================================
-- Create Views
-- =============================================

-- View for Reservation Details
IF EXISTS (SELECT * FROM sys.views WHERE name = 'vw_ReservationDetails')
BEGIN
    DROP VIEW [dbo].[vw_ReservationDetails];
END
GO

CREATE VIEW [dbo].[vw_ReservationDetails]
AS
SELECT
    r.ReservationID,
    r.GuestID,
    g.Name AS GuestName,
    g.Phone AS GuestPhone,
    g.Email AS GuestEmail,
    g.Nationality,
    r.RoomType,
    r.CheckInDate,
    r.CheckOutDate,
    DATEDIFF(day, r.CheckInDate, r.CheckOutDate) AS NumberOfNights,
    r.Adults,
    r.Children,
    r.SpecialRequests,
    r.Status,
    ri.PricePerNight,
    ri.PricePerNight * DATEDIFF(day, r.CheckInDate, r.CheckOutDate) AS TotalPrice,
    r.CreatedDate
FROM
    [dbo].[Reservations] r
    INNER JOIN [dbo].[Guests] g ON r.GuestID = g.GuestID
    LEFT JOIN [dbo].[RoomInventory] ri ON r.RoomType = ri.RoomType;
GO

-- =============================================
-- Create Stored Procedures
-- =============================================

-- Stored Procedure to Check Room Availability
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_CheckRoomAvailability')
BEGIN
    DROP PROCEDURE [dbo].[sp_CheckRoomAvailability];
END
GO

CREATE PROCEDURE [dbo].[sp_CheckRoomAvailability]
    @RoomType NVARCHAR(50),
    @CheckInDate DATE,
    @CheckOutDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ri.RoomType,
        ri.TotalRooms,
        ri.AvailableRooms,
        COUNT(r.ReservationID) AS BookedRooms,
        (ri.AvailableRooms - COUNT(r.ReservationID)) AS RoomsAvailable
    FROM
        [dbo].[RoomInventory] ri
        LEFT JOIN [dbo].[Reservations] r ON ri.RoomType = r.RoomType
            AND r.Status = 'Active'
            AND (
                (@CheckInDate BETWEEN r.CheckInDate AND r.CheckOutDate) OR
                (@CheckOutDate BETWEEN r.CheckInDate AND r.CheckOutDate) OR
                (r.CheckInDate BETWEEN @CheckInDate AND @CheckOutDate)
            )
    WHERE
        ri.RoomType = @RoomType
    GROUP BY
        ri.RoomType, ri.TotalRooms, ri.AvailableRooms;
END
GO

-- =============================================
-- Grant Permissions (if needed)
-- =============================================

PRINT 'Database setup completed successfully!';
PRINT 'Database: HotelBookingDB';
PRINT 'Tables: Guests, Reservations, RoomInventory';
PRINT 'Views: vw_ReservationDetails';
PRINT 'Stored Procedures: sp_CheckRoomAvailability';
GO
