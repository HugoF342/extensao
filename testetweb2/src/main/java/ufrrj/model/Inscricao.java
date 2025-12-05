package ufrrj.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "inscricao")
public class Inscricao {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "acao_id", nullable = false)
    private AcaoExtensao acao;

    @Column(nullable = false)
    private String nome;

    @Column(nullable = false)
    private String contato;

    @Column(nullable = false)
    private LocalDate dataInscricao;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public AcaoExtensao getAcao() { return acao; }
    public void setAcao(AcaoExtensao acao) { this.acao = acao; }
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    public String getContato() { return contato; }
    public void setContato(String contato) { this.contato = contato; }
    public LocalDate getDataInscricao() { return dataInscricao; }
    public void setDataInscricao(LocalDate dataInscricao) { this.dataInscricao = dataInscricao; }

    public String getDataInscricaoFormatada() {
        if (dataInscricao == null) return "";
        return java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy").format(dataInscricao);
    }
}
