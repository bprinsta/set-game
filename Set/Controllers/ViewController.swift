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
	private var attributedStrings = [Card: NSAttributedString]()
	
	@IBOutlet private(set) var cardButtons: [UIButton]!
	@IBOutlet private weak var dealThreeCardsButton: UIButton!
	@IBOutlet private(set) var newGameButton: UIButton!
	@IBOutlet private(set) var score: UILabel!
	@IBOutlet private(set) var matchedCountLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		mapAttributedStrings()
		roundButtonEdges()
		updateView()
	}
	
	@IBAction func touchCard(_ sender: UIButton) {
		if let card = map[sender] {
			game.choose(card)
		}
		updateView()
		
		if game.isGameOver {
			createParticles(view)
			congratulatePlayer()
		}
	}
	
	@IBAction func dealThreeCards(_ sender: UIButton) {
		game.dealThreeCards()
		updateView()
	}
	
	@IBAction func newGame(_ sender: UIButton) {
		newGame()
	}
	
	@IBAction func hint(_ sender: UIButton) {
		if let cards = game.hintCards() {
			for card in cards {
				if let button = map.someKey(forValue: card) {
					highlightButton(button)
				}
			}
		} else {
			print("No solution right now")
		}
		updateScore()
	}
	
	@IBAction private func presentGameRules(_ sender: UIButton) {
		let alertController = UIAlertController(title: "How To Play", message:
			"A SET consists of 3 cards in which each of the cards’ features (shape, color, number & shading), looked at one-by-one, are the same on each card, or, are different on each card. All of the features must separately satisfy this rule. \n \n A QUICK CHECK: If 2 cards are the same and 1 card is different for any feature, then it is not a SET \n \n The point of the game is to identify as many sets as you can! Score \(SetGameConstants.correctSelection) points for correct selections and lose \(SetGameConstants.wrongSelection) points for wrong selections. If you’re struggling you can press the hint button, but you’ll lose \(SetGameConstants.usedHint) points. \n \n Good luck :)", preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "Play", style: .default))
		
		self.present(alertController, animated: true, completion: nil)
	}
	
	private func newGame() {
		removeParticles(view)
		game = Set()
		updateView()
	}
	
	// we never get here because player selecting one card prompts next loop
	private func congratulatePlayer() {
		let alertController = UIAlertController(title: "Congratulations!", message:
			"You found \(game.matches) sets and finished the game with a score of \(game.score)!", preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "Play New Game", style: .default, handler: { _ in
			self.newGame()
		}))
		
		 self.present(alertController, animated: true, completion: nil)
	}
	
	// MARK: Add Game Information Button
	
	private func updateView() {
		updateScore()
		updateMatches()
		
		for index in cardButtons.indices {
			let button = cardButtons[index]
			unhighlightButton(button)
			
			if index >= game.cardsInPlay.count {
				hideCardButton(button)
			} else if let card = game.cardsInPlay[index] {
				showCardButton(button)
				configureCardButton(button, card)
				map[button] = card
			} else {
				hideCardButton(button)
			}
		}
		
		dealThreeCardsButton.isEnabled = (game.cardsInPlay.count == SetGameConstants.maxCardsInPlay || game.deck.isEmpty) ? false : true
	}
	
	private func mapAttributedStrings(){
		for card in game.deck + game.cardsInPlay {
			if let card = card {
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
				case .optionA: attributes[NSAttributedString.Key.foregroundColor] = color.withAlphaComponent(0.30)
				case .optionB: attributes[NSAttributedString.Key.strokeWidth] = 10
				case .optionC: attributes[NSAttributedString.Key.foregroundColor] = color
				}
				
				attributes[NSAttributedString.Key.strokeColor] = color
				attributedStrings[card] = NSAttributedString(string: string, attributes: attributes)
			}
		}
	}
	
	private func configureCardButton(_ button: UIButton, _ card: Card) {
		button.setAttributedTitle(attributedStrings[card], for: UIControl.State.normal)
		
		if game.selectedCards.contains(card) {
			if game.threeCardsAreSelected {
				button.backgroundColor = game.selectedCardsAreSet ? #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1) : #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
			} else {
				button.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
			}
		} else {
			button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		}
	}
	
	private func showCardButton(_ button: UIButton) {
		button.alpha = 1
		button.isEnabled = true
	}
	
	private func hideCardButton(_ button: UIButton) {
		button.alpha = 0
		button.isEnabled = false
	}
	
	private func highlightButton(_ button: UIButton) {
		button.layer.borderWidth = 3.0
		button.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
	}
	
	private func unhighlightButton(_ button: UIButton) {
		button.layer.borderWidth = 0
		button.layer.borderColor = UIColor.clear.cgColor
	}
	
	private func roundButtonEdges() {
		for button in cardButtons {
			button.layer.cornerRadius = 8.0
		}
		dealThreeCardsButton.layer.cornerRadius = 8.0
	}
	
	private func updateScore() {
		score.text = "Score: \(game.score)"
	}
	
	private func updateMatches() {
		matchedCountLabel.text = "Matches: \(game.matches)"
	}
}

extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}

