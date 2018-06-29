ARG mysql_tag
FROM mysql:$mysql_tag
RUN apt-get update && apt-get install -y supervisor openssh-server
COPY resources/sshd_config /etc/ssh/sshd_config
RUN chmod 644 /etc/ssh/sshd_config && echo "root:xebialabs" | chpasswd
RUN mkdir -p /var/log/supervisor /var/run/sshd
COPY resources/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV MYSQL_ROOT_PASSWORD secret

CMD ["/usr/bin/supervisord"]
EXPOSE 22