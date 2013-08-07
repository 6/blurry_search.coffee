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
        expect(result.startIndex).toEqual(4)
        expect(result.endIndex).toEqual(14)

describe "StringHelper", ->
  beforeEach =>
    @subject = BlurrySearch.StringHelper

  describe ".isString", =>
    it "returns false for non-Strings", =>
      expect(@subject.isString(123)).toBe(false)
      expect(@subject.isString(null)).toBe(false)
      expect(@subject.isString(false)).toBe(false)
      expect(@subject.isString(true)).toBe(false)
      expect(@subject.isString(undefined)).toBe(false)
      expect(@subject.isString(new Object())).toBe(false)

    it "returns true for Strings", =>
      expect(@subject.isString("ok")).toBe(true)
      expect(@subject.isString(new String("ok"))).toBe(true)

  describe ".characterDifferences", =>
    it "returns an array of non-unique differences between two strings", =>
      diffs = @subject.characterDifferences("hello world", "hello hoo world!")
      expect(diffs.sort()).toEqual([' ', '!', 'h', 'o','o'])

      diffs2 = @subject.characterDifferences("112344","1112")
      expect(diffs2.sort()).toEqual(["1", "3", "4", "4"])

  describe ".percentDifference", =>
    it "returns the percent difference between to strings", =>
      percent = @subject.percentDifference("hello world", "hello hoo world!")
      expect(Math.round(percent)).toEqual(19)

  describe ".removeNonWordCharacters", =>
    it "removes punctuation and spaces", =>
      result = @subject.removeNonWordCharacters("yo! What's UP?? 1234")
      expect(result.str).toEqual("yoWhatsUP1234")

    it "returns a 'stack' of removed characters and their indices", =>
      result = @subject.removeNonWordCharacters("What's up?")
      expect(result.removed).toEqual([
        {char: "'", index: 4}
        {char: ' ', index: 6}
        {char: '?', index: 9}
      ])

    it "works with unicode characters", =>
      result = @subject.removeNonWordCharacters("★あっ！〜モぉ、どうしよう？（笑）１２３")
      expect(result.str).toEqual("あっモぉどうしよう笑１２３")
