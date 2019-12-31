//
//  SetTests.swift
//  SetTests
//
//  Created by Benjamin Musoke-Lubega on 12/30/19.
//  Copyright © 2019 Ben Musoke-Lubega. All rights reserved.
//

import XCTest
@testable import Set

class SetTests: XCTestCase {

    func testInit() {
		let setGame = Set()
		
		XCTAssertEqual(setGame.deck.count, 69)
		XCTAssertEqual(setGame.cardsInPlay.count, 12)
		XCTAssertEqual(setGame.score, 0)
		XCTAssertEqual(setGame.matchedCards.count, 0)
		XCTAssertEqual(setGame.selectedCards.count, 0)
    }
	
	func testSelectCard() {
		var setGame = Set()
		
		setGame.selectCard(at: 0)
		XCTAssertEqual(setGame.selectedCards.count, 1)
		
		setGame.selectCard(at: 0)
		XCTAssertEqual(setGame.selectedCards.count, 2)
		
		// if three card match --> test that stuff gets
		
		setGame.selectCard(at: 0)
		XCTAssertEqual(setGame.selectedCards.count, 0)
		
		
	}
	
	func testDealThreeCards() {
		var setGame = Set()
		
		let originalCardsInPlayCount = setGame.cardsInPlay.count
		let originalDeckCount = setGame.deck.count
		
		setGame.dealThreeCards()
		XCTAssertEqual(originalCardsInPlayCount + 3, setGame.cardsInPlay.count)
		XCTAssertEqual(originalDeckCount - 3, setGame.deck.count)
		
		let nextCardsInPlayCount = setGame.cardsInPlay.count
		let nextDeckCount = setGame.deck.count
		setGame.dealThreeCards()
		XCTAssertEqual(nextCardsInPlayCount + 3, setGame.cardsInPlay.count)
		XCTAssertEqual(nextDeckCount - 3, setGame.deck.count)
	}

}
