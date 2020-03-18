\ProvidesClass{cv-style}[2014/08/16 CV class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass[a4paper]{article}

% no paragraph identation
\setlength\parindent{\z@}

% no page numbers
\RequirePackage{nopageno}

% page margins
\RequirePackage[left=1cm,top=1cm,right=1cm,bottom=1cm,nohead,nofoot]{geometry}


%----------------------------------------------------------------------------------------
% Colors %
%----------------------------------------------------------------------------------------

\RequirePackage{xcolor}

\definecolor{white}{RGB}{255,255,255}
\definecolor{black}{RGB}{0,0,0}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{accentcolor}{HTML}{000080}% blue
%\definecolor{accentcolor}{HTML}{16a085}% light turquoise
%\definecolor{accentcolor}{HTML}{341f97}% purple
%\definecolor{accentcolor}{HTML}{227093}% dark turquoise


\ifdefined\@cv@print
  \colorlet{accentcolor}{gray}
  \colorlet{fillheader}{gray}
\else
  \colorlet{fillheader}{accentcolor}
\fi
\colorlet{textcolor}{black}

%----------------------------------------------------------------------------------------
% Fonts %
%----------------------------------------------------------------------------------------

\RequirePackage[default,scale=1]{opensans}
\RequirePackage[T1]{fontenc}

%----------------------------------------------------------------------------------------
% Header %
%----------------------------------------------------------------------------------------

\RequirePackage{tikz}
\RequirePackage{svg}

\newcommand{\header}{%
  \begin{tikzpicture}[remember picture, every node/.style={inner sep=0,outer sep=0}]%
    \node[rectangle,
          minimum width=\textwidth] (wrapper) at (current page.north west) {};%
    \node[rectangle,
          anchor=north east] (contact) at (wrapper.north east) {%
      \begin{tabular}{@{}r@{}}%
        {\huge\color{accentcolor}\MakeUppercase{
          \@ifundefined{cvname}
          {%
            Your Name%
          }
          {%
            \cvname%
          }%
        }}\vspace{0.5ex}\\%
        {\fontsize{12pt}{12pt}\color{gray}
          \parbox[c][12pt][c]{12pt}{\includesvg[width=10pt]{icons/home}}\,%
          \@ifundefined{cvstreet}{}
          {%
            \cvstreet,\,%
          }%
          \@ifundefined{cvzipcode}{}
          {%
            \cvzipcode\,%
          }%
          \@ifundefined{cvcity}{}
          {%
            \cvcity,\,%
          }%
          \@ifundefined{cvcountry}{}
          {%
            \cvcountry%
          }%
        }\\%
        \@ifundefined{cvemail}{}
        {%
          \parbox[c][12pt][c]{12pt}{\includesvg[width=10pt]{icons/mail}}\,%
          {\fontsize{12pt}{12pt}\color{gray}\cvemail}\\%
        }%
        \@ifundefined{cvweb}{}
        {%
          \parbox[c][12pt][c]{12pt}{\includesvg[width=10pt]{icons/web}}\,%
          {\fontsize{12pt}{12pt}\color{gray}\cvweb}\\%
        }%
        \@ifundefined{cvphone}{}
        {%
          \parbox[c][12pt][c]{12pt}{\includesvg[width=10pt]{icons/phone}}\,%
          {\fontsize{12pt}{12pt}\color{gray}\cvphone}%
        }%
      \end{tabular}%
    };%
    \node[fill=fillheader,
          align=right,
          anchor=north west,
          text width=16ex,
          text depth=0pt,
          text height=10ex,
          text=white,
          inner sep=2ex] (box) at (wrapper.north west) {%
      {\LARGE CV}%
    };%
  \end{tikzpicture}
  \vspace{1ex}
  %\vspace{-2\parskip}
}

%----------------------------------------------------------------------------------------
% Structure %
%----------------------------------------------------------------------------------------

\RequirePackage{calc}
\RequirePackage{tabularx}
\RequirePackage{makecell}
\RequirePackage{ifmtarg}

\newenvironment{aside}{%
  \renewcommand\section{\@startsection{section}%
                                      {1}%
                                      {\z@}% zero indentaion
                                      {-2ex \@plus -0.5ex \@minus -0.5ex}% beforeskip is between 1 and 4 ex, negative -> no indentaion of the following line
                                      {1.5ex}% positive -> linebreak
                                      {\Large\color{accentcolor}}
  }%
  \begin{minipage}[t]{18ex}%
  \begin{flushright}%
}{%
  \end{flushright}%
  \end{minipage}%
}

\newenvironment{main}{%
  \newcommand{\cvunderline}[1]{%
    \parbox[b]{.618\hsize}{\raggedright\MakeUppercase{##1}}
    % see https://tex.stackexchange.com/a/30979
    \par\nobreak % don't break a page here
    \kern\the\prevdepth % don't take into account the depth of the preceding line
    \kern 0.5ex % space before the rule
    {\color{accentcolor}\hrule height 0.1ex width .618\hsize} % the rule
    \nointerlineskip % no additional space after the rule
  }%
  \renewcommand\section{\@startsection{section}%
                                      {1}%
                                      {\z@}% zero indentaion
                                      {-3ex \@plus -0.5ex \@minus -0.5ex}% beforeskip is between 2.5 and 3.5 ex, negative -> no indentaion of the following line
                                      {0.4ex}% positive -> linebreak
                                      {\Large\color{accentcolor}\cvunderline}
  }%
  \hfill%
  \begin{minipage}[t]{\linewidth - 26ex}%
}{%
  \end{minipage}%
}

\newenvironment{cvitemize}{%
  \newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}p{##1}}%
  \newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}p{##1}}%
  \newcolumntype{Z}{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}X}%
  \newcommand{\cvitem}[5]{%
    \rule{\z@}{3.5ex}%
    {\color{gray} ##1} & \makecell[tZ]{\textbf{##2} \@ifnotmtarg{##4}{\\ \textit{##4}}} & {\color{gray}\small ##3}\\
    \@ifnotmtarg{##5}{& \multicolumn{2}{p{\linewidth - 2cm - 2\tabcolsep}}{##5}\\}
  }%
  \setlength{\extrarowheight}{0.25ex}
  \tabularx{\linewidth}{@{}L{2cm} X R{2cm}@{}}
}{%
  \endtabularx
}


%----------------------------------------------------------------------------------------
% Other utils %
%----------------------------------------------------------------------------------------

\RequirePackage{hyperref}
\newcommand{\pdfmeta}{%
  \hypersetup{
      pdftitle=CV of \cvname,
      pdfauthor=\cvname,
      pdfsubject=CV%
  }
}

\newcommand{\cityanddate}{%
  \vfill
  \cvcity, \today
}
