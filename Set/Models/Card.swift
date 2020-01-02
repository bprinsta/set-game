//
//  Card.swift
//  Set
//
//  Created by Benjamin Musoke-Lubega on 12/30/19.
//  Copyright © 2019 Ben Musoke-Lubega. All rights reserved.
//

import Foundation

struct Card: Hashable {
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
	
	func hash(into hasher: inout Hasher) {
        hasher.combine(number)
        hasher.combine(shape)
		hasher.combine(color)
		hasher.combine(shading)
    }
	
	static func isSet(cards: [Card]) -> Bool {
		assert(cards.count == 3, "Card.isSet(\(cards)): A set is composed with three cards")
		return isSet(first: cards[0], second: cards[1], third: cards[2])
	}
}

enum Feature: Int {
	case optionA = 0
	case optionB = 1
	case optionC = 2
	
	static let allFeatures = [Feature.optionA, Feature.optionB, Feature.optionC]
}

// MARK: Extensions
private extension Card {
	static func isSet(first: Card, second: Card, third: Card) -> Bool {
		return isSet(first.number, second.number, third.number) && isSet(first.shape, second.shape, third.shape) && isSet(first.color, second.color, third.color) && isSet(first.shading, second.shading, third.shading)
	}
	
	static func isSet(_ first: Feature, _ second: Feature, _  third: Feature) -> Bool {
		return Feature.isEqual(first, second, third) || Feature.isUnique(first, second, third)
	}
}

extension Card: CustomStringConvertible {
	var description: String {
		return "Card(num: \(number.rawValue), shape: \(shape.rawValue), color: \(color.rawValue), shade: \(shading.rawValue))"
	}
}

extension Feature {
	static func isEqual(_ a: Feature, _ b: Feature, _ c: Feature) -> Bool {
		return (c == a) && (c == b)
	}
	
	static func isUnique(_ a: Feature, _ b: Feature, _ c: Feature) -> Bool {
		return (c != a) && (c != b) && (b != a)
	}
	
	// determines third feature needed to complete a set
	static func complementFeature(for a: Feature, for b: Feature) -> Feature {
		if (a == .optionA && b == .optionB) || (b == .optionA && a == .optionB){
			return .optionC
		} else if (a == .optionB && b == .optionC) || ( a == .optionC && b == .optionB) {
			return .optionA
		} else {
			return .optionB
		}
	}
}




