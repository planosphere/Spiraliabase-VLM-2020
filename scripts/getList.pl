#!/usr/bin/perl
use strict;
use warnings;

my $in_tsv = shift;

if (!defined $in_tsv){
  die "Please provide a tsv file with the following format:
 Col 1 = citation id
 Col 2 = semi colon (;) separted list of terms in singular form

";
}

open TSV, $in_tsv or die "Can't open tsv:$in_tsv\n";

my %terms;
while (my $line = <TSV>){
  chomp $line;
  my ($citation_id,$terms) = split "\t", $line;
  my @terms = split /\s*;\s*/ , $terms;
  foreach my $term (@terms){
    $terms{$term}{$citation_id}++;
  }
}

foreach my $term (sort keys %terms){
  my @citations = sort {$a <=> $b} keys %{$terms{$term}};
  my $citations = join(",",@citations);
  print join("\t",$term,$citations),"\n";
}
