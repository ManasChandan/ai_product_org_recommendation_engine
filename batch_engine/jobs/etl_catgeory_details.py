import os
from utils import *

category_csv_file_path = os.path.join(
    "datasets", 
    "departments.csv"
)

spark = get_spark_session()

df = read_csv_to_df(spark, category_csv_file_path)

df = df.withColumnRenamed(
    "department_id", "category_id"
).withColumnRenamed(
    "depatment", "name"
)

jdbc_url = "jdbc:postgresql://postgres_host:5432/reco_db"
table_name = "category_details"

user = "reco_user"
password = "reco_pass"

# Build connection properties
conn_props = get_jdbc_properties(user, password)

# Write to Postgres table (overwrite mode)
write_df_to_postgres(df, jdbc_url, table_name, conn_props)