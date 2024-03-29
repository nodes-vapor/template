import Fluent
import Vapor

struct AppUserController {
    func logIn(request: Request) -> EventLoopFuture<DataWrapper<AppUserLoginResponse>> {
        AppUserLoginRequest
            .logIn(
                on: request,
                errorOnWrongPassword: AppError.incorrectCredentials,
                currentDate: request.date.current()
            )
            .flatMapThrowing { try $0.map(AppUserMeResponse.init) }
            .map(DataWrapper.init)
    }

    func me(request: Request) throws -> DataWrapper<AppUserResponse> {
        try .init(data: .init(request.auth.require()))
    }

    func refreshToken(request: Request) throws -> DataWrapper<RefreshTokenResponse> {
        try .init(data: .init(AppUserRefreshKeychainConfig.makeToken(on: request)))
    }

    func create(request: Request) throws -> EventLoopFuture<Response> {
        AppUserCreateRequest
            .create(on: request)
            .flatMap(request.repositories.appUser.saveAppUser)
            .flatMapThrowing(AppUserCreateResponse.init)
            .map(DataWrapper.init)
            .encodeResponse(status: .created, for: request)
    }

    func list(request: Request) throws -> EventLoopFuture<Page<AppUserResponse>> {
        request
            .repositories
            .appUser
            .paginateAppUsers(searchterm: request.query.searchTerm, on: request)
            .flatMapThrowing { paginatedRespondents in
                try paginatedRespondents.map(AppUserResponse.init)
            }
    }

    func single(request: Request) -> EventLoopFuture<DataWrapper<AppUserResponse>> {
        AppUser
            .find(on: request)
            .unwrap()
            .flatMapThrowing(AppUserCreateResponse.init)
            .map(DataWrapper.init)
    }

    func update(request: Request) throws -> EventLoopFuture<DataWrapper<AppUserUpdateResponse>> {
        AppUserUpdateRequest
            .update(on: request)
            .flatMap(request.repositories.appUser.saveAppUser)
            .flatMapThrowing(AppUserUpdateResponse.init)
            .map(DataWrapper.init)
    }

    func delete(request: Request) throws -> EventLoopFuture<HTTPStatus> {
        AppUser
            .find(on: request)
            .unwrap()
            .flatMap(request.repositories.appUser.deleteAppUser)
            .transform(to: .noContent)
    }
}

extension AppUserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.post("login", use: logIn)

        let meRoutes = routes.grouped("me")
        meRoutes
            .grouped(AppUserAccessKeychainConfig.authenticator)
            .get("", use: me)
        meRoutes
            .grouped(AppUserRefreshKeychainConfig.authenticator)
            .post("token", use: refreshToken)

        let accessKeychainProtected = routes.grouped(AppUserAccessKeychainConfig.authenticator)
        accessKeychainProtected.get("", use: list)
        accessKeychainProtected.post("", use: create)
        
        let singleUser = accessKeychainProtected.grouped(AppUser.pathComponent)
        singleUser.get("", use: single)
        singleUser.patch("", use: update)
        singleUser.delete("", use: delete)
    }
}
