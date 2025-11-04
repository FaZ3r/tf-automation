import random
import randomtimestamp
from datetime import datetime

def random_log_datetime():
    """Generate a random datetime within the range."""
    return randomtimestamp.random_date(start=datetime(2025, 1, 1), end=datetime.now())

def aws_log_timestamp(dt=None):
    """Return AWS-style timestamp string."""
    if dt is None:
        dt = datetime.utcnow()
    return dt.strftime("%Y-%m-%dT%H:%M:%S.%f")[:-3] + "Z"  

def random_log_type():
    return random.choice(['INFO', 'DEBUG', 'ERROR'])

def random_app_log():
    return random.choice(['BackendApp', 'FrontendApp', 'API', 'SYSTEM'])

def random_ms():
    return random.randrange(10, 30)

def random_success_log_message_running(app):
    return f"{app} has started running..."

def random_success_log_message_ms(app, ms):
    return f"{app} has ran successfully in {ms}ms"

def random_fail_log_message():
    return f"{random_app_log()} has failed after {random_ms()}ms. Retrying..."

def random_debug_log_message():
    return f"{random_app_log()} is still running, please wait..."


logs = []
for _ in range(10):
    log_type = random_log_type()
    log_dt = random_log_datetime()
    log_ts = aws_log_timestamp(log_dt)

    if log_type == 'ERROR':
        logs.append(f"{log_ts} - [{log_type}] - {random_fail_log_message()}")
    elif log_type == 'DEBUG':
        logs.append(f"{log_ts} - [{log_type}] - {random_debug_log_message()}")
    else:
        app = random_app_log()
        logs.append(f"{log_ts} - [{log_type}] - {random_success_log_message_running(app)}")
        logs.append(f"{log_ts} - [{log_type}] - {random_success_log_message_ms(app, random_ms())}")


logs.sort()

with open('/home/ec2-user/logs.txt', 'a') as f:
    for entry in logs:
        f.write(entry + "\n")
