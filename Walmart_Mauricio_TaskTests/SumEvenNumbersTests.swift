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

        // Caso 2: Verifica la suma en un array vacío
        func testSumEvenNumbersWithEmptyArray() {
            let result = sumEvenNumbers([])
            XCTAssertEqual(result, 0, "La suma de los números pares en un array vacío debería ser 0")
        }

        // Caso 3: Verifica cuando no hay números pares en el array
        func testSumEvenNumbersWithNoEvenNumbers() {
            let result = sumEvenNumbers([1, 3, 5, 7])
            XCTAssertEqual(result, 0, "La suma de los números pares debería ser 0 si no hay números pares")
        }

        // Caso 4: Verifica la función con números negativos
        func testSumEvenNumbersWithNegativeNumbers() {
            let result = sumEvenNumbers([-2, -3, -4, -5, -6])
            XCTAssertEqual(result, -12, "La suma de los números pares debería ser -12")
        }

        // Caso 5: Verifica la función con todos los números pares
        func testSumEvenNumbersWithAllEvenNumbers() {
            let result = sumEvenNumbers([2, 4, 6, 8])
            XCTAssertEqual(result, 20, "La suma de los números pares debería ser 20")
        }

        // Caso 6: Verifica la función con un solo número en el array
        func testSumEvenNumbersWithSingleElement() {
            let result = sumEvenNumbers([4])
            XCTAssertEqual(result, 4, "La suma de los números pares debería ser 4 si el único elemento es par")
        }

        // Caso 7: Verifica la función con un solo número impar en el array
        func testSumEvenNumbersWithSingleOddNumber() {
            let result = sumEvenNumbers([3])
            XCTAssertEqual(result, 0, "La suma de los números pares debería ser 0 si el único elemento es impar")
        }

}
