package ufrrj.controller;

import ufrrj.dao.ResponsavelDAO;
import ufrrj.model.Responsavel;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class AuthServlet extends HttpServlet {
    private final ResponsavelDAO dao = new ResponsavelDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/logout".equals(path)) {
            HttpSession s = req.getSession(false);
            if (s != null) s.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        if ("/login".equals(path)) {
            req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
            return;
        }
        if ("/register".equals(path)) {
            req.getRequestDispatcher("/jsp/register.jsp").forward(req, resp);
            return;
        }
        resp.sendError(404);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();
        if ("/login".equals(path)) {
            String email = req.getParameter("email");
            String senha = req.getParameter("senha");
            Responsavel r = dao.findByEmail(email);
            if (r != null && r.getSenhaHash().equals(hash(senha))) {
                HttpSession s = req.getSession(true);
                s.setAttribute("userId", r.getId());
                s.setAttribute("userNome", r.getNome());
                resp.sendRedirect(req.getContextPath() + "/admin");
            } else {
                req.setAttribute("erro", "Credenciais inválidas");
                req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
            }
            return;
        }
        if ("/register".equals(path)) {
            String nome = req.getParameter("nome");
            String email = req.getParameter("email");
            String senha = req.getParameter("senha");
            Responsavel existente = dao.findByEmail(email);
            if (existente != null) {
                req.setAttribute("erro", "Email já cadastrado");
                req.getRequestDispatcher("/jsp/register.jsp").forward(req, resp);
                return;
            }
            Responsavel r = new Responsavel();
            r.setNome(nome);
            r.setEmail(email);
            r.setSenhaHash(hash(senha));
            dao.save(r);
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        resp.sendError(404);
    }

    private String hash(String senha) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] h = md.digest(senha.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : h) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (NoSuchAlgorithmException e) { throw new RuntimeException(e); }
    }
}

