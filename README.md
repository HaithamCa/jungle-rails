# Jungle

E-commerce application built with Rails 4.2.

## Features

---

- Users can register, login and logout.
- Users can see all the products as well as filtering by categories.
- Users can add available items to their cart, remove items, and pay.
- Admins have access to a dashboard of the products and categories.
- Admins can add/remove products and add categories.

## Final product

![Products page](https://github.com/HaithamCa/jungle-rails/blob/master/Docs/products.png)
![Appearel](https://github.com/HaithamCa/jungle-rails/blob/master/Docs/appearel.png)
![User cart](https://github.com/HaithamCa/jungle-rails/blob/master/Docs/my-cart.png)
![User order](https://github.com/HaithamCa/jungle-rails/blob/master/Docs/order.png)

## Recent Improvements

### Admin Access Control (October 2026)

**Security Enhancement**: Replaced vulnerable HTTP basic authentication with proper user-based admin permissions.

#### What was implemented:
- **Admin Flag System**: Added `admin` boolean column to users table (defaults to false)
- **Protected Routes**: All admin controllers now require authenticated admin users
- **Smart Navigation**: Admin menu appears only for users with admin privileges
- **Enhanced Login Flow**: 
  - Guests accessing admin URLs are redirected to login and returned to their intended page
  - Non-admin users receive clear "access denied" messaging
  - Improved error handling with "Invalid email or password" feedback
- **Bug Fixes**:
  - Fixed dashboard product count display issue
  - Resolved Admin::Category autoload conflicts
  - Added proper flash message rendering throughout the application

#### Admin Access:
- **Development Admin**: `admin@jungle.test` / `password`
- **Promoting Users**: `User.find_by(email: "email@example.com").update_column(:admin, true)`

#### Testing:
- Comprehensive request specs covering all admin access scenarios
- Protection against privilege escalation through signup form
- Validation of proper access control for guests, users, and admins

This enhancement eliminates security vulnerabilities while improving the overall user experience for both shoppers and administrators.
