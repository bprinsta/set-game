//
//  Card.swift
//  Set
//
//  Created by Benjamin Musoke-Lubega on 12/30/19.
//  Copyright © 2019 Ben Musoke-Lubega. All rights reserved.
//

import Foundation

struct Card {

	private(set) var number: Int
	private(set) var shape: Int
	private(set) var color: Int
	private(set) var shading: Int

//	They all have the same number or have three different numbers.
//	They all have the same shape or have three different shapes.
//	They all have the same shading or have three different shadings.
//	They all have the same color or have three different colors.
	
	init(number: Int, shape: Int, color: Int, shading: Int){
		self.number = number
		self.shape = shape
		self.color = color
		self.shading = shading
	}
	
	static func isSet(cards: [Card]) -> Bool {
		assert(cards.count == 3, "Card.isSet(\(cards)): A set is composed with three cards")
		
		return isSet(first: cards[0], second: cards[1], third: cards[2])
	}
	
	private static func isSet(first: Card, second: Card, third: Card) -> Bool {
		return isSetOfNums(first: first, second: second, third: third) && isSetOfShapes(first: first, second: second, third: third) && isSetOfColors(first: first, second: second, third: third) && isSetOfShades(first: first, second: second, third: third)
	}
	
	private static func isSetOfNums(first: Card, second: Card, third: Card) -> Bool {
		return first.number.isEqual(a: second.number, b: third.number) || first.number.isUnique(a: second.number, b: third.number) ? true : false
	}
	
	private static func isSetOfShapes(first: Card, second: Card, third: Card) -> Bool {
		return first.shape.isEqual(a: second.shape, b: third.shape) || first.shape.isUnique(a: second.shape, b: third.shape) ? true : false
	}

	private static func isSetOfColors(first: Card, second: Card, third: Card) -> Bool {
		return first.color.isEqual(a: second.color, b: third.color) || first.color.isUnique(a: second.color, b: third.color) ? true : false
	}
	
	private static func isSetOfShades(first: Card, second: Card, third: Card) -> Bool {
		return first.shading.isEqual(a: second.shading, b: third.shading) || first.shading.isUnique(a: second.shading, b: third.shading) ? true : false
	}
}

extension Int {
	func isEqual(a: Int, b: Int) -> Bool {
		return ((self == a) && (self == b))
	}
	
	func isUnique(a: Int, b: Int) -> Bool {
		return ((self != a) && (self != b) && (b != a))
	}
}


