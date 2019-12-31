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
	
	@IBOutlet private(set) var cardButtons: [UIButton]!
	@IBOutlet private weak var dealThreeCardsButton: UIButton!
	@IBOutlet private(set) var newGameButton: UIButton!
	@IBOutlet private(set) var score: UILabel!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	private func updateView() {
		
	}


}

