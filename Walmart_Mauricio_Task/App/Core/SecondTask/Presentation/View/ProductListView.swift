//
//  ProductView.swift
//  Walmart_Mauricio_Task
//
//  Created by MaurZac on 10/10/24.
//
import UIKit
import Combine

final class ProductListViewController: UIViewController {
    
    private var viewModel: ProductListViewModel!
    private var cancellables = Set<AnyCancellable>()
    private var tableView: UITableView!
    var coordinator: ProductListCoordinator?
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let repository = ProductRepositoryImpl()
        viewModel = ProductListViewModel(repository: repository)
        view.isUserInteractionEnabled = true
        setupUI()
        setupBindings()
        viewModel.fetchProducts()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        self.title = "Productos"
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.$products
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                guard let activityIndicator = self?.activityIndicator else {
                    return
                }
                activityIndicator.stopAnimating()
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .sink { [weak self] error in
                if let error = error {
                    self?.showErrorAlert(error: error)
                    guard let activityIndicator = self?.activityIndicator else {
                        return
                    }
                    activityIndicator.stopAnimating()
                }
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator?.startAnimating()
                } else {
                    self?.activityIndicator?.stopAnimating()
                }
            }
            .store(in: &cancellables)
    }
    
    private func showErrorAlert(error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfProducts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        let product = viewModel.getProduct(at: indexPath.row)
        cell.selectionStyle = .none
        cell.configure(with: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = viewModel.getProduct(at: indexPath.row)
        coordinator?.navigateToMapView(location: "\(selectedProduct.location)")
    }
}
