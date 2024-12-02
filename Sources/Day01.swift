//
//  Day01.swift
//
//
//  Created by Dylan Cunningham on 12/1/24.
//

import Foundation

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Int]] {
    data.split(separator: "\n").map {
      $0.split(separator: "   ").compactMap { Int($0) }
    }
  }

  // form array. Sort array.
  func part1() async throws -> Int {
    let left: [Int] =
      entities
      .map { entity in
        guard entity.count == 2 else { return nil }

        return entity[0]
      }.compactMap { $0 }
      .sorted()

    let right: [Int] =
      entities
      .map { entity in
        guard entity.count == 2 else { return nil }

        return entity[1]
      }.compactMap { $0 }
      .sorted()

    var final = 0
    for i in 0..<left.count {
      final += findDistance(lhs: left[i], rhs: right[i])
    }

    return final
  }

  func findDistance(lhs: Int, rhs: Int) -> Int {
    abs(rhs - lhs)
  }

  func part2() async throws -> Int {
    let left: [Int] =
      entities
      .map { entity in
        guard entity.count == 2 else { return nil }

        return entity[0]
      }.compactMap { $0 }
      .sorted()

    let right: [Int] =
      entities
      .map { entity in
        guard entity.count == 2 else { return nil }

        return entity[1]
      }.compactMap { $0 }
      .sorted()

    var similarityMap: [Int: Int] = [:]

    var total = 0
    for i in 0..<left.count {
      let current = left[i]
      if let mapped = similarityMap[current] {
        total += current * mapped
      } else {
        var num = 0
        for j in 0..<right.count {
          let rightCurrent = right[j]
          if rightCurrent == current {
            num += 1
          }
        }
        total += current * num
        similarityMap[current] = num
      }
    }

    return total
  }
}
