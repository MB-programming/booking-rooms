/* ===========================================
   DarkPan Dashboard JavaScript
   Hotel Booking System
   =========================================== */

// ==================== DOM Ready ====================
document.addEventListener('DOMContentLoaded', function() {
    initializeDarkPan();
});

// ==================== Initialize Dashboard ====================
function initializeDarkPan() {
    console.log('🚀 DarkPan Dashboard Initialized');

    // Set active menu item
    setActiveMenu();

    // Initialize sidebar toggle
    initSidebarToggle();

    // Initialize tooltips if Bootstrap is available
    if (typeof bootstrap !== 'undefined') {
        const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    }

    // Run connectivity test
    testConnectivity();
}

// ==================== Sidebar Toggle ====================
function initSidebarToggle() {
    const menuToggle = document.querySelector('.menu-toggle');
    const sidebar = document.querySelector('.sidebar');

    if (menuToggle && sidebar) {
        menuToggle.addEventListener('click', function() {
            sidebar.classList.toggle('active');
            console.log('📱 Sidebar toggled');
        });
    }
}

// ==================== Set Active Menu Item ====================
function setActiveMenu() {
    const currentPage = window.location.pathname.split('/').pop() || 'index.html';
    const menuItems = document.querySelectorAll('.sidebar nav ul li a');

    menuItems.forEach(item => {
        const href = item.getAttribute('href');
        if (href === currentPage) {
            item.classList.add('active');
            console.log(`✅ Active menu set: ${currentPage}`);
        } else {
            item.classList.remove('active');
        }
    });
}

// ==================== Form Validation ====================
function validateForm(formId) {
    const form = document.getElementById(formId);
    if (!form) {
        console.error('❌ Form not found:', formId);
        return false;
    }

    const inputs = form.querySelectorAll('input[required], select[required], textarea[required]');
    let isValid = true;
    let errors = [];

    inputs.forEach(input => {
        if (!input.value.trim()) {
            input.style.borderColor = '#dc3545';
            isValid = false;
            errors.push(input.name || input.id || 'Unknown field');
        } else {
            input.style.borderColor = '';
        }
    });

    if (!isValid) {
        console.warn('⚠️ Form validation failed:', errors);
        showNotification('Please fill in all required fields', 'warning');
    } else {
        console.log('✅ Form validation passed');
    }

    return isValid;
}

// ==================== Email Validation ====================
function validateEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const isValid = re.test(email);
    console.log(`📧 Email validation (${email}):`, isValid ? '✅ Valid' : '❌ Invalid');
    return isValid;
}

// ==================== Phone Validation ====================
function validatePhone(phone) {
    const re = /^[+]?[\d\s\-()]+$/;
    const isValid = re.test(phone);
    console.log(`📞 Phone validation (${phone}):`, isValid ? '✅ Valid' : '❌ Invalid');
    return isValid;
}

// ==================== Date Validation ====================
function validateDates(checkInId, checkOutId) {
    const checkIn = document.getElementById(checkInId);
    const checkOut = document.getElementById(checkOutId);

    if (!checkIn || !checkOut) {
        console.error('❌ Date fields not found');
        return false;
    }

    const checkInDate = new Date(checkIn.value);
    const checkOutDate = new Date(checkOut.value);

    if (checkOutDate <= checkInDate) {
        showNotification('Check-out date must be after check-in date', 'danger');
        console.error('❌ Invalid dates:', {checkIn: checkIn.value, checkOut: checkOut.value});
        return false;
    }

    console.log('✅ Dates validated:', {checkIn: checkIn.value, checkOut: checkOut.value});
    return true;
}

// ==================== Number Validation ====================
function validateNumbers(adultsId, childrenId) {
    const adults = document.getElementById(adultsId);
    const children = document.getElementById(childrenId);

    if (adults && parseInt(adults.value) < 1) {
        showNotification('At least one adult is required', 'warning');
        console.error('❌ Invalid number of adults:', adults.value);
        return false;
    }

    console.log('✅ Numbers validated:', {adults: adults?.value, children: children?.value});
    return true;
}

// ==================== Table Search ====================
function searchTable(inputId, tableId) {
    const input = document.getElementById(inputId);
    const table = document.getElementById(tableId);

    if (!input || !table) {
        console.error('❌ Search elements not found:', {inputId, tableId});
        return;
    }

    const filter = input.value.toUpperCase();
    const rows = table.getElementsByTagName('tr');
    let visibleCount = 0;

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

        if (found) {
            row.style.display = '';
            visibleCount++;
        } else {
            row.style.display = 'none';
        }
    }

    console.log(`🔍 Search results: ${visibleCount} rows found for "${filter}"`);
}

// ==================== Notification System ====================
function showNotification(message, type = 'success') {
    const notification = document.createElement('div');
    notification.className = `alert alert-${type}`;
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 15px 25px;
        background: ${getNotificationColor(type)};
        color: white;
        border-radius: 8px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
        z-index: 9999;
        animation: slideInRight 0.3s ease-out;
        min-width: 300px;
        max-width: 500px;
    `;

    notification.innerHTML = `
        <div style="display: flex; align-items: center; gap: 10px;">
            <i class="fas ${getNotificationIcon(type)}" style="font-size: 20px;"></i>
            <span>${message}</span>
        </div>
    `;

    document.body.appendChild(notification);

    console.log(`📢 Notification (${type}): ${message}`);

    setTimeout(() => {
        notification.style.animation = 'slideOutRight 0.3s ease-out';
        setTimeout(() => notification.remove(), 300);
    }, 3000);
}

function getNotificationColor(type) {
    const colors = {
        success: 'linear-gradient(135deg, #28a745 0%, #218838 100%)',
        danger: 'linear-gradient(135deg, #dc3545 0%, #c82333 100%)',
        warning: 'linear-gradient(135deg, #ffc107 0%, #e0a800 100%)',
        info: 'linear-gradient(135deg, #17a2b8 0%, #138496 100%)'
    };
    return colors[type] || colors.info;
}

function getNotificationIcon(type) {
    const icons = {
        success: 'fa-check-circle',
        danger: 'fa-exclamation-circle',
        warning: 'fa-exclamation-triangle',
        info: 'fa-info-circle'
    };
    return icons[type] || icons.info;
}

// ==================== Loading Spinner ====================
function showLoading(elementId) {
    const element = document.getElementById(elementId);
    if (element) {
        element.innerHTML = '<div class="spinner"></div>';
        console.log('⏳ Loading spinner shown');
    }
}

function hideLoading(elementId) {
    const element = document.getElementById(elementId);
    if (element) {
        element.innerHTML = '';
        console.log('✅ Loading spinner hidden');
    }
}

// ==================== Test Functions ====================
function testConnectivity() {
    console.log('\n🧪 ==========  TESTING DARKPAN DASHBOARD ==========');
    console.log('📋 Running connectivity tests...\n');

    // Test 1: DOM Elements
    console.log('Test 1: Checking DOM Elements');
    const sidebar = document.querySelector('.sidebar');
    const mainContent = document.querySelector('.main-content');
    const topNav = document.querySelector('.top-nav');

    console.log('  ✅ Sidebar:', sidebar ? 'Found' : '❌ Not Found');
    console.log('  ✅ Main Content:', mainContent ? 'Found' : '❌ Not Found');
    console.log('  ✅ Top Navigation:', topNav ? 'Found' : '❌ Not Found');

    // Test 2: CSS Files
    console.log('\nTest 2: Checking CSS Files');
    const stylesheets = document.styleSheets;
    let darkpanCSSFound = false;
    let bootstrapCSSFound = false;

    for (let i = 0; i < stylesheets.length; i++) {
        try {
            const href = stylesheets[i].href || '';
            if (href.includes('darkpan.css')) darkpanCSSFound = true;
            if (href.includes('bootstrap')) bootstrapCSSFound = true;
        } catch (e) {
            // Cross-origin stylesheets
        }
    }

    console.log('  ✅ DarkPan CSS:', darkpanCSSFound ? 'Loaded' : '⚠️ Not Found');
    console.log('  ✅ Bootstrap CSS:', bootstrapCSSFound ? 'Loaded' : '⚠️ Not Found');

    // Test 3: JavaScript Libraries
    console.log('\nTest 3: Checking JavaScript Libraries');
    console.log('  ✅ jQuery:', typeof jQuery !== 'undefined' ? `v${jQuery.fn.jquery}` : '⚠️ Not Loaded');
    console.log('  ✅ Bootstrap:', typeof bootstrap !== 'undefined' ? 'Loaded' : '⚠️ Not Loaded');
    console.log('  ✅ Chart.js:', typeof Chart !== 'undefined' ? 'Loaded' : '⚠️ Not Loaded');

    // Test 4: Pages
    console.log('\nTest 4: Checking Navigation Links');
    const navLinks = document.querySelectorAll('.sidebar nav ul li a');
    console.log(`  📄 Found ${navLinks.length} navigation links:`);
    navLinks.forEach((link, index) => {
        const href = link.getAttribute('href');
        const text = link.textContent.trim();
        console.log(`     ${index + 1}. ${text} → ${href}`);
    });

    // Test 5: Form Validation Functions
    console.log('\nTest 5: Testing Form Validation Functions');
    console.log('  ✅ validateEmail:', typeof validateEmail === 'function' ? 'Available' : '❌ Missing');
    console.log('  ✅ validatePhone:', typeof validatePhone === 'function' ? 'Available' : '❌ Missing');
    console.log('  ✅ validateDates:', typeof validateDates === 'function' ? 'Available' : '❌ Missing');
    console.log('  ✅ validateForm:', typeof validateForm === 'function' ? 'Available' : '❌ Missing');

    // Test 6: Sample Validation Tests
    console.log('\nTest 6: Running Sample Validations');
    const testEmail = validateEmail('test@hotel.com');
    const testPhone = validatePhone('+1234567890');
    console.log('  📧 Email test (test@hotel.com):', testEmail ? '✅ Pass' : '❌ Fail');
    console.log('  📞 Phone test (+1234567890):', testPhone ? '✅ Pass' : '❌ Fail');

    console.log('\n🎉 ========== TESTING COMPLETED ==========\n');
}

function runComprehensiveTest() {
    console.log('\n🔬 ========== COMPREHENSIVE SYSTEM TEST ==========\n');

    testConnectivity();

    // Test notification system
    console.log('🧪 Testing Notification System...');
    setTimeout(() => showNotification('Test: Success notification', 'success'), 500);
    setTimeout(() => showNotification('Test: Warning notification', 'warning'), 1500);
    setTimeout(() => showNotification('Test: Error notification', 'danger'), 2500);
    setTimeout(() => showNotification('Test: Info notification', 'info'), 3500);

    console.log('✅ Notification tests queued\n');
}

// ==================== Animation Styles ====================
const animationStyles = document.createElement('style');
animationStyles.textContent = `
    @keyframes slideInRight {
        from {
            transform: translateX(400px);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }

    @keyframes slideOutRight {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(400px);
            opacity: 0;
        }
    }

    .spinner {
        border: 4px solid rgba(0, 156, 255, 0.1);
        border-radius: 50%;
        border-top: 4px solid #009CFF;
        width: 40px;
        height: 40px;
        animation: spin 1s linear infinite;
        margin: 20px auto;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
`;
document.head.appendChild(animationStyles);

// ==================== Export Functions for Global Access ====================
window.DarkPan = {
    validateForm,
    validateEmail,
    validatePhone,
    validateDates,
    validateNumbers,
    searchTable,
    showNotification,
    showLoading,
    hideLoading,
    testConnectivity,
    runComprehensiveTest
};

console.log('✅ DarkPan utilities loaded and ready!');
console.log('💡 Run DarkPan.runComprehensiveTest() to test all features');
