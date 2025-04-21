import json
import base64
import boto3
from datetime import datetime
import os

s3 = boto3.client('s3')
BUCKET_NAME = os.environ['Bucket_name']

def lambda_handler(event, context):
    for record in event.get('Records', []):
        try:
            payload_stage1 = base64.b64decode(record['kinesis']['data']).decode('utf-8')
            print("Decoded payload:", payload_stage1)

            data = json.loads(payload_stage1)

            device_id = data.get('device_id', 'unknown')

            timestamp = datetime.utcnow().strftime("%Y-%m-%dT%H-%M-%S")
            key = f"processed/{timestamp}-{device_id}.json"

            s3.put_object(
                Bucket=BUCKET_NAME,
                Key=key,
                Body=json.dumps(data)
            )

            print(f"Uploaded to S3: {key}")

        except Exception as e:
            print(f"Error processing record: {e}")
            continue

    return {'statusCode': 200}