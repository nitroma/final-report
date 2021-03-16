\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nitroma-report}[2020/01/27 LaTeX class for Nitroma reports]
\LoadClass[a4paper,12pt]{report}

\RequirePackage[margin=20mm]{geometry}
\RequirePackage{etoolbox}

%%% COLOURS
\RequirePackage[table]{xcolor}
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
    \currentpdfbookmark{\@title}{titlepage}
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
% \RequirePackage{fontspec} % this method works everywhere except GH Actions...
%     \setmainfont{Fira Sans}
%     \setmonofont{inconsolata}
\RequirePackage[default,lining]{FiraSans}
    \renewcommand{\rmdefault}{\firafamily} % force "roman" (serif) text to use Fira Sans too
\RequirePackage{FiraMono}
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
 \titlespacing*{\section}{0pt}{*1}{*1}
 \titlespacing*{\subsection}{0pt}{2pt plus 4pt}{*0}
\titlespacing*{\subsubsection}{0pt}{2pt plus 2pt}{*0}
\titlespacing*{\paragraph} {0pt}{2pt plus 1pt minus 1pt}{1em}
\setcounter{secnumdepth}{3}

%%% NUMBERING & CONTENTS
\RequirePackage[hidelinks,pdfusetitle]{hyperref}
\RequirePackage[numbered]{bookmark}
\RequirePackage{chngcntr}
\setcounter{tocdepth}{1}
\RequirePackage{etoc}
%% page numbering: front & main content
\newcommand\frontmatter{
    \renewcommand\thepage{\roman{page}}
}
\newcommand\mainmatter{
    \clearpage
    % option 1: go back to simple single-digit page numbers
    % \setcounter{page}{1}
    % \renewcommand\thepage{\arabic{page}}
    % option 2: number pages within chapters like 2.1
    \counterwithin{page}{chapter}
    % now do fancy chapter pages
    \fancychapterstyle
    % switch toc display
    \etocsettocstyle{\section*{\contentsname{}}}{}
    \setcounter{tocdepth}{3}
}
\AtBeginEnvironment{appendices}{\clearpage}
\AtEndEnvironment{appendices}{\clearpage}
%% float numbering: chapters
\newcommand\counterallwithin[1]{
    \counterwithin{figure}{#1}
    \counterwithin{table}{#1}
    \counterwithin{equation}{#1}
    \counterwithin{scheme}{#1}
}
\newcommand\counterallwithout[1]{
    \counterwithout{figure}{#1}
    \counterwithout{table}{#1}
    \counterwithout{equation}{#1}
    \counterwithout{scheme}{#1}
}
\AtBeginDocument{\counterallwithin{chapter}}
%% float numbering: appendices
\RequirePackage[titletoc]{appendix}
\AtBeginEnvironment{subappendices}{
    \clearpage % flushes waiting floats out
    \counterallwithin{section}
    \crefalias{section}{appendix}
}
\AtEndEnvironment{subappendices}{
    \counterallwithout{section} 
    \counterallwithin{chapter}
}

%%% REFERENCING
\RequirePackage[capitalise,noabbrev,nameinlink]{cleveref}   % clever cross-referencing
\RequirePackage[style=chem-angew,maxnames=3]{biblatex} % references
    \renewcommand*{\bibfont}{%
        % \fontsize{6pt}{7pt}\selectfont
        % \small
    }
    \AtBeginBibliography{
        \setlength{\itemsep}{0em}
        \setlength{\parskip}{0em}
    }

%%% FLOATS
\RequirePackage[font={small,singlespacing},labelfont={bf},skip=2pt]{caption}
% command to remove erroneous extra vertical spacing before lists inside tabular environments - https://tex.stackexchange.com/a/6454/135479
\newcommand*{\compress}{\@minipagetrue}
% set up method to detect tabular environments automatically - https://tex.stackexchange.com/a/557166/135479
\usepackage{expl3}
\ExplSyntaxOn
\bool_new:N \l_clement_if_in_table_bool% a boolean for table manners
\newcommand\IfInTableTF[2]
{
  \str_case:onF { \@currenvir }% check current environment
  {
      {array}     { \bool_set_true:N \l_clement_if_in_table_bool  }
      {tabular}   { \bool_set_true:N \l_clement_if_in_table_bool  }
      {tabularx}  { \bool_set_true:N \l_clement_if_in_table_bool  }
      {longtable} { \bool_set_true:N \l_clement_if_in_table_bool  }
  }{               \bool_set_false:N \l_clement_if_in_table_bool }
  \bool_if:NTF \l_clement_if_in_table_bool {#1} {#2}
}
\ExplSyntaxOff
% now apply spacing removal automatically
\BeforeBeginEnvironment{itemize}{\IfInTableTF{\compress}{}}
\BeforeBeginEnvironment{enumerate}{\IfInTableTF{\compress}{}}
% make tables small text
\newcommand\tabletextformat{\footnotesize}
\AtBeginEnvironment{tabular}{\tabletextformat}
\AtBeginEnvironment{tabularx}{\tabletextformat}
\AtBeginEnvironment{longtable}{\tabletextformat}
