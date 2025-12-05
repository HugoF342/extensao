package ufrrj.controller;

import ufrrj.dao.AcaoDAO;
import ufrrj.model.AcaoExtensao;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

public class AcaoExtensaoServlet extends HttpServlet {
    private final AcaoDAO dao = new AcaoDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            Long id = Long.valueOf(idParam);
            AcaoExtensao a = dao.findById(id);
            request.setAttribute("acao", a);
            request.getRequestDispatcher("/jsp/detalhes.jsp").forward(request, response);
            return;
        }
        String termo = request.getParameter("termo");
        String status = request.getParameter("status");
        List<AcaoExtensao> acoes = dao.findByFiltros(termo, status);
        request.setAttribute("acoes", acoes);
        request.getRequestDispatcher("/jsp/listagem.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        if (request.getSession(false) == null || request.getSession(false).getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Long userId = (Long) request.getSession(false).getAttribute("userId");
        String id = request.getParameter("id");
        AcaoExtensao a = new AcaoExtensao();
        if (id != null && !id.isBlank()) a.setId(Long.valueOf(id));
        a.setTitulo(request.getParameter("titulo"));
        a.setDescricao(request.getParameter("descricao"));
        String di = request.getParameter("dataInicio");
        String de = request.getParameter("dataEncerramento");
        if (di != null && !di.isBlank()) a.setDataInicio(LocalDate.parse(di));
        if (de != null && !de.isBlank()) a.setDataEncerramento(LocalDate.parse(de));
        a.setResponsavel(request.getParameter("responsavel"));
        a.setLocalRealizacao(request.getParameter("localRealizacao"));
        a.setPublicoAlvo(request.getParameter("publicoAlvo"));
        a.setTemTaxas("on".equals(request.getParameter("temTaxas")) || Boolean.parseBoolean(request.getParameter("temTaxas")));
        a.setStatus(request.getParameter("status"));
        a.setContatoInscricao(request.getParameter("contatoInscricao"));
        a.setLinkExterno(request.getParameter("linkExterno"));
        a.setResponsavel((String) request.getSession(false).getAttribute("userNome"));
        ufrrj.dao.ResponsavelDAO rdao = new ufrrj.dao.ResponsavelDAO();
        a.setResponsavelRef(rdao.findById(userId));
        dao.save(a);
        response.sendRedirect(request.getContextPath() + "/acoes");
    }
}
