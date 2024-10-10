//
//  SumEvenNumbers.swift
//  Walmart_Mauricio_Task
//
//  Created by MaurZac on 10/10/24.
//
import Foundation

public func sumEvenNumbers(_ numbers: [Int]) -> Int {
    return numbers.filter{$0 % 2 == 0}.reduce(0,+)
}
