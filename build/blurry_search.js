(function() {
  var StringHelper,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.BlurrySearch = (function() {
    function BlurrySearch(text) {
      this.text = text;
      this.search = __bind(this.search, this);
      if (!StringHelper.isString(this.text)) {
        throw new Error("Must specify text to search through");
      }
    }

    BlurrySearch.prototype.search = function(str) {
      var startIndex, text;
      if (!StringHelper.isString(str)) {
        throw new Error("Must specify search string");
      }
      text = new String(this.text).toLocaleLowerCase();
      str = str.toLocaleLowerCase();
      startIndex = text.indexOf(str);
      if (startIndex === -1) {
        return null;
      }
      return {
        startIndex: startIndex,
        endIndex: startIndex + str.length - 1,
        similarity: StringHelper.similarity(text, str)
      };
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

    StringHelper.percentDifference = function(stringA, stringB) {
      return (1 - this.similarity(stringA, stringB)) * 100;
    };

    StringHelper.removeNonWordCharacters = function(str) {
      return XRegExp.replace(str, XRegExp('[^0-9\\p{L}\\p{N}]'), "", 'all');
    };

    return StringHelper;

  })();

  this.BlurrySearch.StringHelper = StringHelper;

}).call(this);
