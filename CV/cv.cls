%-------------------------
% CV in Latex
% Author : Shuo Qu
% Based off of: https://github.com/jakegut/resume
% License : MIT
%------------------------


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}[2021/08/19 v0.1 CV Class]


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}


\RequirePackage{ctex}
\RequirePackage{ifthen}
\RequirePackage{verbatim}
\RequirePackage{latexsym}
\RequirePackage[empty]{fullpage}
\RequirePackage{titlesec}
\RequirePackage{marvosym}
\RequirePackage[usenames,dvipsnames]{color}
\RequirePackage{verbatim}
\RequirePackage{enumitem}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{fancyhdr}
\RequirePackage[english]{babel}
\RequirePackage{tabularx}


%----------FONT OPTIONS----------
% sans-serif
% \RequirePackage[sfdefault]{FiraSans}
% \RequirePackage[sfdefault]{roboto}
% \RequirePackage[sfdefault]{noto-sans}
% \RequirePackage[default]{sourcesanspro}

% serif
% \RequirePackage{CormorantGaramond}
% \RequirePackage{charter}


\pagestyle{fancy}
\fancyhf{} % clear all header and footer fields
\fancyfoot{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% Adjust margins
\addtolength{\oddsidemargin}{-0.5in}
\addtolength{\evensidemargin}{-0.5in}
\addtolength{\textwidth}{1in}
\addtolength{\topmargin}{-.5in}
\addtolength{\textheight}{1.0in}

\urlstyle{same}

\raggedbottom
\raggedright
\setlength{\tabcolsep}{0in}

% Sections formatting
\titleformat{\section}{
  \vspace{-4pt}\scshape\raggedright\large
}{}{0em}{}[\color{black}\titlerule \vspace{-5pt}]


%---------------------------
% Profile commands
\newcommand{\name}[1]{\newcommand{\@name}{#1}}
\newcommand{\phone}[1]{\newcommand{\@phone}{#1}}
\newcommand{\github}[1]{\newcommand{\@github}{#1}}
\newcommand{\email}[1]{\newcommand{\@email}{#1}}
\newcommand{\linkedin}[1]{\newcommand{\@linkedin}{#1}}

\newcommand{\makeheader}{
  \textbf{\Huge \scshape \@name} \\ \vspace{1pt}

  \ifthenelse{\isundefined{\@phone}}
  {}
  {\small \@phone $|$}
  \ifthenelse{\isundefined{\@github}}
  {}
  {\href{https://github.com/\@github}{\underline{github.com/\@github}} $|$}
  \ifthenelse{\isundefined{\@linkedin}}
  {}
  {\href{https://linkedin.com/in/\@linkedin}{\underline{linkedin.com/in/\@linkedin}} $|$}
  \href{mailto:\@email}{\underline{\@email}}
}


%-------------------------
% Custom commands
\newenvironment{CVitemize}
  {\begin{itemize}}
  {\end{itemize}\vspace{-5pt}}

\newenvironment{CVentries}
  {\begin{itemize}[leftmargin=0.15in, label={}]}
  {\end{itemize}}

\newcommand{\CVentry}{\vspace{-2pt}\item}

\newcommand{\CVitem}[2][$\bullet$]{
  \item[#1]\small{
    {#2 \vspace{-2pt}}
  }
}

\newcommand{\CVsubitem}[1]{
  \setlength\itemindent{15pt}
  \CVitem[$-$]{#1}
  \setlength\itemindent{0pt}
  \vspace{-4pt}
}

\newcommand{\CVhead}[4]{
    \begin{tabular*}{0.97\textwidth}[t]{l@{\extracolsep{\fill}}r}
      \textbf{#1} & #2 \\
      \textit{\small#3} & \textit{\small #4} \\
    \end{tabular*}\vspace{-7pt}
}

\newcommand{\CVSubSubheading}[2]{
    \item
    \begin{tabular*}{0.97\textwidth}{l@{\extracolsep{\fill}}r}
      \textit{\small#1} & \textit{\small #2} \\
    \end{tabular*}\vspace{-7pt}
}

\newcommand{\CVprojhead}[2]{
    \begin{tabular*}{0.97\textwidth}{l@{\extracolsep{\fill}}r}
      \small#1 & #2 \\
    \end{tabular*}\vspace{-7pt}
}

\renewcommand\labelitemii{$\vcenter{\hbox{\tiny$\bullet$}}$}

%-------------------------------------------