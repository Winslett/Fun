# Sinatra-MongoMapper Bootstrap

To Get started

1. Clone this source to you local machine
2. Start Mongo in this directory 
  
    ``mongod --dbpath=data/``

3. Load Sample Data into Mongo 

    ``mongoimport -d sinatra-mongo-db -c users seed/users.json``

4. Install Gems

    ``bundle install``

5. Start Application

    ``rackup``

## Debugging

This is a sample application.  It can be deployed to Heroku with by
making changes to your heroku config, via:

    heroku config

MongoHQ does not support this application.  Please read the MongoMapper
and Sinatra documentation.  As programmers, you get nothing from someone
telling you everything -- we would hate to rob you of an opportunity to
debug a problem.

## Settings

We try to put all settings as environmental variables in .rvmrc

If you are a Windows user, you will need to set your environment
variables similar to those in .rvmrc

If you are not using .rvmrc, you can still run the following to set your
environmental variables

    source .rvmrc

## Project Structure

The purpose of the project structure is separation of purposes. 

  - data/ houses your local MongoDB data for the project, hence the 
    "dbpath" option with mongod above.
  - initializers/ is a convenient directory for initializing settings
    for different modules of the application
  - models/ contains the Mongoid models
  - seed/ contains some seed data that you would like to use to
    bootstrap your project
  - views/ contains the HAML files that generate your output
