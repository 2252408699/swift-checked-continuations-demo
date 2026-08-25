import Foundation

enum DemoError: Error, CustomStringConvertible {
    case invalidID
    var description: String { "The user ID must be positive" }
}

final class LegacyUserClient: Sendable {
    func loadUser(id: Int, completion: @escaping @Sendable (Result<String, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) {
            completion(.success("User #\(id)"))
        }
    }
}

func loadUser(id: Int, client: LegacyUserClient) async throws -> String {
    guard id > 0 else { throw DemoError.invalidID }
    return try await withCheckedThrowingContinuation { continuation in
        client.loadUser(id: id) { result in
            continuation.resume(with: result)
        }
    }
}

@main
struct Demo {
    static func main() async {
        let client = LegacyUserClient()
        do {
            print("Loading through a callback...")
            print("Result: \(try await loadUser(id: 42, client: client))")
            _ = try await loadUser(id: 0, client: client)
        } catch {
            print("Expected validation error: \(error)")
        }
    }
}
