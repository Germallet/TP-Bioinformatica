#!/bin/perl

use strict;
use warnings;

print "TP Bioinformática - Ejercicio 4\n\n";
if ($#ARGV + 1 != 2) {
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
