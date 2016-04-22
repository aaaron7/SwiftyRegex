//
//  main.swift
//  Regex
//
//  Created by aaaron7 on 16/4/21.
//  Copyright © 2016年 aaaron7. All rights reserved.
//

import Foundation

indirect enum Regex{
    case Char(Character)
    case Concat(Regex,Regex)
    case Alter(Regex,Regex)
    case ZeroOrOne(Regex)
    case ZeroOrMore(Regex)
    case OneOrMore(Regex)
}

enum Status{
    case SinglePass(Character)
    case Split
    case Match
}


func matcher(reg : Regex, str : String) -> Bool{
    return matcherHelper(reg, str: str, cont: {_ in true})
}

func matcherHelper(reg: Regex , str : String, cont: String-> Bool) -> Bool{
    switch reg {
    case .Concat(let reg1 ,let reg2):
        return matcherHelper(reg1, str: str, cont: { (rest) -> Bool in
            return matcherHelper(reg2, str: rest, cont: cont)
        })
    case .Char(let c):
        return c == str.characters.first! && cont(String(str.characters.dropFirst()))
    case .Alter(let reg1 , let reg2):
        return matcherHelper(reg1, str: str, cont: cont) || matcherHelper(reg2, str: str, cont: cont)
    case .ZeroOrOne(let reg):
        return matcherHelper(reg, str: str, cont: cont) || cont(str)
    case .ZeroOrMore(let reg):
        return matcherHelper(reg, str: str, cont: {rest in matcherHelper(reg, str: rest, cont: cont)}) || cont(str)
    case .OneOrMore(let reg):
        return matcherHelper(reg, str: str, cont: { (rest) -> Bool in
            matcherHelper(reg, str: rest, cont: cont) || cont(rest)
        })
    }
}

let reg1:Regex = .Concat(.Char("c"),.Char("a"))
let reg2 : Regex = .OneOrMore(reg1)

let result = matcher(reg2, str: "cacacabd")

print(result)



print("Hello, World!")

