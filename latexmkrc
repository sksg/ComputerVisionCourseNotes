$pdflatex = 'lualatex --shell-escape';
if (-d "/compile/tex") {  # Overleaf
    ensure_path('TEXINPUTS', '/compile/tex//');
    ensure_path('TEXINPUTS', '/compile/graphics//');
    ensure_path('OPENTYPEFONTS', '/compile/tex//');
    ensure_path('TTFONTS', '/compile/tex//');
}
else {  # other
    ensure_path('TEXINPUTS', './tex//');
    ensure_path('TEXINPUTS', './graphics//');
    ensure_path('OPENTYPEFONTS', './tex//');
    ensure_path('TTFONTS', './tex//');
}
