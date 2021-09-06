//
//  BookCell.swift
//  KavakChallenge
//
//  Created by Juan Tocino on 19/08/2021.
//

import UIKit

public class BookCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var imageBook: UIImageView!
    var book: BookModel?
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setBook(book: BookModel){
        self.book = book
        self.labelTitle.text = book.title
        self.labelAuthor.text = book.author
        self.imageBook?.downloaded(from: book.img)
    }
    
}
