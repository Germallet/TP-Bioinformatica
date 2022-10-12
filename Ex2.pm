#!/bin/perl

use strict;
use warnings;

use Bio::Tools::Run::RemoteBlast;

print "TP Bioinformática - Ejercicio 2\n";
if ($#ARGV + 1 != 2) {
    print "Se requieren dos parámetros! El archivo de secuencias de entrada y el arhivo FASTA de salida.\n";
    exit;
}

my $factory = Bio::Tools::Run::RemoteBlast->new('-prog' => 'blastp', '-data' => 'swissprot');
my $str = Bio::SeqIO->new(-file=> $ARGV[0], -format => 'fasta');

# Seguir https://metacpan.org/pod/Bio::Tools::Run::RemoteBlast

my $v = 1;
while (my $input = $str->next_seq()){
  #Blast a sequence against a database:
 
  #Alternatively, you could  pass in a file with many
  #sequences rather than loop through sequence one at a time
  #Remove the loop starting 'while (my $input = $str->next_seq())'
  #and swap the two lines below for an example of that.
  my $r = $factory->submit_blast($input);
  #my $r = $factory->submit_blast('amino.fa');
 
  print STDERR "waiting..." if( $v > 0 );
  while ( my @rids = $factory->each_rid ) {
    foreach my $rid ( @rids ) {
      my $rc = $factory->retrieve_blast($rid);
      if( !ref($rc) ) {
        if( $rc < 0 ) {
          $factory->remove_rid($rid);
        }
        print STDERR "." if ( $v > 0 );
        sleep 5;
      } else {
        my $result = $rc->next_result();
        #save the output
        my $filename = $result->query_name()."\.out";
        $factory->save_output($filename);
        $factory->remove_rid($rid);
        print "\nQuery Name: ", $result->query_name(), "\n";
        while ( my $hit = $result->next_hit ) {
          next unless ( $v > 0);
          print "\thit name is ", $hit->name, "\n";
          while( my $hsp = $hit->next_hsp ) {
            print "\t\tscore is ", $hsp->score, "\n";
          }
        }
      }
    }
  }
}
