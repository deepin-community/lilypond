%% DO NOT EDIT this file manually; it was automatically
%% generated from the LilyPond Snippet Repository
%% (http://lsr.di.unimi.it).
%%
%% Make any changes in the LSR itself, or in
%% `Documentation/snippets/new/`, then run
%% `scripts/auxiliar/makelsr.pl`.
%%
%% This file is in the public domain.

\version "2.23.13"

\header {
  lsrtags = "contexts-and-engravers, staff-notation"

  texidoc = "
The system start delimiter @code{SystemStartSquare} can be used by
setting it explicitly in a @code{StaffGroup} or @code{ChoirStaff}
context.
"

  doctitle = "Use square bracket at the start of a staff group"
} % begin verbatim


\score {
  \new StaffGroup { <<
  \set StaffGroup.systemStartDelimiter = #'SystemStartSquare
    \new Staff { c'4 d' e' f' }
    \new Staff { c'4 d' e' f' }
  >> }
}
