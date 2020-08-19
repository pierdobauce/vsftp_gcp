#vim: set ft=dockerfile:
FROM alpine:3.7

RUN apk add --no-cache vsftpd

RUN adduser -h /home/./files -s /bin/false -D files

RUN echo "local_enable=YES" >> /etc/vsftpd/vsftpd.conf \
  && echo "chroot_local_user=YES" >> /etc/vsftpd/vsftpd.conf \
  && echo "allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf \
  && echo "write_enable=YES" >> /etc/vsftpd/vsftpd.conf \
  && echo "local_umask=022" >> /etc/vsftpd/vsftpd.conf \
  && echo "passwd_chroot_enable=yes" >> /etc/vsftpd/vsftpd.conf \
  && echo 'seccomp_sandbox=NO' >> /etc/vsftpd/vsftpd.conf \
  && echo 'log_ftp_protocol=NO' >> /etc/vsftpd/vsftpd.conf \
  && echo 'port_enable=Yes' >> /etc/vsftpd/vsftpd.conf \
  && echo 'port_promiscuous=Yes' >> /etc/vsftpd/vsftpd.conf \
  && echo 'ftp_data_port=31200' >> /etc/vsftpd/vsftpd.conf \
  && echo 'pasv_enable=Yes' >> /etc/vsftpd/vsftpd.conf \
  && echo 'pasv_max_port=31101' >> /etc/vsftpd/vsftpd.conf \
  && echo 'pasv_min_port=31100' >> /etc/vsftpd/vsftpd.conf \
#  && echo 'pasv_address=192.168.1.104' >> /etc/vsftpd/vsftpd.conf \
  && sed -i "s/anonymous_enable=YES/anonymous_enable=NO/" /etc/vsftpd/vsftpd.conf
  && sed -i "s/connect_from_port_20=YES/connect_from_port_20=NO/" /etc/vsftpd/vsftpd.conf

ADD docker-entrypoint.sh /
VOLUME /home/files

EXPOSE 21 30100 30101 31200

CMD /docker-entrypoint.sh
