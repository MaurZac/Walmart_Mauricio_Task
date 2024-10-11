//
//  SumEvenNumbersTests.swift
//  Walmart_Mauricio_TaskTests
//
//  Created by MaurZac on 10/10/24.
//

import XCTest
@testable import Walmart_Mauricio_Task

final class SumEvenNumbersTests: XCTestCase {
    
    func testSumEvenNumbersWithPositiveNumbers() {
        let result = sumEvenNumbers([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
        XCTAssertEqual(result, 30, "La suma de los números pares debería ser 30")
    }
    
    func testSumEvenNumbersWithEmptyArray() {
        let result = sumEvenNumbers([])
        XCTAssertEqual(result, 0, "La suma de los números pares en un array vacío debería ser 0")
    }
    
    func testSumEvenNumbersWithNoEvenNumbers() {
        let result = sumEvenNumbers([1, 3, 5, 7])
        XCTAssertEqual(result, 0, "La suma de los números pares debería ser 0 si no hay números pares")
    }
    
    func testSumEvenNumbersWithNegativeNumbers() {
        let result = sumEvenNumbers([-2, -3, -4, -5, -6])
        XCTAssertEqual(result, -12, "La suma de los números pares debería ser -12")
    }
    
    func testSumEvenNumbersWithAllEvenNumbers() {
        let result = sumEvenNumbers([2, 4, 6, 8])
        XCTAssertEqual(result, 20, "La suma de los números pares debería ser 20")
    }
    
    func testSumEvenNumbersWithSingleElement() {
        let result = sumEvenNumbers([4])
        XCTAssertEqual(result, 4, "La suma de los números pares debería ser 4 si el único elemento es par")
    }
    
    func testSumEvenNumbersWithSingleOddNumber() {
        let result = sumEvenNumbers([3])
        XCTAssertEqual(result, 0, "La suma de los números pares debería ser 0 si el único elemento es impar")
    }
    
}
