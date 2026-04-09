This directory contains "system" fonts in TTF/OTF file format.

TTF/OTF FONTS CAN BE USED IN XeLaTeX and LuaLaTeX ONLY!! (no pdflatex)

To compile in pdflatex, I had to convert Mouse Memoirs from TTF into a GROUP of LaTeX-style fonts:

1) On http://colab.google.com:
    import math
    
    # 1. SET YOUR ANGLE HERE
    angle = 9.4
    
    # 2. Mathematical calculations
    skew = round(math.tan(math.radians(angle)), 4)
    zip_name = f"mouse_memoirs_{angle}.zip"
    
    print(f"Angle: {angle}° | Calculated Skew: {skew} | Output: {zip_name}")
    
    # 3. RUN GENERATION
    # Cleanup: Delete all TTFs EXCEPT the original source
    !find . -maxdepth 1 -name "*.ttf" ! -name "MouseMemoirs-Regular.ttf" -delete
    !rm -f *.tfm *.vf *.map *.enc *.fd *.zip
    
    # FontForge Transformation
    !fontforge -lang=py -c 'import fontforge; font = fontforge.open("MouseMemoirs-Regular.ttf"); font.selection.all(); font.transform((1, 0, {skew}, 1, 0, 0)); font.fontname = "MouseMemoirsSlanted"; font.fullname = "MouseMemoirs Slanted"; font.familyname = "MouseMemoirsSlanted"; font.italicangle = -{angle}; font.generate("MouseMemoirs-Slanted.ttf")'
    
    # Metric Generation
    !otftotfm --encoding=ec --tfm-directory=. --vf-directory=. --map-file=MouseMemoirs.map --encoding-directory=. --no-updmap MouseMemoirs-Regular.ttf MouseMemoirs-Regular-T1
    !otftotfm --encoding=ec --tfm-directory=. --vf-directory=. --map-file=MouseMemoirs.map --encoding-directory=. --no-updmap MouseMemoirs-Slanted.ttf MouseMemoirs-Slanted-T1
    
    # Create .fd file
    with open("T1MouseMemoirs-TLF.fd", "w") as f:
        f.write(r"""\DeclareFontFamily{T1}{MouseMemoirs-TLF}{}
    \DeclareFontShape{T1}{MouseMemoirs-TLF}{m}{n}{ <-> MouseMemoirs-Regular-T1 }{}
    \DeclareFontShape{T1}{MouseMemoirs-TLF}{m}{sl}{ <-> MouseMemoirs-Slanted-T1 }{}
    \DeclareFontShape{T1}{MouseMemoirs-TLF}{m}{it}{ <-> ssub * MouseMemoirs-TLF/m/sl }{}
    """)
    
    # Package results
    !zip {zip_name} *.tfm *.vf *.map *.enc *.fd *.ttf


2) Then take all the files and upload to fonts/MouseMemoirs-pdflatex/

3) Add a latexmkrc file in the ROOT directory (no extension and **NOT** in the src/ dir!):
  
    $font_dir = './fonts/MouseMemoirs-pdflatex//';
    ensure_path('TEXINPUTS', $font_dir);
    ensure_path('TEXFONTMAPS', $font_dir);
    ensure_path('TFMFONTS', $font_dir);
    ensure_path('VFFONTS',  $font_dir);
    ensure_path('ENCFONTS', $font_dir);
    ensure_path('TTFONTS', $font_dir);
