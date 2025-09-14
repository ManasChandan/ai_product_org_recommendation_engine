-- Company Details Dimension
CREATE TABLE company_details (
    company_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Category Details Dimension
CREATE TABLE category_details (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Product Details Dimension
CREATE TABLE product_details (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    fk_category_id INTEGER NOT NULL REFERENCES category_details(category_id)
);

-- Order Fact Table
CREATE TABLE order_fact (
    fk_company_id INTEGER NOT NULL REFERENCES company_details(company_id),
    order_id SERIAL PRIMARY KEY,
    fk_product_id INTEGER NOT NULL REFERENCES product_details(product_id),
    fk_user_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    date DATE NOT NULL
);

-- Instacart Details Table (Event/Line-item fact)
CREATE TABLE instacart_details (
    fk_company_id INTEGER NOT NULL REFERENCES company_details(company_id),
    fk_order_id INTEGER NOT NULL REFERENCES order_fact(order_id),
    fk_product_id INTEGER NOT NULL REFERENCES product_details(product_id),
    order_of_addition INTEGER,
    is_repeated BOOLEAN,
    day_since_prior_order INTEGER,
    order_hour_of_day INTEGER,
    order_day_of_week INTEGER,
    PRIMARY KEY (fk_company_id, fk_order_id, fk_product_id)
);
