\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{CVCN-handout}[2020/06/01 Computer Vision Course Notes LaTeX class]

\RequirePackage{luacode}
\begin{luacode*}
  function PrintOutputArgs()
    if arguments then
      texio.write_nl("The following options were passed:")
      for k, v in pairs(arguments) do
        arg = " --" .. k
        if v ~= nil and v ~= "" then
          arg = arg .. "=" .. v
        end
        texio.write_nl(arg) tex.print(arg)
      end
    else
      texio.write_nl("No options were passed!")
    end
  end
\end{luacode*}

\RequirePackage[build={latexoptions={\directlua{PrintOutputArgs()}}}]{standalone}

\LoadClass{article}

\RequirePackage{CVCN-common}

\RequirePackage{titlesec,titletoc}

\PassOptionsToPackage{noabbrev}{cleveref}
\RequirePackage{xstring,xifthen,microtype,hyperref,ifdraft,refcount,cleveref,lecturenotes-oneandhalfcolumn}

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

\renewcommand\normalsize{%
   \@setfontsize\normalsize\@xpt{14}%
   \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\normalbaselineskip=14pt
\normalsize
\renewcommand\small{%
   \@setfontsize\small\@ixpt{12}%
   \abovedisplayskip 8.5\p@ \@plus3\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus2\p@
   \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 4\p@ \@plus2\p@ \@minus2\p@
               \parsep 2\p@ \@plus\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\renewcommand\footnotesize{%
   \@setfontsize\footnotesize\@viiipt{10}%
   \abovedisplayskip 6\p@ \@plus2\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus\p@
   \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 3\p@ \@plus\p@ \@minus\p@
               \parsep 2\p@ \@plus\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\renewcommand\scriptsize{\@setfontsize\scriptsize\@viipt\@viiipt}
\renewcommand\tiny{\@setfontsize\tiny\@vpt\@vipt}
\renewcommand\large{\@setfontsize\large\@xipt{15}}
\renewcommand\Large{\@setfontsize\Large\@xiipt{16}}
\renewcommand\LARGE{\@setfontsize\LARGE\@xivpt{18}}
\renewcommand\huge{\@setfontsize\huge\@xxpt{30}}
\renewcommand\Huge{\@setfontsize\Huge{24}{36}}

\setlength\leftmargini   {1pc}
\setlength\leftmarginii  {1pc}
\setlength\leftmarginiii {1pc}
\setlength\leftmarginiv  {1pc}
\setlength\leftmarginv   {1pc}
\setlength\leftmarginvi  {1pc}
\setlength\labelsep      {.5pc}
\setlength\labelwidth    {\leftmargini}
\addtolength\labelwidth{-\labelsep}

\setlength{\parindent}{1.0pc}
\setlength{\parskip}{0pt}

\setlength\abovedisplayskip{6pt plus 2pt minus 4pt}
\setlength\belowdisplayskip{6pt plus 2pt minus 4pt}

\setlength\marginparpush{10pt}

\newlength{\@tufte@overhang}% used by the fullwidth environment and the running heads
\newlength{\@tufte@fullwidth}
\newlength{\@tufte@caption@fill}

\newcommand{\TufteRecalculate}{%
  \setlength{\@tufte@overhang}{\marginparwidth}
  \addtolength{\@tufte@overhang}{\marginparsep}

  \setlength{\@tufte@fullwidth}{\textwidth}
  \addtolength{\@tufte@fullwidth}{\marginparsep}
  \addtolength{\@tufte@fullwidth}{\marginparwidth}

  \setlength{\@tufte@caption@fill}{\textwidth}
  \addtolength{\@tufte@caption@fill}{\marginparsep}
}

\AtBeginDocument{\TufteRecalculate}


\newenvironment{fullwidth}{\begin{adjustwidth}{}{-\@tufte@overhang}}{\end{adjustwidth}}

\setcounter{secnumdepth}{2}


%%
% Modified \title, \author, and \date commands.  These store the
% (footnote-less) values in \plaintitle, \plainauthor, and \thedate, respectively.

\newcommand{\plaintitle}{}%     plain-text-only title
\newcommand{\plainauthor}{}%    plain-text-only author
\newcommand{\plainpublisher}{}% plain-text-only publisher

\newcommand{\thanklesstitle}{}%     full title text minus \thanks{}
\newcommand{\thanklessauthor}{}%    full author text minus \thanks{}
\newcommand{\thanklesspublisher}{}% full publisher minus \thanks{}

\newcommand{\@publisher}{}% full publisher with \thanks{}
\newcommand{\thedate}{\today}

% TODO Fix it so that \thanks is not spaced out (with `soul') and can be
% used in \maketitle when the `sfsidenotes' option is provided.
\renewcommand{\thanks}[1]{\NoCaseChange{\footnote{#1}}}

\renewcommand{\title}[2][]{%
  \gdef\@title{#2}%
  \begingroup%
    % TODO store contents of \thanks command
    \renewcommand{\thanks}[1]{}% swallow \thanks contents
    \protected@xdef\thanklesstitle{#2}%
  \endgroup%
  \ifthenelse{\isempty{#1}}%
    {\renewcommand{\plaintitle}{\thanklesstitle}}% use thankless title
    {\renewcommand{\plaintitle}{#1}}% use provided plain-text title
  \ifthenelse{\isundefined{\hypersetup}}%
    {}% hyperref is not loaded; do nothing
    {\hypersetup{pdftitle={\plaintitle}}}% set the PDF metadata title
}

\let\@author\@empty% suppress default latex.ltx ``no author'' warning
\renewcommand{\author}[2][]{%
  \ifthenelse{\isempty{#2}}{}{\gdef\@author{#2}}%
  \begingroup%
    % TODO store contents of \thanks command
    \renewcommand{\thanks}[1]{}% swallow \thanks contents
    \protected@xdef\thanklessauthor{#2}%
  \endgroup%
  \ifthenelse{\isempty{#1}}%
    {\renewcommand{\plainauthor}{\thanklessauthor}}% use thankless author
    {\renewcommand{\plainauthor}{#1}}% use provided plain-text author
  \ifthenelse{\isundefined{\hypersetup}}%
    {}% hyperref is not loaded; do nothing
    {\hypersetup{pdfauthor={\plainauthor}}}% set the PDF metadata author
}

\renewcommand{\date}[1]{%
  \gdef\@date{#1}%
  \begingroup%
    % TODO store contents of \thanks command
    \renewcommand{\thanks}[1]{}% swallow \thanks contents
    \protected@xdef\thedate{#1}%
  \endgroup%
}

%%
% Provides a \publisher command to set the publisher

\newcommand{\publisher}[2][]{%
  \gdef\@publisher{#2}%
  \begingroup%
    \renewcommand{\thanks}[1]{}% swallow \thanks contents
    \protected@xdef\thanklesspublisher{#2}%
  \endgroup%
  \ifthenelse{\isempty{#1}}
    {\renewcommand{\plainpublisher}{\thanklesspublisher}}% use thankless publisher
    {\renewcommand{\plainpublisher}{#1}}% use provided plain-text publisher
}

\renewcommand*\descriptionlabel[1]{\hspace\labelsep\normalfont\em #1}

\newskip\tufteskipamount
\tufteskipamount=1.0\baselineskip plus 0.5ex minus 0.2ex
\newcommand{\tufteskip}{\vspace\tufteskipamount}

\renewcommand{\maketitle}{%
  \newpage\
  \global\@topnum\z@% prevent floats from being placed at the top of the page
  \begin{fullwidth}
  \begingroup
    \setlength{\parindent}{0pt}%
    \setlength{\parskip}{4pt}%
    \let\@@title\@empty
    \let\@@author\@empty
    \let\@@date\@empty
    \gdef\@@title{\normalfont\huge\@title\vspace{0.25\baselineskip}\par}%
    \gdef\@@author{\normalfont\Large\@author\par}%
    \gdef\@@date{\normalfont\Large\@date\par}%
    \@@title
    \@@author
    \@@date
  \endgroup
  \end{fullwidth}
  \thispagestyle{plain}% suppress the running head
  \par\ifdim\lastskip<\tufteskipamount
  \removelastskip\penalty-100\tufteskip\fi% add some space before the text begins
  \@afterindentfalse\@afterheading% suppress indentation of the next paragraph
}


\titleformat{\chapter}%
  [display]% shape
  {\relax\ifthenelse{\NOT\boolean{@tufte@symmetric}}{\begin{fullwidth}}{}}% format applied to label+text
  {{\itshape\huge\thechapter\quad}}% label
  {2pt}% horizontal separation between label and title body
  {\huge\rmfamily\itshape}% before the title body
  [\ifthenelse{\NOT\boolean{@tufte@symmetric}}{\end{fullwidth}}{}]% after the title body

\titleformat{\section}%
  [hang]% shape
  {\normalfont\Large\itshape}% format applied to label+text
  {{\thesection\quad}}% label
  {2pt}% horizontal separation between label and title body
  {}% before the title body
  []% after the title body

\titleformat{\subsection}%
  [hang]% shape
  {\normalfont\large\itshape}% format applied to label+text
  {{\thesubsection\quad}}% label
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
\renewcommand\subsubsection{%
  \@tufte@error{\string\subsubsection is undefined by this class.
    See Robert Bringhurst's _The Elements of
    Typographic Style_, section 4.2.2.
    \string\subsubsection was used}
    {From Bringhurst's _The Elements of Typographic Style_, section 4.2.2: Use as
    many levels of headings as you need, no more and no fewer.  Also see the many
    related threads on Ask E.T. at http://www.edwardtufte.com/.}
}

\renewcommand\subparagraph{%
  \@tufte@error{\string\subparagraph is undefined by this class.%
    See Robert Bringhurst's _The Elements of
    Typographic Style_, section 4.2.2.
    \string\subparagraph was used}
    {From Bringhurst's _The Elements of Typographic Style_, section 4.2.2: Use as
    many levels of headings as you need, no more and no fewer.  Also see the many
    related threads on Ask E.T. at http://www.edwardtufte.com/.}
}


% Formatting for main TOC (printed in front matter)
% {section} [left] {above} {before w/label} {before w/o label} {filler + page} [after]
  \titlecontents{part}% FIXME
    [0em] % distance from left margin
    {\vspace{1.5\baselineskip}\begin{fullwidth}\LARGE\rmfamily\itshape} % above (global formatting of entry)
    {\contentslabel{2em}} % before w/label (label = ``II'')
    {} % before w/o label
    {\rmfamily\upshape\qquad\thecontentspage} % filler + page (leaders and page num)
    [\end{fullwidth}] % after
  \titlecontents{chapter}%
    [0em] % distance from left margin
    {\vspace{1.5\baselineskip}\begin{fullwidth}\LARGE\rmfamily\itshape} % above (global formatting of entry)
    {\hspace*{0em}\contentslabel{2em}} % before w/label (label = ``2'')
    {\hspace*{0em}} % before w/o label
    {\rmfamily\upshape\qquad\thecontentspage} % filler + page (leaders and page num)
    [\end{fullwidth}] % after
  \titlecontents{section}% FIXME
    [0em] % distance from left margin
    {\vspace{0\baselineskip}\begin{fullwidth}\Large\rmfamily\itshape} % above (global formatting of entry)
    {\hspace*{2em}\contentslabel{2em}} % before w/label (label = ``2.6'')
    {\hspace*{2em}} % before w/o label
    {\rmfamily\upshape\qquad\thecontentspage} % filler + page (leaders and page num)
    [\end{fullwidth}] % after
  \titlecontents{subsection}% FIXME
    [0em] % distance from left margin
    {\vspace{0\baselineskip}\begin{fullwidth}\large\rmfamily\itshape} % above (global formatting of entry)
    {\hspace*{4em}\contentslabel{4em}} % before w/label (label = ``2.6.1'')
    {\hspace*{4em}} % before w/o label
    {\rmfamily\upshape\qquad\thecontentspage} % filler + page (leaders and page num)
    [\end{fullwidth}] % after
  \titlecontents{paragraph}% FIXME
    [0em] % distance from left margin
    {\vspace{0\baselineskip}\begin{fullwidth}\normalsize\rmfamily\itshape} % above (global formatting of entry)
    {\hspace*{6em}\contentslabel{2em}} % before w/label (label = ``2.6.0.0.1'')
    {\hspace*{6em}} % before w/o label
    {\rmfamily\upshape\qquad\thecontentspage} % filler + page (leaders and page num)
    [\end{fullwidth}] % after

%%
% Format lists of figures/tables

\renewcommand\listoffigures{%
  \ifthenelse{\equal{\@tufte@class}{book}}%
    {\chapter*{\listfigurename}}%
    {\section*{\listfigurename}}%
%  \begin{fullwidth}%
    \@starttoc{lof}%
%  \end{fullwidth}%
}

\renewcommand\listoftables{%
  \ifthenelse{\equal{\@tufte@class}{book}}%
    {\chapter*{\listtablename}}%
    {\section*{\listtablename}}%
%  \begin{fullwidth}%
    \@starttoc{lot}%
%  \end{fullwidth}%
}

\newcommand{\@tufte@lof@line}[2]{%
  % #1 is the figure/table number and its caption text
  % #2 is the page number on which the figure/table appears
  \leftskip 0.0em
  \rightskip 0em
  \parfillskip 0em plus 1fil
  \parindent 0.0em
  \@afterindenttrue
  \interlinepenalty\@M
  \leavevmode
  \@tempdima 2.0em
  \advance\leftskip\@tempdima
  \null\nobreak\hskip -\leftskip
  {#1}\nobreak\qquad\nobreak#2%
  \par%
}

\renewcommand*\l@figure{\@tufte@lof@line}
\let\l@table\l@figure


%%
% A handy command to disable hyphenation for short bits of text.
% Borrowed from Peter Wilson's `hyphenat' package.

\AtBeginDocument{%
  \@ifpackageloaded{hyphenat}{}{%
    \newlanguage\langwohyphens% define a language without hyphenation rules
    \providecommand{\nohyphens}[1]{{\language\langwohyphens #1}}% used for short bits of text
    \providecommand{\nohyphenation}{\language\langwohyphens}% can be used inside environments for longer text
  }%
}


\RequirePackage{CVCN-boxes}
