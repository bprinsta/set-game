//
//  Set.swift
//  Set
//
//  Created by Benjamin Musoke-Lubega on 12/22/19.
//  Copyright © 2019 Ben Musoke-Lubega. All rights reserved.
//

import Foundation

struct Set {
	
	private(set) var deck = [Card]()
	private(set) var cardsInPlay = [Card]()
	private(set) var selectedCards = [Card]()
	private(set) var matchedCards = [Card]()
	private(set) var score: Int
	
	mutating func dealThreeCards() {
		cardsInPlay += deck.removeLast(3)
	}
	
	mutating func selectCard(at index: Int) {
		assert(index < cardsInPlay.count, "Set.selectCard(\(index)): You selected card index not within Set.cardsInPlay")
		selectedCards.append(cardsInPlay.remove(at: index))
		
		if (selectedCards.count == 3) {
			let isSet = Card.isSet(cards: selectedCards)
			
			if (isSet) {
				matchedCards += selectedCards
				selectedCards.removeAll()
				dealThreeCards()
				score += 3
			} else {
				cardsInPlay += selectedCards
				selectedCards.removeAll()
				score -= 5
			}
		}
	}
	
	mutating func deselectCard(at index: Int) {
		assert(index < selectedCards.count, "Set.deselectCard(\(index)): You selected card index not within Set.selectedCards")
		cardsInPlay.append(selectedCards.remove(at: index))
	}
		
	init() {
		// Add 81 unique cards to deck
		for i in 0..<3 {
			for j in 0..<3 {
				for k in 0..<3 {
					for m in 0..<3 {
						let card = Card(number: i, shape: j, color: k, shading: m)
						deck.append(card)
					}
				}
			}
		}
		
		// Deal 12 Random Cards to Begin Game
		deck.shuffle()
		cardsInPlay = deck.removeLast(12)
		score = 0
	}
}

extension Array {
	mutating func removeLast(_ k: Int) -> [Element] {
		assert(k <= self.count, "Array.removeLast(\(k)): You cannot remove a greater amount elements than stored in array")
		
		var removedElements = [Element]()
		for _ in 1...k {
			removedElements.append(self.removeLast())
		}
		return removedElements
	}
}
