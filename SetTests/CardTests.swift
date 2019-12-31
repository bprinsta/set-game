//
//  CardTests.swift
//  SetTests
//
//  Created by Benjamin Musoke-Lubega on 12/30/19.
//  Copyright © 2019 Ben Musoke-Lubega. All rights reserved.
//

import XCTest
@testable import Set

class CardTests: XCTestCase {
	
	func testInit() {
		let card = Card(number: 0, shape: 1, color: 2, shading: 2)
		
		XCTAssertEqual(card.number, 0)
		XCTAssertEqual(card.shape, 1)
		XCTAssertEqual(card.color, 2)
		XCTAssertEqual(card.shading, 2)
	}
	
	func testIsSet() {
		
		// Case where all the cards are the same
		let cardA = Card(number: 1, shape: 1, color: 2, shading: 2)
		let cardB = Card(number: 1, shape: 2, color: 1, shading: 1)
		let cardC = Card(number: 0, shape: 0, color: 0, shading: 1)
		let group1 = [cardA, cardB, cardC]
		XCTAssertFalse(Card.isSet(cards: group1))
		
		// Case where three cards are a set
		let cardD = Card(number: 0, shape: 0, color: 0, shading: 2)
		let cardE = Card(number: 1, shape: 1, color: 1, shading: 2)
		let cardF = Card(number: 2, shape: 2, color: 2, shading: 2)
		let group2 = [cardD, cardE, cardF]
		XCTAssertTrue(Card.isSet(cards: group2))
		
		// Another case where three cards are a set
		let cardG = Card(number: 1, shape: 1, color: 0, shading: 0)
		let cardH = Card(number: 1, shape: 1, color: 1, shading: 1)
		let cardI = Card(number: 1, shape: 1, color: 2, shading: 2)
		let group3 = [cardG, cardH, cardI]
		XCTAssertTrue(Card.isSet(cards: group3))
	}
	
	func testIsEqual(){
		XCTAssertTrue(8.isEqual(a: 8, b: 8))
		XCTAssertFalse(12.isEqual(a: 24, b: 0))
		XCTAssertFalse(13.isEqual(a: 13, b: 0))
		XCTAssertFalse(99.isEqual(a: -99, b: 999))
	}
	
	func testIsUnique() {
		XCTAssertTrue(18.isUnique(a: 19, b: 20))
		XCTAssertFalse(9.isUnique(a: 9, b: 10))
		XCTAssertFalse(20.isEqual(a: 200, b: 2000))
		XCTAssertFalse(1.isUnique(a: 1, b: 1))
	}
}
