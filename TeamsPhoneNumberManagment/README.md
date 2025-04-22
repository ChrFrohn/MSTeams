# Teams PSTN phone number management.

A project created to manage assigment of PSTN numbers in Microsoft Teams (Direct routing)

## About: 

This project is created with a dream to ease the management of phone numbers provided to an organization by an external provider (Telecommunications company's like T-Mobil or TDC). Phone numbers are often provided in an Excel spreadsheet and System administrator in charge needs to assign the number “by hand” and remember to update the spreadsheet. 

This project aims to ease that pain by having the phone numbers in a database and Power BI report to display insight in to how the numbers are used and then a couple of PowerShell scripts to assign phone numbers and then a PowerShell script to “clean up” the database. 

### PowerShell modules in use (needs to be add in the automation account module section):

- Microsoft Teams
- SQLServer
  
### Installation / Configuration - Quick and dirty:

- Create an Azure SQL server and SQL database [How To](https://www.christianfrohn.dk/2022/04/17/how-to-create-a-azure-sql-server-and-a-database/)
- Create an Azure Automation Account [How to](https://learn.microsoft.com/en-us/azure/automation/quickstarts/create-azure-automation-account-portal#create-automation-account)
- Create a SQL table using the SQL query - [CreateTables.sql](https://github.com/ChrFrohn/MSTeams-PhoneNumberMgmt/blob/main/CreateTables.sql) found in this reposistory
- Import PSTN numbers from your Telecommunications provider into the SQL table - [ImportTemplate.csv](https://github.com/ChrFrohn/MSTeams-PhoneNumberMgmt/blob/main/PhoneNumberImportTemplate.csv) using the PowerShell script [ImportPSTNNumbersToDB.ps1](https://github.com/ChrFrohn/MSTeams-PhoneNumberMgmt/blob/main/ImportPSTNNumbersToDB.ps1) *Note
- Create a Service Principal in Entra and assign SQL write permission - [How To](https://www.christianfrohn.dk/2022/04/17/using-azure-service-principal-to-run-powershell-script-on-azure-sql-server-managed-instance/)
- Create a Runbook in the Automation with the PowerShell script [DB-Maintenance.ps1](https://github.com/ChrFrohn/MSTeams-PhoneNumberMgmt/blob/main/DB-Maintenance.ps1)
- Create a Runbook in the Automation with the PowerShell script [EnableAndAssignPhoneNumber.ps1](https://github.com/ChrFrohn/MSTeams-PhoneNumberMgmt/blob/main/EnableAndAssignPhoneNumber.ps1)

Note: You only need to provide the PSTN numbers from your number serie and the country code, you don't need to add the user that is using the number - It can be done automatily by running the [DB-Maintenance.ps1](https://github.com/ChrFrohn/MSTeams-PhoneNumberMgmt/blob/main/DB-Maintenance.ps1)

### How to:

- Start the runbook with PowerShell script [EnableAndAssignPhoneNumber.ps1](https://github.com/ChrFrohn/MSTeams-PhoneNumberMgmt/blob/main/EnableAndAssignPhoneNumber.ps1) in the automation account and type in the users UPN (Username@christianfrohn.dk)
- Create a schedule that runs the [DB-Maintenance.ps1](https://github.com/ChrFrohn/MSTeams-PhoneNumberMgmt/blob/main/DB-Maintenance.ps1) when you deem it best (Recommend to run at least once a day)

---------------------------------------------------- -------------------------- -------------------------- --------------------------  

### EnableAndAssignPhoneNumber.ps1: 

The PowerShell script will assign the first available phone number (PSTN) it can find in the DB and assign it to the user and then enable the user to use PSTN calling in Teams 

There is a function for reserved numbers. Currently if it only looks at the department attribute. Say a user is in "IT" department then if a number is reserved for "IT" then the user will get the first available that is reserved for IT. otherwise the user will get the first available number.

### DB-Maintenance.ps1: 

This PowerShell script will first look at all users in Teams and add them to the database. After that the script will look up all users in the database in Teams.
This is to ensure that the numberserie is always up to date.
 
### ImportPSTNNumbersToDB.ps1 

This PowerShell script will import the csv file PhoneNumberImportTemplate.csv in to the SQL table that has been created using CreateTables.sql

### Database table struture:

* PSTNnumber int NOT NULL PRIMARY KEY, 
* UsedBy varchar(255)
* ReservedFor varchar(255)
* CountryCode int

### To-do / Bug fixes:

* Update Active Directory OfficePhone attribute with assigned phone number 

