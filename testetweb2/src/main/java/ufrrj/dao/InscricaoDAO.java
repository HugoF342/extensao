package ufrrj.dao;

import ufrrj.model.Inscricao;
import ufrrj.model.AcaoExtensao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import java.util.List;

public class InscricaoDAO {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("ufrrjPU");

    public Inscricao save(Inscricao i) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Inscricao merged = em.merge(i);
            em.getTransaction().commit();
            return merged;
        } finally { em.close(); }
    }

    public List<Inscricao> findByAcao(Long acaoId) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Inscricao> q = em.createQuery("SELECT i FROM Inscricao i WHERE i.acao.id = :aid ORDER BY i.dataInscricao DESC", Inscricao.class);
            q.setParameter("aid", acaoId);
            return q.getResultList();
        } finally { em.close(); }
    }
}

