[![Build Status](https://secure.travis-ci.org/6/blurry_search.coffee.png?branch=master)](http://travis-ci.org/6/blurry_search.coffee)

Example usage:
```coffeescript
b = new BlurrySearch("Harry Potter has no idea how famous he is.")
b.formatMatch("...NO IDEA? how~Famous!!", "<em><%= match %></em>")
# Returns:
"Harry Potter has <em>no idea how famous</em> he is."
```
---
Use `search` to get matching indices in original text:
```coffeescript
b = new BlurrySearch("A meek hobbit of The Shire and eight companions set out")
b.search("Hobbit! Of the ~shire")
# Returns match indices and match confidence range from 0 (less confident) to 1:
{ startIndex: 7, endIndex: 25, confidence: 0.95 }
```
---
Works with unicode:
```coffeescript
b = new BlurrySearch("★あっ！〜モぉ、どうしよう？（笑）")
b.formatMatch("ど〜うしよう‥", "match found -> <%= match %> <-")
# Returns:
"★あっ！〜モぉ、match found -> どうしよう <-？（笑）"
```
---
Works with diacritics:
```coffeescript
b = new BlurrySearch("the ⓘnternảtḯonǎlḭzatiǿn of baseball")
b.formatMatch("IлｔèｒｎåｔïｏｎɑｌíƶａｔïꝊԉ", "<span><%= match %></span>")
# Returns:
"the <span>ⓘnternảtḯonǎlḭzatiǿn</span> of baseball"
```
