#!/bin/perl

use strict;
use warnings;

use Bio::DB::GenPept;

print "TP Bioinformática - Ejercicio 4\n\n";
if ($#ARGV + 1 < 2) {
    print "Se requieren dos parámetros! El archivo de entrada y el patrón de búsqueda.\n";
    exit;
}

my $fileContent = do {
    local $/ = undef;
    open my $fh, "<", $ARGV[0]
        or die "Could not open $ARGV[0]: $!";
    <$fh>;
};

my $pattern = $ARGV[1];
my $patternRegex = qr/$pattern/;
my @matches = $fileContent =~ m/(>.*(?:\n.+)*${patternRegex}.*(?:\n.+)*)/g;

for my $i (0 .. $#matches) {
  my $n = $i + 1;
  print "===== Resultado $n ===== \n\n";
  print "$matches[$i]\n\n";
}

sub get_seq_from_db {
    my $db_obj = Bio::DB::GenPept->new;
    my $seq = $db_obj->get_Seq_by_acc($_[0]);
}

if ($#ARGV >= 2 and $#matches > 0)
{
  print "Bajando secuencias de aminoácidos y guardándolas en el archivo\n";
  my $seqio_obj = Bio::SeqIO->new(-file => ">$ARGV[2]", -format => 'fasta');
  foreach (@matches) {
    my $acc = ($_ =~ m/>([^ ]*) /g)[0];
    print ">$acc\n";
    my $seq = get_seq_from_db($acc);
    $seqio_obj->write_seq($seq);
  }
}
