(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.BlurrySearch = (function() {
    var isString,
      _this = this;

    function BlurrySearch(text) {
      this.text = text;
      this.search = __bind(this.search, this);
      if (!isString(this.text)) {
        throw new Error("Must specify text to search through");
      }
    }

    BlurrySearch.prototype.search = function(str) {
      if (!isString(str)) {
        throw new Error("Must specify search string");
      }
    };

    isString = function(obj) {
      if (obj == null) {
        return false;
      }
      return typeof obj === "string" || (typeof obj === "object" && obj.constructor === String);
    };

    return BlurrySearch;

  }).call(this);

}).call(this);
