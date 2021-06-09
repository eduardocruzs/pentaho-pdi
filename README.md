# pentaho-pdi
Repositório para imagens do pentaho-pdi
Imagem para apoiar na execução de Transformações e Jobs, sem a necessidade de ter uma máquina para esta finalidade. Você pode executar a job ou transformação usando um container docker.

Exemplo de execução a partir de um arquivo:

docker run -v /opt/docker/:/input educruzs/pentaho-pdi:8.0 kitchen.sh -file=/input/job_teste.kjb -level=Detailed
Ao executar a imagem, basta chamar kitchen.sh, pan.sh com seus respectivos parâmetros.

Dockerfile disponível no github - https://github.com/eduardocruzs/pentaho-pdi/issues