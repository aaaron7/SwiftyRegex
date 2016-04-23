# SwiftyRegex

SwiftyRegex is a minimum implementation of Regular expression engine, which consist of two component:

- Parser, convert regular expression string, like `a(bc|b*)` to regular syntax tree. in `RegexParser.swift`
- Matcher, do match operation to input string by previous syntax tree. in `main.swift`

## Support Syntax

- () Group
- | Alternative
- abc  Concatenation
- * Zero or more
- + One or more
- ? Zero or one

## Play with it

```
let result = regexMatch("a(bc|b*)", source: "abbbbbbbbbbbb")

print(result)
```
