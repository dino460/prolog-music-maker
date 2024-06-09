:- dynamic main/0.

note(c,0).
note(c_sharp,1).
note(d,2).
note(d_sharp,3).
note(e,4).
note(f,5).
note(f_sharp,6).
note(g,7).
note(g_sharp,8).
note(a,9).
note(a_sharp,10).
note(b,11).

%% 1 octave above to account for overflow
note(c,12).
note(c_sharp,13).
note(d,14).
note(d_sharp,15).
note(e,16).
note(f,17).
note(f_sharp,18).
note(g,19).
note(g_sharp,20).
note(a,21).
note(a_sharp,22).
note(b,23).


main :- 
	repeat,
	nl,
	writeln(' > Choose a scale [major, minor]'),
	writeln(' > Exit [e]'),
	writeln('( string |: {input} )'),
	read_line_to_string(user_input, S1),
	string_lower(S1, Answer),
	format('    data inputed : [ ~w ]', [Answer]),
	nl,
	(
		Answer = "e" ->
			writeln('~nExiting...'), ! ;
			(
				menu_option(Answer) -> 
					writeln('~nInvalid option') ;
					true
			),
			fail
	).


menu_option(Answer) :-
	nl,
	writeln(' > Type a scale root note [c, d, e, f, g, a, b]'),
	writeln('( predicate |: {input}. )'),
	read(ScaleRoot),
	skip_line, %% Clear \n in buffer
	format('    data inputed : [ ~w ~w ]', [Answer, ScaleRoot]),
	nl,
	nl,

	writeln(' > Type a tempo [1, 2, 3, ...]'),
	writeln('( number |: {input}. )'),
	read(Tempo),
	skip_line, %% Clear \n in buffer
	format('    data inputed : [ ~w ~w ~w ]', [Answer, ScaleRoot, Tempo]),
	nl,
	nl,

	writeln(' > Type the number of bars [1, 2, 3, ...]'),
	writeln('( number |: {input}. )'),
	read(Bars),
	skip_line, %% Clear \n in buffer
	format('    data inputed : [ ~w ~w ~w ~w ]', [Answer, ScaleRoot, Tempo, Bars]),
	nl,
	nl,

	make_music(Answer, ScaleRoot, Tempo, Tempo, Bars, Bars),
	nl.


%% SCALES
major_scale(Root, Second, Third, Fourth, Fifth, Sixth, Seventh) :- 
	note(Root, RootValue),

	note(Second, SecondValue),
	(SecondValue =:= RootValue + 2 -> true ; false),

	note(Third, ThirdValue),
	(ThirdValue =:= RootValue + 4 -> true ; false),

	note(Fourth, FourthValue),
	(FourthValue =:= RootValue + 5 -> true ; false),

	note(Fifth, FifthValue),
	(FifthValue =:= RootValue + 7 -> true ; false),

	note(Sixth, SixthValue),
	(SixthValue =:= RootValue + 9 -> true ; false),

	note(Seventh, SeventhValue),
	(SeventhValue =:= RootValue + 11 -> true ; false).

minor_scale(Root, Second, Third, Fourth, Fifth, Sixth, Seventh) :- 
	note(Root, RootValue),

	note(Second, SecondValue),
	(SecondValue =:= RootValue + 2 -> true ; false),

	note(Third, ThirdValue),
	(ThirdValue =:= RootValue + 3 -> true ; false),

	note(Fourth, FourthValue),
	(FourthValue =:= RootValue + 5 -> true ; false),

	note(Fifth, FifthValue),
	(FifthValue =:= RootValue + 7 -> true ; false),

	note(Sixth, SixthValue),
	(SixthValue =:= RootValue + 8 -> true ; false),

	note(Seventh, SeventhValue),
	(SeventhValue =:= RootValue + 10 -> true ; false).

blues_major_scale(Root, Second, Third, Fourth, Fifth, Sixth, Seventh) :- 
	note(Root, RootValue),
	major_scale(Root, MajorSecond, MajorThird, _, MajorFifth, MajorSixth, _),
	
	note(Second, SecondValue),
	note(MajorSecond, MajorSecondValue),
	(SecondValue =:= MajorSecondValue -> true ; false),

	note(Third, ThirdValue),
	note(MajorThird, MajorThirdValue),
	(ThirdValue =:= MajorThirdValue - 1 -> true ; false),

	note(Fourth, FourthValue),
	(FourthValue =:= MajorThirdValue -> true ; false),

	note(Fifth, FifthValue),
	note(MajorFifth, MajorFifthValue),
	(FifthValue =:= MajorFifthValue -> true ; false),

	note(Sixth, SixthValue),
	note(MajorSixth, MajorSixthValue),
	(SixthValue =:= MajorSixthValue -> true ; false),

	note(Seventh, SeventhValue),
	(SeventhValue =:= RootValue -> true ; false).

blues_minor_scale(Root, Second, Third, Fourth, Fifth, Sixth, Seventh) :- 
	note(Root, RootValue),
	major_scale(Root, _, MajorThird, MajorFourth, MajorFifth, _, MajorSeventh),
	
	note(Second, SecondValue),
	note(MajorThird, MajorThirdValue),
	(SecondValue =:= MajorThirdValue - 1 -> true ; false),

	note(Third, ThirdValue),
	note(MajorFourth, MajorFourthValue),
	(ThirdValue =:= MajorFourthValue -> true ; false),

	note(Fourth, FourthValue),
	note(MajorFifth, MajorFifthValue),
	(FourthValue =:= MajorFifthValue - 1 -> true ; false),

	note(Fifth, FifthValue),
	(FifthValue =:= MajorFifthValue -> true ; false),

	note(Sixth, SixthValue),
	note(MajorSeventh, MajorSeventhValue),
	(SixthValue =:= MajorSeventhValue - 1 -> true ; false),

	note(Seventh, SeventhValue),
	(SeventhValue =:= RootValue -> true ; false).



%% CHORDS OF MAJOR SCALE
i_chord_major_scale(ScaleRoot, ChordRoot, PerfectThird, PerfectFifth) :-
	major_scale(ScaleRoot, _, Third, _, Fifth, _, _),
	
	note(ChordRoot, ChordRootValue),
	note(ScaleRoot, ScaleRootValue),
	(ChordRootValue =:= ScaleRootValue -> true ; false),
	
	note(PerfectThird, PerfectThirdValue),
	note(Third, ThirdValue),
	(PerfectThirdValue =:= ThirdValue -> true ; false),
	
	note(PerfectFifth, PerfectFifthValue),
	note(Fifth, FifthValue),
	(PerfectFifthValue =:= FifthValue -> true ; false).

ii_chord_major_scale(ScaleRoot, ChordRoot, PerfectThird, PerfectFifth) :-
	major_scale(ScaleRoot, Second, _, Fourth, _, Sixth, _),
	
	note(ChordRoot, ChordRootValue),
	note(Second, SecondValue),
	(ChordRootValue =:= SecondValue -> true ; false),
	
	note(PerfectThird, PerfectThirdValue),
	note(Fourth, FourthValue),
	(PerfectThirdValue =:= FourthValue -> true ; false),
	
	note(PerfectFifth, PerfectFifthValue),
	note(Sixth, SixthValue),
	(PerfectFifthValue =:= SixthValue -> true ; false).

iii_chord_major_scale(ScaleRoot, ChordRoot, PerfectThird, PerfectFifth) :-
	major_scale(ScaleRoot, _, Third, _, Fifth, _, Seventh),
	
	note(ChordRoot, ChordRootValue),
	note(Third, ThirdValue),
	(ChordRootValue =:= ThirdValue -> true ; false),
	
	note(PerfectThird, PerfectThirdValue),
	note(Fifth, FifthValue),
	(PerfectThirdValue =:= FifthValue -> true ; false),
	
	note(PerfectFifth, PerfectFifthValue),
	note(Seventh, SeventhValue),
	(PerfectFifthValue =:= SeventhValue -> true ; false).

iv_chord_major_scale(ScaleRoot, ChordRoot, PerfectThird, PerfectFifth) :-
	major_scale(ScaleRoot, _, _, Fourth, _, Sixth, _),
	
	note(ChordRoot, ChordRootValue),
	note(Fourth, FourthValue),
	(ChordRootValue =:= FourthValue -> true ; false),
	
	note(PerfectThird, PerfectThirdValue),
	note(Sixth, SixthValue),
	(PerfectThirdValue =:= SixthValue -> true ; false),
	
	note(PerfectFifth, PerfectFifthValue),
	note(ScaleRoot, ScaleRootValue),
	(PerfectFifthValue =:= ScaleRootValue -> true ; false).

v_chord_major_scale(ScaleRoot, ChordRoot, PerfectThird, PerfectFifth) :-
	major_scale(ScaleRoot, Second, _, _, Fifth, _, Seventh),
	
	note(ChordRoot, ChordRootValue),
	note(Fifth, FifthValue),
	(ChordRootValue =:= FifthValue -> true ; false),
	
	note(PerfectThird, PerfectThirdValue),
	note(Seventh, SeventhValue),
	(PerfectThirdValue =:= SeventhValue -> true ; false),
	
	note(PerfectFifth, PerfectFifthValue),
	note(Second, SecondValue),
	(PerfectFifthValue =:= SecondValue -> true ; false).

vi_chord_major_scale(ScaleRoot, ChordRoot, PerfectThird, PerfectFifth) :-
	major_scale(ScaleRoot, _, Third, _, _, Sixth, _),
	
	note(ChordRoot, ChordRootValue),
	note(Sixth, SixthValue),
	(ChordRootValue =:= SixthValue -> true ; false),
	
	note(PerfectThird, PerfectThirdValue),
	note(ScaleRoot, ScaleRootValue),
	(PerfectThirdValue =:= ScaleRootValue -> true ; false),
	
	note(PerfectFifth, PerfectFifthValue),
	note(Third, ThirdValue),
	(PerfectFifthValue =:= ThirdValue -> true ; false).

vii_chord_major_scale(ScaleRoot, ChordRoot, PerfectThird, PerfectFifth) :-
	major_scale(ScaleRoot, Second, _, Fourth, _, _, Seventh),
	
	note(ChordRoot, ChordRootValue),
	note(Seventh, SeventhValue),
	(ChordRootValue =:= SeventhValue -> true ; false),
	
	note(PerfectThird, PerfectThirdValue),
	note(Second, SecondValue),
	(PerfectThirdValue =:= SecondValue -> true ; false),
	
	note(PerfectFifth, PerfectFifthValue),
	note(Fourth, FourthValue),
	(PerfectFifthValue =:= FourthValue -> true ; false).



%% CHORDS OF MINOR SCALE
i_chord_minor_scale(ScaleRoot, ChordRoot, PerfectThird, PerfectFifth) :-
	minor_scale(ScaleRoot, _, Third, _, Fifth, _, _),
	
	note(ChordRoot, ChordRootValue),
	note(ScaleRoot, ScaleRootValue),
	(ChordRootValue =:= ScaleRootValue -> true ; false),
	
	note(PerfectThird, PerfectThirdValue),
	note(Third, ThirdValue),
	(PerfectThirdValue =:= ThirdValue -> true ; false),
	
	note(PerfectFifth, PerfectFifthValue),
	note(Fifth, FifthValue),
	(PerfectFifthValue =:= FifthValue -> true ; false).

ii_chord_minor_scale(ScaleRoot, ChordRoot, PerfectThird, PerfectFifth) :-
	minor_scale(ScaleRoot, Second, _, Fourth, _, Sixth, _),
	
	note(ChordRoot, ChordRootValue),
	note(Second, SecondValue),
	(ChordRootValue =:= SecondValue -> true ; false),
	
	note(PerfectThird, PerfectThirdValue),
	note(Fourth, FourthValue),
	(PerfectThirdValue =:= FourthValue -> true ; false),
	
	note(PerfectFifth, PerfectFifthValue),
	note(Sixth, SixthValue),
	(PerfectFifthValue =:= SixthValue -> true ; false).

iii_chord_minor_scale(ScaleRoot, ChordRoot, PerfectThird, PerfectFifth) :-
	minor_scale(ScaleRoot, _, Third, _, Fifth, _, Seventh),
	
	note(ChordRoot, ChordRootValue),
	note(Third, ThirdValue),
	(ChordRootValue =:= ThirdValue -> true ; false),
	
	note(PerfectThird, PerfectThirdValue),
	note(Fifth, FifthValue),
	(PerfectThirdValue =:= FifthValue -> true ; false),
	
	note(PerfectFifth, PerfectFifthValue),
	note(Seventh, SeventhValue),
	(PerfectFifthValue =:= SeventhValue -> true ; false).

iv_chord_minor_scale(ScaleRoot, ChordRoot, PerfectThird, PerfectFifth) :-
	minor_scale(ScaleRoot, _, _, Fourth, _, Sixth, _),
	
	note(ChordRoot, ChordRootValue),
	note(Fourth, FourthValue),
	(ChordRootValue =:= FourthValue -> true ; false),
	
	note(PerfectThird, PerfectThirdValue),
	note(Sixth, SixthValue),
	(PerfectThirdValue =:= SixthValue -> true ; false),
	
	note(PerfectFifth, PerfectFifthValue),
	note(ScaleRoot, ScaleRootValue),
	(PerfectFifthValue =:= ScaleRootValue -> true ; false).

v_chord_minor_scale(ScaleRoot, ChordRoot, PerfectThird, PerfectFifth) :-
	minor_scale(ScaleRoot, Second, _, _, Fifth, _, Seventh),
	
	note(ChordRoot, ChordRootValue),
	note(Fifth, FifthValue),
	(ChordRootValue =:= FifthValue -> true ; false),
	
	note(PerfectThird, PerfectThirdValue),
	note(Seventh, SeventhValue),
	(PerfectThirdValue =:= SeventhValue -> true ; false),
	
	note(PerfectFifth, PerfectFifthValue),
	note(Second, SecondValue),
	(PerfectFifthValue =:= SecondValue -> true ; false).

vi_chord_minor_scale(ScaleRoot, ChordRoot, PerfectThird, PerfectFifth) :-
	minor_scale(ScaleRoot, _, Third, _, _, Sixth, _),
	
	note(ChordRoot, ChordRootValue),
	note(Sixth, SixthValue),
	(ChordRootValue =:= SixthValue -> true ; false),
	
	note(PerfectThird, PerfectThirdValue),
	note(ScaleRoot, ScaleRootValue),
	(PerfectThirdValue =:= ScaleRootValue -> true ; false),
	
	note(PerfectFifth, PerfectFifthValue),
	note(Third, ThirdValue),
	(PerfectFifthValue =:= ThirdValue -> true ; false).

vii_chord_minor_scale(ScaleRoot, ChordRoot, PerfectThird, PerfectFifth) :-
	minor_scale(ScaleRoot, Second, _, Fourth, _, _, Seventh),

	note(ChordRoot, ChordRootValue),
	note(Seventh, SeventhValue),
	(ChordRootValue =:= SeventhValue -> true ; false),
	
	note(PerfectThird, PerfectThirdValue),
	note(Second, SecondValue),
	(PerfectThirdValue =:= SecondValue -> true ; false),
	
	note(PerfectFifth, PerfectFifthValue),
	note(Fourth, FourthValue),
	(PerfectFifthValue =:= FourthValue -> true ; false).


%% TESTS WITH RANDO GENERATION
choice([X|_], [P|_], Cumul, Rand, X) :-
    Rand < Cumul + P.
choice([_|Xs], [P|Ps], Cumul, Rand, Y) :-
    Cumul1 is Cumul + P,
    Rand >= Cumul1,
    choice(Xs, Ps, Cumul1, Rand, Y).
choice([X], [P], Cumul, Rand, X) :-
    Rand < Cumul + P.

choice(Xs, Ps, Y) :- random(R), choice(Xs, Ps, 0, R, Y).


%% make_song(major, c, 4, 2).
%% select major chords
%% 2 times get 4 major chords
%% random number between 1 and 7 to choose chord

get_random_chord(Scale, ScaleRoot, CR, PT, PF) :- 
	(
		Scale = "major" -> 
			choice([1, 2, 3, 4, 5, 6, 7], [0.2, 0.1, 0.2, 0.2, 0.1, 0.1, 0.1], Y),
			format('~w : ', [Y]),
			( Y =:= 1 -> i_chord_major_scale(ScaleRoot, CR, PT, PF);
				( Y =:= 2 -> ii_chord_major_scale(ScaleRoot, CR, PT, PF);
					( Y =:= 3 -> iii_chord_major_scale(ScaleRoot, CR, PT, PF); 
						( Y =:= 4 -> iv_chord_major_scale(ScaleRoot, CR, PT, PF); 
							( Y =:= 5 -> v_chord_major_scale(ScaleRoot, CR, PT, PF);
								( Y =:= 6 -> vi_chord_major_scale(ScaleRoot, CR, PT, PF);
									( Y =:= 7 -> vii_chord_major_scale(ScaleRoot, CR, PT, PF);
										false
										)
									)
								)
							)
						)
					)
				)
			;
			choice([1, 2, 3, 4, 5, 6, 7], [0.2, 0.1, 0.2, 0.2, 0.1, 0.1, 0.1], Y),
			format('~w : ', [Y]),
			( Y =:= 1 -> i_chord_minor_scale(ScaleRoot, CR, PT, PF);
				( Y =:= 2 -> ii_chord_minor_scale(ScaleRoot, CR, PT, PF);
					( Y =:= 3 -> iii_chord_minor_scale(ScaleRoot, CR, PT, PF); 
						( Y =:= 4 -> iv_chord_minor_scale(ScaleRoot, CR, PT, PF); 
							( Y =:= 5 -> v_chord_minor_scale(ScaleRoot, CR, PT, PF);
								( Y =:= 6 -> vi_chord_minor_scale(ScaleRoot, CR, PT, PF);
									( Y =:= 7 -> vii_chord_minor_scale(ScaleRoot, CR, PT, PF);
										false
										)
									)
								)
							)
						)
					)
				)
	).

make_bar(Scale, ScaleRoot, Tempo) :-
	Tempo > 0,
	Tempo1 is Tempo-1,
	get_random_chord(Scale, ScaleRoot, N1, N2, N3), !,
	format('~w : ~w ~w ~w\n', [Tempo, N1, N2, N3]),
	make_bar(Scale, ScaleRoot, Tempo1).

make_music(Scale, ScaleRoot, Tempo, T, Bars, B) :- 

	( T =:= Tempo -> format('------\n') ; true ),
	( B > 0 ->
		( T > 1 -> T1 is T-1, B1 is B ; T1 is Tempo, B1 is B-1 ) ; false ),

	get_random_chord(Scale, ScaleRoot, N1, N2, N3), !,
	format('~w ~w ~w\n', [N1, N2, N3]),
	make_music(Scale, ScaleRoot, Tempo, T1, Bars, B1).
