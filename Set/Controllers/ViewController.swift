//
//  ViewController.swift
//  Set
//
//  Created by Benjamin Musoke-Lubega on 12/22/19.
//  Copyright © 2019 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	private lazy var game = Set()
	private var map = [UIButton: Card]()
	
	@IBOutlet private(set) var cardButtons: [UIButton]!
	@IBOutlet private weak var dealThreeCardsButton: UIButton!
	@IBOutlet private(set) var newGameButton: UIButton!
	@IBOutlet private(set) var score: UILabel!
	@IBOutlet private(set) var matchedCountLabel: UILabel!
	
	@IBAction func selectCard(_ sender: UIButton) {
		if let card = map[sender] {
			if game.selectedCards.contains(card) {
				if (!game.threeCardsAreSelected) {
					game.deselect(card: card)
				}
			} else {
				game.select(card: card)
			}
		}
		updateView()
		
		// MARK: Add Game Over Functionality
	}
	
	@IBAction func dealThreeCards(_ sender: UIButton) {
		game.dealThreeCards()
		updateView()
	}
	
	@IBAction func newGame(_ sender: UIButton) {
		game = Set()
		updateView()
	}
	
	// MARK: Add Game Information Button
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
		updateView()
	}
	
	private func configureView() {
		for button in cardButtons {
			button.layer.cornerRadius = 8.0
		}
		configureNewGameButton()
	}
	
	private func updateView() {
		score.text = "Score: \(game.score)"
		matchedCountLabel.text = "Matches: \(game.matches)"
		
		for index in game.cardsInPlay.indices {
			let card = game.cardsInPlay[index]
			let button = cardButtons[index]
			
			configureCardButtonAttributes(button, card)
			
			if game.selectedCards.contains(card) {
				if game.threeCardsAreSelected {
					button.backgroundColor = game.selectedCardsAreSet ? #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1) : #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
				} else {
					button.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
				}
			} else {
				button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
			}
			
			button.isEnabled = true
			button.isHidden = false
			
			map[button] = card
		}
		
		for index in game.cardsInPlay.count ..< cardButtons.count {
			let button = cardButtons[index]
			button.isEnabled = false
			button.isHidden = true
		}
		
		dealThreeCardsButton.isEnabled = (game.cardsInPlay.count == SetGameConstants.maxCardsInPlay || game.deck.isEmpty) ? false : true
	}
	
	private func configureCardButtonAttributes(_ button: UIButton, _ card: Card){
		var attributes = [NSAttributedString.Key: Any]()
		var string = String()
		var color = UIColor()
		
		switch card.color {
		case .optionA: color = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
		case .optionB: color = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
		case .optionC: color = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
		}
		
		switch card.shape {
		case .optionA: string = SetGameConstants.triangle
		case .optionB: string = SetGameConstants.circle
		case .optionC: string = SetGameConstants.square
		}
		
		switch card.number {
		case .optionA: break
		case .optionB: string += "\(string)"
		case .optionC: string += "\(string)\(string)"
		}
		
		switch card.shading {
		case .optionA:
			attributes[NSAttributedString.Key.foregroundColor] = color.withAlphaComponent(0.30)
		case .optionB:
			attributes[NSAttributedString.Key.strokeWidth] = 10
		case .optionC:
			attributes[NSAttributedString.Key.foregroundColor] = color
		}
		
		attributes[NSAttributedString.Key.strokeColor] = color
		button.setAttributedTitle(NSAttributedString(string: string, attributes: attributes), for: UIControl.State.normal)
	}
	
	private func configureNewGameButton() {
		dealThreeCardsButton.layer.cornerRadius = 8.0
		dealThreeCardsButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
		dealThreeCardsButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		dealThreeCardsButton.layer.borderWidth = 1.0
	}
}

