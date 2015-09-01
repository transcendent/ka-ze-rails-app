<B>Introduction</B>

This application is a demonstration to show how Heroku, Salesforce.com and an IOS application can work together to create a compelling customer experience.  It is provided for the study and enjoyment of users. Please note that this is not designed or intended to be a production application.

The application is designed to show how the Salesforce account and case objects can be replicated across multiple applications using APIs exposed by Heroku and Salesforce. The application federates identity in the Heroku application to the Salesforce account object, and allows Heroku users to create ‘incidents’ (Salesforce cases) to report damage to public property. This can be processed and reported on in Salesforce, and is also viewable in the IOS application.

This application has been built using a number of great open source tools, including Rails, RestForce, Devise and others (please see the Gemfile for a complete list of resources). Please see those projects for further details.

This project also links to the Mapbox (https://www.mapbox.com/) mapping tools as part of its user interface.  Please see the Mapbox website for further information.

The portions of this application that have been created by us are covered by the GNU General Public License version 2. Please see the license file in the root directory of this repo for more details.

We hope that you have as much fun in studying this application as we did creating it !

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

<B>Setup Instructions</B>

<i>Salesforce</i>

Enable Person Accounts in your Salesforce org. Please see Salesforce’s documentation for more details on this.

Deploy the following unmanaged package: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t1a000000EYo4

Create an user with at least create access on the Account object and create and update rights on the Case object.  Note the username, password and API token for this user as these will be required as part of setting up the Heroku application.

Create a new connected application with full oAuth rights. Note that the client ID and secret are needed for the Heroku application setup.

Update the Remote Site for the 'IncidentManager' record with the URL settings for the Heroku application.

Update the Heroku Account Details custom settings with the URL for the Heroku application, and username and password for the Heroku integration user.

<i>Mapbox</i>

Sign up for a Mapbox account and obtain an access key. This will be required for setting up the Heroku application.

<i>Heroku</i>

Git clone this Github repo.

Run the unit tests (rake) to confirm that the application is correctly deployed. 

Note that a asset precompile (rake assets:precompile) will be required if assets are changed prior to deploying to Heroku.

The following environment variables need to be set, both locally and within the Heroku settings:

|Key|Value|
|---|------|
|MAPBOX_ACCESS_TOKEN|	The Mapbox key associated with the Mapbox account.|
|SALESFORCE_USERNAME|	The username of the Salesforce user that will be used for API calls.|
|SALESFORCE_PASSWORD|	The password of the above user.|
|SALESFORCE_SECURITY_TOKEN|	The security token associated with the user.|
|SALESFORCE_CLIENT_ID|	The Client ID of the connected application that was created in the Salesforce setup.|
|SALESFORCE_CLIENT_SECRET|	The client secret of the connected application.|

<B>Troubleshooting</B>

The Salesforce.com application logs errors into the Incident Manager Call Log object. View its tab to confirm that the integration between Salesforce and the Heroku application is functioning correctly. 

Note that Postgres is required for running the application locally. 
