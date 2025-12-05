<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="ufrrj.dao.AcaoDAO, java.util.List, ufrrj.model.AcaoExtensao" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UFRRJ Extensão | Cadastro e Inscrição</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap');
        body { font-family: 'Inter', sans-serif; background-color: #f4f7fa; transition: background-color 0.3s; }
        .login-btn-effect { transition: all 0.3s ease; }
        .login-btn-effect:hover { transform: scale(1.05) translateY(-2px); box-shadow: 0 4px 15px rgba(239, 68, 68, 0.4); }
        .header-logo:hover { transform: rotate(-3deg) scale(1.02); transition: transform 0.3s ease; }
        .subscribe-btn-effect { transition: all 0.3s ease; }
        .subscribe-btn-effect:hover { transform: translateY(-1px); box-shadow: 0 4px 8px rgba(5, 150, 105, 0.3); }
    </style>
    <script>
        tailwind.config = { theme: { extend: { colors: { 'ufrrj-blue': '#1c4587', 'ufrrj-green': '#059669', 'ufrrj-red': '#ef4444', 'ufrrj-light': '#fefefe' } } } };
        const projectData = {
            'p1': { title: "Horta Comunitária: Cultivando o Futuro", description: "Este projeto visa a implementação e manutenção de hortas orgânicas em espaços urbanos subutilizados, promovendo a segurança alimentar, a educação ambiental e a integração comunitária. Os participantes aprendem técnicas de plantio sustentável e a importância da biodiversidade local. É um espaço de troca de saberes entre a academia e a comunidade.", location: "Instituto de Agronomia, Sala 203", schedule: "Terças e Quintas, das 09:00h às 12:00h" },
            'p2': { title: "Robótica Educacional: Despertando Talentos", description: "Oferece workshops e cursos de introdução à programação e robótica para jovens do ensino fundamental e médio. O objetivo é estimular o pensamento lógico, a resolução de problemas e o interesse por carreiras em Ciência e Tecnologia (STEM). Os alunos constroem e programam seus próprios robôs.", location: "Pavilhão de Aula Teóricas (PAT), Sala 213", schedule: "Segundas e Quartas, das 13:00h às 15:00h" },
            'p3': { title: "Inclusão Digital para a Terceira Idade", description: "Focado em reduzir a exclusão digital, o projeto oferece aulas de informática básica, uso de smartphones e acesso seguro à internet para a terceira idade. Ensina desde o básico de navegação até o uso de serviços públicos online e redes sociais, empoderando os idosos na sociedade moderna.", location: "Biblioteca Central", schedule: "Sextas-feiras, das 14:00h às 16:30h" },
            'p4': { title: "Saúde e Bem-Estar na Escola", description: "Equipes multidisciplinares da UFRRJ (Nutrição, Psicologia, Enfermagem) realizam oficinas e atendimentos preventivos em escolas públicas. Os temas abordados incluem nutrição saudável, saúde mental, prevenção de doenças e primeiros socorros. O foco é na promoção de hábitos de vida saudáveis.", location: "Praça da Alegria", schedule: "Quintas e Sextas, das 09:00h às 11:00h" },
            'p5': { title: "Arte, Cultura e Expressão Comunitária", description: "Promove a valorização da cultura local através de oficinas de teatro, música, dança e artes visuais. O projeto culmina em eventos abertos à comunidade, servindo como um palco para novos artistas e um ponto de encontro cultural, fortalecendo a identidade regional.", location: "Auditório Gustavo Dutra", schedule: "Sábados, das 10:00h às 13:00h" },
            'p6': { title: "Empreendedorismo e Geração de Renda", description: "Oferece capacitação, mentorias e consultoria gratuita para pequenos empreendedores e grupos produtivos da região. O foco é em gestão, finanças, marketing digital e desenvolvimento de plano de negócios, visando o crescimento sustentável e a autonomia financeira.", location: "Instituto de Ciências Sociais Aplicadas (ICSA), Sala 101", schedule: "Quartas e Sextas, das 17:00h às 19:00h" }
        };
        function showDetails(id) {
            const modal = document.getElementById('details-modal');
            const data = projectData[id];
            document.getElementById('modal-title').textContent = data.title;
            document.getElementById('modal-description').innerHTML = `
                <p class="mb-4">${data.description}</p>
                <div class="bg-gray-50 p-4 rounded-lg border border-gray-200">
                    <p class="font-bold text-gray-800 flex items-center mb-2">
                        <svg class="w-5 h-5 mr-2 text-ufrrj-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.828 0l-4.243-4.243a8 8 0 1111.314 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path></svg>
                        Localização: <span class="font-normal ml-2">${data.location}</span>
                    </p>
                    <p class="font-bold text-gray-800 flex items-center">
                        <svg class="w-5 h-5 mr-2 text-ufrrj-blue" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                        Horário: <span class="font-normal ml-2">${data.schedule}</span>
                    </p>
                </div>
            `;
            modal.classList.remove('hidden');
        }
        function openRegisterModal() { document.getElementById('register-modal').classList.remove('hidden'); }
        function submitRegisterForm(event) { event.preventDefault(); const name = document.getElementById('reg-name').value; alertUser(`Cadastro realizado com sucesso, ${name}! Você agora tem acesso à plataforma.`); closeModal('register-modal'); event.target.reset(); }
        function openSubscriptionModal(id, event) { event.stopPropagation(); const data = projectData[id]; document.getElementById('sub-modal-title').textContent = `Inscrição: ${data.title}`; document.getElementById('sub-project-id').value = id; document.getElementById('subscription-modal').classList.remove('hidden'); }
        function submitSubscriptionForm(event) { event.preventDefault(); const projectId = document.getElementById('sub-project-id').value; const projectTitle = projectData[projectId].title; const name = document.getElementById('sub-name').value; alertUser(`Parabéns, ${name}! Sua inscrição no projeto "${projectTitle}" foi confirmada. Entraremos em contato.`); closeModal('subscription-modal'); event.target.reset(); }
        function closeModal(id) { document.getElementById(id).classList.add('hidden'); }
        function alertUser(message) { const alertModal = document.getElementById('alert-modal'); document.getElementById('alert-message').textContent = message; alertModal.classList.remove('hidden'); }
    </script>
</head>
<body class="bg-gray-50 text-gray-800">
    <%
        List<AcaoExtensao> acoes = new AcaoDAO().findByFiltros(null, null);
        request.setAttribute("acoes", acoes);
    %>
    <div id="alert-modal" class="fixed inset-0 bg-gray-900 bg-opacity-75 hidden flex items-center justify-center p-4 z-50">
        <div class="bg-white rounded-xl shadow-2xl max-w-sm w-full p-6 transition-all transform scale-100 duration-300">
            <h3 class="text-xl font-bold text-ufrrj-green mb-4 border-b pb-2">Sucesso!</h3>
            <p id="alert-message" class="text-gray-700 leading-relaxed mb-6"></p>
            <div class="flex justify-end">
                <button onclick="closeModal('alert-modal')" class="px-6 py-2 bg-ufrrj-green text-white font-medium rounded-lg hover:bg-ufrrj-green/90 transition duration-200">Ok</button>
            </div>
        </div>
    </div>
    <div id="details-modal" class="fixed inset-0 bg-gray-900 bg-opacity-75 hidden flex items-center justify-center p-4 z-40">
        <div class="bg-white rounded-xl shadow-2xl max-w-lg w-full p-6 transition-all transform scale-100 duration-300">
            <h3 id="modal-title" class="text-2xl font-bold text-ufrrj-blue mb-4 border-b pb-2">Detalhes do Projeto</h3>
            <div id="modal-description" class="text-gray-700 leading-relaxed mb-6"></div>
            <div class="flex justify-end">
                <button onclick="closeModal('details-modal')" class="px-6 py-2 bg-ufrrj-blue text-white font-medium rounded-lg hover:bg-ufrrj-blue/90 transition duration-200">Fechar</button>
            </div>
        </div>
    </div>
    <div id="register-modal" class="fixed inset-0 bg-gray-900 bg-opacity-75 hidden flex items-center justify-center p-4 z-40">
        <div class="bg-white rounded-xl shadow-2xl max-w-md w-full p-8 transition-all transform scale-100 duration-300">
            <h3 class="text-2xl font-bold text-ufrrj-red mb-6 border-b pb-2">Cadastro e Acesso</h3>
            <form onsubmit="submitRegisterForm(event)">
                <div class="mb-4"><label for="reg-name" class="block text-gray-700 font-semibold mb-2">Nome Completo</label><input type="text" id="reg-name" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-ufrrj-red/50 transition duration-150"></div>
                <div class="mb-4"><label for="reg-email" class="block text-gray-700 font-semibold mb-2">Email Institucional/Pessoal</label><input type="email" id="reg-email" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-ufrrj-red/50 transition duration-150"></div>
                <div class="mb-6"><label for="reg-matricula" class="block text-gray-700 font-semibold mb-2">Matrícula (Se Aluno/Servidor)</label><input type="text" id="reg-matricula" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-ufrrj-red/50 transition duration-150" placeholder="Opcional"></div>
                <div class="flex justify-between items-center">
                    <button type="button" onclick="closeModal('register-modal')" class="px-6 py-2 text-gray-600 font-medium rounded-lg hover:bg-gray-100 transition duration-200">Cancelar</button>
                    <button type="submit" class="px-6 py-2 bg-ufrrj-red text-white font-medium rounded-lg hover:bg-ufrrj-red/90 transition duration-200 shadow-md">Cadastrar e Acessar</button>
                </div>
            </form>
        </div>
    </div>
    <div id="subscription-modal" class="fixed inset-0 bg-gray-900 bg-opacity-75 hidden flex items-center justify-center p-4 z-40">
        <div class="bg-white rounded-xl shadow-2xl max-w-md w-full p-8 transition-all transform scale-100 duration-300">
            <h3 id="sub-modal-title" class="text-2xl font-bold text-ufrrj-green mb-6 border-b pb-2">Inscrição no Projeto</h3>
            <form onsubmit="submitSubscriptionForm(event)">
                <input type="hidden" id="sub-project-id" value="">
                <p class="text-sm text-gray-500 mb-4">Por favor, preencha seus dados para confirmar a sua vaga.</p>
                <div class="mb-4"><label for="sub-name" class="block text-gray-700 font-semibold mb-2">Seu Nome</label><input type="text" id="sub-name" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-ufrrj-green/50 transition duration-150"></div>
                <div class="mb-6"><label for="sub-contact" class="block text-gray-700 font-semibold mb-2">Melhor Contato (Email ou WhatsApp)</label><input type="text" id="sub-contact" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-ufrrj-green/50 transition duration-150"></div>
                <div class="flex justify-between items-center">
                    <button type="button" onclick="closeModal('subscription-modal')" class="px-6 py-2 text-gray-600 font-medium rounded-lg hover:bg-gray-100 transition duration-200">Voltar</button>
                    <button type="submit" class="px-6 py-2 bg-ufrrj-green text-white font-medium rounded-lg hover:bg-ufrrj-green/90 transition duration-200 shadow-md">Confirmar Inscrição</button>
                </div>
            </form>
        </div>
    </div>
    <header class="bg-ufrrj-blue shadow-lg">
        <div class="container mx-auto p-4 flex justify-between items-center max-w-7xl">
            <div class="flex items-center space-x-3 header-logo cursor-pointer" onclick="window.location.reload()">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-ufrrj-green" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2L2 7l10 5 10-5-10-5z"></path><path d="M2 17l10 5 10-5"></path><path d="M2 12l10 5 10-5"></path></svg>
                <h1 class="text-3xl font-extrabold text-white">Extensão UFRRJ</h1>
            </div>
            <div class="flex gap-3">
                <a href="${pageContext.request.contextPath}/acoes" class="px-5 py-2 bg-white text-ufrrj-blue font-semibold rounded-full shadow-md">Ver Ações</a>
                <a href="${pageContext.request.contextPath}/login" class="px-5 py-2 bg-ufrrj-red text-white font-semibold rounded-full login-btn-effect shadow-md">Área do Responsável</a>
            </div>
        </div>
    </header>
    <main class="container mx-auto p-6 max-w-7xl">
        <section class="text-center py-12 md:py-16 bg-white rounded-2xl shadow-xl mb-12">
            <h2 class="text-4xl md:text-5xl font-bold text-ufrrj-blue mb-4">Conectando Conhecimento à Comunidade</h2>
            <p class="text-xl text-gray-600 max-w-3xl mx-auto mb-6">Descubra os projetos de Extensão da Universidade Federal Rural do Rio de Janeiro que transformam vidas e promovem o desenvolvimento sustentável na região.</p>
            <a href="#projetos" class="inline-block px-8 py-3 bg-ufrrj-green text-white font-bold text-lg rounded-lg shadow-lg hover:bg-ufrrj-green/90 transition duration-300 transform hover:scale-105">Explorar Projetos</a>
        </section>
        <section id="projetos" class="pb-12">
            <h3 class="text-3xl font-bold text-ufrrj-blue mb-8 border-l-4 border-ufrrj-green pl-4">Nossos Projetos Atuais</h3>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                <c:forEach var="a" items="${acoes}">
                    <div class="bg-white p-6 rounded-xl shadow-lg hover:shadow-2xl transition duration-300 transform hover:-translate-y-2 border-t-4 border-ufrrj-green">
                        <div class="flex items-center space-x-3 mb-3">
                            <svg class="w-8 h-8 text-ufrrj-green" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path></svg>
                            <h4 class="text-xl font-semibold text-gray-900">${a.titulo}</h4>
                        </div>
                        <p class="text-gray-600 mb-4">
                            <c:choose>
                                <c:when test="${not empty a.descricao && a.descricao.length() > 140}">${a.descricao.substring(0,140)}...</c:when>
                                <c:otherwise>${a.descricao}</c:otherwise>
                            </c:choose>
                        </p>
                        <div class="flex justify-between items-center">
                            <a href="${pageContext.request.contextPath}/acoes?id=${a.id}" class="text-sm font-medium text-ufrrj-blue hover:underline">Ver Detalhes →</a>
                            <a href="${pageContext.request.contextPath}/inscricoes?acaoId=${a.id}" class="px-4 py-1.5 text-sm bg-ufrrj-green text-white font-medium rounded-full">Inscrever-se</a>
                        </div>
                        <div class="mt-3 text-sm text-gray-500">Status: ${a.status}</div>
                    </div>
                </c:forEach>
            </div>
        </section>
        <section class="py-12 bg-ufrrj-light rounded-2xl shadow-xl mb-12 p-8 md:p-12">
            <h3 class="text-3xl font-bold text-ufrrj-blue mb-6 border-b pb-2">O que é a Extensão Universitária?</h3>
            <div class="space-y-6 text-gray-700 text-lg">
                <p>A Extensão é o processo educativo, cultural e científico que articula o Ensino e a Pesquisa de forma indissociável, viabilizando a relação transformadora entre a Universidade e a Sociedade.</p>
            </div>
        </section>
        <section class="py-12">
            <h3 class="text-3xl font-bold text-ufrrj-blue mb-8 border-l-4 border-ufrrj-green pl-4">Como Fazer Parte</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 text-center">
                <div class="p-6 bg-white rounded-xl shadow-lg border-b-4 border-ufrrj-blue hover:shadow-2xl transition duration-300"><p class="text-5xl font-extrabold text-ufrrj-blue mb-4">1</p><h4 class="text-xl font-semibold mb-2">Comunidade</h4><p class="text-gray-600">Participe diretamente dos projetos, inscrevendo-se em nossas oficinas e eventos abertos.</p></div>
                <div class="p-6 bg-white rounded-xl shadow-lg border-b-4 border-ufrrj-green hover:shadow-2xl transition duration-300"><p class="text-5xl font-extrabold text-ufrrj-green mb-4">2</p><h4 class="text-xl font-semibold mb-2">Alunos/Professores</h4><p class="text-gray-600">Submeta propostas de projetos ou integre equipes existentes como bolsista ou voluntário.</p></div>
                <div class="p-6 bg-white rounded-xl shadow-lg border-b-4 border-ufrrj-red hover:shadow-2xl transition duration-300"><p class="text-5xl font-extrabold text-ufrrj-red mb-4">3</p><h4 class="text-xl font-semibold mb-2">Parceiros</h4><p class="text-gray-600">Apoie financeiramente ou com recursos materiais/estruturais os projetos de impacto social.</p></div>
            </div>
        </section>
    </main>
    <footer class="bg-ufrrj-blue mt-12 py-8">
        <div class="container mx-auto text-center text-white max-w-7xl">
            <p class="mb-2">© 2025 Pró-Reitoria de Extensão (PROEXT) - UFRRJ.</p>
            <p class="text-sm text-ufrrj-light/80">Conectando a universidade com o campo e a cidade.</p>
        </div>
    </footer>
</body>
</html>
