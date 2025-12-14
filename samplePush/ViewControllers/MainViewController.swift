import UIKit

class MainViewController: UIViewController {

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Push Notification App"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go to Settings", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        
        settingsButton.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.addSubview(statusLabel)
        view.addSubview(settingsButton)
        
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            settingsButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 20),
            settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func didTapSettings() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}
