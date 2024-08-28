FROM sonarqube:8.9-community
COPY sonar-custom-plugin-1.0.jar /opt/sonarqube/extensions/


FROM nginx:alpine


COPY index.html /usr/share/nginx/html/index.html


