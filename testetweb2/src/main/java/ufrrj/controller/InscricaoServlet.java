package ufrrj.controller;

import ufrrj.dao.AcaoDAO;
import ufrrj.dao.InscricaoDAO;
import ufrrj.model.AcaoExtensao;
import ufrrj.model.Inscricao;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

public class InscricaoServlet extends HttpServlet {
    private final AcaoDAO acaoDAO = new AcaoDAO();
    private final InscricaoDAO inscricaoDAO = new InscricaoDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String aid = req.getParameter("acaoId");
        if (aid == null || aid.isBlank()) { resp.sendRedirect(req.getContextPath() + "/acoes"); return; }
        req.setAttribute("acaoId", aid);
        req.getRequestDispatcher("/jsp/inscricao.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String aid = req.getParameter("acaoId");
        String nome = req.getParameter("nome");
        String contato = req.getParameter("contato");
        if (aid == null || nome == null || contato == null) { resp.sendRedirect(req.getContextPath() + "/acoes"); return; }
        Long id = Long.valueOf(aid);
        AcaoExtensao a = acaoDAO.findById(id);
        if (a == null) { resp.sendRedirect(req.getContextPath() + "/acoes"); return; }
        Inscricao i = new Inscricao();
        i.setAcao(a);
        i.setNome(nome);
        i.setContato(contato);
        i.setDataInscricao(LocalDate.now());
        inscricaoDAO.save(i);
        resp.sendRedirect(req.getContextPath() + "/acoes?id=" + id);
    }
}

