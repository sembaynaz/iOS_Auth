# iOS_Auth

# iOS_StopWatch
<img width = "245" height = "500" src = "https://github.com/sembaynaz/iOS_Auth/assets/96616194/3cf5ff5e-37df-4262-abcc-3036e92683cf">
<img width = "245" height = "500" src = "https://github.com/sembaynaz/iOS_Auth/assets/96616194/a37d7c73-ba9e-4993-831c-b5a2e5dc5cef">
<img width = "245" height = "500" src = "https://github.com/sembaynaz/iOS_Auth/assets/96616194/e9a62614-cd71-4945-851b-ea61fc91a5f0">
<img width = "245" height = "500" src = "https://github.com/sembaynaz/iOS_Auth/assets/96616194/4cbf05de-1244-4248-913f-89d96a395eec">
<img width = "245" height = "500" src = "https://github.com/sembaynaz/iOS_Auth/assets/96616194/8ef307a4-2cfd-4793-8277-f51c5d918853">
<img width = "245" height = "500" src = "https://github.com/sembaynaz/iOS_Auth/assets/96616194/323c6489-6f3c-4c76-8973-f0867c54fc0d">


## Project Description
This iOS application is designed for user authentication and account management. It includes custom UI components like TextField, Button, and BackButton, providing a seamless user experience. The application utilizes several view controllers, each serving a specific purpose within the authentication and registration process.

## Installation
Libraries used here, that we must instaal is **SnapKit**. You can download the project from GitHub as a zip file and then open it in the **xCode** application.
If you have problems when run the project: Delete Podfile.lock, Pods, .xcworkspace files, them in terminal install the pod. (pod install)

## Usage

#### Components Overview
* TextField.swift: This custom text field class features a placeholder label and a toggle button for password visibility. It offers extensive customization options and functions for enhanced user interaction.

* Button.swift: The custom button class inherits from UIButton, allowing tailored visual styling. It includes functions to set the button's active state, ensuring a consistent look across the app.

* BackButton.swift: This extension refines the appearance of the back button in the navigation bar, maintaining a unified design throughout the application.


#### View Controllers
* **SplashViewController:**
This view controller likely serves as the entry point of the application. It appears to handle authentication state and navigation logic based on whether the user is signed in or not and hasnotification that notificate about correctly changed password .

* **SigninViewController:**
This view controller seems to be responsible for user sign-in functionality. It includes text fields for email and password entry and a button for initiating the sign-in process. **_Write a valid email to activa button. For example: q@mail.ty_**

* **SignupAndCheckEmailViewController:**
This view controller appears to handle user registration and email verification. It includes text fields for email and verification code, as well as buttons for signing up and resending the verification email. **_Write a valid email to activa button. For example: q@mail.ty_**

* **ChangePasswordViewController:**
This screen appears to contain a view controller for changing the user's password. It includes text fields for entering the new password and confirming it. There are also labels indicating password strength requirements (uppercase letter, digits, special characters) and a button for proceeding to the next step. The `nextButtonTapped` function handles the logic for changing the password and navigating to the next screen. **_For active button do all requirements Uppercase letter, digits,special characters. For example: Q_1_**

* **UserInfoViewController:**
This screen contains a view controller for collecting user information such as name, surname, birth date, and email address. It includes text fields for each of these pieces of information, and a button for registering the user. The `signupButtonTapped` function handles the logic for navigating to the next screen for creating a password. **_No empty textFIelds for active button_**

* **AlertViewController:**
This file seems to contain a view controller for displaying alerts to the user. It includes a message label, a close button, and a logo image. The `closeButtonTapped` function handles the logic for dismissing the alert and navigating to the appropriate screen based on the context of the alert (changing password or providing user information).

## Contribution
Contributions to this project are welcome!
You can organize my code, add a new functionalities, user interface improvments,testing, error handling, add Combine, add the back-end. 

Feel free to customize, extend, or modify these components and view controllers according to your project requirements. If you have specific questions about any part of the code or need further assistance, please let us know!

## Author
git: sembaynaz

mail: nazerke.sembay11@gmail.com 

telegram: @sembaynaz
