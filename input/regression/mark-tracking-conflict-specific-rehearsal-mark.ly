\version "2.23.6"
#(ly:set-option 'warning-as-error #t)

\header {
  texidoc = "LilyPond issues warnings when @code{\\mark @var{n}}
conflicts with certain other simultaneous marks, and engraves only the
first.

Rehearsal marks 1 to @tie{}3 should appear alone.  Rehearsal marks 4
to@tie{}9 should appear with various performance marks."
}

\layout {
  \context {
    \Score
    rehearsalMarkFormatter = #format-mark-numbers
  }
}

\parallelMusic upper,lower {
  R1 \mark 1    |
  R1 \mark "A!" |
  #(ly:expect-warning (ly:translate-cpp-warning-scheme
                       "conflict with event: `%s'") "rehearsal-mark-event")
  #(ly:expect-warning (ly:translate-cpp-warning-scheme
                       "discarding event: `%s'") "ad-hoc-mark-event")

  R1 \mark 2        |
  R1 \mark \default |
  %% no warning

  R1 \mark 3 |
  R1 \mark 9 |
  #(ly:expect-warning (ly:translate-cpp-warning-scheme
                       "conflict with event: `%s'") "rehearsal-mark-event")
  #(ly:expect-warning (ly:translate-cpp-warning-scheme
                       "discarding event: `%s'") "rehearsal-mark-event")

  R1 \mark 4 |
  R1 \segnoMark \default |
  %% no warning

  R1 \mark 5 |
  R1 \segnoMark 5 |
  %% no warning

  R1 \mark 6 |
  R1 \codaMark \default |
  %% no warning

  R1 \mark 7 |
  R1 \codaMark 8 |
  %% no warning

  R1 \mark 8 |
  R1 \sectionLabel "Coda" |
  %% no warning

  R1 |
  R1 |
}

\new Staff <<
  \new Voice \upper
  \new Voice \lower
>>
