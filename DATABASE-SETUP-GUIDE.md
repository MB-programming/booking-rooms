# 📚 دليل إعداد قاعدة البيانات والربط الكامل
## Hotel Booking System - DarkPan Dashboard

---

## 📋 جدول المحتويات

1. [متطلبات النظام](#متطلبات-النظام)
2. [إعداد قاعدة البيانات](#إعداد-قاعدة-البيانات)
3. [ربط قاعدة البيانات](#ربط-قاعدة-البيانات)
4. [اختبار الاتصال](#اختبار-الاتصال)
5. [حل المشاكل](#حل-المشاكل)

---

## 🔧 متطلبات النظام

### البرامج المطلوبة:
- ✅ **Visual Studio 2019** أو أحدث
- ✅ **SQL Server 2016** أو أحدث (أو SQL Server Express)
- ✅ **.NET Framework 4.8**
- ✅ **IIS Express** (مدمج مع Visual Studio)

### المتصفحات المدعومة:
- Google Chrome (موصى به)
- Microsoft Edge
- Mozilla Firefox

---

## 💾 إعداد قاعدة البيانات

### الطريقة الأولى: SQL Server المحلي

#### الخطوة 1: تثبيت SQL Server

```bash
# تحميل SQL Server Express (مجاني)
https://www.microsoft.com/en-us/sql-server/sql-server-downloads

# تحميل SQL Server Management Studio (SSMS)
https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms
```

#### الخطوة 2: تشغيل سكريبت قاعدة البيانات

1. افتح **SQL Server Management Studio (SSMS)**
2. اتصل بـ SQL Server:
   ```
   Server name: localhost\SQLEXPRESS
   أو
   Server name: (local)
   Authentication: Windows Authentication
   ```

3. افتح ملف `DatabaseSetup.sql`:
   - File → Open → File
   - اختر `DatabaseSetup.sql` من مجلد المشروع

4. نفذ السكريبت:
   - اضغط **F5** أو **Execute**
   - انتظر حتى تظهر رسالة النجاح:
     ```
     Database setup completed successfully!
     Database: HotelBookingDB
     Tables: Guests, Reservations, RoomInventory
     ```

#### الخطوة 3: التحقق من إنشاء قاعدة البيانات

```sql
-- تحقق من وجود قاعدة البيانات
SELECT name FROM sys.databases WHERE name = 'HotelBookingDB'

-- تحقق من الجداول
USE HotelBookingDB
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES

-- تحقق من البيانات التجريبية
SELECT COUNT(*) AS 'Guests' FROM Guests
SELECT COUNT(*) AS 'Reservations' FROM Reservations
SELECT COUNT(*) AS 'Room Inventory' FROM RoomInventory
```

**النتيجة المتوقعة:**
```
Guests: 5 records
Reservations: 5 records
Room Inventory: 5 records
```

---

### الطريقة الثانية: استخدام SmarterASP.NET

#### الخطوة 1: إنشاء قاعدة البيانات

1. سجل دخول إلى **لوحة تحكم SmarterASP.NET**
2. اذهب إلى **Database Manager**
3. اضغط **Add New Database**
4. اختر **MS SQL Server**
5. سجل معلومات الاتصال:
   ```
   Server Name: sql123.somee.com (مثال)
   Database Name: YourDB
   Username: YourUsername
   Password: YourPassword
   ```

#### الخطوة 2: استيراد قاعدة البيانات

1. في لوحة التحكم، اذهب إلى **SQL Script Manager**
2. افتح ملف `DatabaseSetup.sql`
3. انسخ المحتوى بالكامل
4. الصقه في SQL Script Manager
5. اضغط **Execute**

#### الخطوة 3: التحقق من الاستيراد

في SQL Script Manager، نفذ:
```sql
SELECT name FROM sys.tables
```

يجب أن ترى:
- Guests
- Reservations
- RoomInventory

---

## 🔗 ربط قاعدة البيانات

### 1. تحديث Web.config

افتح ملف `Web.config` في المشروع وحدّث `connectionStrings`:

#### للسيرفر المحلي (SQL Server Express):

```xml
<connectionStrings>
    <add name="HotelDBConnection"
         connectionString="Data Source=.\SQLEXPRESS;Initial Catalog=HotelBookingDB;Integrated Security=True"
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

**أو إذا كان SQL Server العادي:**

```xml
<connectionStrings>
    <add name="HotelDBConnection"
         connectionString="Data Source=(local);Initial Catalog=HotelBookingDB;Integrated Security=True"
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

#### لـ SmarterASP.NET أو أي استضافة خارجية:

```xml
<connectionStrings>
    <add name="HotelDBConnection"
         connectionString="Data Source=YOUR_SERVER;Initial Catalog=YOUR_DATABASE;User ID=YOUR_USERNAME;Password=YOUR_PASSWORD"
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

**مثال حقيقي:**
```xml
<connectionStrings>
    <add name="HotelDBConnection"
         connectionString="Data Source=sql123.somee.com;Initial Catalog=HotelBookingDB;User ID=myuser_SQLLogin_1;Password=myp@ssw0rd123"
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

### 2. حفظ الملف

احفظ `Web.config` بعد التعديل (**Ctrl+S**)

---

## ✅ اختبار الاتصال

### الطريقة الأولى: من خلال صفحة الاختبار

1. شغل المشروع في Visual Studio (**F5**)
2. في المتصفح، اذهب إلى صفحة الاختبار:
   ```
   http://localhost:PORT/Test.aspx
   ```
3. اضغط على **"Test Database Connection"**

**النتيجة المتوقعة:**
```
✅ Database Connection Successful!

Database Tables Status:
✅ Guests: 5 records
✅ Reservations: 5 records
✅ RoomInventory: 5 records
```

### الطريقة الثانية: اختبار من Console في المتصفح

1. افتح المشروع في المتصفح
2. اضغط **F12** لفتح Developer Tools
3. اذهب إلى **Console**
4. نفذ:
   ```javascript
   DarkPan.runComprehensiveTest()
   ```

**النتيجة المتوقعة:**
```
🧪 ========== COMPREHENSIVE SYSTEM TEST ==========

Test 1: Checking DOM Elements
  ✅ Sidebar: Found
  ✅ Main Content: Found
  ✅ Top Navigation: Found

Test 2: Checking CSS Files
  ✅ DarkPan CSS: Loaded
  ✅ Bootstrap CSS: Loaded

Test 3: Checking JavaScript Libraries
  ✅ jQuery: v3.6.0
  ✅ Bootstrap: Loaded
  ✅ Chart.js: Loaded

🎉 ========== TESTING COMPLETED ==========
```

### الطريقة الثالثة: اختبار الصفحات يدوياً

#### اختبار Guest.aspx:

1. اذهب إلى `Guest.aspx`
2. أدخل بيانات ضيف جديد:
   ```
   Name: Ahmed Mohamed
   Phone: +201234567890
   Email: ahmed@test.com
   Nationality: Egypt
   ```
3. اضغط **Save Guest**
4. تحقق من ظهور الرسالة: **"Guest saved successfully!"**
5. تحقق من ظهور الضيف في الجدول

#### اختبار Reservations.aspx:

1. اذهب إلى `Reservations.aspx`
2. اختر ضيف من القائمة
3. اختر نوع الغرفة: **Double**
4. حدد تاريخ الدخول: **2024-12-01**
5. حدد تاريخ المغادرة: **2024-12-05**
6. عدد البالغين: **2**
7. عدد الأطفال: **1**
8. اضغط **Create Reservation**
9. تحقق من ظهور الرسالة: **"Reservation created successfully!"**

#### اختبار Rooms.aspx:

1. اذهب إلى `Rooms.aspx`
2. تحقق من ظهور 6 أنواع غرف مع الصور
3. تحقق من ظهور جدول Room Inventory

---

## 🔍 اختبار شامل لجميع الوظائف

### قائمة الاختبار الكاملة:

#### ✅ اختبار الواجهة (Frontend)

- [ ] الصفحة الرئيسية (index.html) تفتح بدون أخطاء
- [ ] القائمة الجانبية (Sidebar) تظهر بشكل صحيح
- [ ] جميع الأيقونات تظهر (Font Awesome)
- [ ] التصميم متجاوب على الموبايل
- [ ] الألوان والتنسيق مطابق لـ DarkPan

#### ✅ اختبار قاعدة البيانات (Database)

- [ ] الاتصال بقاعدة البيانات يعمل
- [ ] جدول Guests موجود ويحتوي على بيانات
- [ ] جدول Reservations موجود ويحتوي على بيانات
- [ ] جدول RoomInventory موجود ويحتوي على بيانات
- [ ] العلاقات بين الجداول تعمل (Foreign Keys)

#### ✅ اختبار صفحة Guests

- [ ] إضافة ضيف جديد يعمل
- [ ] التحقق من صحة البيانات (Validation) يعمل
- [ ] التحقق من الإيميل يعمل
- [ ] التحقق من رقم الهاتف يعمل
- [ ] عرض قائمة الضيوف يعمل
- [ ] تعديل بيانات ضيف يعمل
- [ ] حذف ضيف يعمل
- [ ] البحث في الجدول يعمل

#### ✅ اختبار صفحة Reservations

- [ ] إنشاء حجز جديد يعمل
- [ ] اختيار الضيف من القائمة يعمل
- [ ] اختيار نوع الغرفة يعمل
- [ ] التحقق من التواريخ يعمل (Check-out بعد Check-in)
- [ ] التحقق من عدد البالغين يعمل (على الأقل 1)
- [ ] عرض الإحصائيات يعمل
- [ ] تعديل حجز يعمل
- [ ] حذف حجز يعمل

#### ✅ اختبار صفحة Rooms

- [ ] عرض بطاقات الغرف مع الصور يعمل
- [ ] عرض جدول Room Inventory يعمل
- [ ] الأسعار تظهر بشكل صحيح
- [ ] رابط Book Now يعمل

#### ✅ اختبار JavaScript

- [ ] DarkPan.validateEmail() يعمل
- [ ] DarkPan.validatePhone() يعمل
- [ ] DarkPan.validateDates() يعمل
- [ ] DarkPan.searchTable() يعمل
- [ ] DarkPan.showNotification() يعمل
- [ ] القائمة النشطة (Active Menu) تعمل

---

## 🐛 حل المشاكل

### Problem 1: لا يمكن الاتصال بقاعدة البيانات

**الخطأ:**
```
A network-related or instance-specific error occurred while establishing a connection to SQL Server
```

**الحلول:**

1. ✅ تأكد من أن SQL Server يعمل:
   ```
   Services → SQL Server (SQLEXPRESS) → Status: Running
   ```

2. ✅ تأكد من اسم السيرفر الصحيح:
   ```
   في SSMS، Server name يجب أن يكون نفسه في Web.config
   ```

3. ✅ جرب connection strings مختلفة:
   ```xml
   <!-- جرب 1 -->
   Data Source=.\SQLEXPRESS;...

   <!-- جرب 2 -->
   Data Source=(local)\SQLEXPRESS;...

   <!-- جرب 3 -->
   Data Source=localhost\SQLEXPRESS;...
   ```

### Problem 2: قاعدة البيانات غير موجودة

**الخطأ:**
```
Cannot open database "HotelBookingDB" requested by the login
```

**الحل:**

1. نفذ سكريبت إنشاء قاعدة البيانات:
   ```sql
   -- في SSMS
   -- افتح DatabaseSetup.sql
   -- اضغط F5
   ```

2. تحقق من وجود قاعدة البيانات:
   ```sql
   SELECT name FROM sys.databases
   ```

### Problem 3: خطأ في الصلاحيات

**الخطأ:**
```
Login failed for user
```

**الحل:**

**لـ Windows Authentication:**
```xml
<connectionStrings>
    <add name="HotelDBConnection"
         connectionString="Data Source=.\SQLEXPRESS;Initial Catalog=HotelBookingDB;Integrated Security=True"
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

**لـ SQL Authentication:**
```xml
<connectionStrings>
    <add name="HotelDBConnection"
         connectionString="Data Source=.\SQLEXPRESS;Initial Catalog=HotelBookingDB;User ID=sa;Password=YourPassword"
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

### Problem 4: الصفحات لا تظهر بشكل صحيح

**الحل:**

1. تأكد من Bootstrap و Font Awesome:
   ```html
   <!-- في Site.Master -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
   ```

2. امسح cache المتصفح:
   ```
   Ctrl + Shift + Delete → Clear Cache
   ```

3. تأكد من ملفات CSS و JS:
   ```
   /assets/css/darkpan.css ← يجب أن يكون موجود
   /assets/js/darkpan.js ← يجب أن يكون موجود
   ```

### Problem 5: JavaScript لا يعمل

**الحل:**

1. افتح Console (F12):
   ```javascript
   // تحقق من وجود DarkPan
   console.log(window.DarkPan)

   // يجب أن تظهر:
   // {validateForm: ƒ, validateEmail: ƒ, ...}
   ```

2. تأكد من تحميل jQuery:
   ```javascript
   console.log(jQuery.fn.jquery)
   // يجب أن تظهر: "3.6.0"
   ```

---

## 📊 جدول البيانات (Database Schema)

### جدول Guests

| Column | Type | Nullable | Description |
|--------|------|----------|-------------|
| GuestID | INT | NOT NULL | Primary Key |
| Name | NVARCHAR(100) | NOT NULL | اسم الضيف |
| Phone | NVARCHAR(20) | NOT NULL | رقم التليفون |
| Email | NVARCHAR(100) | NOT NULL | البريد الإلكتروني |
| Nationality | NVARCHAR(50) | NOT NULL | الجنسية |
| CreatedDate | DATETIME | NOT NULL | تاريخ الإنشاء |
| UpdatedDate | DATETIME | NULL | تاريخ التحديث |

### جدول Reservations

| Column | Type | Nullable | Description |
|--------|------|----------|-------------|
| ReservationID | INT | NOT NULL | Primary Key |
| GuestID | INT | NOT NULL | Foreign Key → Guests |
| RoomType | NVARCHAR(50) | NOT NULL | نوع الغرفة |
| CheckInDate | DATE | NOT NULL | تاريخ الدخول |
| CheckOutDate | DATE | NOT NULL | تاريخ المغادرة |
| Adults | INT | NOT NULL | عدد البالغين |
| Children | INT | NOT NULL | عدد الأطفال |
| SpecialRequests | NVARCHAR(500) | NULL | طلبات خاصة |
| Status | NVARCHAR(20) | NOT NULL | الحالة |
| CreatedDate | DATETIME | NOT NULL | تاريخ الإنشاء |

### جدول RoomInventory

| Column | Type | Nullable | Description |
|--------|------|----------|-------------|
| RoomInventoryID | INT | NOT NULL | Primary Key |
| RoomType | NVARCHAR(50) | NOT NULL | نوع الغرفة |
| TotalRooms | INT | NOT NULL | إجمالي الغرف |
| AvailableRooms | INT | NOT NULL | الغرف المتاحة |
| OccupiedRooms | INT | NOT NULL | الغرف المحجوزة |
| PricePerNight | DECIMAL(10,2) | NOT NULL | السعر في الليلة |
| Description | NVARCHAR(500) | NULL | الوصف |
| Status | NVARCHAR(20) | NOT NULL | الحالة |

---

## 🎯 الخطوات التالية

بعد إكمال الإعداد والاختبار:

1. ✅ **رفع المشروع على الاستضافة**
   - نسخ الملفات إلى السيرفر
   - تحديث Web.config بمعلومات قاعدة البيانات الجديدة
   - اختبار الموقع على الاستضافة

2. ✅ **إضافة مميزات جديدة**
   - صفحة Reports
   - صفحة Settings
   - نظام المستخدمين والصلاحيات

3. ✅ **تحسين الأمان**
   - تشفير كلمات المرور
   - منع SQL Injection
   - HTTPS

---

## 📞 الدعم الفني

إذا واجهت أي مشاكل:

1. تحقق من **Test.aspx** للحصول على تشخيص كامل
2. افتح **Browser Console (F12)** وشاهد الأخطاء
3. راجع **Application Event Log** في Windows
4. ارجع إلى قسم **حل المشاكل** أعلاه

---

## ✅ خلاصة سريعة

```bash
# 1. تثبيت SQL Server
# 2. فتح SSMS
# 3. تنفيذ DatabaseSetup.sql
# 4. تحديث Web.config بـ connection string
# 5. تشغيل المشروع (F5)
# 6. الذهاب إلى Test.aspx
# 7. اختبار الاتصال بقاعدة البيانات
# 8. اختبار جميع الصفحات

# ✅ انتهى!
```

---

**تم إنشاء هذا الدليل بواسطة:** DarkPan Hotel Booking System
**التاريخ:** 2024
**الإصدار:** 1.0
