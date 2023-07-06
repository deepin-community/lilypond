\version "2.23.3"

\header {
  lsrtags = "contexts-and-engravers, repeats, staff-notation"

  texidoc = "
Scores of large ensemble works often have bar numbers placed beneath
the system, centered horizontally on the measure's extent.  This
snippet shows how the @code{Measure_counter_engraver} may be used to
simulate this notational practice.  Here, the engraver has been added
to a @code{Dynamics} context.

This snippet presents a legacy method: starting from LilyPond 2.23.3,
@code{\\set Score.centerBarNumbers = ##t} is enough.
"

  doctitle = "Centered measure numbers"
}


\layout {
  \context {
    \Dynamics
    \consists #Measure_counter_engraver
    \override MeasureCounter.direction = #DOWN
    \override MeasureCounter.font-encoding = #'latin1
    \override MeasureCounter.font-shape = #'italic
    % to control the distance of the Dynamics context from the staff:
    \override VerticalAxisGroup.nonstaff-relatedstaff-spacing.padding = #2
  }
  \context {
    \Score
    \remove "Bar_number_engraver"
  }
}

pattern = \repeat unfold 7 { c'4 d' e' f' }

\new StaffGroup <<
  \new Staff {
    \pattern
  }
  \new Staff {
    \pattern
  }
  \new Dynamics {
    \startMeasureCount
    s1*7
    \stopMeasureCount
  }
>>
