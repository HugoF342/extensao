# 📋 README - Projeto: Sistema de Ações de Extensão UFRRJ

## 📖 Visão Geral do Projeto

Sistema web para gerenciamento e consulta de ações de extensão universitária da UFRRJ, desenvolvido como projeto da disciplina Sistemas Web II.

**Disciplina:** Sistemas Web II  
**Docente:** Prof. Tiago Cruz de França  
**Instituição:** Universidade Federal Rural do Rio de Janeiro - Departamento de Computação

---

## 🎯 Contexto e Problema

As universidades desenvolvem diversas ações de extensão (eventos, cursos, projetos, programas e prestações de serviço) que estabelecem interação entre a instituição e a comunidade. 

**Problema Identificado:**
- Muitas ações de extensão são pouco conhecidas pela comunidade
- Ausência de canal oficial centralizado que apresente todas as ações
- Falta de visibilidade e acesso às oportunidades oferecidas
- Necessidade de transparência e histórico institucional

**Solução Proposta:**
Criar um site institucional para apresentar e organizar as ações de extensão da universidade, com funcionalidades dinâmicas (buscas e filtros reais) e projeto visual de qualidade em HTML e CSS.

---

## 📋 Requisitos do Sistema

### Requisitos Técnicos Obrigatórios

1. **Orientação a Objetos:** Sistema baseado em paradigma OO
2. **ORM:** Integração com banco de dados via Mapeamento Objeto-Relacional
3. **Servlets:** Classes de controle para gerenciar requisições
4. **JSPs:** Interface web de qualidade funcional
5. **HTML/CSS:** Projeto visual de qualidade
6. **Funcionalidades Dinâmicas:** Implementar buscas e filtros reais

### Requisitos Funcionais

O sistema deve permitir acesso a informações essenciais sobre cada ação de extensão:

- **Título** da ação
- **Data de início** e **data de encerramento**
- **Descrição** da ação
- **Responsável** pela ação
- **Local de realização**
- **Contatos para inscrição**
- **Links externos** (quando existentes)
- **Público-alvo**
- **Existência de taxas** (sim/não)
- **Status** da ação (Vigente/Encerrada)

**Importante:** Ações encerradas devem permanecer registradas para fins de transparência e histórico institucional.

---

## 🏗️ Arquitetura do Sistema (MVC)
```
┌─────────────────────────────────────────────────┐
│                   VIEW (JSPs)                   │
│          Interface Web de Qualidade             │
└────────────────────┬────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────┐
│            CONTROLLER (Servlets)                │
│        Classes de Controle e Lógica             │
└────────────────────┬────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────┐
│     MODEL (Classes de Negócio + DAO + ORM)     │
│   Mapeamento para Banco de Dados via ORM       │
└────────────────────┬────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────┐
│              BANCO DE DADOS                     │
└─────────────────────────────────────────────────┘
```

---

## 📦 Componentes a Serem Implementados

### FASE 1: Model e Persistência (Back-End Core)

#### 1.1. Configuração do Ambiente
- Criar projeto Java Web (Maven/Gradle)
- Configurar dependências: Servlet API, ORM (JPA/Hibernate), Driver do BD, JSTL
- Configurar arquivos do ORM (ex: `persistence.xml`)

#### 1.2. Classe de Negócio: `AcaoExtensao.java`
**Localização:** `/src/main/java/ufrrj/model/AcaoExtensao.java`

**Atributos obrigatórios:**
- `id` (Long) - Identificador único
- `titulo` (String) - Título da ação
- `descricao` (String) - Descrição detalhada
- `dataInicio` (LocalDate) - Data de início
- `dataEncerramento` (LocalDate) - Data de encerramento
- `responsavel` (String) - Nome do responsável
- `localRealizacao` (String) - Local da ação
- `publicoAlvo` (String) - Público-alvo
- `temTaxas` (boolean) - Indica se há taxas
- `status` (String) - Status: 'Vigente' ou 'Encerrada'
- `contatoInscricao` (String) - Contatos para inscrição
- `linkExterno` (String) - Links externos

**Requisitos:**
- Mapeamento adequado para banco de dados via anotações JPA/Hibernate
- Implementar como POJO com getters/setters

#### 1.3. Camada de Persistência: `AcaoDAO.java`
**Localização:** `/src/main/java/ufrrj/dao/AcaoDAO.java`

**Métodos obrigatórios:**
- `save(AcaoExtensao acao)` - Salvar/Atualizar ação
- `findById(Long id)` - Buscar ação por ID
- `findAll()` - Listar todas as ações
- `findByFiltros(String termo, String status)` - **Busca dinâmica por termo (título/descrição) e filtro por status**

**Requisitos:**
- Integração com ORM
- Arquivos de configuração adequados

---

### FASE 2: Controller (Servlets)

#### 2.1. Servlet Principal: `AcaoExtensaoServlet.java`
**Localização:** `/src/main/java/ufrrj/controller/AcaoExtensaoServlet.java`

**Método `doGet()` - Exibição e Busca:**

**Rota de Listagem:**
- Capturar parâmetros: `termo` (busca por texto) e `status` (filtro)
- Chamar `AcaoDAO.findByFiltros(termo, status)`
- Armazenar lista no request
- Encaminhar para JSP de listagem

**Rota de Detalhes:**
- Capturar parâmetro `id`
- Chamar `AcaoDAO.findById(id)`
- Encaminhar para JSP de detalhes

**Método `doPost()` - Cadastro/Edição:**
- Capturar parâmetros do formulário
- Criar/atualizar objeto `AcaoExtensao`
- Chamar `AcaoDAO.save(acao)`
- Redirecionar para listagem

---

### FASE 3: View (JSPs e Design)

#### 3.1. Estilos e Layout
**Localização:** `/src/main/webapp/static/css/style.css`

**Requisitos:**
- Projeto visual de qualidade em HTML e CSS
- Layout limpo e focado em usabilidade
- Design responsivo

#### 3.2. JSP de Listagem
**Localização:** `/src/main/webapp/jsp/listagem.jsp`

**Funcionalidades obrigatórias:**
- Formulário de busca por texto (termo)
- Filtro por status (Vigente/Encerrada)
- Listagem dinâmica usando JSTL
- Exibir resumo de cada ação (Título, Status, Responsável, Datas)
- Links para página de detalhes

**Requisitos:**
- Qualidade funcional
- Uso de JSTL para dinamismo

#### 3.3. JSP de Detalhes
**Localização:** `/src/main/webapp/jsp/detalhes.jsp`

**Funcionalidades obrigatórias:**
- Exibir todos os atributos da ação
- Descrição completa
- Local, público-alvo, contato
- Link externo (quando existir)
- Status da ação

**Requisitos:**
- Qualidade funcional
- Apresentação clara e organizada

#### 3.4. JSP de Cadastro (Área Administrativa)
**Localização:** `/src/main/webapp/jsp/cadastro.jsp`

**Funcionalidades:**
- Formulário completo para cadastro/edição
- Todos os campos da entidade `AcaoExtensao`
- Validação de dados

---

## 📤 Entregáveis

### Obrigatórios:

1. **Código no GitHub:**
   - Repositório com código final
   - Transferir propriedade para `labwebt-team`
   - Licença: BSD-2
   - Tracks permanecem com os autores

2. **Link do Site Online:**
   - Site funcionando em produção
   - Ambiente de produção configurado

3. **Identificação dos Membros:**
   - Lista clara de todos os integrantes do grupo

### Aspectos que Serão Avaliados:

1. **Classes do modelo de negócio** com mapeamento adequado para o banco de dados
2. **Classes de operações com o banco de dados**, incluindo arquivos de configuração
3. **Servlets** e outras eventuais classes de controle
4. **JSPs** e sua qualidade funcional

---

## 🎤 Apresentação

### Formato:
1. Apresentar o site funcionando em sua versão final
2. Apresentar organização do código: estrutura de diretórios, localização das classes
3. Apresentar exemplo de código relevante

### Avaliação Individual:
- Qualquer integrante pode ser questionado pelo professor
- **Não será aceita** como justificativa o fato de o trabalho ter sido dividido
- Incapacidade de responder sobre o projeto pode resultar em nota 0 na apresentação
- Ausência na apresentação implica nota 0

### Nota Final:
**Nota Final = Nota do Trabalho (0-10) × Nota da Apresentação Individual (0-1)**

---

## ⚠️ Observações Importantes

### Proibições:
- **Não é permitido copiar** código de outros projetos
- Podem se inspirar em outros sites, mas devem desenvolver o próprio código

### Incentivos:
- Construção progressiva do projeto
- Questionamentos ao professor como "cliente" do projeto
- Interação com o professor é mais valiosa que opiniões de colegas

### Créditos:
- Pertencem ao grupo e colaboradores conforme participação efetiva

---

## 📁 Estrutura de Diretórios Esperada
```
projeto-acoes-extensao/
├── src/
│   └── main/
│       ├── java/
│       │   └── ufrrj/
│       │       ├── model/
│       │       │   └── AcaoExtensao.java
│       │       ├── dao/
│       │       │   └── AcaoDAO.java
│       │       └── controller/
│       │           └── AcaoExtensaoServlet.java
│       ├── resources/
│       │   └── META-INF/
│       │       └── persistence.xml
│       └── webapp/
│           ├── jsp/
│           │   ├── listagem.jsp
│           │   ├── detalhes.jsp
│           │   └── cadastro.jsp
│           └── static/
│               └── css/
│                   └── style.css
└── pom.xml / build.gradle
```

---

## ✅ Checklist de Implementação

### Back-End:
- [ ] Configurar projeto Maven/Gradle
- [ ] Configurar banco de dados e ORM
- [ ] Criar classe `AcaoExtensao.java` com todos os atributos
- [ ] Mapear classe para BD via JPA/Hibernate
- [ ] Criar classe `AcaoDAO.java` com todos os métodos
- [ ] Implementar busca dinâmica por filtros
- [ ] Criar `AcaoExtensaoServlet.java`
- [ ] Implementar `doGet()` para listagem e detalhes
- [ ] Implementar `doPost()` para cadastro/edição

### Front-End:
- [ ] Criar arquivo CSS com projeto visual de qualidade
- [ ] Criar `listagem.jsp` com busca e filtros funcionais
- [ ] Implementar JSTL para listagem dinâmica
- [ ] Criar `detalhes.jsp` com informações completas
- [ ] Criar `cadastro.jsp` com formulário completo
- [ ] Testar todas as funcionalidades dinâmicas

---

# 🔧 Sistema Atual (implementado)
## Modelos
- `ufrrj.model.AcaoExtensao`: título, descrição, `dataInicio`, `dataEncerramento`, responsável (`responsavel` e `responsavelRef`), local, público, `temTaxas`, status, `contatoInscricao`, link
- `ufrrj.model.Inscricao`: ação (`acao`), nome, contato, `dataInscricao` (LocalDate); formato exibido `dd/MM/yyyy`
- `ufrrj.model.Responsavel`: nome, email (único), `senhaHash`

## DAOs
- `ufrrj.dao.AcaoDAO`: `save`, `findById`, `findAll`, `findByFiltros(termo,status)`, `findByOwner(responsavelId)`
- `ufrrj.dao.InscricaoDAO`: `save`, `findByAcao(aid)`
- `ufrrj.dao.ResponsavelDAO`: `save`, `findByEmail`, `findById`

## Rotas e Autenticação
- `GET /acoes`: listagem com filtros `termo`, `status` → `jsp/listagem.jsp`
- `GET /acoes?id={id}`: detalhes da ação → `jsp/detalhes.jsp`
- `POST /acoes`: cria/edita ação (restrito) → preenche responsável a partir da sessão
- `GET /inscricoes?acaoId={id}`: formulário de inscrição → `jsp/inscricao.jsp`
- `POST /inscricoes`: cria inscrição e redireciona para detalhes
- `GET /admin`: área do responsável com ações e inscritos da ação selecionada (`verInscritos`)
- `GET /login`, `POST /login`: autenticação; sessão com `userId`, `userNome`
- `GET /register`, `POST /register`: cadastro de responsável
- `GET /logout`: encerra sessão

## Sessão
- Em rotas restritas (`/admin`, `POST /acoes`) é exigido `session.userId`
- O campo responsável no cadastro é preenchido com `session.userNome` e fixo

## JSPs
- `jsp/listagem.jsp`: busca e filtros; datas com `dd/MM/yyyy`
- `jsp/detalhes.jsp`: exibe atributos completos; datas formatadas
- `jsp/cadastro.jsp`: formulário com campo responsável preenchido automaticamente; máscara de telefone para `contatoInscricao`
- `jsp/inscricao.jsp`: formulário com máscara de telefone em `contato`
- `jsp/admin.jsp`: lista ações e exibe inscritos em tabela com título da ação


### Deploy:
- [ ] Preparar ambiente de produção
- [ ] Fazer deploy do site
- [ ] Testar site online
- [ ] Documentar membros do grupo
- [ ] Criar repositório no GitHub
- [ ] Transferir propriedade para `labwebt-team`
- [ ] Adicionar licença BSD-2

### Apresentação:
- [ ] Preparar demonstração do site funcionando
- [ ] Preparar apresentação da estrutura do código
- [ ] Selecionar exemplos relevantes de código
- [ ] Garantir que todos os membros conheçam todo o projeto

---

## 🎓 Competências a Serem Demonstradas

- Desenvolvimento web com Java
- Programação Orientada a Objetos
- Mapeamento Objeto-Relacional (ORM)
- Padrão MVC (Model-View-Controller)
- Servlets e JSPs
- HTML/CSS de qualidade
- Integração com banco de dados
- Deploy em ambiente de produção
- Trabalho em equipe
- Gerenciamento de projeto

---

**Em caso de dúvidas, procure o professor!**
