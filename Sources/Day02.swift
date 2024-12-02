//
//  Day02.swift
//
//
//  Created by Dylan Cunningham on 12/1/24.
//

import Foundation

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var reports: [[Int]] {
    data.split(separator: "\n").map {
      $0.split(separator: " ").compactMap { Int($0) }
    }
  }

  func part1() async throws -> Int {
    reports
      .map {
        isSafe(report: $0)
      }
      .map { $0 ? 1 : 0 }
      .reduce(0, +)
  }

  func isSafe(report: [Int]) -> Bool {
    guard var previous = report.first else { return false }
    let second = report[1]
    let isIncreasing = previous < second
    if !distanceIsWithinAcceptableRange(previous: previous, current: second) {
      return false
    }
    previous = second

    for i in 2..<report.count {
      let current = report[i]
      if (current < previous && isIncreasing)
        || (current > previous && !isIncreasing)
        || !distanceIsWithinAcceptableRange(previous: previous, current: current)
      {
        return false
      }

      previous = current
    }

    return true
  }

  func findDistance(lhs: Int, rhs: Int) -> Int {
    abs(rhs - lhs)
  }

  func distanceIsWithinAcceptableRange(previous: Int, current: Int) -> Bool {
    let distance = findDistance(lhs: current, rhs: previous)
    return distance >= 1 && distance <= 3
  }

  func part2() async throws -> Int {
    reports
      .map {
        isSafeWithOneRemoval(report: $0)
      }
      .map { $0 ? 1 : 0 }
      .reduce(0, +)
  }

  func isSafeWithOneRemoval(report: [Int]) -> Bool {
    for i in 0..<report.count {
      var copy = report
      copy.remove(at: i)
      if isSafe(report: copy) {
        return true
      }
    }

    return false
  }
}
