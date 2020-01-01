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
	
	private(set) var matches = 0
	private(set) var score = 0
	
	var isThreeCardsSelected: Bool {
		return selectedCards.count == 3
	}
	
	var isSelectedCardsASet: Bool {
		if isThreeCardsSelected {
			return Card.isSet(cards: selectedCards) ? true : false
		} else {
			return false
		}
	}
	
	var isGameOver: Bool {
		return matches == SetGameConstants.maxMatchCount
	}
	
	mutating func dealThreeCards() {
		cardsInPlay += deck.removeLast(3)
	}
	
	mutating func select(card: Card) {
		assert(cardsInPlay.contains(card), "Set.select(\(card)): You selected card not in Set.cardsInPlay")
		
		if isThreeCardsSelected {
			if Card.isSet(cards: selectedCards) {
				for card in selectedCards {
					if let index = cardsInPlay.firstIndex(of: card) {
						cardsInPlay.remove(at: index)
					}
				}
				
				matchedCards += selectedCards
				selectedCards.removeAll()
				
				if !deck.isEmpty {
					dealThreeCards()
				}
				
				matches += 1
				score += SetGameConstants.correctSelection
			} else {
				selectedCards.removeAll()
				score += SetGameConstants.wrongSelection
			}
		}
		selectedCards.append(card)
		print(selectedCards)
	}
	
	mutating func deselect(card: Card) {
		assert(selectedCards.contains(card), "Set.deselect(\(card)): You selected card not in Set.selectedCards")
		
		if let index = selectedCards.firstIndex(of: card) {
			selectedCards.remove(at: index)
		}
		// score -= 1
	}
		
	init() {
		let featureOptions = [Feature.optionA, Feature.optionB, Feature.optionC]
		for i in featureOptions {
			for j in featureOptions {
				for k in featureOptions {
					for m in featureOptions {
						let card = Card(number: i, shape: j, color: k, shading: m)
						deck.append(card)
					}
				}
			}
		}
		
		deck.shuffle()
		cardsInPlay = deck.removeLast(12)
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
