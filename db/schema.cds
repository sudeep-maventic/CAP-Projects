namespace my.shop;

entity Products{
    key ID: UUID;

    @mandatory
    productName: String;
    category: Category @assert.range;
    quantity: Integer;
    price: Integer;

    @readonly
    amount: Integer = quantity * price;
}

entity Customer{
    key Cust_ID: UUID;
    cust_name: String(50);
    phone: Integer64;
    email: String;
    address: Address;
}

entity Orders{
    key ID: UUID;
    customerId: Association to Customer @assert.target;
    productId: Association to Products @assert.target;
    order_status: Status @assert.range;
    total_amount: Decimal(10, 2);
    payment_method: String;
}

type Status: String enum {
    Pending = 'P';
    Shipped = 'S';
    Delivered = 'D';
    Canceled = 'C';
}

type Address: {
    city: String;
    state: String;
    postal_code: Integer;
}

type Category: String enum{
    Electronics = 'E';
    Apparel = 'A';
    Kitchen = 'K';
    Beauty = 'B';
    Sports = 'S';
}