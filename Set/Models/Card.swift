//
//  Card.swift
//  Set
//
//  Created by Benjamin Musoke-Lubega on 12/30/19.
//  Copyright © 2019 Ben Musoke-Lubega. All rights reserved.
//

import Foundation

enum Feature: Int {
	case optionA = 0
	case optionB = 1
	case optionC = 2
	
	static let allFeatures = [Feature.optionA, Feature.optionB, Feature.optionC]
}

struct Card: Hashable {
	let number: Feature
	let shape: Feature
	let color: Feature
	let shading: Feature
	
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

// MARK: Extensions
extension Card: CustomStringConvertible {
	var description: String {
		return "Card(num: \(number.rawValue), shape: \(shape.rawValue), color: \(color.rawValue), shade: \(shading.rawValue))"
	}
}

extension Card {
	static func complementCard(for cardA: Card, for cardB: Card) -> Card {
		let number = cardA.number == cardB.number ? cardA.number : Feature.complementFeature(for: cardA.number, for: cardB.number)
		let color = cardA.color == cardB.color ? cardA.color : Feature.complementFeature(for: cardA.color, for: cardB.color)
		let shape = cardA.shape == cardB.shape ? cardA.shape : Feature.complementFeature(for: cardA.shape, for: cardB.shape)
		let shade = cardA.shading == cardB.shading ? cardA.shading : Feature.complementFeature(for: cardA.shading, for: cardB.shading)
		
		return Card(number: number, shape: shape, color: color, shading: shade)
	}
}

private extension Card {
	static func isSet(first: Card, second: Card, third: Card) -> Bool {
		return Feature.isSet(first.number, second.number, third.number) && Feature.isSet(first.shape, second.shape, third.shape) && Feature.isSet(first.color, second.color, third.color) && Feature.isSet(first.shading, second.shading, third.shading)
	}
}

extension Feature {
	static func isEqual(_ a: Feature, _ b: Feature, _ c: Feature) -> Bool {
		return (c == a) && (c == b)
	}
	
	static func isUnique(_ a: Feature, _ b: Feature, _ c: Feature) -> Bool {
		return (c != a) && (c != b) && (b != a)
	}
	
	static func isSet(_ a: Feature, _ b: Feature, _  c: Feature) -> Bool {
		return Feature.isEqual(a, b, c) || Feature.isUnique(a, b, c)
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




