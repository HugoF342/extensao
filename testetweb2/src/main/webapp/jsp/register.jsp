<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Cadastro de Responsável</title>
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
      </div>
    </div>
  </header>
  <main class="container mx-auto p-6 max-w-md">
    <div class="bg-white rounded-xl shadow p-6">
      <h2 class="text-2xl font-bold mb-4">Cadastrar Responsável</h2>
      <form method="post" action="${pageContext.request.contextPath}/register" class="space-y-3">
        <input type="text" name="nome" placeholder="Nome" required class="w-full px-4 py-2 border rounded-lg">
        <input type="email" name="email" placeholder="Email" required class="w-full px-4 py-2 border rounded-lg">
        <input type="password" name="senha" placeholder="Senha" required class="w-full px-4 py-2 border rounded-lg">
        <button type="submit" class="w-full px-4 py-2 bg-ufrrj-blue text-white rounded-lg">Cadastrar</button>
      </form>
      <div class="text-red-600 mt-2">${erro}</div>
    </div>
  </main>
</body>
</html>
