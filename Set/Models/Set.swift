//
//  Set.swift
//  Set
//
//  Created by Benjamin Musoke-Lubega on 12/22/19.
//  Copyright © 2019 Ben Musoke-Lubega. All rights reserved.
//

import Foundation

// MARK: Something is wrong with the game right now making it unbeatable
struct Set {
	private(set) var deck = [Card]()
	private(set) var cardsInPlay = [Card?]()
	private(set) var selectedCards = [Card]()
	
	private(set) var matches = 0
	private(set) var score = 0
	
	var threeCardsAreSelected: Bool {
		return selectedCards.count == 3
	}
	
	var selectedCardsAreSet: Bool {
		if threeCardsAreSelected {
			return Card.isSet(cards: selectedCards) ? true : false
		} else {
			return false
		}
	}
	
	var isGameOver: Bool {
		// game is over when there are no more matches to be made
		return deck.isEmpty && findSet() == nil
	}
	
	mutating func deal(_ count: Int) {
		cardsInPlay += deck.removeLast(count)
	}
	
	mutating func choose(_ card: Card) {
		assert(cardsInPlay.contains(card), "Set.choose(\(card)): You selected a card not in Set.cardsInPlay")
				
		if selectedCards.contains(card) {
			if (!threeCardsAreSelected) {
				deselect(card)
			}
		} else {
			select(card)
		}
	}
	
	mutating func hintCards() -> [Card]? {
		score -= 10
		return findSet()
	}
	
	private mutating func select(_ card: Card) {
		if threeCardsAreSelected {
			if Card.isSet(cards: selectedCards) {
				for card in selectedCards {
					if let index = cardsInPlay.firstIndex(of: card) {
						cardsInPlay[index] = !deck.isEmpty ? deck.removeLast() : nil
					}
				}
				
				matches += 1
				score += SetGameConstants.correctSelection
			} else {
				score += SetGameConstants.wrongSelection
			}
			selectedCards.removeAll()
		}
		selectedCards.append(card)
	}
	
	private mutating func deselect(_ card: Card) {
		if let index = selectedCards.firstIndex(of: card) {
			selectedCards.remove(at: index)
		}
	}
		
	init() {
		for i in Feature.allFeatures {
			for j in Feature.allFeatures {
				for k in Feature.allFeatures {
					for m in Feature.allFeatures {
						let card = Card(number: i, shape: j, color: k, shading: m)
						deck.append(card)
					}
				}
			}
		}
		
		deck.shuffle()
		deal(12)
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

extension Set {
	func findSet() -> [Card]? {
		for cardA in cardsInPlay {
			for cardB in cardsInPlay {
				if let cardA = cardA, let cardB = cardB{
					if cardA != cardB {
						let cardC = complementCard(for: cardA, for: cardB)
						if (cardsInPlay.contains(cardC)) {
							return [cardA, cardB, cardC]
						}
					}
				}
			}
		}
		return nil
	}
	
	func complementCard(for cardA: Card, for cardB: Card) -> Card {
		let number = cardA.number == cardB.number ? cardA.number : Feature.complementFeature(for: cardA.number, for: cardB.number)
		let color = cardA.color == cardB.color ? cardA.color : Feature.complementFeature(for: cardA.color, for: cardB.color)
		let shape = cardA.shape == cardB.shape ? cardA.shape : Feature.complementFeature(for: cardA.shape, for: cardB.shape)
		let shade = cardA.shading == cardB.shading ? cardA.shading : Feature.complementFeature(for: cardA.shading, for: cardB.shading)
		
		return Card(number: number, shape: shape, color: color, shading: shade)
	}
}
