import pika, json

params = pika.URLParameters('amqps://yxkzlipj:ewKx_gGURTsQdGe_qWUxp1pEEI9Z8Njj@fly.rmq.cloudamqp.com/yxkzlipj')

connection = pika.BlockingConnection(params)

channel = connection.channel()


def publish(method, body):
    properties = pika.BasicProperties(method)
    channel.basic_publish(exchange='', routing_key='main', body=json.dumps(body), properties=properties)
