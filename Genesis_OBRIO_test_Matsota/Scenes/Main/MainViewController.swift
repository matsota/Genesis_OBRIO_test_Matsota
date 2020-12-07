//
//  MainViewController.swift
//  Genesis_OBRIO_test_Matsota
//
//  Created by Andrew Matsota on 07.12.2020.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// - Setup
        setupNavigationController()
        setupTableView()
        setupNetwork()
        
        /// - Initiate
        let alert = AlertConfiguration(alertTitle: "Greetings!", alertBody: "In this app you are able to browse any repository at \ngithub.com\nJust enter any you want and try your luck\nWe already prepared first search for you")
        UIRouter.instance.presentAlert(self, configure: alert) {
            UserDefaults.standard.set("swift", forKey: UserDefaults.Key.searchingText)
            let request = SearchRequest(text: "swift", page: 0)
            self.loadRepositories(with: request)
        }
        
        /// - Notification
        NotificationCenter.default.addObserver(self, selector: #selector(loadMore(_:)), name: .loadMoreBrowsedRepositiories, object: nil)
    }
    
    //MARK: - Private Implementation
    private var population = [SearchResponse.Item]()
    private var network: NetworkManagment?
    private var totalRepositories = Int()
    private var searchText: String?
    
    @IBOutlet private weak var tableView: UITableView!
}









//MARK: - UISearchResultsUpdating
extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              text != "" else {return}
        self.searchText = text
        searchBar.text = nil
        UserDefaults.standard.set(text, forKey: UserDefaults.Key.searchingText)
        UserDefaults.standard.set(0, forKey: UserDefaults.Key.pageToUploadFromGithubBrowsing)
        let request = SearchRequest(text: text, page: 0)
        loadRepositories(with: request)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        if !population.isEmpty,
           UserDefaults.standard.string(forKey: UserDefaults.Key.searchingText) != "swift"  {
            UserDefaults.standard.set("swift", forKey: UserDefaults.Key.searchingText)
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            population.removeAll()
            tableView.reloadSections([0], with: .fade)
            let request = SearchRequest(text: "swift", page: 0)
            loadRepositories(with: request)
        }
    }
    
}

//MARK: - TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// - `numberOfRowsInSection`
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return population.count
    }
    
    /// - `cellForRowAt`
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        
        cell.populate(from: population[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        moreArticlesTrigger(indexPath)
        
        return cell
    }
    
    /// - `didSelectRowAt`
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let url = URL(string: population[indexPath.row].html_url) else {
            let alert = AlertConfiguration(alertTitle: "Attention", alertBody: "Link for this repository was lost.\nAnyway we copied link to owner of this repository on github in your clipboard")
            UIPasteboard.general.string = "https://github.com/\(population[indexPath.row].owner.login)"
            UIRouter.instance.presentAlert(self, configure: alert)
            return
        }
        UIRouter.instance.showWebView(self, url)
    }
    
}

//MARK: - Private setup methods
private extension MainViewController {
    
    func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .black
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search article"
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.showsScopeBar = true
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        navigationItem.titleView = searchBar
    }
    
    func setupNetwork() {
        let networking = NetworkService()
        network = NetworkManager(networking: networking)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
    }
    
}
//MARK: - Private methods
private extension MainViewController {
    
    func loadRepositories(with request: SearchRequest) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.network?.searchGitRepository(search: request, success: { (response) in
                DispatchQueue.main.async {
                    switch request.page {
                    case 0:
                        UserDefaults.standard.set(0, forKey: UserDefaults.Key.pageToUploadFromGithubBrowsing)
                        self.totalRepositories = response.total_count
                        print("totalRepositories", self.totalRepositories)
                        self.population = response.items
                        self.tableView.reloadSections([0], with: .fade)
                        
                    default:
                        self.population.append(contentsOf: response.items)
                        self.tableView.reloadSections([0], with: .fade)
                    }
                }
            }, failure: { (localizedDescription) in
                DispatchQueue.main.async {
                    let alert = AlertConfiguration(alertTitle: "Error occured",
                                                   alertBody: localizedDescription)
                    UIRouter.instance.presentAlert(self, configure: alert)
                }
            })
        }
    }
    
    func moreArticlesTrigger(_ indexPath: IndexPath) {
        if indexPath.row == population.count - 15 {
            if totalRepositories > population.count {
                NotificationCenter.default.post(Notification(name: .loadMoreBrowsedRepositiories))
            }
        }
    }
    
    @objc func loadMore(_ notification: Notification) {
        guard let text = UserDefaults.standard.string(forKey: UserDefaults.Key.searchingText) else {
            let alert = AlertConfiguration(alertTitle: "Some error occured", alertBody: "We lost you browsing text")
            UIRouter.instance.presentAlert(self, configure: alert) {
                let request = SearchRequest(text: "swift", page: 0)
                self.loadRepositories(with: request)
            }
            return
        }
        let page = UserDefaults.standard.integer(forKey: UserDefaults.Key.pageToUploadFromGithubBrowsing)
        UserDefaults.standard.set(page + 1, forKey: UserDefaults.Key.pageToUploadFromGithubBrowsing)
        let request = SearchRequest(text: text, page: page + 1)
        loadRepositories(with: request)
    }
    
}
