\version "2.23.6"

\header {
  lsrtags = "midi, percussion, specific-notation"

  texidoc = "
Customized drum @qq{pitch} names (suitable for a custom drum style, for
example) may be used both in printed and MIDI output by defining such
variables as @code{drumPitchNames}, @code{drumStyleTable} and
@code{midiDrumPitches}, as demonstrated here. In short, this snippet:

@itemize
@item
defines some \"pitch\" names,
@item
defines how they will be rendered,
@item
tells LilyPond to use them for layout,
@item
assigns pitches to the names,
@item
tells LilyPond to use them for MIDI output.
@end itemize
"

  doctitle = "Customized drum notation in printed and MIDI output"
}


%% This snippet tries to amend
%% NR 2.5.1 Common notation for percussion - Custom percussion staves
%% http://lilypond.org/doc/v2.18/Documentation/notation/common-notation-for-percussion#custom-percussion-staves

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% To use custom drum pitch names for your score and midi you need to follow
%% this route:
%%
%%%%%%%%%%%%
%% LAYOUT:
%%%%%%%%%%%%
%%
%% (1) Define a name and put it in `drumPitchNames'
%%     This can be done at toplevel with
%%         drumPitchNames.my-name  = #'my-name
%%     It's possible to add an alias as well.
%% (2) Define how it should be printed
%%     Therefore put them into a top-level list, where each entry should
%%     be of the form:
%%         (my-name
%%           note-head-style-or-default
%%             articulation-type-or-#f
%%               staff-position)
%%     Example:
%%         #(define my-style
%%           '(
%%             (my-name default tenuto -1)
%%             ; ...
%%             ))
%% (3) Tell LilyPond to use these custom definitions, with
%%         drumStyleTable = #(alist->hash-table my-style)
%%     in a \layout or \with block
%%
%%     Now we're done for layout. Here is a short but complete example:
%%         \new DrumStaff
%%           \with { drumStyleTable = #(alist->hash-table my-style) }
%%           \drummode { my-name }
%%
%%%%%%%%%%%%
%% MIDI:
%%%%%%%%%%%%
%%
%% (1) Again at top-level, assign a pitch to your custom note name
%%         midiDrumPitches.my-name = ges
%%     Note that you have to use the name, which is in drumPitchNames, no alias
%% (2) Tell LilyPond to use this pitch(es), with
%%         drumPitchTable = #(alist->hash-table midiDrumPitches)
%%
%%     Example:
%%         \score {
%%            \new DrumStaff
%%             \with {
%%               drumStyleTable = #(alist->hash-table my-style)
%%               drumPitchTable = #(alist->hash-table midiDrumPitches)
%%             }
%%             \drummode { my-name4 }
%%           \layout {}
%%           \midi {}
%%         }
%%
%%%%%%%%%%%%
%% TESTING
%%%%%%%%%%%%
%%
%% To test whether all is fine, run the following sequence in terminal:
%%         lilypond my-file.ly
%%         midi2ly my-file.midi
%%         gedit my-file-midi.ly
%%
%% This will do the following:
%% 1. create pdf and midi
%% 2. transform the midi back to a .ly-file
%%    (note: midi2ly is not always good in correctly identifying enharmonic pitches)
%% 3. open this file in gedit (or use another editor)
%% Now watch what you've got.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FULL EXAMPLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

drumPitchNames.dbass      = #'dbass
drumPitchNames.dba        = #'dbass  % 'db is in use already
drumPitchNames.dbassmute  = #'dbassmute
drumPitchNames.dbm        = #'dbassmute
drumPitchNames.do         = #'dopen
drumPitchNames.dopenmute  = #'dopenmute
drumPitchNames.dom        = #'dopenmute
drumPitchNames.dslap      = #'dslap
drumPitchNames.ds         = #'dslap
drumPitchNames.dslapmute  = #'dslapmute
drumPitchNames.dsm        = #'dslapmute

#(define djembe
  '((dbass      default  #f         -2)
    (dbassmute  default  stopped    -2)
    (dopen      default  #f          0)
    (dopenmute  default  stopped     0)
    (dslap      default  #f          2)
    (dslapmute  default  stopped     2)))

midiDrumPitches.dbass = g
midiDrumPitches.dbassmute = fis
midiDrumPitches.dopen =  a
midiDrumPitches.dopenmute = gis
midiDrumPitches.dslap =  b
midiDrumPitches.dslapmute = ais

one = \drummode { r4 dba4 do ds r dbm dom dsm }

\score {
   \new DrumStaff
    \with {
      \override StaffSymbol.line-count =  #3
      instrumentName = #"Djembe "
      drumStyleTable = #(alist->hash-table djembe)
      drumPitchTable = #(alist->hash-table midiDrumPitches)
    }
    \one
  \layout {}
  \midi {}
}
