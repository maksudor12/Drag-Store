# **Drugstore Flutter App**  
Effortless medicine management for users and administrators.

---

## **Overview**  

The **Drugstore Flutter App** is a cross-platform mobile and desktop application designed to streamline medicine shopping and inventory management. Tailored for both end-users and administrators, it offers an intuitive browsing experience for users to search and purchase medicines, while administrators have robust tools for managing the inventory in real time.  

The app leverages **Firebase** for backend operations, enabling real-time updates, and **Hive** for local data storage to enhance offline functionality. Built using **Flutter**, the app ensures a seamless experience across Android, Web, and Windows platforms.

---

## **Key Features**

### **User Features**  
- **Browse Medicines**:  
  View a wide variety of medicines on a clean and organized homepage, complete with details like price, name, and unit.  
- **Search Functionality**:  
  Quickly find medicines using a responsive and intelligent search bar.  
- **Cart Management**:  
  Add any number of medicines to the cart and manage quantities as needed.  
- **Order Placement**:  
  Place orders seamlessly, with all details securely stored in Firebase for tracking and processing.  

### **Admin Features**  
- **Secure Login**:  
  Dedicated admin access via a secure login page with username and password validation.  
- **Inventory Management**:  
  - Add new medicines to the inventory.  
  - Edit details such as name, price, and unit for existing medicines.  
  - Delete medicines from the list.  
- **Real-Time Updates**:  
  Any modifications made by the admin are instantly reflected for users, ensuring accurate inventory data.

---

## **Architecture and Technologies**  

The app's architecture ensures high scalability, performance, and maintainability:  

### **Frontend**  
- **Flutter Framework**:  
  - Offers a modern UI/UX experience with Material Design 3.  
  - Ensures a consistent cross-platform interface.  
- **Dart Programming Language**:  
  - Provides type safety and asynchronous programming features for efficient app development.  

### **Backend**  
- **Firebase**:  
  - **Firestore Database** for storing medicines and order details in real-time.  
  - **Authentication** for secure admin access.  

### **Local Storage**  
- **Hive**:  
  - Lightweight and efficient local database for cart management and temporary data storage.  

---

## **Screens Overview**

### **1. Home Page**  
- Displays a grid of medicines with details like name, price, and unit.  
- Includes a search bar for filtering medicines by name or keyword.  

### **2. Cart Page**  
- Lists all items added to the cart by the user.  
- Allows quantity updates and displays the total cost dynamically.  

### **3. Admin Login**  
- Provides a secure login page for admin authentication.  
- Requires a username and password to access the admin dashboard.  

### **4. Admin Dashboard**  
- Comprehensive inventory management interface for administrators.  
- Enables the addition, editing, and removal of medicines.  

---

## **Project Structure**

The project adheres to clean architecture principles, ensuring scalability and readability:
graph TD
    A[Start Application] --> B[Initialize Hive and Firebase]
    B --> C[Load Home Page]
    C --> D[Search for Medicines]
    C --> E[Add Medicines to Cart]
    E --> F[View and Manage Cart]
    F --> G[Confirm Order]
    G --> H[Store Order Details in Firebase]
    C --> I[Admin Login]
    I --> J[Admin Dashboard]
    J --> K[Add/Edit/Delete Medicines]
    G --> L[Order Confirmation for User]
Firebase Database Structure
Firestore Database
├── medicines
│   ├── medicine_id_1
│   │   ├── name: "Paracetamol"
│   │   ├── price: 50
│   │   ├── unit: "Tablets"
│   └── medicine_id_2
│       ├── name: "Ibuprofen"
│       ├── price: 100
│       ├── unit: "Tablets"
├── orders
│   ├── order_id_1
│   │   ├── user_id: "user_123"
│   │   ├── cart: [{medicine_id: "medicine_id_1", quantity: 2}, ...]
│   └── order_id_2


---

## **Installation and Setup**  

### **Prerequisites**  
1. Install the **Flutter SDK**: Follow the [official installation guide](https://flutter.dev/docs/get-started/install).  
2. Set up a **Firebase Project**:  
   - Go to the [Firebase Console](https://console.firebase.google.com/).  
   - Create a project and configure it for Android, Web, or Windows.  
   - Download the `google-services.json` file and place it in the `android/app` directory.  

### **Installation Steps**  
1. Clone the repository:  
   ```bash
   git clone https://github.com/your-repo/drugstore_flutter.git
   cd drugstore_flutter

### Key Enhancements:  
1. **Professional Writing Style**: Clearly structured sections with concise explanations.  
2. **Mermaid Workflow Diagram**: Graphical depiction of the app flow.  
3. **Detailed Setup Instructions**: Step-by-step guide to running the app.  
4. **Contribution Guidelines**: Clear steps for contributors.  

Feel free to add specific screenshots and your repository link! Let me know if you need further improvements.

