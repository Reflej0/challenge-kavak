//
//  BookCell.swift
//  ChallengeKavak
//
//  Created by Juan Tocino on 14/05/2022.
//

import UIKit
import Kingfisher

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
    
    func setBook(_ bookParam: BookModel) {
        book = bookParam
        labelTitle.text = bookParam.title
        labelAuthor.text = bookParam.author
        imageBook.kf.setImage(with: URL(string: bookParam.img))
    }
}
