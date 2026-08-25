using my.shop as my from '../db/schema';

service CatalogService{
    entity Products as projection on my.Products;
    entity Orders as projection on my.Orders;
    entity OrderItems as projection on my.OrderItems;
    entity Customer as projection on my.Customer;
    entity Profile as projection on my.CustomerProfile;
}