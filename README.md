# DBT-Snowflake using Virtual Environment in Mac

# Environment - Macbook, VS Code

Created DBT  folder in Volume D

![image](https://github.com/user-attachments/assets/cb9b3527-3722-471d-b11b-d7c3060866e4)

python3  -m venv venv_dbt  
 . venv_dbt/bin/activate
 cd venv_dbt
 

![image](https://github.com/user-attachments/assets/ef44d58d-7e68-4c85-8c76-ab01d28e1b7c)

After activation virtual environment, go to the folder

pip install dbt-snowflake
pip install dbt-core cryptography
pip install snowflake-connector-python pandas

check dbt version

![image](https://github.com/user-attachments/assets/7fef1797-bd9e-4e36-b943-d19ee1db3489)

Configure dbt for Snowflake
dbt init my_dbt_project
cd my_dbt_project

![image](https://github.com/user-attachments/assets/e11e65b2-1382-4e50-8281-eeeec93c8842)

provide below details in prompt

account (https://<this_value>.snowflakecomputing.com): 
user (dev username): 

![image](https://github.com/user-attachments/assets/8d46e49e-11e7-4d33-b321-59de73f2d903)

Based on my snowflake setup, I provided required details

Above step will create a profile file. To see nano ~/.dbt/profiles.yml

Run Debug  should give below result

![image](https://github.com/user-attachments/assets/663aa5fa-b6d2-4622-94e4-2e62c6a64581)

Connection is successful

If you open VSCODE., you will see many code templates generated automatically

![image](https://github.com/user-attachments/assets/76668624-1619-47c7-b612-7e7529f8eda4)

In this demo, I am trying to load data in incrimental model and in SCD way

Created new table EmployeeSalary in SnowFlake. DB- MagnumDB, Schema- MagnumSchema

![image](https://github.com/user-attachments/assets/94dbd763-9d48-4a74-84d5-dad4d244356f)

Loading initial data in EmployeeSalary table. Inserted 10 records

![image](https://github.com/user-attachments/assets/4e38e9b6-33e6-4bc7-b11c-6598a3124347)



For tesing , Creating an Incremental dbt Model

under models folder , creating  a file called incremental_load.sql.

![image](https://github.com/user-attachments/assets/0775cb98-1708-4eea-b9fd-d90b1b1e5b3d)

2nd sql file is for loading data incrimental way based on last updated date
![image](https://github.com/user-attachments/assets/0506dd51-b62d-4a58-9299-4e879c18375a)

Execute DBT Run from terminal. 

![image](https://github.com/user-attachments/assets/6b3bb432-e7eb-4c69-b648-e3b00c49d065)

check Snowflake DB, you can see 2 tables created

![image](https://github.com/user-attachments/assets/178f174f-9d3d-4f07-be8d-73531cf52b15)

![image](https://github.com/user-attachments/assets/6f2b779a-5383-47ac-ae45-eef343edc935)


Next we will load more data in EmployeeSalary table and see how it is incrimentally loading in the destination table based on date field change

![image](https://github.com/user-attachments/assets/e5174c74-1eee-43bd-8a92-3e9f693fac29)

Now run DBT Run and see how data is loading

![image](https://github.com/user-attachments/assets/8a649605-f4b5-488f-801d-65a9febf53c6)


Now update only one record and see it is loading in incremental table

![image](https://github.com/user-attachments/assets/a59869e1-eba7-4dd5-92f4-49e37078e5c7)

18:28:23  1 of 2 OK created sql incremental model MAGNUMSCHEMA.employeesalary_incrimental  [SUCCESS 1 in 1.87s]
18:28:23  2 of 2 START sql table model MAGNUMSCHEMA.employeesalary_initial ............... [RUN]
18:28:23  2 of 2 OK created sql table model MAGNUMSCHEMA.employeesalary_initial .......... [SUCCESS 1 in 0.51s]
18:28:23  
18:28:23  Finished running 1 incremental model, 1 table model in 0 hours 0 minutes and 3.16 seconds (3.16s).
18:28:23  
18:28:23  Completed successfully
18:28:23  
18:28:23  Done. PASS=2 WARN=0 ERROR=0 SKIP=0 TOTAL=2
(venv_dbt) bijum@MacBook-Pro my_dbt_project % 

you can see only employee_id 1 is updated in incriment table

![image](https://github.com/user-attachments/assets/7c3bf20d-f3b2-4fbc-add3-c545cab479c2)



# SCD 2 type incriment using Snapshot

Added new sql file under snapshots folder

![image](https://github.com/user-attachments/assets/1a6c7fd9-fd8f-4a08-8997-14b04897fee8)


Execute dbt snapshot command from terminal

![image](https://github.com/user-attachments/assets/3c8900a6-ec27-4e96-a6b6-29302fa05af3)

You can see new snapshot table created initially with existing data

![image](https://github.com/user-attachments/assets/ae8bd673-ef60-4bde-bc52-1505b20d05ed)

Important part note down here is the scd columns added in snapshot table

![image](https://github.com/user-attachments/assets/2b55dcca-68f9-437b-a925-a0bd48196f07)


Now I will add more records in employeesalary table, modify couple of records and show how it is incremented in Snapshot table

First  updated salaries of 2 records and updated last_updated field with current time stamp

update employeesalary set salary=6700,last_updated=CURRENT_TIMESTAMP where employee_id=1;

update employeesalary set salary=45700,last_updated=CURRENT_TIMESTAMP where employee_id=2;


Next run dbt snapshot command


Now you can see changes in snapshot table

![image](https://github.com/user-attachments/assets/a5dbb296-d7e3-4b23-aef1-16cf34793d85)


Employeeids 1 and 2 are visible 2 times. I.e its history also maintained here

![image](https://github.com/user-attachments/assets/adc1f618-2512-4fa0-88eb-94d706c9c0e7)

Next I will add  5 more new records to employeesalary table.

INSERT INTO employeesalary (employee_id, employee_name, department, salary, effective_date, last_updated) VALUES
(16, 'Penny Lane', 'Data Science', 98000.00, '2024-01-05', CURRENT_TIMESTAMP()),
(17, 'Ringo Starr', 'Product', 88000.50, '2024-01-15', CURRENT_TIMESTAMP()),
(18, 'Stuart Sutcliffe', 'DevOps', 73000.75, '2024-01-25', CURRENT_TIMESTAMP()),
(19, 'Ursula Andress', 'Security', 105000.00, '2024-02-05', CURRENT_TIMESTAMP()),
(20, 'Victor Mature', 'QA', 79000.25, '2024-02-15', CURRENT_TIMESTAMP());


Added to table

Running Dbt Snapshot from terminal


![image](https://github.com/user-attachments/assets/247707ff-e645-401f-8a6d-38ee84247fb7)


All 5 records are added in snapshot table


# Conclusion- 

DBT offers several significant advantages when implementing incremental loading and SCD (Slowly Changing Dimension) type loading, streamlining and enhancing the data transformation process.

 













