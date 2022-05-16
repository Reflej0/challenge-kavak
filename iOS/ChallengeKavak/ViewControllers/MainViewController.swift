//
//  MainViewController.swift
//  ChallengeKavak
//
//  Created by Juan Tocino on 14/05/2022.
//

import Foundation
import UIKit

public class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    let resultService = ResultService()
    let bestSellersService = BestSellersService()
    let rowHeight: CGFloat = 100
    let segueBookIdentifier = "segueBookDescription"
    let bookCellIdentifier = "bookCell"
    let titleError = "Ha ocurrido un error"
    let buttonError = "Aceptar"
    var bestSellers = [BestSellersModel]()
    var books = [BookModel]()
    var bookSelected = [BookModel]()
    var genreSelected : String = ""
    
    
    // MARK: - Lifecycle methods
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getAllBooks()
    }
    
    // MARK: - Setup methods
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = rowHeight
    }
    
    // MARK: - Actions methods
    
    @IBAction func buttonAllClicked(_ sender: Any) {
        getAllBooks()
    }
    
    @IBAction func buttonHistoryClicked(_ sender: Any) {
        filterBook(Genre.history.rawValue)
    }
    
    @IBAction func buttonScienceClicked(_ sender: Any) {
        filterBook(Genre.science.rawValue)
    }
    
    @IBAction func buttonBusinessClicked(_ sender: Any) {
        filterBook(Genre.business.rawValue)
    }
    
    @IBAction func buttonBestSellerClicked(_ sender: Any) {
        getBestSellersBooks()
    }
    
    // MARK: - Logic methods
    
    private func filterBook(_ genre: String) {
        genreSelected = genre
        getAllBooksFilter()
    }
    
    private func getAllBooks() {
        books.removeAll()
        spinner.startAnimating()
        resultService.getResults(succesBlock: successBlock, failureBlock: errorBlock)
        bookSelected.removeAll()
    }
    
    private func getAllBooksFilter() {
        books.removeAll()
        spinner.startAnimating()
        resultService.getResults(succesBlock: successBlockFilter, failureBlock: errorBlock)
        bookSelected.removeAll()
    }
    
    private func getBestSellersBooks() {
        books.removeAll()
        spinner.startAnimating()
        resultService.getResults(succesBlock: successBlockBestSellersFirst, failureBlock: errorBlock)
        bookSelected.removeAll()
    }
    
    // MARK: - Callbacks
    
    private func successBlockBestSellersFirst(_ results: ResultModel) {
        results.results.books.forEach { books.append($0) }
        bestSellersService.getResults(succesBlock: successBlockBestSellersFinal, failureBlock: errorBlock)
    }
    
    private func successBlockBestSellersFinal(_ result: ResultBestSellersModel) {
        var filterBooks = [BookModel]()
        for bestSeller in result.results.best_sellers {
            for book in books {
                if book.isbn == bestSeller {
                    filterBooks.append(book)
                }
            }
        }
        books = filterBooks
        tableView.reloadData()
        spinner.stopAnimating()
    }
    
    private func successBlockFilter(_ result: ResultModel) {
        books = result.results.books.filter { $0.genre == genreSelected }
        tableView.reloadData()
        spinner.stopAnimating()
    }
    
    private func successBlock(_ results: ResultModel) {
        results.results.books.forEach { books.append($0) }
        tableView.reloadData()
        spinner.stopAnimating()
    }
    
    private func errorBlock(_ error: String) {
        let alert = UIAlertController(title: titleError, message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonError, style: UIAlertAction.Style.destructive, handler: { action in

            }))
            present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Tableview Delegates
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = books[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: bookCellIdentifier) as? BookCell else { return UITableViewCell() }
        cell.setBook(book)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bookSelected.append(books[indexPath.row])
        performSegue(withIdentifier: segueBookIdentifier, sender: nil)
    }
    
    // MARK: - Segue
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueBookIdentifier {
            if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.book = bookSelected.first
            }
        }
    }
}

