FROM rabbitmq:3-management
ADD poststart.sh /
RUN chmod +x /poststart.sh

