package ufrrj.controller;

import ufrrj.dao.AcaoDAO;
import ufrrj.dao.InscricaoDAO;
import ufrrj.dao.ResponsavelDAO;
import ufrrj.model.AcaoExtensao;
import ufrrj.model.Responsavel;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class AdminServlet extends HttpServlet {
    private final AcaoDAO acaoDAO = new AcaoDAO();
    private final InscricaoDAO inscricaoDAO = new InscricaoDAO();
    private final ResponsavelDAO respDAO = new ResponsavelDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("userId") == null) { resp.sendRedirect(req.getContextPath() + "/login"); return; }
        Long userId = (Long) s.getAttribute("userId");
        List<AcaoExtensao> minhas = acaoDAO.findByOwner(userId);
        req.setAttribute("acoes", minhas);
        String verId = req.getParameter("verInscritos");
        if (verId != null && !verId.isBlank()) {
            Long aid = Long.valueOf(verId);
            req.setAttribute("inscritos", inscricaoDAO.findByAcao(aid));
            req.setAttribute("acaoView", acaoDAO.findById(aid));
        }
        req.getRequestDispatcher("/jsp/admin.jsp").forward(req, resp);
    }
}
