describe "BlurrySearch", ->
  describe "constructor", =>
    context "`text` is falsy or not a string", =>
      sharedBehaviorForThrowsAnError =>
        new BlurrySearch(null)
      , /Must specify text/

      sharedBehaviorForThrowsAnError =>
        new BlurrySearch(123)
      , /Must specify text/

    context "`text` is truthy and a string", =>
      it "does not throw an error", =>
        new BlurrySearch("test")
        new BlurrySearch(new String("what"))

  describe "#search", =>
    beforeEach =>
      @subject = new BlurrySearch("text")

    context "search string is falsy or not a string", =>
      sharedBehaviorForThrowsAnError =>
        @subject.search(null)
      , /Must specify search/

      sharedBehaviorForThrowsAnError =>
        @subject.search(123)
      , /Must specify search/

    context "search string is truthy and a string", =>
      it "does not throw an error", =>
        @subject.search("...")

    context "when there is no match", =>
      it "returns a falsy value", =>
        subject = new BlurrySearch("hello")
        expect(subject.search("hi")).toBeFalsy()

    context "when the search string is longer than text", =>
      it "returns a falsy value", =>
        subject = new BlurrySearch("yo")
        expect(subject.search("yoyo")).toBeFalsy()

    context "with variable-case strings", =>
      it "produces a match", =>
        subject = new BlurrySearch("sup Hello WOrld yo!!")
        result = subject.search("hellO WORLD")
        expect(result).toBeTruthy()
        expect(result.startIndex).toEqual(4)
        expect(result.endIndex).toEqual(14)

    context "with variable non-letter characters", =>
      it "produces a match", =>
        subject = new BlurrySearch(" row, row your*~boat!!!")
        result = subject.search("RowYour boat??")
        expect(result).toBeTruthy()
        expect(result.startIndex).toEqual(6)
        expect(result.endIndex).toEqual(19)

    context "with diacritics", =>
      it "produces a match", =>
        subject = new BlurrySearch("the ⓘnternảtḯonǎlḭzatiǿn of baseball")
        result = subject.search("IлｔèｒｎåｔïｏｎɑｌíƶａｔïꝊԉ")
        expect(result).toBeTruthy()
        expect(result.startIndex).toEqual(4)
        expect(result.endIndex).toEqual(23)

  describe "#formatMatch", =>
    context "with a match", =>
      it "surrounds matching text using the given format string", =>
        subject = new BlurrySearch("Harry Potter has no idea how famous he is.")
        result = subject.formatMatch("...NO IDEA?   how~Famous!!!", "<em class='highlight'><%= match %></em>")
        expect(result).toEqual("Harry Potter has <em class='highlight'>no idea how famous</em> he is.")

      it "works when the format string uses variable spacing", =>
        subject = new BlurrySearch("A meek hobbit of The Shire")
        result = subject.formatMatch("Hobbit_OfThe", "<h1><%=match  %></h1>")
        expect(result).toEqual('A meek <h1>hobbit of The</h1> Shire')

    context "without a match", =>
      it "returns unmodified text", =>
        subject = new BlurrySearch("Original text!!")
        result = subject.formatMatch("Nope", "<em><%= match %></em>")
        expect(result).toEqual("Original text!!")
