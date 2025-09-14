"""
All Utils
"""

from pyspark.sql import SparkSession

def get_spark_session(app_name="ETLApp"):
    """
    Create and return a SparkSession
    """
    return SparkSession.builder.appName(app_name).getOrCreate()

def get_jdbc_properties(user, password, driver="org.postgresql.Driver"):
    """
    Prepare JDBC connection properties dictionary
    """
    return {
        "user": user,
        "password": password,
        "driver": driver
    }

def read_csv_to_df(spark, csv_path, header=True):
    """
    Read CSV file to Spark DataFrame
    """
    return spark.read.option("header", str(header).lower()).csv(csv_path)

def write_df_to_postgres(df, jdbc_url, table_name, connection_props, mode="overwrite"):
    """
    Write DataFrame to PostgreSQL table with given write mode (default overwrite)
    """
    df.write.jdbc(url=jdbc_url, table=table_name, mode=mode, properties=connection_props)

