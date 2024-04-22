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
