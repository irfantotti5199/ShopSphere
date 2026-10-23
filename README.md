# ShopSphere 🛍️

A modern iOS shopping application built with **Swift, SwiftUI, MVVM, and async/await**. ShopSphere demonstrates real-world iOS development practices, including REST API integration, paginated product loading, product discovery, shopping cart management, favourites, and local persistence using Core Data.

## ✨ Features

- **Product Listing** — Browse products in a responsive grid layout.
- **REST API Integration** — Fetch product data from the DummyJSON API.
- **Pagination** — Load products in batches as the user scrolls.
- **Product Search** — Search for products by keyword.
- **Category Filtering** — Filter products by category.
- **Product Details** — View product descriptions, prices, ratings, and images.
- **Shopping Cart** — Add products, update quantities, remove items, and calculate totals.
- **Favourites / Wishlist** — Save favourite products for quick access.
- **Core Data Persistence** — Store product data, favourites, and cart information locally.
- **Offline Support** — Display cached products when network requests fail.

> **Development status:** ShopSphere is being developed incrementally. Some features, including complete persistence restoration, offline behavior, and automated tests, may still be in progress.

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| Swift | Primary programming language |
| SwiftUI | Declarative user interface |
| MVVM | Separation of UI and presentation logic |
| Foundation | Networking utilities and data handling |
| URLSession | HTTP requests |
| async/await | Asynchronous networking |
| Codable / Decodable | JSON model decoding |
| Core Data | Local persistence and product caching |
| Git & GitHub | Version control |

## 🏗️ Architecture

ShopSphere follows the Model–View–ViewModel (MVVM) architectural pattern.

```text
ShopSphere
├── Core
│   ├── Networking
│   │   ├── ProductServiceProtocol.swift
│   │   ├── ProductService.swift
│   │   └── NetworkError.swift
│   └── Persistence
│       ├── PersistenceController.swift
│       └── ProductPersistenceService.swift
├── Features
│   ├── Products
│   │   ├── Product.swift
│   │   ├── ProductListView.swift
│   │   ├── ProductListViewModel.swift
│   │   ├── ProductCardView.swift
│   │   └── ProductDetailView.swift
│   ├── Cart
│   │   ├── CartItem.swift
│   │   ├── CartView.swift
│   │   └── CartViewModel.swift
│   └── Favourites
│       ├── FavouritesView.swift
│       └── FavouritesViewModel.swift
└── ShopSphereApp.swift
```

*The directory tree illustrates the intended organization. Actual filenames and folders may differ as development progresses.*

### Architecture responsibilities

- **Model:** Represents product data and cart items.
- **View:** Renders screens and handles user interactions.
- **ViewModel:** Manages presentation state and business logic.
- **Service layer:** Encapsulates API requests and persistence operations.
- **Dependency injection:** Allows services and shared state to be supplied to ViewModels.

## 🌐 API Integration

ShopSphere uses the public [DummyJSON Products API](https://dummyjson.com/docs/products) for sample product data.

| Operation | Endpoint |
|---|---|
| Fetch products | `GET /products?limit=20&skip=0` |
| Search products | `GET /products/search?q=phone` |
| Fetch product details | `GET /products/1` |
| Fetch categories | `GET /products/categories` |
| Filter by category | `GET /products/category/smartphones` |

### Pagination

Pagination uses two query parameters:

- `limit` — Maximum number of products returned per request.
- `skip` — Number of products skipped before returning results.

For example, `limit=20&skip=20` requests the next batch of products.

## 💾 Persistence and Offline Strategy

Core Data is used as the local persistence layer.

The planned persistence responsibilities include:

- Caching fetched products for offline browsing.
- Saving favourite product IDs.
- Saving cart product IDs and quantities.
- Restoring saved state when the app launches.

Offline behavior depends on successfully saving and restoring the relevant data. Full persistence integration is still subject to implementation and testing.

## 🚀 Getting Started

### Prerequisites

- macOS
- Xcode
- Swift toolchain compatible with the selected Xcode version
- iOS Simulator or a compatible iOS device

### Installation

1. Clone the repository:

   ```bash
   git clone git@github.com:irfantotti5199/ShopSphere.git
   ```

2. Navigate to the project directory:

   ```bash
   cd ShopSphere
   ```

3. Open the Xcode project:

   ```bash
   open ShopSphere.xcodeproj
   ```

4. Select an iOS Simulator or connected device.
5. Build and run the app using **Product → Run** in Xcode.

No API key is required for the public DummyJSON product endpoints used by this project.

## 🧪 Testing

Automated tests are planned for the following areas:

- Product decoding and API response handling.
- Product pagination and search.
- Category filtering.
- Cart quantity updates and total-price calculations.
- Favourite state management.
- Core Data persistence and offline fallback.

## 🔮 Future Improvements

- [ ] Complete and verify Core Data persistence for cart and favourites.
- [ ] Restore favourite products after app relaunch.
- [ ] Cache paginated product results.
- [ ] Improve offline loading and error recovery.
- [ ] Add search debouncing and request cancellation.
- [ ] Add sorting and advanced filters.
- [ ] Write unit tests using mock services.
- [ ] Add UI tests and accessibility improvements.
- [ ] Improve product detail images and loading states.
- [ ] Add a polished checkout flow backed by a suitable backend.

## 📸 Screenshots

Screenshots will be added as the UI is finalized.

Suggested screenshots:

- Product listing
- Search and category filters
- Product details
- Shopping cart
- Favourites
- Offline product listing

## ⚠️ Disclaimer

ShopSphere is an educational portfolio project built to demonstrate iOS application development practices. Product data is provided by DummyJSON. It is not affiliated with any commercial retailer, and it does not currently provide a production payment or checkout system.

## 👨‍💻 Author

**Irfan Totti**

[GitHub Profile](https://github.com/irfantotti5199)

---

Built with ❤️ using Swift and SwiftUI.
