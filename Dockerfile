FROM python:3.11-slim-buster

COPY requirements.txt /tmp/

RUN apt-get update && apt-get install -y libpq-dev gcc python-dev curl openssh-client && \
  pip install --upgrade pip && \
  pip install --upgrade --force-reinstall -r /tmp/requirements.txt -i https://pypi.org/simple/ --extra-index-url https://test.pypi.org/simple/

RUN useradd --create-home kodakadm
WORKDIR /home/kodakadm
RUN mkdir /home/kodakadm/.ssh && \
    chmod 700 /home/kodakadm/.ssh
COPY --chown=kodakadm ./ .

# Update permissions for the kodakadm user and group
COPY change_id.sh /root/change_id.sh
RUN chmod 755 /root/change_id.sh && \
  /root/change_id.sh -u 55030 -g 1636 && \
  chown kodakadm:kodakadm /home/kodakadm/.ssh

USER kodakadm

# CMD celery -A tasks.tasks worker -E --loglevel=info --queues $QUEUE_NAME
CMD ["celery", "-A", "tasks", "worker", "--loglevel=info"]

