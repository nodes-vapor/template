import Keychain
import Vapor

struct AppUserLoginRequest: Codable, LoginRequest {
    typealias AccessKeychainConfig = AppUserAccessKeychainConfig
    typealias RefreshKeychainConfig = AppUserRefreshKeychainConfig

    static let hashedPasswordKey: KeyPath<AppUser, String> = \.hashedPassword

    let id: String
    let password: String

    func logIn(on request: Request) -> EventLoopFuture<AppUser> {
        request.repositories.appUser.find(id).unwrap(or: MoodError.incorrectCredentials)
    }
}
