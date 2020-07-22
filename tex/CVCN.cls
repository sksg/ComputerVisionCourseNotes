\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{CVCN}[2020/06/01 Computer Vision Course Notes LaTeX class]

\RequirePackage{luacode}
\begin{luacode*}
  function PrintOutputArgs()
    if arguments then
      for k, v in pairs(arguments) do
        arg = " --" .. k
        if v ~= nil and v ~= "" then
          arg = arg .. "=" .. v
        end
        tex.print(arg)
      end
    end
  end
  if arguments then
    texio.write_nl("The following options were passed:")
    for k, v in pairs(arguments) do
      arg = "--" .. k
      if v ~= nil and v ~= "" then
        arg = arg .. "=" .. v
      end
      texio.write_nl(arg)
    end
  else
    texio.write_nl("No options were passed!")
  end
\end{luacode*}

\RequirePackage[build={latexoptions={\directlua{PrintOutputArgs()}}}]{standalone}

\LoadClass[10pt,oneside]{book}

\RequirePackage{CVCN}

\PassOptionsToPackage{most}{tcolorbox}
\PassOptionsToPackage{noabbrev}{cleveref}
\RequirePackage{xstring,subcaption,caption,etoolbox,hyperref,ifdraft,refcount,tcolorbox,cleveref}
\hypersetup{draft=false, breaklinks=true, colorlinks, unicode=true, pdfdisplaydoctitle,
            linkcolor={red!50!black}, citecolor={blue!50!black}, urlcolor={blue!80!black}}
\NewDocumentCommand\crefp{m}{\cref{#1} \cpageref{#1}}


% Remove chapters:
\renewcommand{\thesection}{\arabic{section}}
\let\oldsection\section
\renewcommand\section{\ifdraft{}{\tcbstartrecording[solutions]}\oldsection}
\newcommand\printsolutions{\ifdraft{}{\tcbstoprecording\tcbinputrecords[solutions]}}
\let\oldtableofcontents\tableofcontents
\renewcommand\tableofcontents{{\hypersetup{hidelinks}\oldtableofcontents}}


\DeclareDocumentCommand{\exampleicon}{}{%
    \begin{tikzpicture}[baseline=+0.5mm]
    \def\width{4mm}
    \def\height{4mm}
    \def\margin{0.8mm}
    \def\spacing{0.8mm}
    \draw[thick, rounded corners=0.5mm]
     (0,0) rectangle ++ (\width,\height);
    \begin{scope}[shift={(0.5*\width,0.5*\height-\margin)}]
    \draw[rounded corners=0.1mm]
     (0.5*\spacing, 0) -- ++ (0, 0.25*\spacing)
      to[out=90,in=-90] ++ (0.5*\spacing, 1.5*\spacing)
      to[out=90,in=0] ++ (-\spacing, \spacing)
      to[out=180,in=90] ++ (-\spacing, -\spacing)
      to[out=-90,in=90] ++ (0.5*\spacing, -1.5*\spacing)
      -- ++ (0, -0.25*\spacing) -- cycle;
    \draw[line cap=round] (-0.45*\spacing, -0.25*\spacing) -- ++ (0.9*\spacing, 0);
    \draw[line cap=round] (-0.45*\spacing, -0.5*\spacing) -- ++ (0.9*\spacing, 0);
    \draw[line cap=round] (-0.4*\spacing, -0.75*\spacing) -- ++ (0.8*\spacing, 0);
    \end{scope}
    \end{tikzpicture}%
}

\DeclareDocumentCommand{\exerciseicon}{}{%
    \begin{tikzpicture}[baseline=+0.5mm]
    \def\width{4mm}
    \def\height{4mm}
    \def\margin{0.3mm}
    \def\spacing{0.8mm}
    \draw[thick, rounded corners=0.5mm]
     (0,0) rectangle ++ (\width,\height);
    \begin{scope}[shift={(0.5*\width+3*\margin,0.5*\height+4*\margin)},rotate=225]
        \fill[rounded corners=0.1mm, draw=none]
         (0,0) -- ++({\width-2*\margin-1.25*\spacing}, 0)
         to[in=-40,out=40] ++ (0, \spacing)
          -- ++({-\width+2*\margin+1.25*\spacing}, 0) -- cycle;
        \fill[rounded corners=0.1mm, draw=none]
         (\width-2*\margin-\spacing, 0)
          to[in=-40,out=40] ++(0, \spacing)
          -- ++(\spacing, -0.5*\spacing) -- cycle;
    \end{scope}
    \end{tikzpicture}%
}

\def\checkmark{\tikz\fill[scale=0.4](0,.35) -- (.25,0) -- (1,.7) -- (.25,.15) -- cycle;}

\DeclareDocumentCommand{\solutionicon}{}{%
    \begin{tikzpicture}[baseline=+0.5mm]
    \def\width{4mm}
    \def\height{4mm}
    \def\margin{0.3mm}
    \draw[thick, rounded corners=0.5mm]
     (0,0) rectangle ++ (\width,\height);
    \begin{scope}[shift={(0.5*\width,0.5*\height)}]
    \begin{scope}[shift={({-0.45*(\width - 2*\margin)},{-0.3*(\height - 2*\margin)})}]
    \fill(0,{.35*(\height - 2*\margin)}) -- ({.25*(\width - 2*\margin)},0) -- ({(\width - 2*\margin)},{.7*(\height - 2*\margin)}) -- ({.25*(\width - 2*\margin)},{.15*(\height - 2*\margin)}) -- cycle;
    \end{scope}
    \end{scope}
    \end{tikzpicture}%
}

\definecolor{examplecolor}{RGB}{5,112,176}
\definecolor{exercisecolor}{RGB}{189,0,38}
\definecolor{solutioncolor}{RGB}{35,132,67}
\colorlet{remarkcolor}{orange}
\colorlet{proofcolor}{black}

\NewTColorBox[auto counter, number within=section]{example}{O{}g}{
  enhanced, breakable, lines before break=10,
  title={\exampleicon\ Example \thetcbcounter}, detach title,
  fonttitle={\bfseries}, coltitle=white, colbacktitle=examplecolor,
  colback=examplecolor!0, opacityfill=0,
  sharp corners, boxrule=0pt, frame hidden,
  borderline north={2pt}{0pt}{examplecolor},
  borderline south={2pt}{0pt}{examplecolor},
  before upper={\vspace*{4ex}},
  overlay unbroken={
    \node[white, fill=examplecolor, anchor=north west, xshift=-0.325pt] (A) at (interior.north west) {\tcbtitle};
    \IfNoValueTF{#2}{}
    {\node[examplecolor, anchor=north west, yshift=-2.5pt] (B) at (A.north east) {{\bfseries #2}};}
    \fill[examplecolor, xshift=+0.325pt] (interior.south east) ++ (0,0.5pt) rectangle ++ (-2pt,1ex);
  },
  overlay first={
    \node[white, fill=examplecolor, anchor=north west, xshift=-0.325pt] (A) at (interior.north west) {\tcbtitle};
    \IfNoValueTF{#2}{}
    {\node[examplecolor, anchor=north west, yshift=-2.5pt] (B) at (A.north east) {{\bfseries #2}};}
  },
  overlay last={
    \fill[examplecolor, xshift=+0.325pt] (interior.south east) ++ (0,0.5pt) rectangle ++ (-2pt,1ex);
  },
  before skip=20pt plus 2pt,
  % after skip=20pt plus 2pt,
  left=0pt, right=0pt,
  after={\par\noindent},
  label={exp:\thetcbcounter},
  #1
}

\NewDocumentCommand\solution{G{}}{%
    \global\expandafter\def\csname solutiontitle@\thetcbcounter\endcsname{#1}
    \ifdraft{%
      \vspace*{0.5em}\par\textcolor{solutioncolor}{\bfseries Solution:}\vspace*{0.5em}%
    }{%
      \tcbset{
        after upper={\hypersetup{linkcolor=solutioncolor!90!black}\par\hfill\textcolor{solutioncolor}%
                     {\bfseries Solution on page~\pageref{sol:\thetcbreflabel}}\;\vspace*{-3pt}},
      }
      \tcblower%
    }%
}

\NewTColorBox[auto counter, number within=section]{exercise}{d<>O{}g}{
  enhanced, breakable,
  code={\def\thetcbreflabel{\IfValueTF{#1}{#1}{\thetcbcounter}}%
        \let\exercisesubtitle\tcbsubtitle},
  title={\exerciseicon\ Exercise \thetcbcounter}, detach title,
  fonttitle={\bfseries}, coltitle=white, colbacktitle=exercisecolor,
  colback=exercisecolor!0, opacityfill=0,
  sharp corners, boxrule=0pt, frame hidden,
  borderline north={2pt}{0pt}{exercisecolor},
  borderline south={2pt}{0pt}{exercisecolor},
  before upper={\vspace*{4ex}},
  overlay unbroken={
    \node[white, fill=exercisecolor, anchor=north west, xshift=-0.325pt] (A) at (interior.north west) {\tcbtitle};
    \IfNoValueTF{#2}{}
    {\node[exercisecolor, anchor=north west, yshift=-2.5pt] (B) at (A.north east) {{\bfseries #3}};}
    \fill[exercisecolor, xshift=+0.325pt] (interior.south east) ++ (0,0.5pt) rectangle ++ (-2pt,1ex);
  },
  overlay first={
    \node[white, fill=exercisecolor, anchor=north west, xshift=-0.325pt] (A) at (interior.north west) {\tcbtitle};
    \IfNoValueTF{#2}{}
    {\node[exercisecolor, anchor=north west, yshift=-2.5pt] (B) at (A.north east) {{\bfseries #3}};}
  },
  overlay last={
    \fill[exercisecolor, xshift=+0.325pt] (interior.south east) ++ (0,0.5pt) rectangle ++ (-2pt,1ex);
  },
  before skip=20pt plus 2pt,
  after skip=20pt plus 2pt,
  left=0pt, right=0pt,
  subtitle style={fontupper={\bfseries\color{exercisecolor}},top=1em,opacityfill=0},
  label={exc:\IfValueTF{#1}{#1}{\thetcbcounter}},
  lowerbox=ignored,
  savelowerto={\jobname-solution-\thetcbcounter.tex},
  record={\string\displaysolutioncond<\thetcbreflabel><\thetcbcounter>[#2]{\jobname-solution-\thetcbcounter.tex}},
  #2
}

\NewDocumentCommand\displaysolutioncond{r<>r<>O{}m}{
    \ifcsname solutiontitle@#2\endcsname
        \displaysolution<#1><#2>[#3]{#4}
    \fi
}

\NewTotalTColorBox{\displaysolution}{r<>r<>O{}m}{
  enhanced, breakable,
  title={\solutionicon\ Solution~\getrefnumber{exc:#1}}, detach title,
  fonttitle={\bfseries}, coltitle=white, colbacktitle=solutioncolor,
  colback=solutioncolor!0, opacityfill=0,
  sharp corners, boxrule=0pt, frame hidden,
  borderline north={2pt}{0pt}{solutioncolor},
  borderline south={2pt}{0pt}{solutioncolor},
  before upper={\vspace*{4ex}},
  overlay unbroken={
    \node[white, fill=solutioncolor, anchor=north west, xshift=-0.325pt] (A) at (interior.north west) {\tcbtitle};
    \node[solutioncolor, anchor=north west, yshift=-2.5pt] (B) at (A.north east) {\hypersetup{linkcolor=solutioncolor!90!black}{\bfseries \csname solutiontitle@#2\endcsname}};
    \node[exercisecolor, anchor=north east, yshift=-2.5pt] (B) at (interior.north east) {\hypersetup{linkcolor=exercisecolor!90!black}{\bfseries Exercise on page~\pageref{exc:#1}}};
    \fill[solutioncolor] (interior.south east) ++ (0,1.5pt) rectangle ++ (-2pt,1ex);
  },
  overlay first={
    \node[white, fill=solutioncolor, anchor=north west, xshift=-0.325pt] (A) at (interior.north west) {\tcbtitle};
    \node[solutioncolor, anchor=north west, yshift=-2.5pt] (B) at (A.north east) {\hypersetup{linkcolor=solutioncolor!90!black}{\bfseries \csname solutiontitle@#2\endcsname}};
    \node[exercisecolor, anchor=north east, yshift=-2.5pt] (B) at (interior.north east) {\hypersetup{linkcolor=exercisecolor!90!black}{\bfseries Exercise on page~\pageref{exc:#1}}};
  },
  overlay last={
    \fill[solutioncolor, xshift=+0.325pt] (interior.south east) ++ (0,1.5pt) rectangle ++ (-2pt,1ex);
  },
  before skip=20pt plus 2pt,
  after skip=20pt plus 2pt,
  left=0pt, right=0pt,
  subtitle style={fontupper={\bfseries\color{solutioncolor}},top=1em,opacityfill=0},
  phantomlabel={sol:#1},
  #3
}{\input{#4}}

\crefname{tcb@cnt@example}{example}{examples}
\Crefname{tcb@cnt@example}{Examples}{Examples}
\crefname{tcb@cnt@exercise}{exercise}{exercises}
\Crefname{tcb@cnt@exercise}{Exercise}{Exercises}
\crefname{tcb@cnt@solution}{solution}{solutions}
\Crefname{tcb@cnt@solution}{Solution}{Solutions}

\NewTColorBox{remark}{}{
  enhanced, breakable,
  title={Remark:}, attach title to upper={\quad},
  opacityfill=0,
  fonttitle={\bfseries}, coltitle=remarkcolor,
  sharp corners, boxrule=0pt, frame hidden,
  borderline west={2pt}{0pt}{remarkcolor},
  before skip=20pt plus 2pt,
  after skip=20pt plus 2pt,
}

\NewTColorBox{proof}{}{
  enhanced, breakable,
  title={Proof:}, attach title to upper={\quad},
  colback=white,
  fonttitle={\bfseries}, coltitle=proofcolor,
  sharp corners, boxrule=0pt, frame hidden,
  borderline west={2pt}{0pt}{proofcolor},
  before skip=20pt plus 2pt,
  after skip=20pt plus 2pt,
}

\renewcommand\thesubfigure{(\alph{subfigure})}
\let\oldsubcaptionbox\subcaptionbox
\RenewDocumentCommand\subcaptionbox{somoom}{
  \hfill
  \begin{tikzpicture}
  \IfValueTF{#4}
    {\node[minimum width=#4, outer sep=5pt] (contents) at (0,0) {#6};}
    {\node[outer sep=5pt] (contents) at (0,0) {#6};}
  \node[anchor=north west, outer sep=5pt] (label) at (contents.north west) {\phantomsubcaption\thesubfigure~#3};
  \end{tikzpicture}
  \SubCaptionBoxPatch
  \hfill
}

\crefmultiformat{figure}{\edef\crefstripprefixinfo{#1}figures~#2#1#3}%
    { and~#2\IfEndWith{#1}{)}{(}{}\crefstripprefix{\crefstripprefixinfo}{#1}#3}%
    {, #2\IfEndWith{#1}{)}{(}{}\crefstripprefix{\crefstripprefixinfo}{#1}#3}%
    { and~#2\IfEndWith{#1}{)}{(}{}\crefstripprefix{\crefstripprefixinfo}{#1}#3}
\crefrangeformat{figure}{figures~#3#1#4 to~#5\IfEndWith{#2}{)}{(}{}\crefstripprefix{#1}{#2}#6}

\Crefmultiformat{figure}{\edef\crefstripprefixinfo{#1}Figures~#2#1#3}%
    { and~#2\IfEndWith{#1}{)}{(}{}\crefstripprefix{\crefstripprefixinfo}{#1}#3}%
    {, #2\IfEndWith{#1}{)}{(}{}\crefstripprefix{\crefstripprefixinfo}{#1}#3}%
    { and~#2\IfEndWith{#1}{)}{(}{}\crefstripprefix{\crefstripprefixinfo}{#1}#3}
\Crefrangeformat{figure}{Figures~#3#1#4 to~#5\IfEndWith{#2}{)}{(}{}\crefstripprefix{#1}{#2}#6}


\AtBeginEnvironment{figure}{\ClearMySubcaptionThings}
\AtEndEnvironment{figure}{\ClearMySubcaptionThings}
\AtBeginEnvironment{table}{\ClearMySubcaptionThings}
\AtEndEnvironment{table}{\ClearMySubcaptionThings}

\newcommand*\ClearMySubcaptionThings
  {%
    \gdef\MySubcaptionFirst{}%
    \gdef\MySubcaptionLast{}%
  }
\newcommand*\MySubcaptionFirst{}
\newcommand*\MySubcaptionLast{}
\newcommand*\MySubcaptionRange
  {%
    \MySubcaptionFirst
    \ifx\MySubcaptionLast\@empty
    \else
      \MySubcaptionLast
    \fi
  }
\newcommand*\SubCaptionBoxPatch
  {%
    \ifx\MySubcaptionFirst\@empty
      \xdef\MySubcaptionFirst{\csname thesub\@captype\endcsname}%
    \else
        \ifx\MySubcaptionLast\@empty
          \xdef\MySubcaptionLast{~and~\csname thesub\@captype\endcsname}%
        \else
          \xdef\MySubcaptionLast{--\csname thesub\@captype\endcsname}%
        \fi
    \fi
  }
\DeclareCaptionLabelFormat{subcaptions}
  {#1 #2\MySubcaptionRange}
\captionsetup{labelformat=subcaptions}
