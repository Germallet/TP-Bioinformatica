#!/bin/perl

use strict;
use warnings;

use Bio::Seq;
use Bio::DB::GenBank;
use Bio::SeqIO;

print "TP Bioinformática - Ejercicio 1\n";
if ($#ARGV + 1 < 2) {
    print "Se requieren al menos dos parámetros! El archivo de secuencias de entrada y el archivo FASTA de salida.\n";
    exit;
}

sub get_seq_from_db {
    my $db_obj = Bio::DB::GenBank->new;
    return $db_obj->get_Seq_by_acc($_[0]);
}

sub get_seq_from_file {
    my $seqio_obj = Bio::SeqIO->new(-file => $_[0], -format => "genbank"); 
    return $seqio_obj->next_seq;
}

sub export_to_fasta {
    my $seqio_obj = Bio::SeqIO->new(-file => $_[1], -format => 'fasta');
    $seqio_obj->write_seq($_[0]->translate(-frame => 0));
    $seqio_obj->write_seq($_[0]->translate(-frame => 1));
    $seqio_obj->write_seq($_[0]->translate(-frame => 2));
    $seqio_obj->write_seq($_[0]->revcom->translate(-frame => 0));
    $seqio_obj->write_seq($_[0]->revcom->translate(-frame => 1));
    $seqio_obj->write_seq($_[0]->revcom->translate(-frame => 2));
}

my $seq;
if ($#ARGV >= 2 and $ARGV[2] eq 'db') {
    $seq = get_seq_from_db($ARGV[0]);
} else {
    $seq = get_seq_from_file($ARGV[0]);
}

export_to_fasta($seq, ">$ARGV[1]");
print "Ok\n";
