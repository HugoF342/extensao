<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Área do Responsável</title>
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
  <%
    if (session == null || session.getAttribute("userId") == null) {
      response.sendRedirect(request.getContextPath()+"/login");
      return;
    }
  %>
  <header class="bg-ufrrj-blue shadow-lg">
    <div class="container mx-auto p-4 flex justify-between items-center max-w-7xl">
      <div class="flex items-center space-x-3 header-logo cursor-pointer" onclick="location.href='${pageContext.request.contextPath}/'">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-ufrrj-green" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2L2 7l10 5 10-5-10-5z"></path><path d="M2 17l10 5 10-5"></path><path d="M2 12l10 5 10-5"></path></svg>
        <h1 class="text-2xl font-extrabold text-white">Extensão UFRRJ</h1>
      </div>
      <div class="flex gap-3 items-center">
        <a href="${pageContext.request.contextPath}/" class="px-5 py-2 bg-white text-ufrrj-blue font-semibold rounded-full shadow-md">Início</a>
        <a href="${pageContext.request.contextPath}/jsp/cadastro.jsp" class="px-5 py-2 bg-ufrrj-green text-white font-semibold rounded-full subscribe-btn-effect">Nova Ação</a>
        <span class="px-5 py-2 bg-white/10 text-white rounded-full">${sessionScope.userNome}</span>
        <a href="${pageContext.request.contextPath}/logout" class="px-5 py-2 bg-ufrrj-red text-white font-semibold rounded-full login-btn-effect">Sair</a>
      </div>
    </div>
  </header>
  <main class="container mx-auto p-6 max-w-7xl">
    <h2 class="text-3xl font-bold mb-6">Minhas Ações</h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
      <c:forEach var="a" items="${acoes}">
        <div class="bg-white p-5 rounded-xl shadow hover:shadow-lg transition">
          <h3 class="text-xl font-semibold">${a.titulo}</h3>
          <p class="text-sm text-gray-600 mt-1">Status: ${a.status}</p>
          <p class="text-sm text-gray-600 mt-1">Inscrições: <a href="${pageContext.request.contextPath}/admin?verInscritos=${a.id}" class="text-ufrrj-blue underline">ver</a></p>
        </div>
      </c:forEach>
    </div>
    <c:if test="${not empty param.verInscritos}">
      <div class="bg-white rounded-xl shadow p-6 mt-8">
        <h3 class="text-2xl font-bold mb-4">Inscritos — <c:choose><c:when test="${not empty acaoView}">${acaoView.titulo}</c:when><c:otherwise>#${param.verInscritos}</c:otherwise></c:choose></h3>
        <c:choose>
          <c:when test="${not empty inscritos}">
            <div class="overflow-x-auto">
              <table class="min-w-full text-left">
                <thead>
                  <tr class="border-b">
                    <th class="py-2 px-3">Nome</th>
                    <th class="py-2 px-3">Contato</th>
                    <th class="py-2 px-3">Data</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="i" items="${inscritos}">
                    <tr class="border-b">
                      <td class="py-2 px-3">${i.nome}</td>
                      <td class="py-2 px-3">${i.contato}</td>
                      <td class="py-2 px-3">${i.dataInscricaoFormatada}</td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </c:when>
          <c:otherwise>
            <p class="text-gray-600">Nenhum inscrito até agora.</p>
          </c:otherwise>
        </c:choose>
      </div>
    </c:if>
  </main>
</body>
</html>
