# Logs6
 Mikrotik LOG IPv6

# Build
```
docker build -t log6:latest .
```

# Run
```
docker run -itd \
  --privileged \
  --name logs6 \
  --hostname logs6 \
  -p 8010:80 \
  --restart=always \
  -v logs6_data:/data \
  -l traefik.frontend.rule=Host:logs6.brasil-ip.net \
  -l traefik.port=80 \ 
  --network web \
  log6:latest
  ```
  
  # Informações
  Após container em execução acessar o BASH para iniciar os serviços editar os arquivos de configurações e o banco de dados.
  
  ```
  docker exec -it logs6 /bin/bash
  ```
  Serviços a serem iniciados:
  ```
  /etc/init.d/apache2 start
  /etc/init.d/mysql start
  ```
  Editar arquivo .htaccess colocando os IP's que podem acessar a pagina.
  ```
  cd /var/www/html/logs6
  nano .htaccess
  ```
  Criar Banco de Dados
  ```
  mariadb -p
  ```
  ```
  CREATE DATABASE logs6;
  GRANT ALL PRIVILEGES ON logs6.* TO 'logs6'@'localhost' IDENTIFIED BY 'SUA_SENHA_DA_CONEXAO';
  FLUSH PRIVILEGES;
  quit;
  ```
  Importa tabelas utilizando senha criada anteriormente:
  ```
  mariadb -u logs6 logs6 < logs6_mikrotik.sql -p
  ```
  Alterar as linhas no arquivo config.php:
  $token = 'senha_de_acesso';
  ```
  cd /var/www/html/logs6
  nano config.php
  ```
  
