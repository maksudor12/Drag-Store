# Drugstore Flutter App

Effortless medicine management for users and administrators.

## Overview

The **Drugstore Flutter App** is a comprehensive platform designed to simplify medicine shopping for users and provide seamless inventory management for administrators. It combines a modern user interface, powerful search capabilities, and real-time database integration with Firebase, ensuring a smooth and reliable experience across devices.

The app leverages **Flutter** for cross-platform compatibility, **Firebase** for real-time backend services, and **Hive** for efficient local storage.

---

## Features

### For Users
- **Browse Medicines**: A grid-based display of available medicines with details such as name, price, and unit.
- **Search Medicines**: An intuitive search bar to quickly find medicines.
- **Add to Cart**: Add unlimited products to the cart and view total cost dynamically.
- **Place Orders**: Place orders with real-time updates stored in Firebase.

### For Admins
- **Secure Login**: Admin access through a secure login page requiring credentials.
- **Inventory Management**:
  - Add new medicines to the inventory.
  - Edit medicine details like name, price, and unit.
  - Delete medicines from the database.
- **Real-Time Updates**: Changes made by admins are instantly reflected for all users.

---

## Technology Stack

| Technology       | Usage                                                   |
|-------------------|---------------------------------------------------------|
| **Flutter**       | Cross-platform app development framework.              |
| **Firebase**      | Backend services for real-time database and auth.      |
| **Hive**          | Lightweight local storage for cart and offline data.   |
| **Dart**          | Primary programming language for app development.      |

---

## Application Flow

### User Flow
1. **Home Page**: Browse available medicines or use the search bar to filter results.
2. **Cart Management**: Add selected medicines to the cart, adjust quantities, and review the order.
3. **Order Placement**: Confirm the order, and details are saved to Firebase.

### Admin Flow
1. **Login**: Access the admin dashboard using a username and password.
2. **Inventory Management**:
   - Add new medicines with details (name, price, unit).
   - Update or delete existing medicines.
3. **Data Sync**: All changes are synchronized with Firebase in real-time.





