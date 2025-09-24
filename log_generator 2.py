import random
import randomtimestamp
import datetime

def random_log_time():
    return randomtimestamp.random_time()

def random_log_type():
    return random.choice(['INFO', 'DEBUG', 'ERROR'])

def random_app_log():
    return random.choice(['BackendApp', 'FrontendApp', 'API', 'SYSTEM'])

def random_ms():
    return random.randrange(10, 30)

def random_success_log_message_running(app):
    return '{} has started running... \n'.format(app)

def random_success_log_message_ms(app, ms):
    return '{} has ran successfully in {}ms'.format(app, ms)

def random_fail_log_message():
    return '{} has failed after {}ms. Retrying... '.format(random_app_log(), random_ms())

def random_debug_log_message():
    return '{} is still running, please wait... '.format(random_app_log())

logs=[]
for x in range(10000):
    log_type = random_log_type()
    if (log_type == 'ERROR'):
        logs.append("{} - [{}] - {}\n".format(random_log_time(), log_type, random_fail_log_message()))
    elif (log_type == 'DEBUG'):
        logs.append("{} - [{}] - {}\n".format(random_log_time(), log_type, random_debug_log_message()))
    else: 
        log_time = random_log_time()
        app = random_app_log()
        logs.append("{} - [{}] - {}".format(log_time, log_type, random_success_log_message_running(app)))
        logs.append("{} - [{}] - {}\n".format(log_time, log_type, random_success_log_message_ms(app, random_ms())))
      
def parse_timestamp(ts_str):
    return datetime.strptime(ts_str, "%Y-%m-%d %H:%M:%S")

logs.sort(key= lambda x: parse_timestamp(x[0]))

with open('/home/ec2-user/logs.txt', 'a') as f:
    for _, entry in logs :
        f.write(entry+"\n")
