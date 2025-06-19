# Walmart Seller API Ruby SDK

⚠️ **WARNING: This is an AI-generated SDK and has not yet been reviewed or tested. Use at your own risk.**

A comprehensive Ruby SDK for interacting with Walmart's Seller API, providing easy access to inventory management, order processing, and marketplace operations.

## Features

- **Authentication**: Automatic OAuth2 token management
- **Inventory Management**: Update and manage product inventory
- **Order Processing**: Retrieve, acknowledge, ship, and cancel orders
- **Item Management**: Create, update, and manage product listings
- **Shipping**: Manage shipping templates and calculate rates
- **Reports**: Generate and download various marketplace reports
- **Error Handling**: Comprehensive error handling with custom exception classes
- **Logging**: Built-in request/response logging
- **Pagination**: Automatic pagination support for list endpoints

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'walmart_seller_api'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install walmart_seller_api
```

## Configuration

Configure the gem with your Walmart Seller API credentials:

```ruby
WalmartSellerApi.configure do |config|
  config.client_id = "your_client_id"
  config.client_secret = "your_client_secret"
  config.environment = :sandbox  # or :production
  config.timeout = 30
  config.open_timeout = 10
  config.logger = Rails.logger  # Optional: for request logging
end
```

## Usage

### Inventory Management

```ruby
# Get inventory for a specific SKU
inventory = WalmartSellerApi.inventory.get_inventory("SKU123")

# Update inventory quantity
WalmartSellerApi.inventory.update_inventory("SKU123", 50)

# Bulk update inventory
updates = [
  { sku: "SKU123", quantity: 50 },
  { sku: "SKU456", quantity: 25 }
]
WalmartSellerApi.inventory.bulk_update_inventory(updates)

# Get inventory by warehouse
warehouse_inventory = WalmartSellerApi.inventory.get_inventory_by_warehouse("SKU123", "WAREHOUSE001")
```

### Order Management

```ruby
# Get orders with filters
orders = WalmartSellerApi.orders.get_orders(
  limit: 20,
  status: "Acknowledged",
  created_start_date: "2024-01-01",
  created_end_date: "2024-01-31"
)

# Get specific order
order = WalmartSellerApi.orders.get_order("ORDER123")

# Acknowledge an order
WalmartSellerApi.orders.acknowledge_order("ORDER123")

# Ship an order
order_lines = [
  {
    order_line_number: "1",
    quantity: 2,
    ship_date_time: Time.now.iso8601,
    carrier_name: "FedEx",
    method_code: "Ground",
    tracking_number: "123456789"
  }
]
WalmartSellerApi.orders.ship_order("ORDER123", order_lines)

# Cancel an order
WalmartSellerApi.orders.cancel_order("ORDER123", "Out of stock")
```

### Item Management

```ruby
# Get items
items = WalmartSellerApi.items.get_items(limit: 50, lifecycle_status: "Active")

# Get specific item
item = WalmartSellerApi.items.get_item("SKU123")

# Create a new item
item_data = {
  sku: "SKU123",
  productName: "Sample Product",
  shortDescription: "A sample product description",
  price: {
    amount: 29.99,
    currency: "USD"
  },
  shipping: {
    weight: {
      value: 1.5,
      unit: "LB"
    },
    dimensions: {
      length: 10,
      width: 5,
      height: 2,
      unit: "IN"
    }
  }
}
WalmartSellerApi.items.create_item(item_data)

# Update an item
WalmartSellerApi.items.update_item("SKU123", { price: { amount: 24.99, currency: "USD" } })

# Retire an item
WalmartSellerApi.items.retire_item("SKU123")
```

### Shipping

```ruby
# Get shipping templates
templates = WalmartSellerApi.shipping.get_shipping_templates

# Create shipping template
template_data = {
  templateName: "Standard Shipping",
  rateType: "FLAT_RATE",
  rate: {
    amount: 5.99,
    currency: "USD"
  }
}
WalmartSellerApi.shipping.create_shipping_template(template_data)

# Calculate shipping rate
shipping_request = {
  originAddress: {
    address1: "123 Main St",
    city: "Bentonville",
    state: "AR",
    postalCode: "72716",
    country: "US"
  },
  destinationAddress: {
    address1: "456 Oak Ave",
    city: "New York",
    state: "NY",
    postalCode: "10001",
    country: "US"
  },
  items: [
    {
      sku: "SKU123",
      quantity: 1,
      weight: { value: 1.5, unit: "LB" }
    }
  ]
}
rates = WalmartSellerApi.shipping.calculate_shipping_rate(shipping_request)
```

### Reports

```ruby
# Get available reports
reports = WalmartSellerApi.reports.get_available_reports

# Create a custom report
report_params = {
  startDate: "2024-01-01",
  endDate: "2024-01-31",
  reportFilters: {
    status: "Shipped"
  }
}
report = WalmartSellerApi.reports.create_report("ITEM_PERFORMANCE", report_params)

# Check report status
status = WalmartSellerApi.reports.get_report_status(report["reportId"])

# Download report when ready
if status["status"] == "READY"
  report_data = WalmartSellerApi.reports.download_report(report["reportId"])
end

# Get specific report types
orders_report = WalmartSellerApi.reports.get_orders_report("2024-01-01", "2024-01-31")
inventory_report = WalmartSellerApi.reports.get_inventory_report
financial_report = WalmartSellerApi.reports.get_financial_report("2024-01-01", "2024-01-31")
```

### Feeds

```ruby
# Submit a new feed
feed_response = WalmartSellerApi.feeds.submit_feed(
  "ITEM_FULL",
  "/path/to/your/feed.xml"
)

# Get feed status
status = WalmartSellerApi.feeds.get_feed_status("feedId123")

# Get feed result
result = WalmartSellerApi.feeds.get_feed_result("feedId123")

# List feeds
feeds = WalmartSellerApi.feeds.list_feeds(feed_type: "ITEM_FULL", status: "PROCESSED", limit: 10)
```

## Error Handling

The SDK provides comprehensive error handling with specific exception classes:

```ruby
begin
  WalmartSellerApi.inventory.update_inventory("SKU123", 50)
rescue WalmartSellerApi::AuthenticationError => e
  puts "Authentication failed: #{e.message}"
rescue WalmartSellerApi::ValidationError => e
  puts "Validation error: #{e.message}"
rescue WalmartSellerApi::RateLimitError => e
  puts "Rate limit exceeded: #{e.message}"
rescue WalmartSellerApi::NotFoundError => e
  puts "Resource not found: #{e.message}"
rescue WalmartSellerApi::ServerError => e
  puts "Server error: #{e.message}"
rescue WalmartSellerApi::NetworkError => e
  puts "Network error: #{e.message}"
end
```

## Pagination

The SDK automatically handles pagination for list endpoints:

```ruby
# Get all items with automatic pagination
all_items = []
WalmartSellerApi.items.get_items do |items|
  all_items.concat(items)
end
```

## Logging

Enable request/response logging by setting a logger:

```ruby
WalmartSellerApi.configure do |config|
  config.logger = Rails.logger
end
```

This will log all API requests and responses for debugging purposes.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yourusername/walmart_seller_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the WalmartSellerApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md). 