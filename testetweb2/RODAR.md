# Como rodar o projeto (Windows)

## Pré-requisitos
- Docker Desktop instalado e iniciado
- Porta `8050` livre no host

## Execução com Docker
- No diretório do projeto, executar:
  - `docker compose up -d --build`
- Acessar no navegador:
  - `http://localhost:8080/` (Página inicial)
  - `http://localhost:8080/acoes` (Listagem dinâmica)

## Serviços
- `web` (Tomcat 9 + JDK 17): publica o WAR em `ROOT.war`
- Volume `sqlite-data` mapeado em `/data` para persistência do SQLite

## Configuração de Banco (JPA)
- Arquivo: `src/main/resources/META-INF/persistence.xml`
- Driver: `org.sqlite.JDBC`
- URL: `jdbc:sqlite:/data/extensao.db`
- Dialeto: `org.hibernate.community.dialect.SQLiteDialect`
- `hibernate.hbm2ddl.auto=update` para criar/atualizar tabelas em desenvolvimento

## Navegação
- Home: `index.jsp` com links para
  - `Ver Ações` → `/acoes`
  - `Cadastrar Ação` → `/jsp/cadastro.jsp`
- Listagem: `/acoes` com busca por `termo` e filtro `status`
- Detalhes: `/acoes?id=<id>`
- Cadastro: formulário completo em `jsp/cadastro.jsp`

## Build local (opcional)
- Sem necessidade de Maven/Java na máquina host; o build é feito dentro do Docker
- Se desejar usar Maven localmente: requer `mvn` e Java 17
- Comandos:
  - `mvn clean package`
  - Gerará `target/app.war`
  - Implantar no Tomcat local (copiar WAR para `webapps/`)

## Troubleshooting
- Erro de conexão no Docker: iniciar o Docker Desktop e aguardar o daemon subir
- Porta ocupada: alterar mapeamento em `docker-compose.yml`
- Sem Maven local: usar apenas Docker para build/run
- Logs:
  - `docker compose logs -f web`

## Estrutura principal
- `pom.xml` — dependências e empacotamento WAR
- `src/main/java/ufrrj/model/AcaoExtensao.java` — entidade JPA
- `src/main/java/ufrrj/dao/AcaoDAO.java` — persistência e filtros
- `src/main/java/ufrrj/controller/AcaoExtensaoServlet.java` — listagem, detalhes, cadastro
- `src/main/webapp/jsp/*` — JSPs (listagem, detalhes, cadastro)
- `src/main/resources/META-INF/persistence.xml` — JPA/hibernate
- `Dockerfile` e `docker-compose.yml` — deploy com Tomcat + SQLite
