@exports ?= {}

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
    text = StringHelper.normalize(@text)
    str = StringHelper.normalize(str)

    textResult = StringHelper.removeNonWordCharacters(text)
    strResult = StringHelper.removeNonWordCharacters(str)

    startIndex = textResult.str.indexOf(strResult.str)
    return null if startIndex == -1

    # Reconstruct indices based on `removed`
    endIndex = startIndex + strResult.str.length - 1
    startIndexFinal = null
    endIndexFinal = null
    i = 0
    while textResult.removed.length > 0
      removed = textResult.removed.shift()
      if removed.index > startIndex + i
        startIndexFinal ?= startIndex + i
      if removed.index > endIndex + i
        endIndexFinal ?= endIndex + i
        break
      i += 1

    {
      startIndex: startIndexFinal
      endIndex: endIndexFinal
      confidence: StringHelper.similarity(text.substring(startIndexFinal, endIndexFinal + 1), str)
    }

  formatMatch: (searchText, formatString) =>
    result = @search(searchText)
    textCopy = new String(@text)
    if result?
      textToSurround = textCopy.substring(result.startIndex, result.endIndex + 1)
      textCopy.substring(0, result.startIndex) +
        formatString.replace(/<%=\s*?match\s*?%>/, textToSurround) +
        textCopy.substring(result.endIndex + 1)
    else
      textCopy

class StringHelper
  @isString: (obj) ->
    return false unless obj?
    typeof obj == "string" || (typeof obj == "object" && obj.constructor == String)

  @normalize: (str) ->
    str = exports.remove(new String(str))
    str.toLocaleLowerCase()

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

  @removeNonWordCharacters: (str) ->
    # Keep track of removed substrings and their start indices
    removed = []
    newStr = new String(str)
    XRegExp.forEach str, XRegExp('[^0-9\\p{L}\\p{N}]'), (match, i) ->
      relativeIndex = match.index - i
      newStr = newStr.substring(0, relativeIndex) + newStr.substring(relativeIndex + 1)
      removed.push({char: match[0], index: match.index})
    {str: newStr, removed: removed}

@BlurrySearch.StringHelper = StringHelper
