package ufrrj.dao;

import ufrrj.model.AcaoExtensao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import java.util.List;

public class AcaoDAO {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("ufrrjPU");

    public AcaoExtensao save(AcaoExtensao acao) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            AcaoExtensao merged = em.merge(acao);
            em.getTransaction().commit();
            return merged;
        } finally {
            em.close();
        }
    }

    public AcaoExtensao findById(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(AcaoExtensao.class, id);
        } finally {
            em.close();
        }
    }

    public List<AcaoExtensao> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<AcaoExtensao> q = em.createQuery("SELECT a FROM AcaoExtensao a ORDER BY a.dataInicio DESC", AcaoExtensao.class);
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public List<AcaoExtensao> findByFiltros(String termo, String status) {
        EntityManager em = emf.createEntityManager();
        try {
            StringBuilder jpql = new StringBuilder("SELECT a FROM AcaoExtensao a WHERE 1=1");
            if (termo != null && !termo.isBlank()) jpql.append(" AND (LOWER(a.titulo) LIKE :like OR LOWER(a.descricao) LIKE :like)");
            if (status != null && !status.isBlank()) jpql.append(" AND a.status = :status");
            jpql.append(" ORDER BY a.dataInicio DESC");
            TypedQuery<AcaoExtensao> q = em.createQuery(jpql.toString(), AcaoExtensao.class);
            if (termo != null && !termo.isBlank()) q.setParameter("like", "%" + termo.toLowerCase() + "%");
            if (status != null && !status.isBlank()) q.setParameter("status", status);
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public List<AcaoExtensao> findByOwner(Long responsavelId) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<AcaoExtensao> q = em.createQuery("SELECT a FROM AcaoExtensao a WHERE a.responsavelRef.id = :rid ORDER BY a.dataInicio DESC", AcaoExtensao.class);
            q.setParameter("rid", responsavelId);
            return q.getResultList();
        } finally { em.close(); }
    }
}
