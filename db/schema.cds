namespace my.shop;

entity Products{
    key ID: UUID;
    productName: String;
    category: Category @assert.range;
    quantity: Integer;
    price: Integer;
    amount: Integer = quantity * price;
}

type Category: String enum{
    Electronics = 'E';
    Apparel = 'A';
    Kitchen = 'K';
    Beauty = 'B';
    Sports = 'S';
}