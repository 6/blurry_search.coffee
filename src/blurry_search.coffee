class @BlurrySearch
  constructor: (@text) ->
    throw new Error("Must specify text to search through") unless StringHelper.isString(@text)

  search: (str) =>
    throw new Error("Must specify search string") unless StringHelper.isString(str)

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

  @percentDifference: (stringA, stringB) ->
    @characterDifferences(stringA, stringB).length / (stringA + stringB).length * 100

@BlurrySearch.StringHelper = StringHelper
