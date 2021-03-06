(function() {
  var StringHelper,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  if (this.exports == null) {
    this.exports = {};
  }

  this.BlurrySearch = (function() {
    function BlurrySearch(text) {
      this.text = text;
      this.formatMatch = __bind(this.formatMatch, this);
      this.search = __bind(this.search, this);
      if (!StringHelper.isString(this.text)) {
        throw new Error("Must specify text to search through");
      }
    }

    BlurrySearch.prototype.search = function(str) {
      var endIndex, endIndexFinal, i, removed, startIndex, startIndexFinal, strResult, text, textResult;
      if (!StringHelper.isString(str)) {
        throw new Error("Must specify search string");
      }
      text = StringHelper.normalize(this.text);
      str = StringHelper.normalize(str);
      textResult = StringHelper.removeNonWordCharacters(text);
      strResult = StringHelper.removeNonWordCharacters(str);
      startIndex = textResult.str.indexOf(strResult.str);
      if (startIndex === -1) {
        return null;
      }
      endIndex = startIndex + strResult.str.length - 1;
      startIndexFinal = null;
      endIndexFinal = null;
      i = 0;
      while (textResult.removed.length > 0) {
        removed = textResult.removed.shift();
        if (removed.index > startIndex + i) {
          if (startIndexFinal == null) {
            startIndexFinal = startIndex + i;
          }
        }
        if (removed.index > endIndex + i) {
          if (endIndexFinal == null) {
            endIndexFinal = endIndex + i;
          }
          break;
        }
        i += 1;
      }
      return {
        startIndex: startIndexFinal,
        endIndex: endIndexFinal,
        confidence: StringHelper.similarity(text.substring(startIndexFinal, endIndexFinal + 1), str)
      };
    };

    BlurrySearch.prototype.formatMatch = function(searchText, formatString) {
      var result, textCopy, textToSurround;
      result = this.search(searchText);
      textCopy = new String(this.text);
      if (result != null) {
        textToSurround = textCopy.substring(result.startIndex, result.endIndex + 1);
        return textCopy.substring(0, result.startIndex) + formatString.replace(/<%=\s*?match\s*?%>/, textToSurround) + textCopy.substring(result.endIndex + 1);
      } else {
        return textCopy;
      }
    };

    return BlurrySearch;

  })();

  StringHelper = (function() {
    function StringHelper() {}

    StringHelper.isString = function(obj) {
      if (obj == null) {
        return false;
      }
      return typeof obj === "string" || (typeof obj === "object" && obj.constructor === String);
    };

    StringHelper.normalize = function(str) {
      str = exports.remove(new String(str));
      return str.toLocaleLowerCase();
    };

    StringHelper.characterDifferences = function(stringA, stringB) {
      var charA, charsA, charsB, diffs, indexB;
      diffs = [];
      charsA = stringA.split("");
      charsB = stringB.split("");
      while (charsA.length > 0) {
        charA = charsA.pop();
        indexB = charsB.indexOf(charA);
        if (indexB === -1) {
          diffs.push(charA);
        } else {
          charsB.splice(indexB, 1);
        }
      }
      return diffs.concat(charsB);
    };

    StringHelper.similarity = function(stringA, stringB) {
      return 1 - (this.characterDifferences(stringA, stringB).length / (stringA + stringB).length);
    };

    StringHelper.removeNonWordCharacters = function(str) {
      var newStr, removed;
      removed = [];
      newStr = new String(str);
      XRegExp.forEach(str, XRegExp('[^0-9\\p{L}\\p{N}]'), function(match, i) {
        var relativeIndex;
        relativeIndex = match.index - i;
        newStr = newStr.substring(0, relativeIndex) + newStr.substring(relativeIndex + 1);
        return removed.push({
          char: match[0],
          index: match.index
        });
      });
      return {
        str: newStr,
        removed: removed
      };
    };

    return StringHelper;

  })();

  this.BlurrySearch.StringHelper = StringHelper;

}).call(this);
