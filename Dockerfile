FROM rocker/r-ver:4.3.1

ENV S6_VERSION=v2.1.0.2
ENV SHINY_SERVER_VERSION=latest
ENV PANDOC_VERSION=default

COPY install_dependencies.sh install_node.sh /rocker_scripts/
RUN chmod 777 /rocker_scripts/install_node.sh
RUN chmod 777 /rocker_scripts/install_dependencies.sh

RUN /rocker_scripts/install_dependencies.sh

COPY install_shiny_server.sh /rocker_scripts/
RUN chmod 777 /rocker_scripts/install_shiny_server.sh
RUN /rocker_scripts/install_shiny_server.sh

EXPOSE 3838

CMD ["/usr/bin/shiny-server"]