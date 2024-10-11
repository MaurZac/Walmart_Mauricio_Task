//
//  MapView.swift
//  Walmart_Mauricio_Task
//
//  Created by MaurZac on 10/10/24.
//
import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    var viewModel: MapViewModel
    
    private let maxLatitudeDelta: CLLocationDegrees = 50.0
    private let minLatitudeDelta: CLLocationDegrees = 0.0001
    private let maxLongitudeDelta: CLLocationDegrees = 50.0
    private let minLongitudeDelta: CLLocationDegrees = 0.0001
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .black
        label.text = "Origen de Producto"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.layer.cornerRadius = 30
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrowshape.turn.up.backward.circle.fill"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dismissMapViewController), for: .touchUpInside)
        return button
    }()
    
    private let zoomInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
        return button
    }()
    
    private let zoomOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMap()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.addSubview(containerView)
        
        containerView.addSubview(titleText)
        containerView.addSubview(mapView)
        containerView.addSubview(backBtn)
        containerView.addSubview(zoomInButton)
        containerView.addSubview(zoomOutButton)
        
        
        NSLayoutConstraint.activate([
            
            titleText.topAnchor.constraint(equalTo: backBtn.topAnchor,constant: -5),
            titleText.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor,constant: 30),
            titleText.heightAnchor.constraint(equalToConstant: 30),
            titleText.widthAnchor.constraint(equalToConstant: 200),
            
            
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            mapView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            mapView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            backBtn.widthAnchor.constraint(equalToConstant: 25),
            backBtn.heightAnchor.constraint(equalToConstant: 25),
            
            zoomInButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            zoomInButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            zoomInButton.widthAnchor.constraint(equalToConstant: 40),
            zoomInButton.heightAnchor.constraint(equalToConstant: 40),
            
            zoomOutButton.bottomAnchor.constraint(equalTo: zoomInButton.topAnchor, constant: -10),
            zoomOutButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            zoomOutButton.widthAnchor.constraint(equalToConstant: 40),
            zoomOutButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupMap() {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(viewModel.location) { [weak self] (placemarks, error) in
            guard let strongSelf = self else { return }
            if let placemark = placemarks?.first, let location = placemark.location {
                let coordinate = location.coordinate
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                strongSelf.mapView.addAnnotation(annotation)
                
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
                strongSelf.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    @objc private func dismissMapViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func zoomIn() {
        var region = mapView.region
        region.span.latitudeDelta /= 5.0
        region.span.longitudeDelta /= 5.0
        
        if isValidRegion(region) {
            mapView.setRegion(region, animated: true)
        }
    }
    
    @objc private func zoomOut() {
        var region = mapView.region
        let zoomFactor: Double = 5.0
        
        let newLatitudeDelta = region.span.latitudeDelta * zoomFactor
        let newLongitudeDelta = region.span.longitudeDelta * zoomFactor
        
        region.span.latitudeDelta = min(max(newLatitudeDelta, minLatitudeDelta), maxLatitudeDelta)
        region.span.longitudeDelta = min(max(newLongitudeDelta, minLongitudeDelta), maxLongitudeDelta)
        
        mapView.setRegion(region, animated: true)
    }
    
    private func isValidRegion(_ region: MKCoordinateRegion) -> Bool {
        let maxDelta: CLLocationDegrees = 360.0
        let minDelta: CLLocationDegrees = 0.0001
        
        return region.span.latitudeDelta < maxDelta && region.span.latitudeDelta > minDelta &&
        region.span.longitudeDelta < maxDelta && region.span.longitudeDelta > minDelta
    }
}
