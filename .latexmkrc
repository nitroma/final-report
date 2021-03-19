$pdf_mode = 5;
$dvi_mode = $postscript_mode = 0;
$force_mode = 1;
$silent = 1;
$xelatex_silent_switch = "-interaction=nonstopmode";
$xelatex = "xelatex --shell-escape %O %S";

# Custom dependency and function for nomencl package
add_cus_dep( 'nlo', 'nls', 0, 'makenlo2nls' );
sub makenlo2nls {
    system( "makeindex -s nomencl.ist -o \"$_[0].nls\" \"$_[0].nlo\"" );
}
