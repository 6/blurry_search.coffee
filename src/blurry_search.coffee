class @BlurrySearch
  constructor: (@text) ->
    throw new Error("Must specify text to search through") unless StringHelper.isString(@text)

  # Input: substring to search for
  # Output:
  #  If no match - returns null
  #  If match - returns object containing the following properties:
  #    startIndex: start index of matched substring in text
  #    endIndex: end index of matched substring in text
  #    similarity: float between 0 and 1 indicating how similar match is (closer to 1 is more similar)
  search: (str) =>
    throw new Error("Must specify search string") unless StringHelper.isString(str)
    text = new String(@text).toLocaleLowerCase()
    str = str.toLocaleLowerCase()

    startIndex = text.indexOf(str)
    return null if startIndex == -1
    {
      startIndex: startIndex
      endIndex: startIndex + str.length - 1
      similarity: StringHelper.similarity(text, str)
    }

class StringHelper
  @isString: (obj) ->
    return false unless obj?
    typeof obj == "string" || (typeof obj == "object" && obj.constructor == String)

  @characterDifferences: (stringA, stringB) ->
    diffs = []
    charsA = stringA.split("")
    charsB = stringB.split("")
    while charsA.length > 0
      charA = charsA.pop()
      indexB = charsB.indexOf(charA)
      if indexB == -1
        diffs.push(charA)
      else
        charsB.splice(indexB, 1)
    diffs.concat(charsB)

  @similarity: (stringA, stringB) ->
    1 - (@characterDifferences(stringA, stringB).length / (stringA + stringB).length)

  @percentDifference: (stringA, stringB) ->
    (1 - @similarity(stringA, stringB)) * 100

@BlurrySearch.StringHelper = StringHelper
