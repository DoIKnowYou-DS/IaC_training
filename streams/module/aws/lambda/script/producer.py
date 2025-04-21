import json
import boto3
import random
import datetime
import os

stream_name = os.environ['STREAM_NAME']

kinesis = boto3.client('kinesis')

def lambda_handler(event, context):
    payload = {
        "device_id": "sensor-001",
        "timestamp": datetime.datetime.utcnow().isoformat(),
        "temperature": round(random.uniform(20.0, 30.0), 2),
        "humidity": round(random.uniform(30.0, 60.0), 2)
    }

    response = kinesis.put_record(
        StreamName=stream_name,
        Data=json.dumps(payload),
        PartitionKey="partition-1"
    )

    return {
        'statusCode': 200,
        'body': json.dumps('Record sent: ' + json.dumps(payload))
    }