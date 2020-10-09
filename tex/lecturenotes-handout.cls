\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lecturenotes-handout}[2020/06/01 Computer Vision Lecture Notes LaTeX class]

\LoadClass{article}
\RequirePackage{lecturenotes-common}
\PassOptionsToPackage{noabbrev}{cleveref}
\RequirePackage{xstring,microtype,hyperref,cleveref}
\RequirePackage{lecturenotes-oneandhalfcolumn}

\hypersetup{
  breaklinks=true,
  colorlinks,
  unicode,
  pdfdisplaydoctitle,
  bookmarksdepth=section,
  linkcolor={red!50!black},
  citecolor={blue!50!black},
  urlcolor={blue!80!black}
}

\RequirePackage{tuftelike-lengths}

\newlength{\@ln@overhang}% used by the fullwidth environment and the running heads
\newlength{\@ln@fullwidth}
\newlength{\@ln@caption@fill}

\newcommand{\@ln@recalculate@lengths}{%
  \setlength{\@ln@overhang}{\marginparwidth}
  \addtolength{\@ln@overhang}{\marginparsep}

  \setlength{\@ln@fullwidth}{\textwidth}
  \addtolength{\@ln@fullwidth}{\marginparsep}
  \addtolength{\@ln@fullwidth}{\marginparwidth}

  \setlength{\@ln@caption@fill}{\textwidth}
  \addtolength{\@ln@caption@fill}{\marginparsep}
}

\AtBeginDocument{\@ln@recalculate@lengths}

\newenvironment{fullwidth}{\begin{adjustwidth}{}{-\@ln@overhang}}{\end{adjustwidth}}

\RenewDocumentCommand{\maketitle}{}{%
  \newpage\
  \global\@topnum\z@% prevent floats from being placed at the top of the page
  \begin{fullwidth}
  \begingroup%
    \setlength{\parindent}{0pt}%
    \setlength{\parskip}{4pt}%
    \gdef\@@title{\normalfont\huge\@title\vspace{0.25\baselineskip}\par}%
    \gdef\@@author{\normalfont\Large\@author\par}%
    \gdef\@@date{\normalfont\Large\@date\par}%
    \@@title
    \@@author
    \@@date
  \endgroup%
  \end{fullwidth}
  \thispagestyle{plain}% suppress the running head
  \par%
  \ifdim\lastskip<\@ln@skipamount%
  \removelastskip\penalty-100\@ln@skip\fi% add some space before the text begins
  \@afterindentfalse\@afterheading% suppress indentation of the next paragraph
}
\newskip\@ln@skipamount
\@ln@skipamount=1.0\baselineskip plus 0.5ex minus 0.2ex
\NewDocumentCommand{\@ln@skip}{}{\vspace\@ln@skipamount}


\RequirePackage{titlesec,titletoc}

\setcounter{secnumdepth}{2}

\titleformat{\chapter}%
  [display]% shape
  {\normalfont\itshape\huge}% format applied to label+text
  {\thechapter\quad}% label
  {2pt}% horizontal separation between label and title body
  {}% before the title body
  []% after the title body

\titleformat{\section}%
  [hang]% shape
  {\normalfont\Large\itshape}% format applied to label+text
  {\thesection\quad}% label
  {2pt}% horizontal separation between label and title body
  {}% before the title body
  []% after the title body

\titleformat{\subsection}%
  [hang]% shape
  {\normalfont\large\itshape}% format applied to label+text
  {\thesubsection\quad}% label
  {2pt}% horizontal separation between label and title body
  {}% before the title body
  []% after the title body

\titleformat{\paragraph}%
  [runin]% shape
  {\normalfont\itshape}% format applied to label+text
  {\theparagraph}% label
  {1em}% horizontal separation between label and title body
  {}% before the title body
  []% after the title body

\titlespacing*{\chapter}{0pt}{50pt}{40pt}
\titlespacing*{\section}{0pt}{3.5ex plus 1ex minus .2ex}{2.3ex plus .2ex}
\titlespacing*{\subsection}{0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus.2ex}

% Subsubsection and following section headings shouldn't be used.
% See Bringhurst's _The Elements of Typography_, section 4.2.2.
\RenewDocumentCommand\subsubsection{}{%
  \@ln@error{\string\subsubsection is undefined by this class.
    See Robert Bringhurst's _The Elements of
    Typographic Style_, section 4.2.2.
    \string\subsubsection was used}
    {From Bringhurst's _The Elements of Typographic Style_, section 4.2.2: Use as
    many levels of headings as you need, no more and no fewer. Also see the many
    related threads on Ask E.T. at http://www.edwardtufte.com/.}
}

\RenewDocumentCommand\subparagraph{}{%
  \@ln@error{\string\subparagraph is undefined by this class.%
    See Robert Bringhurst's _The Elements of
    Typographic Style_, section 4.2.2.
    \string\subparagraph was used}
    {From Bringhurst's _The Elements of Typographic Style_, section 4.2.2: Use as
    many levels of headings as you need, no more and no fewer.  Also see the many
    related threads on Ask E.T. at http://www.edwardtufte.com/.}
}


% Formatting for main TOC (printed in front matter)
\titlecontents{part}
  [0em] % distance from left margin
  {\vspace{1.5\baselineskip}\normalfont\itshape\LARGE} % above (global formatting of entry)
  {\contentslabel{2em}} % before w/label (label = ``II'')
  {} % before w/o label
  {\normalfont\qquad\thecontentspage} % filler + page (leaders and page num)
  [] % after

\titlecontents{chapter}%
  [0em] % distance from left margin
  {\vspace{1.5\baselineskip}\normalfont\itshape\LARGE} % above (global formatting of entry)
  {\contentslabel{2em}} % before w/label (label = ``2'')
  {} % before w/o label
  {\normalfont\qquad\thecontentspage} % filler + page (leaders and page num)
  [] % after

\titlecontents{section}
  [0em] % distance from left margin
  {\normalfont\itshape\Large} % above (global formatting of entry)
  {\hspace*{2em}\contentslabel{2em}} % before w/label (label = ``2.6'')
  {\hspace*{2em}} % before w/o label
  {\normalfont\qquad\thecontentspage} % filler + page (leaders and page num)
  [] % after

\titlecontents{subsection}
  [0em] % distance from left margin
  {\normalfont\itshape\large} % above (global formatting of entry)
  {\hspace*{4em}\contentslabel{4em}} % before w/label (label = ``2.6.1'')
  {\hspace*{4em}} % before w/o label
  {\normalfont\qquad\thecontentspage} % filler + page (leaders and page num)
  [] % after

\titlecontents{paragraph}
  [0em] % distance from left margin
  {\normalfont\itshape} % above (global formatting of entry)
  {\hspace*{6em}\contentslabel{2em}} % before w/label (label = ``2.6.0.0.1'')
  {\hspace*{6em}} % before w/o label
  {\normalfont\qquad\thecontentspage} % filler + page (leaders and page num)
  [] % after
