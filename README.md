# 📱 iOS User Registration & OTP Verification App

This iOS application is built using **UIKit** and follows the **MVVM architecture**. It consists of two core modules:

1. **User Registration**
2. **OTP Verification**

The project ensures proper validation, error handling, and clean UI design based on Apple's Human Interface Guidelines.

---

## 🚀 Features

### ✅ Register Module
- User-friendly registration form
- Validation for all input fields (email, phone number, etc.)
- API integration for user registration
- Handles success and error responses from the backend
- On success, extracts `user_id` and `code` for OTP verification

### 🔐 OTP Verification Module
- Clean UI for entering OTP
- Validation for OTP input
- API call to verify OTP
- On success, navigates to the Welcome screen

---

## 🔧 Technologies Used

- UIKit
- MVVM Architecture
- URLSession for network requests
- AutoLayout (Programmatic or Storyboards)
- Swift

---

## 🧪 API Details

### 📤 Registration API

**URL**: `https://admin-cp.rimashaar.com/api/v1/register-new?lang=en`

**Method**: `POST`

**Sample Request Body**:
```json
{
  "app_version": "1.0",
  "device_model": "STK-L22",
  "device_token": "",
  "device_type": "A",
  "dob": "",
  "email": "rehanwangde@yopmail.com",
  "first_name": "Rehan",
  "gender": "",
  "last_name": "Wangde",
  "newsletter_subscribed": 0,
  "os_version": "10",
  "password": "",
  "phone": "",
  "phone_code": "965"
}
