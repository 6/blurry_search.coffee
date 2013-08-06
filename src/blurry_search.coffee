class @BlurrySearch
  constructor: (@text) ->
    throw new Error("Must specify text to search through") unless isString(@text)

  search: (str) =>
    throw new Error("Must specify search string") unless isString(str)

  # Private

  isString = (obj) =>
    return false unless obj?
    typeof obj == "string" || (typeof obj == "object" && obj.constructor == String)
