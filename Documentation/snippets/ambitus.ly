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
  lsrtags = "pitches, vocal-music"

  texidoc = "
Ambitus indicate pitch ranges for voices.

Accidentals only show up if they are not part of the key
signature.  @code{AmbitusNoteHead} grobs also have ledger lines.
"

  doctitle = "Ambitus"
} % begin verbatim


\layout {
  \context {
    \Voice
    \consists "Ambitus_engraver"
  }
}

<<
  \new Staff {
    \relative c' {
      \time 2/4
      c4 f'
    }
  }
  \new Staff {
    \relative c' {
      \time  2/4
      \key d \major
      cis4 as'
    }
  }
>>
