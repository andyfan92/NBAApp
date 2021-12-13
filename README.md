# NBA Stat APP

## Goals
The NBA stat app can help you stay up to date on everything NBA. it can bring you everything that you need to be the most in-the-know basketball fan possible.
It combines real time live scores and stats from the NBA with the most in-depth statistical database.


## Implementation Part

### Networking

https://rapidapi.com/api-sports/api/api-nba/


The App incorporate data from a networked source:
Use Restful API to request data and integrate downloaded data into the app.

It gives users feedback around network activity, displaying activity indicators when appropriate, and an alert in case of connection failures


### Persistant

The App incorporate data that needs to be persisted between runs of the app.
User can follow the team they interested, the favorite team will be stored locally.When the app start up the App read the user's favorite team from local database.



### MVC
The App adopt MVC architecture. which separate the user interface from business logic and business logic and ensure components are reusable.

## Visual Part

It include the following common UI features:

* There are 7 view controllers and use the segues to define transition between two view controllers.
* The table view controller can show the team's detail, player and recent game information
* Use navigation controller to manages one or more child view controllers in a navigation interface. 
* The image asset and logo have different format
* The autolayout make the APP does not go out of bounds on small screens. 


## Requirement Part

### The Login Flow

Use Firebase Authentication's backend services to authenticate users to your app.  
It will send the username and password to the Firebase backend server.
If the username and password is valid. It will present the main menu view controller.
If the username is invalid, it will shows a message about the username or password is invalid.

### The Logout Flow
Click the logout button in navigation bar, the App will log out and jump to the log in View controller
Logout does NOT clear the favorite team information from the local database


### The main menu
In the main menu. there is two button. My favorite team and All team. The All team view controller would populate all NBA team. The user can follow their interested 
team by clicking the table cell and this part of information will be persisted locally. For the favorite team view controller the user can swipe the table cell to delete it and click it to jump to team detail view controller. When the app start up the App read the user's favorite team from local database.


### The detail page
The detail page will show the team's basic information and team's logo. when the user click the player button, it will make a network call to get all the team information of that team. when the user click the game button, it will get the recent game informtion of that team and show in the view controller. the game is sorted in reversed chronology order. So the top game is the recent game.






