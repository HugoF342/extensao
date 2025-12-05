<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Detalhes da Ação</title>
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
  </script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body class="bg-gray-50 text-gray-800">
  <header class="bg-ufrrj-blue shadow-lg">
    <div class="container mx-auto p-4 flex justify-between items-center max-w-7xl">
      <div class="flex items-center space-x-3 header-logo cursor-pointer" onclick="location.href='${pageContext.request.contextPath}/'">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-ufrrj-green" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2L2 7l10 5 10-5-10-5z"></path><path d="M2 17l10 5 10-5"></path><path d="M2 12l10 5 10-5"></path></svg>
        <h1 class="text-2xl font-extrabold text-white">Extensão UFRRJ</h1>
      </div>
      <div class="flex gap-3">
        <a href="${pageContext.request.contextPath}/" class="px-5 py-2 bg-white text-ufrrj-blue font-semibold rounded-full shadow-md">Início</a>
        <c:choose>
          <c:when test="${not empty sessionScope.userId}">
            <span class="px-5 py-2 bg-white/10 text-white rounded-full">${sessionScope.userNome}</span>
            <a href="${pageContext.request.contextPath}/logout" class="px-5 py-2 bg-ufrrj-red text-white font-semibold rounded-full">Sair</a>
          </c:when>
          <c:otherwise>
            <a href="${pageContext.request.contextPath}/login" class="px-5 py-2 bg-ufrrj-red text-white font-semibold rounded-full login-btn-effect">Área do Responsável</a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </header>
  <main class="container mx-auto p-6 max-w-7xl">
    <div class="bg-white rounded-xl shadow p-6">
      <a href="${pageContext.request.contextPath}/acoes" class="text-ufrrj-blue">Voltar</a>
      <h2 class="text-3xl font-bold mt-2">${acao.titulo}</h2>
      <p class="mt-4 text-gray-700">${acao.descricao}</p>
      <div class="mt-4 grid grid-cols-1 md:grid-cols-2 gap-4 text-gray-700">
        <p>Status: ${acao.status}</p>
        <p>Responsável: ${acao.responsavel}</p>
        <p>Local: ${acao.localRealizacao}</p>
        <p>Público-alvo: ${acao.publicoAlvo}</p>
        <p>Taxas: <c:choose><c:when test="${acao.temTaxas}">Sim</c:when><c:otherwise>Não</c:otherwise></c:choose></p>
        <p>Contato: ${acao.contatoInscricao}</p>
        <c:if test="${not empty acao.linkExterno}">
          <p><a href="${acao.linkExterno}" target="_blank" class="text-ufrrj-blue underline">Link externo</a></p>
        </c:if>
        <p>Início: ${acao.dataInicioFormatada} Encerramento: ${acao.dataEncerramentoFormatada}</p>
      </div>
    </div>
  </main>
</body>
</html>
