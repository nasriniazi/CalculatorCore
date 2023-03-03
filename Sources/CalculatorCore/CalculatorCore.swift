//
//  File.swift
//
//
//  Created by nasrin niazi on 2023-01-18.
//

import Foundation
import LogManager
import RxSwift
import RxCocoa

public struct Calculator{
    var newNumber:Decimal?
    public private(set) var tempResult:Decimal?
    public private(set) var gotError:Bool = false
    private var pendingBinaryOperation: PendingBinaryOperation?
    ///output result to display
    public var result: Decimal? {
        if pressedClear{
            return newNumber
        }
        return newNumber ?? pendingBinaryOperation?.firstNumber ?? tempResult
    }
    var pressedClear:Bool = false
    public var showAllClear: Bool {
        newNumber == nil && pendingBinaryOperation == nil && tempResult == nil || pressedClear
    }
    
    public init() {}
    
    /// Calculation function using our two numbers and the operator
    public mutating func calculate(number1: Decimal, op: Operations.BinaryOperations, number2: Decimal) throws -> Decimal {
        Log.basicOperation.log("you are going to calcuate opearation \(op.rawValue) on number1=\(number1) and number2=\(number2)")
        switch op {
        case .plus:
            Log.basicOperation.debug("plus return value=\(number1 + number2)")
            
            return number1 + number2
        case .minus:
            Log.basicOperation.debug("minus return value=\(number1 - number2)")
            
            return number1 - number2
        case .divide:
            return try divide(dividend: number1, by: number2)
            
        case .multiply:
            Log.basicOperation.debug("multiply return value=\(number1 * number2)")
            
            return number1 * number2
        }
    }
    
    
    public mutating  func calculate(opStr: String) throws{
        
        if let operation = Operations.BinaryOperations(rawValue: opStr){
            guard var number = newNumber ?? tempResult else {
                Log.basicOperation.fault("first Number is nil")
                return}
            Log.basicOperation.debug(" calculat operation \(opStr) with first Number= \(number) ")
            if  pendingBinaryOperation != nil{
                
                number = try calculatePendingBinaryOperation(with: number)
            }
            Log.basicOperation.debug("you are going to create pending calculation \(opStr) on first Number= \(number) ")
            
            pendingBinaryOperation = PendingBinaryOperation(firstNumber: number, op: operation)
            newNumber = nil
        }
    }
    public mutating  func calculateUnary(opStr: String) throws{
        if let number = newNumber {
            newNumber = try? calculateUnaryOperation(number: number,opStr: opStr)
            return
        }
        if let number = tempResult {
            tempResult = try? calculateUnaryOperation(number: number,opStr: opStr)
            return
        }
        pendingBinaryOperation = nil
    }
    
    public mutating func calculateUnaryOperation(number:Decimal,opStr: String)throws->Decimal{
        if let operation = Operations.UnaryOperatotions(rawValue: opStr){
            var numberDouble = Double(truncating: number as NSNumber)
            numberDouble = fmod(numberDouble, 360);
            if (numberDouble > 270) {numberDouble -= 360}
            else if (numberDouble > 90){ numberDouble = 180 - numberDouble}
            switch operation {
            case .cos:
                return Decimal(cos(numberDouble * .pi/180.0))
            case .sin:
                return Decimal(sin(numberDouble * .pi/180.0))
            }
        }
        else{
            throw(OperationError.Unknown)
        }
    }
    
    public mutating func evaluate()throws{
        if gotError {
            Log.basicOperation.error("\(OperationError.NotNumber.description)")
            throw OperationError.NotNumber
        }
        
        guard let number = newNumber, pendingBinaryOperation != nil else { return }
        tempResult = try calculatePendingBinaryOperation(with: number)
        pendingBinaryOperation = nil
        newNumber = nil
    }
    
    private mutating func calculatePendingBinaryOperation(with secondNumber:Decimal) throws ->Decimal{
        Log.basicOperation.debug("calculatePendingBinaryOperation with second Number= \(secondNumber)")
        
        let result = try calculate(number1: pendingBinaryOperation!.firstNumber, op: pendingBinaryOperation!.op, number2: secondNumber)
        return result
        
    }
    
    ///set newNumber
    public mutating func setNumber(digit:Decimal){
        Log.calculatorSetup.debug("initilize newNumber with digit=\(digit)")
        newNumber = digit
        pressedClear = false
    }
    private struct PendingBinaryOperation{
        let firstNumber:Decimal
        let op:Operations.BinaryOperations
    }
    
    private   mutating func divide(dividend: Decimal, by divisor: Decimal) throws -> Decimal {
        /// throw error if divide by 0
        if divisor == 0 {
            gotError = true
            Log.calculatorSetup.debug("set gotError flag true")
            Log.basicOperation.error("\(OperationError.DevisionByZero.description)")
            throw OperationError.DevisionByZero
        }
        Log.basicOperation.debug("divide return value=\(dividend / divisor)")
        return dividend / divisor
    }
    public mutating func clearAll(){
        Log.calculatorSetup.debug("clearAll method set tempResult nil")
        Log.calculatorSetup.debug("clearAll method set gotError flag false")
        newNumber = nil
        pendingBinaryOperation = nil
        gotError = false
        tempResult = nil
    }
    public mutating func clear() {
        Log.calculatorSetup.debug("clear method")
        newNumber = nil
        gotError = false
        pressedClear = true
    }
    ///determine whether an operation is active or not
    public func isActiveOperation(opStr:String)->Bool{
        guard let operation = Operations.BinaryOperations(rawValue: opStr) else {return false}
        
        return pendingBinaryOperation?.op == operation && newNumber == nil
    }
}

///enum for error handling
public enum OperationError:String, LocalizedError{
    case DevisionByZero = "Devision by zero Error"
    case NotNumber = "Not a number"
    case Unknown = "Unknown Error"
    public var description: String { return NSLocalizedString(self.rawValue, comment: "Calculator") }
    
}


