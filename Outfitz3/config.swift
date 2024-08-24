import Foundation

struct Config {
    static var openAIAPIKey: String {
        return getAPIKey(for: "openAIAPIKey", envKey: "OPENAI_API_KEY")
    }
    
    static var customImageAPIKey: String {
        return getAPIKey(for: "customImageAPIKey", envKey: "CUSTOM_IMAGE_API_KEY")
    }
    
    private static func getAPIKey(for plistKey: String, envKey: String) -> String {
        // First, try to get the API key from environment variables
        if let envAPIKey = ProcessInfo.processInfo.environment[envKey] {
            return envAPIKey
        }
        
        // Fallback to getting the API key from the Config.plist file
        guard let filePath = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath),
              let apiKey = plist[plistKey] as? String, !apiKey.isEmpty else {
            fatalError("Couldn't find key '\(plistKey)' in 'Config.plist' or environment variable '\(envKey)'.")
        }
        return apiKey
    }
}
