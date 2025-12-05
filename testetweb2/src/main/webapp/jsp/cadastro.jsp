<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Cadastro de Ação</title>
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
      <div class="flex gap-3">
        <a href="${pageContext.request.contextPath}/" class="px-5 py-2 bg-white text-ufrrj-blue font-semibold rounded-full shadow-md">Início</a>
        <a href="${pageContext.request.contextPath}/logout" class="px-5 py-2 bg-ufrrj-red text-white font-semibold rounded-full login-btn-effect">Sair</a>
      </div>
    </div>
  </header>
  <main class="container mx-auto p-6 max-w-3xl">
    <div class="bg-white rounded-xl shadow p-6">
      <h2 class="text-2xl font-bold mb-4">Cadastro de Ação</h2>
      <form method="post" action="${pageContext.request.contextPath}/acoes" class="space-y-3">
        <input type="text" name="titulo" placeholder="Título" required class="w-full px-4 py-2 border rounded-lg">
        <textarea name="descricao" placeholder="Descrição" rows="4" class="w-full px-4 py-2 border rounded-lg"></textarea>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
          <input type="date" name="dataInicio" placeholder="Data de início" class="px-4 py-2 border rounded-lg">
          <input type="date" name="dataEncerramento" placeholder="Data de encerramento" class="px-4 py-2 border rounded-lg">
        </div>
        <input type="text" name="responsavel" placeholder="Responsável" value="${sessionScope.userNome}" readonly class="w-full px-4 py-2 border rounded-lg bg-gray-100">
        <input type="text" name="localRealizacao" placeholder="Local de realização" class="w-full px-4 py-2 border rounded-lg">
        <input type="text" name="publicoAlvo" placeholder="Público-alvo" class="w-full px-4 py-2 border rounded-lg">
        <label class="flex items-center gap-2"><input type="checkbox" name="temTaxas"> Possui taxas</label>
        <select name="status" class="w-full px-4 py-2 border rounded-lg">
          <option value="Vigente">Vigente</option>
          <option value="Encerrada">Encerrada</option>
        </select>
        <input type="text" name="contatoInscricao" placeholder="Contato para inscrição" class="w-full px-4 py-2 border rounded-lg">
        <input type="url" name="linkExterno" placeholder="Link externo" class="w-full px-4 py-2 border rounded-lg">
        <div class="flex gap-3 pt-2">
          <button type="submit" class="px-4 py-2 bg-ufrrj-green text-white rounded-lg subscribe-btn-effect">Salvar</button>
          <a href="${pageContext.request.contextPath}/acoes" class="px-4 py-2 bg-gray-200 rounded-lg">Cancelar</a>
        </div>
      </form>
    </div>
  </main>
</body>
<script>
  (function() {
    function maskPhone(value) {
      const digits = value.replace(/\D/g, '').slice(0, 11);
      if (digits.length <= 2) return digits;
      if (digits.length <= 6) return `(${digits.slice(0,2)}) ${digits.slice(2)}`;
      if (digits.length <= 10) return `(${digits.slice(0,2)}) ${digits.slice(2,6)}-${digits.slice(6)}`;
      return `(${digits.slice(0,2)}) ${digits.slice(2,7)}-${digits.slice(7)}`;
    }
    const contato = document.querySelector("input[name='contatoInscricao']");
    if (contato) {
      contato.addEventListener('input', function(e) {
        const v = e.target.value;
        if (/^\d/.test(v)) e.target.value = maskPhone(v);
      });
    }
  })();
</script>
</html>
