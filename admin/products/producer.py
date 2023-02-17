import pika, json

params = pika.URLParameters('amqps://yxkzlipj:ewKx_gGURTsQdGe_qWUxp1pEEI9Z8Njj@fly.rmq.cloudamqp.com/yxkzlipj')


params.heartbeat = 240

connection = pika.BlockingConnection(params)

channel = connection.channel()

def publish(method, body):
    try:
        properties = pika.BasicProperties(method)
        channel.basic_publish(exchange='', routing_key='main', body=json.dumps(body), properties=properties)
        print("Message published successfully!")
    except (pika.exceptions.AMQPError, pika.exceptions.ChannelWrongStateError) as e:
        print(f"Error publishing message: {e}")
    finally:
        channel.close()
        connection.close()

