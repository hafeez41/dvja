import os
import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    instance_id = os.environ['INSTANCE_ID']
    response = ec2.stop_instances(InstanceIds=[instance_id])
    print('Stopping instance:', response)
