THIS IS MY ATTEMPT AT BUILDING THE DATABASE STRUCTURE OF AN ECOMMERCE WEB APPLICATION.

I. STRUCTURAL BUSINESS RULES

IDENTIFIABLE ENTITIES:
• SELLER • CUSTOMER • PRODUCT • CATEGORY • ORDER • PACKAGE • RECEIPT

BUSINESS RULES:
A Seller can sell one or more Products and a Product could be sold by one or more Sellers.

A Seller can ship one or more products to the Amazon warehouse, but a given Product belongs to one Seller only.

A Product can belong to only one Category, but a given Category can have one or more Products.

A Category exists if an only if there are Products in it.

A Category is a pre-defined list that is set by Amazon.

A Customer can place zero or more Orders, but a given Order should be placed by only one Customer.

A Package can contain one or more Products, but a Product part of an Order placed by a Customer can only belong to one Package.

A Product may be part of different Orders(when same product is ordered by different customers), and an Order can contain one or more Products.

A Seller can be given zero or more Receipts, but a single Receipt belongs to only one Seller.

A Receipt can contain details of one or more Products, but a given Product can belong to only one Receipt.

Each row in an entity is identified by its own ID.

ASSUMPTIONS MADE:
A Consumer can buy a Product(s) only by placing an Order.

There cannot be an empty Category.

A Package can exist if an only if an existing Product is part of an Order.

II. CONCEPTUAL ERD / EERD

<img width="767" alt="Screenshot 2022-10-05 at 11 44 16 AM" src="https://user-images.githubusercontent.com/67741954/194103583-725113c7-fe73-4766-b034-d6980b9f43b1.png">

III. LOGICAL ERD / EERD

<img width="765" alt="Screenshot 2022-10-05 at 11 44 36 AM" src="https://user-images.githubusercontent.com/67741954/194103661-0f7d55df-ccb4-4a2d-8d38-f2e92a40a388.png">
