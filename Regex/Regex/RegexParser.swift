//
//  RegexParser.swift
//  Regex
//
//  Created by aaaron7 on 16/4/21.
//  Copyright © 2016年 aaaron7. All rights reserved.
//

import Foundation

let reserved = "+?()|*"

indirect enum Regex{
    case Char(Character)
    case Concat(Regex,Regex)
    case Alter(Regex,Regex)
    case ZeroOrOne(Regex)
    case ZeroOrMore(Regex)
    case OneOrMore(Regex)
}

func notReserved(c : Character) -> Bool{
    return reserved.characters.indexOf(c) == nil
}

func rchar()->Parser<Regex>{
    return satisfy(notReserved) >>= { c in
        pure(.Char(c))
    }
}

func regop(c : Character) -> (Regex->Regex)?{
    if c == "?"{
        return { reg in
            .ZeroOrOne(reg)
        }
    }else if c == "*"{
        return { reg in
            .ZeroOrMore(reg)
        }
    }else if c == "+"{
        return { reg in
            .OneOrMore(reg)
        }
    }
    return nil
}

func rexp() -> Parser<Regex>{
    return (rtrm() >>= {term in
        symbol("|") >>= { _ in
            rexp() >>= { exp in
                pure(.Alter(term,exp))
            }
        }
    }) +++ rtrm()
}

func ratm() -> Parser<Regex>{
    return rchar() +++ (symbol("(") >>= { _ in
        rexp() >>= { reg in
            symbol(")") >>= { _ in
                pure(reg)
            }
        }
    })
}

func rfac() -> Parser<Regex>{
    return (ratm() >>= {atm in
        satisfy({sc in sc == "*" || sc == "?" || sc == "+"}) >>= {c in
            pure(regop(c)!(atm))
        }
    })  +++ ratm()
}


func rtrm() -> Parser<Regex>{
    return (rfac() >>= { reg1 in
        rtrm() >>= { reg2 in
            pure(.Concat(reg1,reg2))
        }
    }) +++ rfac()
}


