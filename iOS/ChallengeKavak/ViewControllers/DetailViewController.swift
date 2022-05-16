//
//  DetailViewController.swift
//  ChallengeKavak
//
//  Created by Juan Tocino on 14/05/2022.
//

import Foundation
import UIKit

public class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var labelISBN: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    // MARK: - Properties
    
    public var book: BookModel?
    
    // MARK: - Lifecycle methods
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }
    
    // MARK: - Setup methods
    
    private func setupInterface() {
        guard let internalBook = book else { return }
        labelISBN.text = internalBook.isbn
        labelTitle.text = internalBook.title
        labelAuthor.text = internalBook.author
        labelGenre.text = internalBook.genre
        labelDescription.text = internalBook.description
    }
}
