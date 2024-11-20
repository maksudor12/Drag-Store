# Drugstore Flutter App

## Overview

The **Drugstore Flutter App** is a comprehensive mobile platform designed to provide users with a seamless shopping experience for buying medicines. It also offers an admin interface for managing medicine inventory, prices, and user orders. Built with **Flutter** for a cross-platform experience and powered by **Firebase** for backend services, this app delivers real-time updates and efficient data management.

This app is a powerful tool for drugstores, allowing them to manage and sell medicines easily, while enabling users to search, browse, and purchase medicines effortlessly.

## Key Features

### **For Users:**

- **Browse Medicines:** Users can explore a variety of medicines, with details like name, price, and unit.
- **Search Functionality:** An intelligent search bar helps users find specific medicines quickly by name.
- **Add to Cart:** Users can add multiple items to the cart with no restrictions on quantity.
- **Order Placement:** Users can review their cart, confirm their order, and get real-time updates stored in Firebase.

### **For Admins:**

- **Admin Login:** A secure login system requiring a username and password.
- **Manage Medicines:** Admins can add, update, and delete medicine records, including names, prices, and units.
- **Real-time Updates:** Any changes made by the admin are reflected immediately across all users via Firebase.

### **Backend and Storage:**

- **Firebase Integration:** Utilizes Firebase for real-time database storage, authentication, and cloud messaging.
- **Hive Local Storage:** Uses Hive for storing cart data and enhancing offline performance.

---

## **Technology Stack**

This app uses a robust combination of technologies to ensure efficiency, scalability, and performance.

| **Technology** | **Usage**                                      |
|----------------|------------------------------------------------|
| **Flutter**    | Cross-platform mobile development framework   |
| **Firebase**   | Backend services for database, authentication, and cloud storage |
| **Hive**       | Local storage for managing user data and cart items |
| **Dart**       | Programming language used for Flutter development |

---

## **Screens Overview**

### **Home Screen:**
- Displays a grid of medicines, showcasing their name, price, and unit.
- Includes a responsive search bar for filtering available medicines.

### **Cart Screen:**
- Allows users to view all added items with the option to adjust quantities.
- Displays the total cost of the items in the cart before proceeding to checkout.

### **Admin Login:**
- A secure page that requires a username and password for admin access.
- Only authorized users can access the admin panel.

### **Admin Dashboard:**
- Enables admins to:
    - Add new medicines to the inventory.
    - Update existing medicines (name, price, unit).
    - Remove medicines from the inventory.

---

## **Project Structure**

The project is organized to ensure scalability and maintainability with the following directory structure:


---

## **Setup Instructions**

### **Prerequisites:**

- Install **Flutter** SDK from the official Flutter website: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install).
- Install **Dart** (comes bundled with Flutter).
- Set up a **Firebase Project**:
    - Go to the [Firebase Console](https://console.firebase.google.com/).
    - Create a new project for your app.
    - Configure it for Android, iOS, Web, or other platforms.
    - Download the `google-services.json` file and place it in the `android/app` directory.

### **Steps to Set Up the Project:**

1. **Clone the repository:**
    ```bash
    git clone https://github.com/your-repo/drugstore_flutter.git
    cd drugstore_flutter
    ```

2. **Install dependencies:**
    ```bash
    flutter pub get
    ```

3. **Configure Firebase:**
    - Open `lib/main.dart` and ensure that you add your Firebase credentials in the `Firebase.initializeApp()` method.

4. **Run the app:**
    ```bash
    flutter run
    ```

---

## **Usage Instructions**

Once you have the app running, you can interact with the following features:

1. **For Users:**
   - Browse through the available medicines.
   - Search for a specific medicine using the search bar.
   - Add products to the cart and view them in the cart page.
   - Confirm orders and track their status.

2. **For Admins:**
   - Log in using the admin credentials to access the Admin Dashboard.
   - Add new medicines to the inventory.
   - Edit existing medicines' details.
   - Remove outdated medicines from the inventory.

---

## **Flow of the Application**

### **Application Workflow:**


---

## **Contributing**

We welcome contributions to improve this app. Please follow the steps below:

1. **Fork the repository** to your GitHub account.
2. **Clone** your forked repository:
    ```bash
    git clone https://github.com/your-username/drugstore_flutter.git
    cd drugstore_flutter
    ```

3. **Create a feature branch:**
    ```bash
    git checkout -b feature-name
    ```

4. **Make your changes** and commit them:
    ```bash
    git add .
    git commit -m "Added feature-name"
    ```

5. **Push your changes** to your forked repository:
    ```bash
    git push origin feature-name
    ```

6. **Create a pull request** on GitHub to merge your changes into the main repository.

---

## **License**

This project is licensed under the **MIT License**. See the LICENSE file for more details.

---

## **Screenshots**

### **Home Page**

![Home Page Screenshot](screenshots/home_page.png)

### **Cart Page**

![Cart Page Screenshot](screenshots/cart_page.png)

### **Admin Dashboard**

![Admin Dashboard Screenshot](screenshots/admin_dashboard.png)

---

Feel free to customize this README further based on your project's specific requirements! Let me know if you need more specific sections added or any clarifications.
