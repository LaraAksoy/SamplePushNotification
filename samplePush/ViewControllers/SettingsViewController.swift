import UIKit

class SettingsViewController: UIViewController {

    private let toggleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enable Notification Sound"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let soundSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Toggle this to enable/disable sound for incoming push notifications."
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
        setupUI()
        
        // Load current state
        soundSwitch.isOn = NotificationManager.shared.isSoundEnabled
        soundSwitch.addTarget(self, action: #selector(didToggleSwitch), for: .valueChanged)
    }
    
    private func setupUI() {
        view.addSubview(toggleLabel)
        view.addSubview(soundSwitch)
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            toggleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            toggleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            soundSwitch.centerYAnchor.constraint(equalTo: toggleLabel.centerYAnchor),
            soundSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            infoLabel.topAnchor.constraint(equalTo: toggleLabel.bottomAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func didToggleSwitch(_ sender: UISwitch) {
        NotificationManager.shared.isSoundEnabled = sender.isOn
        print("Sound setting changed to: \(sender.isOn)")
    }
}
