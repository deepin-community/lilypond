\version "2.23.4"

\header {
  lsrtags = "editorial-annotations, expressive-marks, tweaks-and-overrides"

  texidoc = "
Creating a delayed turn, where the lower note of the turn uses the
accidental, requires several overrides.  The
@code{outside-staff-priority} property must be set to @code{#f}, as
otherwise this would take precedence over the
@code{avoid-slur property}.  Changing the fraction @code{2/3}
adjusts the horizontal position.
"

  doctitle = "Creating a delayed turn"
}


\relative c'' {
  \after 2*2/3 \turn c2( d4) r |
  \after 4 \turn c4.( d8)
  \after 4
  {
    \once \set suggestAccidentals = ##t
    \once \override AccidentalSuggestion.outside-staff-priority = ##f
    \once \override AccidentalSuggestion.avoid-slur = #'inside
    \once \override AccidentalSuggestion.font-size = -3
    \once \override AccidentalSuggestion.script-priority = -1
    \once \hideNotes
    cis8\turn \noBeam
  }
  d4.( e8)
}
