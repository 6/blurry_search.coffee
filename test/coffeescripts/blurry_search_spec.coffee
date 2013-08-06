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
