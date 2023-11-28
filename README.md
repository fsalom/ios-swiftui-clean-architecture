# Clean Architecture with SwiftUI
This repository is an implementation of Clean Architecture in a SwiftUI application. Clean architecture is a software design approach that separates concerns and organizes code into independent layers, facilitating maintainability and scalability.

## Project Structure
The project is organized into several layers, each with specific responsibilities. The overall project structure is as follows:

- Presentation: This layer contains the user interface implemented with SwiftUI. Views, view controllers, and other presentation-related components are located here.

- Domain: The domain layer defines the models and business rules of the application. It is independent of any framework and contains pure business logic.

- Data: Here, you find the concrete implementation of repositories and any data access logic. This layer communicates with the domain layer through protocols.

- Use Cases: Use cases encapsulate the application logic and orchestrate interactions between the presentation layer and the data layer. They are independent of the user interface and data implementation.

- DI: This layer provides concrete implementations of any technical details that do not fit into the previous layers, such as external services, caching, etc.

## Dependencies
- SwiftUI: Declarative user interface framework for creating fluid and maintainable applications.
- SwiftLint: Tool for maintaining clean and consistent Swift code.

## Project Setup

Clone this repository: 
```swift
git clone https://github.com/fsalom/ios-swiftui-clean-architecture.git
````

Open the project in Xcode
Build and run the application.

## Contributions
Contributions are welcome! If you find a bug or have an enhancement, create an issue or submit a pull request.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.