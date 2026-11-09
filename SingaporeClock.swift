import AppKit

final class SingaporeClock: NSObject, NSApplicationDelegate {
    private enum ClockZone: String, CaseIterable {
        case singapore = "Asia/Singapore"
        case pacific = "America/Los_Angeles"

        var name: String {
            switch self {
            case .singapore: return "Singapore Time"
            case .pacific: return "Pacific Time"
            }
        }

        var prefix: String {
            switch self {
            case .singapore: return "🇸🇬"
            case .pacific: return "🇺🇸"
            }
        }
    }

    private let preferenceKey = "SelectedClockZone"
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    private let formatter = DateFormatter()
    private var zone = ClockZone.singapore
    private var zoneItems: [ClockZone: NSMenuItem] = [:]

    func applicationDidFinishLaunching(_ notification: Notification) {
        formatter.locale = Locale(identifier: "en_SG")
        formatter.dateFormat = "EEE MMM d h:mm a"

        let menu = NSMenu()
        for option in ClockZone.allCases {
            let item = NSMenuItem(title: option.name, action: #selector(selectZone(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = option.rawValue
            zoneItems[option] = item
            menu.addItem(item)
        }
        menu.addItem(.separator())
        menu.addItem(withTitle: "Quit International Clock", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        statusItem.menu = menu

        let savedZone = UserDefaults.standard.string(forKey: preferenceKey).flatMap(ClockZone.init(rawValue:))
        showZone(savedZone ?? .singapore)
        let refreshTimer = Timer(timeInterval: 1, target: self, selector: #selector(updateClock), userInfo: nil, repeats: true)
        RunLoop.main.add(refreshTimer, forMode: .common)
    }

    @objc private func selectZone(_ item: NSMenuItem) {
        guard let identifier = item.representedObject as? String,
              let option = ClockZone(rawValue: identifier) else { return }
        UserDefaults.standard.set(option.rawValue, forKey: preferenceKey)
        showZone(option)
    }

    private func showZone(_ option: ClockZone) {
        zone = option
        formatter.timeZone = TimeZone(identifier: option.rawValue)
        statusItem.button?.toolTip = option.name
        for (itemZone, item) in zoneItems {
            item.state = itemZone == option ? .on : .off
        }
        updateClock()
    }

    @objc private func updateClock() {
        let time = formatter.string(from: Date())
        let title = "\(zone.prefix) \(time)"
        if statusItem.button?.title != title {
            statusItem.button?.title = title
            statusItem.button?.setAccessibilityLabel("\(zone.name), \(time)")
        }
    }
}

let app = NSApplication.shared
let clock = SingaporeClock()
app.delegate = clock
app.run()
