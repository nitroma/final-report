\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nitroma-report}[2020/01/27 LaTeX class for Nitroma reports]
\LoadClass[a4paper,12pt]{report}

\RequirePackage[margin=20mm]{geometry}
\RequirePackage{etoolbox}

%%% COLOURS
\RequirePackage[table,xcdraw]{xcolor}
\definecolor{color1}{HTML}{2D4F6C}
\definecolor{color2}{HTML}{8BDBDE}
\definecolor{red}{HTML}{EF476F}
\definecolor{green}{HTML}{06D6A0}
\definecolor{blue}{HTML}{0582CA}
\definecolor{yellow}{HTML}{FFD166}

%%% TITLEPAGE
\RequirePackage{tikz}
\newcommand{\gradientpagebackground}[1]{
    \begin{tikzpicture}[remember picture,overlay]
        \node [fill, rectangle, top color=#1, bottom color=white, shading angle=60, anchor=center, minimum width=\paperwidth, minimum height=\paperheight] (box) at (current page.center){};
    \end{tikzpicture}
}
\newcommand\subtitle[1]{\newcommand\@subtitle{#1}}
\renewcommand{\maketitle}{
    \thispagestyle{empty}
    % \geometry{margin=10mm} % doesn't work
    \gradientpagebackground{color2!50}
    \hfill
    \begin{minipage}[t][0.5\linewidth][c]{0.5\linewidth}
        \includegraphics[width=\linewidth]{brand/logo-tight.pdf}
    \end{minipage}
    \vfill\vfill
    \begin{minipage}{0.65\textwidth}
        \raggedright\headingfont\bfseries
        \color{color2}\large\MakeUppercase{\@subtitle}\\
        \color{color1}\huge\linespread{1.3}\@title\\[3ex]
        \mdseries\normalsize\@author\\[1ex]
        \small\@date\\
    \end{minipage}
    \vfill
    \clearpage
}

%%% FONTS
\RequirePackage{fontspec}
    \setmainfont{Fira Sans}
    \setmonofont{inconsolata}
\RequirePackage[usefilenames]{firamath-otf}
\RequirePackage{raleway}
\newcommand{\headingfont}{\ralewayextra}

%%% SECTION TITLE FORMAT
\RequirePackage{titlesec}
\newcommand{\standardchapterstyle}{
    \titleformat{\chapter}{\color{color1}\LARGE\bfseries\headingfont\scshape}{\thechapter}{1em}{}[\titlerule]
}
\newcommand{\fancychapterstyle}{
    \titleformat{\chapter}[display]
    % format for both label and text
    {\color{color1}\Huge\bfseries\headingfont\scshape\raggedleft}
    % label
    {
        \gradientpagebackground{color2!30}
        \color{color2}\fontsize{144pt}{144pt}\selectfont
        \begin{minipage}[b][\fontcharht\font`X][c]{\fontcharht\font`X}
            \hfill\includegraphics[height=0.5ex]{brand/icon.pdf}
        \end{minipage}\hspace{0.1em}
        \thechapter
    }
    {0pt}
    % code before title
    {
        % \parbox{0.75\linewidth} % doesn't work with \raggedleft
    }
    % code after text
    [\newpage]
}
\standardchapterstyle
\titleformat{\section}{\color{color1}\Large\bfseries\headingfont}{\thesection}{1em}{}[\titlerule]
\titleformat{\subsection}{\color{color1}\large\bfseries\headingfont}{\thesubsection}{1em}{}
\titleformat{\subsubsection}{\color{color1}\bfseries\headingfont}{\thesubsubsection}{1em}{}
% original spacing values can be found here https://tex.stackexchange.com/a/48754/135479
% \titlespacing*{\section}{0pt}{*1}{*1}
% \titlespacing*{\subsection}{0pt}{2pt plus 4pt}{*0}
% \titlespacing*{\subsubsection}{0pt}{2pt plus 2pt}{*0}
% \titlespacing*{\paragraph} {0pt}{2pt plus 1pt minus 1pt}{1em}

    \clearpage
}
