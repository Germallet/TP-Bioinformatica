#!/bin/perl

use strict;
use warnings;

use Bio::Tools::Run::RemoteBlast;
use Bio::Tools::Run::StandAloneBlastPlus;

print "TP Bioinformática - Ejercicio 2\n";
if ($#ARGV + 1 < 2) {
    print "Se requieren al menos dos parámetros! El archivo FASTA de entrada y el archivo de salida.\n";
    exit;
}

sub print_results {
  while (my $result = $_[0]->next_result) {
    print "\n\nQuery: ", $result->query_name(), "\n";
    while (my $hit = $result->next_hit) {
      print "\t", $hit->name, "; ", "Puntaje: ", $hit->score, "; ", $hit->description, "\n";
    }
  }
}

sub blast_remote {
  my $factory = Bio::Tools::Run::RemoteBlast->new('-prog' => 'blastp', '-data' => 'swissprot');
  my $str = Bio::SeqIO->new(-file => $ARGV[0], -format => 'fasta');
  my $r = $factory->submit_blast($ARGV[0]);

  while (my @request_ids = $factory->each_rid) {
    print STDERR join(" ", "\nPeticiones pendientes: ", @request_ids), "\n";

    foreach my $request_id (@request_ids) {
      my $rc = $factory->retrieve_blast($request_id);
      if (!ref($rc)) {
        if($rc < 0) {
          $factory->remove_rid($request_id);
        }
        print STDERR ".";
        sleep(1);
      } else {
        $factory->save_output($ARGV[1]);
        $factory->remove_rid($request_id);
        print_results $rc;
      }
    }    
  }

  return $factory;
}

sub blast_local {
  my $factory = Bio::Tools::Run::StandAloneBlastPlus->new(-db_name => $ARGV[2]);
  $factory->blastp(-query => $ARGV[0], -outfile => $ARGV[1]);
  print_results $factory;
}

if (defined $ARGV[2]) {
  blast_local($ARGV[2]);
} else {
  blast_remote();
}
