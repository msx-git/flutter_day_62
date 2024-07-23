const String addProduct = """
mutation addProduct(
  \$title: String!, 
  \$price: Float!, 
  \$description: String!, 
  \$categoryId: Float!,
  \$images: [String!]!
  ){
    addProduct(
      data: {
        title: \$title, 
        price:  \$price, 
        description: \$description, 
        categoryId: \$categoryId
        images: \$images
      }) {
      id
      title
      price
      description
      images
      category {
         id
        title
        price
      }
    }
}

""";


const String editProduct = """
mutation editProduct(
    \$id: ID!, 
    \$title: String!, 
    \$price: Float!, 
    \$description: String!,
) {
    updateProduct(
      id: \$id
      changes: {
        title: \$title
        price: \$price
        description: \$description
      }
    ) {
      id
      title
      price
    }
}
""";

const String updateProduct = """
mutation UpdateProduct(\$id: ID!, \$title: String, \$price: Float, \$description: String, \$categoryId: ID) {
  updateProduct(
  id: \$id, data: {
    title: \$title,
    price: \$price,
    description: \$description,
    categoryId: \$categoryId
  }) {
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

const String deleteProduct = """
mutation deleteProduct(\$id: ID!) {
  deleteProduct(id: \$id)
}
""";
