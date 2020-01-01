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
		// let card = Card(number: 0, shape: 1, color: 2, shading: 2)

		// XCTAssertEqual(card.number, 0)
		// XCTAssertEqual(card.shape, 1)
		// XCTAssertEqual(card.color, 2)
		// XCTAssertEqual(card.shading, 2)
	}

	func testIsSet() {

		// // Case where all the cards are the same
		// let cardA = Card(number: 1, shape: 1, color: 2, shading: 2)
		// let cardB = Card(number: 1, shape: 2, color: 1, shading: 1)
		// let cardC = Card(number: 0, shape: 0, color: 0, shading: 1)
		// let group1 = [cardA, cardB, cardC]
		// XCTAssertFalse(Card.isSet(cards: group1))

		// // Case where three cards are a set
		// let cardD = Card(number: 0, shape: 0, color: 0, shading: 2)
		// let cardE = Card(number: 1, shape: 1, color: 1, shading: 2)
		// let cardF = Card(number: 2, shape: 2, color: 2, shading: 2)
		// let group2 = [cardD, cardE, cardF]
		// XCTAssertTrue(Card.isSet(cards: group2))

		// // Another case where three cards are a set
		// let cardG = Card(number: 1, shape: 1, color: 0, shading: 0)
		// let cardH = Card(number: 1, shape: 1, color: 1, shading: 1)
		// let cardI = Card(number: 1, shape: 1, color: 2, shading: 2)
		// let group3 = [cardG, cardH, cardI]
		// XCTAssertTrue(Card.isSet(cards: group3))
	}

}
