FROM rocker/shiny-verse:4.3.0
LABEL maintainer="USER <david.martinez@macer.tech>"

# Instala tinytex para renderizar documentos en PDF
RUN apt-get update --yes && \
    apt-get upgrade --yes
RUN apt-get install --yes texlive-latex-extra
# RUN R -e "install.packages('tinytex', dependencies = TRUE)"
# RUN R -e "tinytex::install_tinytex()"
# Difine /app/ como el directorio de trabajo dentro del contenedor
WORKDIR /srv/shiny-server/app/
# Copia los archivos dentro de la imagen
COPY /app/* .
# copy the app directory into the image
# run app
CMD ["/usr/bin/shiny-server"]
