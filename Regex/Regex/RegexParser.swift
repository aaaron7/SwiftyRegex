//
//  RegexParser.swift
//  Regex
//
//  Created by aaaron7 on 16/4/21.
//  Copyright © 2016年 aaaron7. All rights reserved.
//

import Foundation

let reserved = "+?()|*"
//
//func plain() -> Parser<Regex>{
//    func pred(c : Character) -> Bool{
//        return reserved.characters.indexOf(c) == nil
//    }
//
//    return many1loop(satisfy(pred)) >>= { cs in
//        pure(.Plain(cs))
//    }
//}
//
//func bracket() -> Parser<Regex>{
//    symbol("(") >>= {
//
//    }
//}