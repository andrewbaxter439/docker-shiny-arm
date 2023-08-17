FROM rocker/r-ver:4.3.1

ENV S6_VERSION=v2.1.0.2
ENV SHINY_SERVER_VERSION=latest
ENV PANDOC_VERSION=default

COPY install_shiny_server.sh /rocker_scripts/install_shiny_server.sh
RUN /rocker_scripts/install_tidyverse.sh
RUN /rocker_scripts/install_shiny_server.sh

EXPOSE 3838

CMD ["/init"]
