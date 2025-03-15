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

