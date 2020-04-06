# Assesment_Notes

|Login|Signup|Folder|Notes List| Notes |
|-|-|-|-|-|
| ![login](https://github.com/adavalli123/Assesment_Notes/blob/master/Images/login.png) | ![signup](https://github.com/adavalli123/Assesment_Notes/blob/master/Images/signup.png) | ![folder](https://github.com/adavalli123/Assesment_Notes/blob/master/Images/folder.png) | ![notesList](https://github.com/adavalli123/Assesment_Notes/blob/master/Images/notes%20list.png) | ![add Notes](https://github.com/adavalli123/Assesment_Notes/blob/master/Images/addnotes.png) |

# Video Demos
| most uses cases tested | Folder level deletion |
| - | - |
| ![login](https://github.com/adavalli123/Assesment_Notes/blob/master/Video/video%20recording%20one%20for%20logged%20in%20saved.mov) | ![Folder level testing](https://github.com/adavalli123/Assesment_Notes/blob/master/Video/folder%20level%20testing.mov)|

# Platforms used
- Dependency Manager - Cocoapods
- Backend/Database - Firebase
- Programmaing Language - Swift
- IDE - Xcode
- UI - Developed programmatically/ Storyboard
- Design pattern - MVVM

### Tasks Completed
Application minimum requirements 
• User registration: users must be able to register an account from the application using a username/password. 
##### Completed - Handled only happy path scenarios. Once user registered an account, he will be pointed to folder screen. After time he lauch the app, app will navigate to Folder screen until or unless user opt to logout.

• Login/Logout: users must be able to login into the application using the credentials defined on registration process. 
##### Completed - Handled only happy path scenarios. Once user is logged in, he will be pointed to folder screen. After time he lauch the app, app will navigate to Folder screen until or unless user opt to logout.

• Notes list: after login, the application must have a list with all user notes.
##### Completed - Handled only happy path scenarios

• Note creation/deletion: users must be able to create or delete a text note. 
##### Completed - Handled only happy path scenarios, besides that added updating the notes

• If developing a mobile application, it must run on a device running iOS or Android. 
##### Completed - Handled only happy path scenarios, on iOS
 

### Additional features Extra points for any cool additional feature implemented on the application: 
• Support for images (user avatars, notes with images, etc.).
##### Have a good overview how the task should be done. Firebase has Storeage cloud. When we upload image from application, then we need to store in Storage cloud and we will come back to that screen we need to do a get call. I looked into it.
• Shared notes (multiple users support). 
##### Completed - tested in simulator
• Social platform login (Facebook, Twitter, etc.). 
##### Haven't got a chance to look
• Location based notes. 
##### Haven't got a chance to look
• Server API deployed on a cloud provider (AWS, Azure, Google Cloud Engine, etc.). 
##### N/A
• Mobile application only 
##### Completed -
o Push notifications support; o Offline experience - persist notes when app does not have internet 
connection. 
##### Completed - persist notes on simulator


