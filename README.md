Web Data Management and XML - Project Phase 2
=============================================
Shweta Satish Pathak
=============================================
1001154572 shweta.pathak@mavs.uta.edu
-------------------------------------
 
### QUESTIONS:
 
###a.What SQL framework did you choose and why?  
I have chosen SQLite3 as the SQL framework. Ruby on Rails has SQLite3 as its inbuilt database which saves time in installing and configuring other databases.SQLite does not require a separate server process or system to operate.
 
###b.What NOSQL framework did you choose and why?
I have chosen MongoDb as the NOSQL framework because of its ability to store the data in the form of documents and its simple syntaxes to query the documents.
 
###c.What server framework did you choose and why? 
Ruby on Rails has been my choice as a server framework.This is because of below points:
Ruby on Rails uses the MVC framework.It saves a lot of time in configuring files to get the setup done.Most importantly it is an open source framework.Rails also emphasizes on RESTful application design.Above all Ruby on Rails have provided a good learning curve.

###d. What aspect of the implementation did you find easy, if any, and why?  
Querying the SQL and NOSQL databases was easy because of the simple methods like find() in case of MongoDb database.
 
###e.What aspect of the implementation did you find hard, if any, and why?  
Binding of the rake tasks to include the NOSQL and SQL database queries was bit tough.

###f.What components OTHER than your SQL, NOSQL, and server framework did  you install, if any, and if so, what is their purpose for your solution?  
No additional components are required to be installed for the current requirement.

###g.What Ubuntu commands are required to deploy and run your server?   
The below steps are required to deploy the code:
 1. unzip ssp4572-project-phase2.zip
 2. cd ssp4572-project-phase2
 3. bundle install
 4. rake my_namespace:my_task1 (For SQL queries) 
 5. rake my_namespace:my_task2 (For NOSQL queries)