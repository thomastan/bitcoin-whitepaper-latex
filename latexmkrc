# This PERL file instructs LaTeX where to look for files
#  e.g.  for \usepackage{something}  where to find the something.sty file

$font_dir = './fonts/MouseMemoirs-pdflatex//';

# for .tex, .sty, .eps, and .pdf files
ensure_path('TEXINPUTS', $font_dir);

# for the MouseMemoirs.map file
ensure_path('TEXFONTMAPS', $font_dir);

# for the .tfm, .vf, and .enc font metrics
ensure_path('TFMFONTS', $font_dir);
ensure_path('VFFONTS',  $font_dir);
ensure_path('ENCFONTS', $font_dir);

# for .ttf
ensure_path('TTFONTS', $font_dir);

# not using .otf files, so no 'OPENTYPEFONTS'
