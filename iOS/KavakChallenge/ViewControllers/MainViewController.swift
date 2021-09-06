//
//  MainViewController.swift
//  KavakChallenge
//
//  Created by Juan Tocino on 19/08/2021.
//

import Foundation
import UIKit

public class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let resultService = ResultService()
    let bestSellersService = BestSellersService()
    var bestSellers = [BestSellersModel]()
    var books = [BookModel]()
    var bookSelected = [BookModel]()
    var genreSelected : String = ""
    
    
    @IBOutlet weak var buttonBestSellers: UIButton!
    @IBOutlet weak var buttonBesr: UIButton!
    @IBOutlet weak var buttonHistory: UIButton!
    @IBOutlet weak var buttonScience: UIButton!
    @IBOutlet weak var buttonBusiness: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    ///MARK: LIFES CYCLE
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDelegates()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getAllBooks()
    }
    
    private func setupDelegates(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 100;
    }
    
    ///MARK: BUTTONS ACTIONS
    
    @IBAction func buttonAllClicked(_ sender: Any) {
        self.getAllBooks()
    }
    
    @IBAction func buttonHistoryClicked(_ sender: Any) {
        self.filterBook(genre: "History")
    }
    
    @IBAction func buttonScienceClicked(_ sender: Any) {
        self.filterBook(genre: "Science")
    }
    
    @IBAction func buttonBusinessClicked(_ sender: Any) {
        self.filterBook(genre: "Business")
    }
    
    @IBAction func buttonBestSellerClicked(_ sender: Any) {
        self.bestSellersService.getResults(succesBlock: self.successBlockBestSellers, failureBlock: self.errorBlock)
    }
    
    ///MARK: LOGIC FUNCTIONS
    
    private func filterBook(genre: String){
        self.genreSelected = genre
        self.getAllBooksFilter()
    }
    
    private func getAllBooks(){
        self.books.removeAll()
        self.spinner.startAnimating()
        self.resultService.getResults(succesBlock: self.successBlock, failureBlock: self.errorBlock)
        self.bookSelected.removeAll()
    }
    
    private func getAllBooksFilter(){
        self.books.removeAll()
        self.spinner.startAnimating()
        self.resultService.getResults(succesBlock: self.successBlockFilter, failureBlock: self.errorBlock)
        self.bookSelected.removeAll()
    }
    
    ///MARK: CALLBACKS
    
    private func successBlockBestSellers(result: ResultBestSellersModel){
        var filterBooks = [BookModel]()
        for bestSeller in result.results.best_sellers{
            for book in self.books{
                if(book.isbn == bestSeller){
                    filterBooks.append(book)
                }
            }
        }
        self.books = filterBooks
        self.tableView.reloadData()
    }
    
    private func successBlockFilter(result: ResultModel){
        var filterBooks = [BookModel]()
        for book in result.results.books{
            
            if(book.genre == self.genreSelected){
                filterBooks.append(book)
            }
        }
        self.books = filterBooks
        self.tableView.reloadData()
    }
    
    private func successBlock(results: ResultModel){
        for result in results.results.books{
            books.append(result)
        }
        self.spinner.stopAnimating()
        self.tableView.reloadData()
    }
    
    private func errorBlock(error: String){
        let alert = UIAlertController(title: "Ha ocurrido un error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.destructive, handler: { action in

            }))
            self.present(alert, animated: true, completion: nil)
    }
    
    ///MARK: TABLEVIEW DELEGATES
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = self.books[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell") as? BookCell
        cell!.setBook(book: book)
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.bookSelected.append(self.books[indexPath.row])
        self.performSegue(withIdentifier: "segueBookDescription", sender: nil)
    }
    
    ///MARK: SEGUE
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueBookDescription" {
            if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.book = self.bookSelected.first
            }
        }
    }
}
