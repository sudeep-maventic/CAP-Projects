namespace my.shop;

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

entity Products{
    key ID: Integer;

    @mandatory
    @assert.unique: {productName: [productName]}
    productName: String;

    category: Category @assert.range;

    @assert.range: [1, 999]
    quantity: Integer;

    @assert.range: [1, 999999]
    price: Integer;

    @readonly
    amount: Integer = quantity * price;

    // Many to Many
    orderItems: Association to many OrderItems on orderItems.product = $self;
}

entity Customer{
    key Cust_ID: Integer;

    @mandatory
    cust_name: String(50) not null;

    phone: Integer64;
    
    @assert.format : '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    @assert.unique: {email: [email]}
    email: String not null;

    // 1 : 1
    profile: Composition of one CustomerProfile on profile.customer = $self;

    // 1 : many
    orders: Association to many Orders on orders.customerId = $self;

    address: Address;
}

entity CustomerProfile{
    key ID: Integer;
    customer: Association to one Customer;
    loyaltyPoints: Integer default 0;
    memberShip: String default 'Bronze';
}

entity Orders{
    key ID: Integer;
    customerId: Association to Customer @assert.target;
    order_status: Status @assert.range default 'P';
    total_amount: Decimal(10, 2);
    payment_method: String;

    // 1 : many Composition 
    items: Composition of many OrderItems on items.order = $self;
}

entity OrderItems{
    key ID: Integer;
    order: Association to Orders;
    product: Association to Products;

    @assert.range: [1, 1000]
    qty: Integer default 1;

    unitPrice: Decimal(10, 2);
}