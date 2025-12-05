package ufrrj.model;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "acao_extensao")
public class AcaoExtensao {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String titulo;

    @Column(columnDefinition = "TEXT")
    private String descricao;

    private LocalDate dataInicio;

    private LocalDate dataEncerramento;

    private String responsavel;

    @ManyToOne
    @JoinColumn(name = "responsavel_id")
    private Responsavel responsavelRef;

    private String localRealizacao;

    private String publicoAlvo;

    private boolean temTaxas;

    private String status;

    private String contatoInscricao;

    private String linkExterno;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }
    public LocalDate getDataInicio() { return dataInicio; }
    public void setDataInicio(LocalDate dataInicio) { this.dataInicio = dataInicio; }
    public LocalDate getDataEncerramento() { return dataEncerramento; }
    public void setDataEncerramento(LocalDate dataEncerramento) { this.dataEncerramento = dataEncerramento; }
    public String getResponsavel() { return responsavel; }
    public void setResponsavel(String responsavel) { this.responsavel = responsavel; }
    public Responsavel getResponsavelRef() { return responsavelRef; }
    public void setResponsavelRef(Responsavel responsavelRef) { this.responsavelRef = responsavelRef; }
    public String getLocalRealizacao() { return localRealizacao; }
    public void setLocalRealizacao(String localRealizacao) { this.localRealizacao = localRealizacao; }
    public String getPublicoAlvo() { return publicoAlvo; }
    public void setPublicoAlvo(String publicoAlvo) { this.publicoAlvo = publicoAlvo; }
    public boolean isTemTaxas() { return temTaxas; }
    public void setTemTaxas(boolean temTaxas) { this.temTaxas = temTaxas; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getContatoInscricao() { return contatoInscricao; }
    public void setContatoInscricao(String contatoInscricao) { this.contatoInscricao = contatoInscricao; }
    public String getLinkExterno() { return linkExterno; }
    public void setLinkExterno(String linkExterno) { this.linkExterno = linkExterno; }

    public String getDataInicioFormatada() {
        if (dataInicio == null) return "";
        return java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy").format(dataInicio);
    }

    public String getDataEncerramentoFormatada() {
        if (dataEncerramento == null) return "";
        return java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy").format(dataEncerramento);
    }
}
