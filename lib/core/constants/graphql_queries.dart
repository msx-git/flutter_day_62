const String getProducts = """
query {
  products(limit: 12, offset: 0) {
    id
    title
    price
    description
    category {
      name
    }
  }
}
""";
