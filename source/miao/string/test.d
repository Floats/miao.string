module miao.string.test;

version(unittest) {
    private auto runTpl(alias fnTpl)()
    {
        assert(fnTpl([1, 2], [0, 1, 2]) == -1);
        assert(fnTpl([0, 1, 2], [1, 2]) == 1);

        immutable x = [1, 2, 3];
        assert(fnTpl([1, 2, 3, 4], x) == 0);

        const(int)[] y = [1, 2, 3];
        assert(fnTpl([1, 2, 3, 4], y) == 0);
    }

    private auto runCreate(alias T)()
    {
        auto a = T!(string)("");
        const b = T!(string)("");
        immutable c = T!(string)("");
    }

	private auto runTest(alias fn) ()
	{
		const haystack1 = "NOW AN FOWE\220ER ANNMAN THE ANPANMANEND";
		const needle1 = "ANPANMAN";
		const needle2 = "MAN THE";
		const needle3 = "WE\220ER";
		const needle4 = "NOW ";
		const needle5 = "NEND";
		const needle6 = "NOT FOUND";
		const needle7 = "NOT FO\340ND";

		const haystack2 = "ABC ABCDAB ABCDABCDABDE";
		const needle11 = "ABCDABD";
			
		const haystack3 = "abra abracad abracadabra";
		const needle12 = "abracadabra";
		const needle13 = "";

		const haystack4 = "";

		import std.conv : to;

		assert(fn("", "") == -1);
		assert(fn("abc", "") == -1);
		assert(fn("", " ") == -1);

		assert(fn("abc", "a") == 0);
		assert(fn("abcd", "bc") == 1, fn("abcd", "bc").to!string);

		assert(fn(haystack1, needle1) == 26);
		assert(fn(haystack1, needle2) == 18);
		assert(fn(haystack1, needle3) == 9);
		assert(fn(haystack1, needle4) == 0);
		assert(fn(haystack1, needle5) == 33);
		assert(fn(haystack1, needle6) == -1);
		assert(fn(haystack1, needle7) == -1);
			
		assert(fn(needle1, haystack1) == -1);

		assert(fn(haystack1, haystack1) == 0, fn(haystack1, haystack1).to!string);
		assert(fn(haystack2, haystack2) == 0);

		assert(fn(haystack2, needle11) == 15, fn(haystack2, needle11).to!string);
		assert(fn(haystack3, needle12) == 13);

		assert(fn(haystack1, needle13) == -1);
		assert(fn(haystack4, needle1) == -1);

		assert(fn("GCATCGCAGAGAGTATACAGTACG", "GCAGAGAG") == 5);
	}	

    auto testAll(alias Type, alias Searcher)()
    {
        import std.stdio;

        writeln("Test ", Type.stringof);

        runTest!Searcher();
        runCreate!Type();
        runTpl!Searcher();
        writeln("\tTest Passed!\n");
    }
}