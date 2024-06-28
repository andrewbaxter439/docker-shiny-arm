FROM rocker/r-ver:4.3.3

ENV S6_VERSION=v2.1.0.2
ENV SHINY_SERVER_VERSION=latest
ENV PANDOC_VERSION=default


COPY install_dependencies.sh install_node.sh /rocker_scripts/
RUN chmod 777 /rocker_scripts/install_node.sh
RUN chmod 777 /rocker_scripts/install_dependencies.sh

RUN /rocker_scripts/install_dependencies.sh
RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cloud.r-project.org/', skipinstalled =TRUE)"
# RUN sudo su - -c "R -e \"install.packages(c('shiny', 'rmarkdown'), repos='https://cloud.r-project.org/')\""

COPY install_shiny_server.sh /rocker_scripts/
RUN chmod 777 /rocker_scripts/install_shiny_server.sh
RUN /rocker_scripts/install_shiny_server.sh

COPY samples/ /srv/shiny-server/

EXPOSE 3838

# RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cloud.r-project.org/')"

CMD ["/usr/bin/shiny-server"]
