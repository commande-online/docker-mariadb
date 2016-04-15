FROM mariadb:10.1

MAINTAINER Commande-Online.fr SAS

COPY ./init /docker-entrypoint-initdb.d
COPY ./conf /conf-DB

ENTRYPOINT ["/docker-entrypoint.sh"]

ENV MYSQL_DATABASE col2-prod
ENV MYSQL_ROOT_PASSWORD A6yc4X9KMUtngEj9
ENV DATADIR /data/db

EXPOSE 3306
CMD ["mysqld"]