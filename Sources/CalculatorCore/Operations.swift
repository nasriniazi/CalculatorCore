//
//  File.swift
//
//
//  Created by nasrin niazi on 2023-01-18.
//

import Foundation

public enum Operations:Hashable,CaseIterable{
    
    case binaryOperatins(BinaryOperations)
    case unaryOperations(UnaryOperatotions)
    case equal
    public static var allCases: [Operations]{
        return Operations.BinaryOperations.allCases.map(Operations.binaryOperatins) + Operations.UnaryOperatotions.allCases.map(Operations.unaryOperations)
    }
    public enum BinaryOperations: String, CaseIterable {
        case plus = "+"
        case minus = "-"
        case divide = "/"
        case multiply = "*"
//        case equal = "="
    }
    public enum UnaryOperatotions:String,CaseIterable {
        case cos = "Cos"
        case sin = "Sin"
    }
    public  var description:String{
        switch self {
        case .binaryOperatins(.plus):
            return "+"
        case .binaryOperatins(.minus):
            return "-"
        case .binaryOperatins(.divide):
            return "/"
        case .binaryOperatins(.multiply):
            return "*"
        case .unaryOperations(.cos):
            return "Cos"
        case .unaryOperations(.sin):
            return "Sin"
        case .equal:
            return "="
        }
    }
   public static var allValues:[String]{
        return Operations.allCases.map{$0.description}
    }

    
}

