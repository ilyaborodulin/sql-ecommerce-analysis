DROP TABLE IF EXISTS ecommerce_data;

CREATE TABLE ecommerce_data (
    InvoiceNo TEXT,
    StockCode TEXT,
    Description TEXT,
    Quantity INT,
    InvoiceDate TIMESTAMP,
    UnitPrice NUMERIC(10,2),
    CustomerID NUMERIC(10,0),
    Country TEXT
);