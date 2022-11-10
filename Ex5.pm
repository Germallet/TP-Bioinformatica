#!/bin/perl

use strict;
use warnings;

use Bio::SeqIO;
use Bio::Factory::EMBOSS;
use Data::Dumper;

print "TP Bioinformática - Ejercicio 5\n\n";
if ($#ARGV + 1 != 3) {
    print "Se requieren tres parámetros! El archivo de entrada y el de salida.\n";
    exit;
}

my $factory = new Bio::Factory::EMBOSS;
$factory->program('transeq')->run({-sequence => $ARGV[0], -outseq => $ARGV[1], -frame => 6});
$factory->program('prosextract')->run({});
$factory->program('patmatmotifs')->run({-sequence => $ARGV[1], -outfile => $ARGV[2], -full => 'Y'});
