//
//  DetailViewController.swift
//  KavakChallenge
//
//  Created by Juan Tocino on 19/08/2021.
//

import Foundation
import UIKit

public class DetailViewController: UIViewController{
    @IBOutlet weak var labelISBN: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    public var book: BookModel?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.labelISBN.text = book?.isbn
        self.labelTitle.text = book?.title
        self.labelAuthor.text = book?.author
        self.labelGenre.text = book?.genre
        self.labelDescription.text = book?.description
    }
}
