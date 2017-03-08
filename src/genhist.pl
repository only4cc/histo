# genhist.pl

use strict;
use warnings;
use Template;

my $titulo     = shift || "Titulo de la Cancion";
my $col_data   = shift || "Clase, Valor";
my $datafile   = shift;

if ( ! $datafile ) {
    die "\n$0: TITULO NOMBRE_BUCKET VALOR ARCHIVO_DATOS";
}

# Formatea Etiquetas
my @cols = map("'".$_."'", split(/\,/,$col_data) );
my $coldata = '['. join(",", @cols) .']';


# Formatea datos
my $datos;
my $line;
my @r;
open( F, $datafile ) or die "$!\nNo se pudo leer $datafile";
while ( $line = <F> ) {
        chomp($line);
	@r = split ( /\,/, $line );
	$datos .= '['.$r[0].', '.$r[1].'],'."\n";
}
close( F );

# Genera el HTML a partir del llenado del template
my $file = '../tmpl/gc_histo.tmpl';
my $data = {
   titulo   => $titulo,
   col_data => $coldata,
   data     => $datos
};
 
my $template = Template->new({
    RELATIVE => 1,
});
 
$template->process($file, $data)
    or die "Template process failed: ", $template->error(), "\n";

