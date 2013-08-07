[![Build Status](https://secure.travis-ci.org/6/blurry_search.coffee.png?branch=master)](http://travis-ci.org/6/blurry_search.coffee)

Example usage:
```coffeescript
b = new BlurrySearch("Harry Potter has no idea how famous he is.")
b.tag("...NO IDEA? how~Famous!!", "em", {class: 'highlight'})
```

Returns:
```coffeescript
"Harry Potter has <em class='highlight'>no idea how famous</em> he is."
```
---
Works with searching unicode:
```coffeescript
b = new BlurrySearch("★あっ！〜モぉ、どうしよう？（笑）")
b.tag("ど〜うしよう‥", "span")
```

Returns:
```coffeescript
"★あっ！〜モぉ、<span>どうしよう</span>？（笑）"
```
---
Access to matching indices in original text:
```coffeescript
b = new BlurrySearch("A meek hobbit of The Shire and eight companions set out")
b.search("Hobbit! Of the ~shire")
```

Returns:
```coffeescript
{ startIndex: 7, endIndex: 25 }
```
