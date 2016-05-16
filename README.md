# FunctionalProgramming

How to run my program - 1. cd into the directory where the haskell files is located.
                        2. run $ stack runghc calculator.hs
                      
I designed a simple RESTful API that used the yesod framework to parse  routes trough my aplication and return HTML results depending on the user input. I decided to use yesod as it provided a ver simple way of doing exxactky what I needed. I desigened my API to have 4 GET routes; add, subtract,multiply and devide. All four routes take 2 integers and perform calculations on those integers depending on which route is taken through the program. I returned the results wrapped in whamlet which is a widget that provides HTML code.
Here is the design of my API

GET - /add/#Integer/#Integer - this adds the two integers and returns html of the equation and resutlt
GET - /subtract/#Integer/#Integer - this subtracts the first int from the second and then returns html
GET - /multiply/#Integer/#Integer - this multiplied the ints and returns the html
GET - /Devide/#Integer/#Integer - this devided the first int by the second and returned html

I was planning on also implimenting the following
PUT - /createuser/#String/#String which would create a user on a local SQLite database with the first string being the username and the second the password
GET - /user/#String/#String again the first string would be the user and the second the password but this time it would get the history of the users calculations and wold aauthorise the user so that all future calculations in the session were stored.

I had trouble implimenting the SQL for these parts so could not comlpete them in time. I managed to create the database and the first table "Users" that would store the sername and password. 
