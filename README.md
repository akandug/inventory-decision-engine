## Inventory Decision Engine
Data-driven SKU rationalization system for optimizing inventory, profitability, and product assortment decisions.

## Tools Used
- Excel
- MySQL
- Tableau

## Project Overview
This project provides a data-driven framework to optimize product portfolio density and eliminate profit drains.

## Business Problem
The company is currently guessing which products to keep, causing three specific headaches that need a data-driven fix

1.	Diminishing Returns: The cost of managing, storing, and marketing new SKUs began to outweigh the marginal revenue they generated.

2.	Operational Inefficiency:  We have too much money tied up in inventory that isn't moving. We need to identify these so we can clear them out and use that cash to double down on our "best-sellers".
 
3.	“Buying” Decision-Making: The buying team can't tell the difference between items that help sell others (Complements) and items that just steal sales from what we already have (Substitutes). We need a framework to help them decide which items actually add value to a customer's basket.

## Project Objective
Identify and free up cash flow locked away in stagnant, high-cost warehouse inventory.Streamline Product Assortment. 
Reduce supply chain complexity by establishing clear, data-backed boundaries for keeping or dropping items.Eliminate Profit Loss. Automatically flag financial anomalies, such as items where the wholesale cost exceeds the retail shelf price.

## Dataset
The breakdown of each data column 

#Product Identification Columns
•	sku_id (Stock Keeping Unit ID): The unique tracking code assigned to each specific product variant.
•	product_name: The descriptive name of the individual retail item.
•	category: The broad department group the item belongs 

#Financial Columns
•	unit_cost: The wholesale price the business paid to acquire or manufacture a single unit of that product.
•	selling_price: The retail price the company charges customers for a single unit.

#Inventory & Sales Velocity Columns
•	units_sold_last_12m: The total volume of units purchased by customers over the past year. This measures consumer demand.
•	inventory_on_hand: The physical count of units currently sitting in the warehouse or store shelves. This represents the current stock level and tied-up capital.

## Analysis Approach (The ABC/XYZ Matrix)
The engine processes raw operational data and segments the product catalog into actionable performance tiers:
ABC Analysis (Revenue Impact): Ranks products by their total annual revenue contribution.

Tier A: Top-performing items driving 70% of total revenue.
Tier B: Mid-tier items driving the next 20% of revenue.
Tier C: Low-performing items making up the final 10% of revenue.

XYZ Analysis (Stock Velocity): Categorizes products by how quickly they move out of the warehouse based on an average turnover benchmark of 3.829.

Class X (Fast): Highly efficient items with an inventory turnover ratio of 4 or higher.
Class Y (Medium): Steady items with a turnover ratio between 1.5 and 4.
Class Z (Stagnant): Dead stock with a turnover ratio below 1.5.

The ultimate operational goal of this project is to isolate "CZ" products—items that contribute the least to annual revenue (C) and move the slowest through the warehouse (Z). Isolating this segment gives management a direct action list to prune underperforming products, slash storage overhead, and reclaim tied-up capital.

## Preview
[Dashboard Sreenshot] (https://github.com/akandug/inventory-decision-engine/blob/main/sku%20dashboard.PNG )

## Insights and Recommendations
I performed a SKU Rationalization study that identified that furniture is the company’s bank, it should be optimized and shouldn’t be slashed. We liquidate CZs in all the products categories. We can release 64.tmillion Naira tied up and really invest in our best selling products.

## Summary Action Plan
# Category	Primary Focus	Strategy
-On Furniture	category, protect AX/AY; liquidate bulky CZs to free space.
-Drastically reduce kitchenware SKU count; it’s currently clutter.
-For Home Decor, target the 149 CZ items for immediate clearance sales.
-Keep the high-movers (BX/CX) but trim the dead weight for gardening category.

