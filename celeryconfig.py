import os

rabbitmq_host = os.getenv("RABBITMQ_HOST", "localhost")

# Broker hostname should be set to the IP address of the host machine if working in docker locally
# broker_url = 'amqps://myuser:mypassword@192.168.12.21:5671'

# Note: what's the diff between amqps and pyamqp?
broker_url = f'amqps://guest@{rabbitmq_host}//'

task_serializer='json'
accept_content=['json']
result_serializer='json'
timezone='Europe/Oslo'
enable_utc=True

# worker_enable_remote_control=False

# task_routes = {
#     'jstor_aspace_publisher.tasks.publish':
#         {'queue': os.getenv("QUEUE_NAME", "jstorforum_publisher")}
# }


