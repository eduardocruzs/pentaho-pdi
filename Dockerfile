FROM openjdk:8u252-jre

#Instalando libwebkitgtk-1.0-0
RUN echo 'deb http://cz.archive.ubuntu.com/ubuntu bionic main universe' >> /etc/apt/sources.list \
&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3B4FE6ACC0B21F32 \
&& apt-get update \
&& apt-get --assume-yes install libwebkitgtk-1.0-0 \
&& apt-get install zip netcat -y; \
apt-get install wget unzip git vim -y; \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Init ENV
ENV PENTAHO_HOME /opt/pentaho

# Apply JAVA_HOME
RUN . /etc/environment
ENV JAVA_HOME /usr/local/openjdk-8/
ENV PENTAHO_JAVA_HOME /usr/local/openjdk-8/

# Criando diretorio
RUN mkdir ${PENTAHO_HOME} /input/ /output/; useradd -s /bin/bash -d ${PENTAHO_HOME} pentaho; chown pentaho:pentaho ${PENTAHO_HOME} /input/ /output/

# Download Pentaho
RUN wget --progress=dot:giga https://sourceforge.net/projects/pentaho/files/Pentaho%209.1/client-tools/pdi-ce-9.1.0.0-324.zip/download -O /tmp/pentaho-pdi.zip

RUN /usr/bin/unzip -q /tmp/pentaho-pdi.zip -d  $PENTAHO_HOME; \
    rm -f /tmp/pentaho-pdi.zip

# Volume para acessar arquivos a serem executados e gerar logs
VOLUME /input/ /output

RUN echo 'alias k="/opt/pentaho/data-integration/kitchen.sh"\nalias p="/opt/pentaho/data-integration/pan.sh"\nalias c="/opt/pentaho/data-integration/carte.sh"' >> /etc/bash.bashrc

WORKDIR ${PENTAHO_HOME}/data-integration/ 

# Ajustando permissões 
RUN chown -R pentaho:pentaho $PENTAHO_HOME/data-integration/; \
    chmod +x kitchen.sh spoon.sh pan.sh carte.sh

USER pentaho

# Pode ser utilizado como ENTRYPOINT os executaveis específicos para que na execução sejam passados apenas os parametros. 
# Deixei padrão o bash, pois pode chamar o kitchen, pan ou outro caso seja necessário. 
#ENTRYPOINT ["/opt/pentaho/data-integration/kitchen.sh"]
#ENTRYPOINT ["/opt/pentaho/data-integration/pan.sh"]
ENTRYPOINT ["/bin/bash"]
