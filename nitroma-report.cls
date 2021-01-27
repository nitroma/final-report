\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nitroma-report}[2020/01/27 LaTeX class for Nitroma reports]
\LoadClass[a4paper]{report}

\RequirePackage[margin=20mm]{geometry}

%%% COLOURS
\RequirePackage{xcolor}
\definecolor{color1}{HTML}{2D4F6C}
\definecolor{color2}{HTML}{8BDBDE}
\definecolor{red}{HTML}{EF476F}
\definecolor{green}{HTML}{06D6A0}
\definecolor{blue}{HTML}{0582CA}
\definecolor{yellow}{HTML}{FFD166}

%%% FONTS
\RequirePackage{fontspec}
    \setmainfont{Fira Sans}
    \setmonofont{inconsolata}
\RequirePackage[usefilenames]{firamath-otf}

%%% SECTION TITLE FORMAT
\RequirePackage{titlesec}
\titleformat{\chapter}{\LARGE\bfseries\scshape\color{color1}}{\thechapter}{1em}{}[\titlerule]
\titleformat{\section}{\color{color1}\Large\bfseries}{\thesection}{1em}{}[\titlerule]
\titleformat{\subsection}{\color{color1}\large\bfseries}{\thesubsection}{1em}{}
\titleformat{\subsubsection}{\color{color1}\bfseries}{\thesubsubsection}{1em}{}

%%% TITLEPAGE
\makeatletter
\renewcommand{\maketitle}{
    \thispagestyle{empty}
    \hfill
    \includegraphics[width=0.7\linewidth]{brand/logo}
    \vfill
    \begin{minipage}{0.65\textwidth}
        \raggedright
        \color{color1}\huge\linespread{1.3}\textbf{\@title}\\[1ex]
        \color{color2}\normalsize\@author\\[1ex]
        \color{color2}\small\@date\\
    \end{minipage}\hfill
    \vfill
    \clearpage
}
\makeatother
