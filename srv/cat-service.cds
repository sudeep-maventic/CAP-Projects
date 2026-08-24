using my.shop as my from '../db/schema';

service CatalogService{
    entity Products as projection on my.Products;
}