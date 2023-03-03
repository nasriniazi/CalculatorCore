import XCTest
@testable import CalculatorCore

final class CalculatorCoreTests: XCTestCase {
    var calculator: Calculator!
    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }
    func testConversionString_ToDecimal_isNotNil(){
        let inputString = "999999999"
        let decimalOutput = Decimal(string: inputString)
        XCTAssertNotEqual(decimalOutput, nil)
    }
    func testConversionString_ToDecimal_NotThrowError(){
        let inputString = "999999999"
        let decimalOutput = Decimal(string: inputString)
        XCTAssertNoThrow(decimalOutput!)
    }
    func testAddition()  {
        // Arrange
        let first:Decimal = 1.0
        let second:Decimal = 2.0
        let expectedSum:Decimal = 3.0
        // Act
        let actualSum = try! calculator.calculate(number1: first, op: Operations.BinaryOperations.plus, number2: second)
        
        // Assert
        XCTAssertEqual(actualSum, expectedSum)
    }
    func testAddition_WithTwoNegative()  {
        let first:Decimal = -2.0
        let second:Decimal = -20.0
        let expectedResult:Decimal = -22.0
        let actualSum = try! calculator.calculate(number1: first, op: Operations.BinaryOperations.plus, number2: second)
        XCTAssertEqual(actualSum, expectedResult, "sum of -2.0 and -22.0 should be -22.0")
        
    }
    func testAddition_WithOneNegative_OnePositive()  {
        let first:Decimal = 10.0
        let second:Decimal = -2.0
        let expectedResult:Decimal = 8.0
        let actualSum =  try!calculator.calculate(number1: first, op: Operations.BinaryOperations.plus, number2: second)
        XCTAssertEqual(actualSum, expectedResult, "sum of -2.0 and 10.0 should be 8.0")
        
    }
    func testAddition_With_Decimals()  {
        let first:Decimal = Decimal(string:"0.0003")!
        let second:Decimal = Decimal(string:"0.00004")!
        let expectedResult:Decimal = 0.00034
        let actualSum = try! calculator.calculate(number1: first, op: Operations.BinaryOperations.plus, number2: second)
        XCTAssertEqual(actualSum, expectedResult, "sum of 0.0003 and 0.00004 should be 0.00034")
    }
    func testAddition_NotThrowError(){
        let first:Decimal = 10.0
        let second:Decimal = -2.0
        
        XCTAssertNoThrow(try calculator.calculate(number1: first, op: Operations.BinaryOperations.plus, number2: second))
    }
    func testSubtraction () {
        // Arrange
        let first:Decimal = 10.0
        let second:Decimal = 3.0
        let expectedResult:Decimal = 7.0
        
        // Act
        let actualSub =  try! calculator.calculate(number1: first, op: Operations.BinaryOperations.minus, number2: second)
        
        // Assert
        XCTAssertEqual(actualSub, expectedResult)
    }
    
    func testMultiplication () {
        // Arrange
        let first:Decimal = 10.0
        let second:Decimal = 3.0
        let expectedResult:Decimal = 30.0
        
        // Act
        let actualMultiply = try! calculator.calculate(number1: first, op: Operations.BinaryOperations.multiply, number2: second)
        
        // Assert
        XCTAssertEqual(actualMultiply, expectedResult)
    }
    func testMultiplication_WithOnePositive_OneNegative(){
        let first:Decimal = -10.0
        let second:Decimal = 3.0
        let expectedResult:Decimal = -30.0
        
        // Act
        let actualMultiply = try! calculator.calculate(number1: first, op: Operations.BinaryOperations.multiply, number2: second)
        
        // Assert
        XCTAssertEqual(actualMultiply, expectedResult)
    }
    func testMultiplication_WithTwoNegative(){
        let first:Decimal = -10.0
        let second:Decimal = -3.0
        let expectedResult:Decimal = 30.0
        // Act
        let actualMultiply = try! calculator.calculate(number1: first, op: Operations.BinaryOperations.multiply, number2: second)
        // Assert
        XCTAssertEqual(actualMultiply, expectedResult)
    }
    
    func testDevision () {
        // Arrange
        let first:Decimal = 10.0
        let second:Decimal = 2.0
        let expectedResult:Decimal = 5.0
        
        // Act
        let actualDevide = try! calculator.calculate(number1: first, op: Operations.BinaryOperations.divide, number2: second)
        
        // Assert
        XCTAssertEqual(actualDevide, expectedResult)
    }
    
    func testThrowError_When_DivideByZero(){
        let first:Decimal = Decimal(string:"0.0003")!
        let second:Decimal = Decimal(string:"0")!
        XCTAssertThrowsError(try calculator.calculate(number1: first, op: Operations.BinaryOperations.divide, number2: second)
        )
    }
    func testThrowError_When_Zero_DivideByZero(){
        //test 0/0
        let first:Decimal = Decimal(string:"0.0")!
        let second:Decimal = Decimal(string:"0")!
        XCTAssertThrowsError(try calculator.calculate(number1: first, op: Operations.BinaryOperations.divide, number2: second)
        )
    }
    func testUnaryOperation_Sin(){
        let first:Decimal = Decimal(string:"90.0")!
        let expectedResult:Decimal = 1.0
        let actualSin = try! calculator.calculateUnaryOperation(number: first, opStr: "Sin")
        XCTAssertEqual(actualSin, expectedResult)
        
    }
    func testUnaryOperation_Cos(){
        let first:Decimal = Decimal(string:"360.0")!
        let expectedResult:Decimal = 1.0
        let actualSin = try! calculator.calculateUnaryOperation(number: first, opStr: "Cos")
        XCTAssertEqual(actualSin, expectedResult)
    }
    func testAllClear() {
        let inputDigit:Decimal = 21
        calculator.setNumber(digit: inputDigit)
        calculator.clearAll()
        XCTAssertEqual(calculator.result, 0)
    }
    
    func testSetInputDigit_To_CalculatorCore(){
        let inputDigit:Decimal = 21
        calculator.setNumber(digit: inputDigit)
        let newNumber = calculator.newNumber
        XCTAssertEqual(inputDigit, newNumber)
        
    }
    //    static var allTests = [
    //        ("testAddition", testAddition),("testSubtraction", testSubtraction),
    //    ]
}
