# Job scriptの例（PySpark）
import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

args = getResolvedOptions(sys.argv, [
    'JOB_NAME',
    'output_path',
    'database',
    'table_name'
])

output_path = args['output_path']
database = args['database']
table_name = args['table_name']

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# rawのデータ読み込み
datasource = glueContext.create_dynamic_frame.from_catalog(
    database = database,
    table_name = table_name # 後述の方法で確認
)

# フィルタ処理（本来は何かを書く）
filtered = Filter.apply(datasource, lambda x: x["age"] >= 30)

# Parquetで書き出し
glueContext.write_dynamic_frame.from_options(
    frame = filtered,
    connection_type = "s3",
    connection_options = {"path": output_path},
    format = "parquet"
)

job.commit()