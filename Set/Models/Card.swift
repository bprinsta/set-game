//
//  Card.swift
//  Set
//
//  Created by Benjamin Musoke-Lubega on 12/30/19.
//  Copyright © 2019 Ben Musoke-Lubega. All rights reserved.
//

import Foundation

struct Card: Equatable {
	private(set) var number: Feature
	private(set) var shape: Feature
	private(set) var color: Feature
	private(set) var shading: Feature
	
	init(number: Feature, shape: Feature, color: Feature, shading: Feature){
		self.number = number
		self.shape = shape
		self.color = color
		self.shading = shading
	}
	
	static func ==(lhs: Card, rhs: Card) -> Bool {
		return lhs.number == rhs.number && lhs.shape == rhs.shape && lhs.color == rhs.color && lhs.shading == rhs.shading
	}
	
	static func isSet(cards: [Card]) -> Bool {
		assert(cards.count == 3, "Card.isSet(\(cards)): A set is composed with three cards")
		return isSet(first: cards[0], second: cards[1], third: cards[2])
		// return true
	}
}

enum Feature: Int, Equatable {
	case optionA = 0
	case optionB = 1
	case optionC = 2
	
	static func ==(lhs: Feature, rhs: Feature) -> Bool {
		switch (lhs, rhs) {
		case (.optionA, .optionA): return true
		case (.optionB, .optionB): return true
		case (.optionC, .optionC): return true
		default: return false
		}
	}
}

// MARK: Extensions
private extension Card {
	static func isSet(first: Card, second: Card, third: Card) -> Bool {
		return isSet(first: first.number, second: second.number, third: third.number) && isSet(first: first.shape, second: second.shape, third: third.shape) && isSet(first: first.color, second: second.color, third: third.color) && isSet(first: first.shading, second: second.shading, third: third.shading)
	}
	
	static func isSet(first: Feature, second: Feature, third: Feature) -> Bool {
		return Feature.isEqual(a: first, b: second, c: third) || Feature.isUnique(a: first, b: second, c: third)
	}
}

extension Card: CustomStringConvertible {
	var description: String {
		return "Card(\(number.rawValue), \(shape.rawValue), \(color.rawValue), \(shading.rawValue))"
	}
}

extension Feature {
	// determines if three features are equal
	static func isEqual(a: Feature, b: Feature, c: Feature) -> Bool {
		return (c == a) && (c == b)
	}
	
	// determines if three features are unique
	static func isUnique(a: Feature, b: Feature, c: Feature) -> Bool {
		return (c != a) && (c != b) && (b != a)
	}
}




