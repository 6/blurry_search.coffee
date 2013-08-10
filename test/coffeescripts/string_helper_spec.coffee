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

  describe ".normalize", =>
    it "converts ASCII to lowercase", =>
      expect(@subject.normalize("TesT")).toEqual("test")

    it "converts to locale lowercase", =>
      expect(@subject.normalize("İ")).toEqual("i")

    it "removes diacritics", =>
      expect(@subject.normalize("ảèⓘǿÛ")).toEqual("aeiou")

  describe ".characterDifferences", =>
    it "returns an array of non-unique differences between two strings", =>
      diffs = @subject.characterDifferences("hello world", "hello hoo world!")
      expect(diffs.sort()).toEqual([' ', '!', 'h', 'o','o'])

      diffs2 = @subject.characterDifferences("112344","1112")
      expect(diffs2.sort()).toEqual(["1", "3", "4", "4"])

  describe ".similarity", =>
    it "returns a range from 0 to 1 indicating similarity between to strings", =>
      similarity = @subject.similarity("hello world", "hello hoo world!")
      expect(Math.round(similarity * 100)).toEqual(81)

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
