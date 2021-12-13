NBA Stat APP
Goals
The NBA stat app can help you stay up to date on everything NBA. it can bring you everything that you need to be the most in-the-know basketball fan possible.

Built by NBA fans, for NBA fans, combining up-to-the-second live scores and stats from the NBA with the most in-depth statistical database.

Implementation Part
Networking
The App incorporate data from a networked source: Use API https://rapidapi.com/api-sports/api/api-nba/ and integrate downloaded data into the app Give users feedback around network activity, displaying activity indicators and/or progress bars when appropriate, and an alert in case of connection failures Encapsulate networking code in a class to reduce detail in View Controllers

Persistant
The App incorporate data that needs to be persisted between runs of the app. User can follow the team they interested, and some of the value will be saved locally.

Visual Part
It include the following common UI features:

More than one view controller
A table or collection view
Navigation and modal presentation
Image assets in 1x, 2x, and 3x formats.
Logo
Autolayout
Requirement Part
The Login Flow
It will send only the username and password If the username and password is valid the server will respond with the user's favorite team. If the username is invalid, respond with a login form that contains a message about the username being invalid

The Logout Flow
Logout does NOT clear the favorite team information from the local After the logout process the server will respond with a redirect to the Home Page

All Teams
In the home viewcontroller add a table view which would populate the list of teams that match your search. Use API https://api-nba-v1.p.rapidapi.com/teams/league/standard to acquire all team.

Team Players
When the app starts up the first table view controller will read teams and then get the team information and team player information. Use API https://api-nba-v1.p.rapidapi.com/players/teamId/%7Bteamid%7D to acquire target team's player information and use API https://api-nba-v1.p.rapidapi.com/teams/teamId/null to acquire logo and other information

My favorite team
User can follow the team they interested, and some of the information will be stored locally to prevent too much network communication.
