import Mailgun
import Vapor

// MARK: App User Access Token
extension Environment {
    static var appUserAccessTokenSignerKey: Data {
        assertGet("APP_USER_ACCESS_TOKEN_SIGNER_KEY").data(using: .utf8)!
    }

    static var appUserAccessTokenExpiration: TimeInterval {
        self.get("APP_USER_ACCESS_TOKEN_EXPIRATION").flatMap { TimeInterval($0) } ?? 3600
    }
}

// MARK: App User Refresh Token
extension Environment {
    static var appUserRefreshTokenSignerKey: Data {
        assertGet("APP_USER_REFRESH_TOKEN_SIGNER_KEY").data(using: .utf8)!
    }

    static var appUserRefreshTokenExpiration: TimeInterval {
        self.get("APP_USER_REFRESH_TOKEN_EXPIRATION").flatMap { TimeInterval($0) } ?? 3600 * 24 * 365
    }
}

// MARK: App User (Re)set Token
extension Environment {
    static var appUserResetTokenSignerKey: Data {
        assertGet("APP_USER_RESET_TOKEN_SIGNER_KEY").data(using: .utf8)!
    }

    static var appUserResetTokenExpiration: TimeInterval {
        self.get("APP_USER_RESET_TOKEN_EXPIRATION").flatMap { TimeInterval($0) } ?? 3600
    }

    static var appUserResetEmailSender: String { assertGet("APP_USER_RESET_EMAIL_SENDER") }
    static var appUserResetEmailSubject: String { assertGet("APP_USER_RESET_EMAIL_SUBJECT") }
    static var appUserResetBaseURL: String { assertGet("APP_USER_RESET_BASE_URL") }
    static var appUserWelcomeEmailSubject: String { assertGet("APP_USER_WELCOME_EMAIL_SUBJECT") }
}

// MARK: Bugsnag
extension Environment {
    static var bugsnagAPIKey: String { assertGet("BUGSNAG_API_KEY") }
}

// MARK: Mailgun
extension Environment {
    static var mailgunPassword: String { assertGet("MAILGUN_PASSWORD") }
    static var mailgunDefaultDomain: String { assertGet("MAILGUN_DEFAULT_DOMAIN") }
    static var mailgunRegion: MailgunRegion { MailgunRegion(rawValue: assertGet("MAILGUN_REGION")) ?? .us }
}

// MARK: PostgreSQL
extension Environment {
    static var postgreSQLURL: String { assertGet("POSTGRESQL_URL") }
}
