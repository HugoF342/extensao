package ufrrj.dao;

import ufrrj.model.Responsavel;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;

public class ResponsavelDAO {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("ufrrjPU");

    public Responsavel save(Responsavel r) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Responsavel merged = em.merge(r);
            em.getTransaction().commit();
            return merged;
        } finally { em.close(); }
    }

    public Responsavel findByEmail(String email) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Responsavel> q = em.createQuery("SELECT r FROM Responsavel r WHERE r.email = :email", Responsavel.class);
            q.setParameter("email", email);
            try { return q.getSingleResult(); } catch (NoResultException e) { return null; }
        } finally { em.close(); }
    }

    public Responsavel findById(Long id) {
        EntityManager em = emf.createEntityManager();
        try { return em.find(Responsavel.class, id); } finally { em.close(); }
    }
}

