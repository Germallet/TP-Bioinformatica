#!/bin/perl

use strict;
use warnings;

use Bio::Seq;
use Bio::DB::GenBank;
use Bio::SeqIO;

print "TP Bioinformática - Ejercicio 1\n";

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
    $seqio_obj->write_seq($_[0]);
}

# $seq = get_seq_from_db('NM_000441')->seq;
my $seq = get_seq_from_file('NM_000441.gb');

export_to_fasta($seq, '>NM_000441.fas')
