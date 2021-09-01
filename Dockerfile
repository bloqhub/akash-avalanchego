FROM debian
ARG password
RUN apt update && apt install -y openssh-server bash supervisor ca-certificates curl \
  && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
  && apt clean
RUN sed -ie 's/#Port 22/Port 2242/g' /etc/ssh/sshd_config
RUN /usr/bin/ssh-keygen -A
RUN ssh-keygen -t rsa -b 4096 -f  /etc/ssh/ssh_host_key
RUN mkdir /run/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN curl -sSL https://github.com/ava-labs/avalanchego/releases/download/v1.5.2/avalanchego-linux-amd64-v1.5.2.tar.gz | tar -xzf - && \
mv ./avalanchego-v1.5.2 /avalanchego
EXPOSE 9650 9651
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
