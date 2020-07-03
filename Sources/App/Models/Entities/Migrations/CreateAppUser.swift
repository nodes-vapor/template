import Fluent

struct CreateAppUser: Migration {
    private let entity = AppUser()

    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database
            .schema(AppUser.schema)
            .id()
            .field(.email, .string, .required)
            .field(.name, .string, .required)
            .field(.hashedPassword, .string, .required)
            .field(.shouldResetPassword, .bool, .required)
            .field(.createdAt, .datetime)
            .field(.updatedAt, .datetime)
            .unique(on: .id, .email)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(AppUser.schema).delete()
    }
}
