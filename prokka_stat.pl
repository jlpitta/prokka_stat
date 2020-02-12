#!/usr/bin/perl
# Script para ler arquivos txt de estatística do prokka e gerar um cvs
# By Antonio Rezende e adaptado por João Pitta (jlpitta82@gmail.com)
# At FIOCRUZ-PE (Recife - PE)
# Wed 12 Fev 2020 14:32 BRT (Primeira versão)
# Versão 0.2
#use warnings;
use strict;

my @files;
my $file;
my $strain;
my $contigs;
my $bases;
my $tmRNA;
my $sig;
my $tRNA;
my $rrna;
my $rep;
my $cds;

#Pegar todos os arquivos txt com as estatísticas do Prokka 
@files=glob("input_files/*.txt") or die "Arquivos não encontrados na pasta input_files. Os Arquivos txt do prokka estão lá?";

my $result = 'result_stat.csv';
open(Arq_Result, '>', $result) or die $!;

#imprimir o cabeçalho
print Arq_Result "STRAIN\tcontigs\tbases\ttmRNA\tsig_peptide\ttRNA\trRNA\trepeat region\tCDS\n";
foreach $file (@files){
    $strain=$file;
    $strain=~s/.txt//g;
    $strain=~s/input_files\///g; 
    # Abre o arquivo e lê linha a linha
    open(IN,"$file");
    my $line;
    while($line=<IN>){
        chomp($line);
        if($line=~m/contigs: /){
            $contigs=$';
        }
        if($line=~m/bases: /){
            $bases=$';
        }
        if($line=~m/tmRNA: /){
            $tmRNA=$';
        }
        if($line=~m/sig_peptide: /){
            $sig=$';
        }
        if($line=~m/tRNA: /){
            $tRNA=$';
        }
        if($line=~m/rRNA: /){
            $rrna=$';
        }
        if($line=~m/repeat_region: /){
            $rep=$';
        }
        if($line=~m/CDS: /){
            $cds=$';
        }
    }
    print Arq_Result "$strain\t$contigs\t$bases\t$tmRNA\t$sig\t$tRNA\t$rrna\t$rep\t$cds\n";
    print "Gravando o seguinte registro: \n STRAIN\tcontigs\tbases\ttmRNA\tsig_peptide\ttRNA\trRNA\trepeat region\tCDS\n $strain\t$contigs\t$bases\t$tmRNA\t$sig\t$tRNA\t$rrna\t$rep\t$cds\n";

}
close(Arq_Result);
 
print "\n\nArquivo $result salvo com sucesso! \n\n\n";