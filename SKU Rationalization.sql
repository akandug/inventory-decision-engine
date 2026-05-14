SELECT * FROM `sku rationalization`.homegear_inventory_data;

#The "Business Logic" Setup
SELECT 
    sku_id,
    category,
    unit_cost,
    selling_price,
    round((selling_price - unit_cost),2) AS margin_per_unit,
    units_sold_last_12m,
    -- BA Metric 1: Gross Margin %
    ROUND(((selling_price - unit_cost) / selling_price) * 100, 2) AS margin_pct,
    -- BA Metric 2: Inventory Value (Capital Tied Up)
    ROUND(inventory_on_hand * unit_cost, 2) AS capital_tied_up,
    -- BA Metric 3: Turnover Ratio (Efficiency)
    ROUND(units_sold_last_12m / NULLIF(inventory_on_hand, 0), 2) AS inventory_turnover
FROM `sku rationalization`.homegear_inventory_data;


WITH revenue_summary AS (
    SELECT 
        sku_id,
        category,
        (units_sold_last_12m * selling_price) as annual_revenue,
        inventory_turnover,
        margin_pct,
        -- Calculate cumulative revenue percentage
        SUM(units_sold_last_12m * selling_price) OVER() as total_company_revenue
    FROM (
        SELECT *, 
        ROUND(units_sold_last_12m / NULLIF(inventory_on_hand, 0), 2) AS inventory_turnover,
        ROUND(((selling_price - unit_cost) / selling_price) * 100, 2) AS margin_pct
        FROM `sku rationalization`.homegear_inventory_data
    ) sub
),
ranked_revenue AS (
    SELECT *,
        SUM(annual_revenue) OVER(ORDER BY annual_revenue DESC) / total_company_revenue as cumulative_pct
    FROM revenue_summary
)
SELECT *,
    -- ABC Logic
    CASE 
        WHEN cumulative_pct <= 0.70 THEN 'A'
        WHEN cumulative_pct <= 0.90 THEN 'B'
        ELSE 'C'
    END AS abc_class,
    -- XYZ Logic (Based on Turnover)
    CASE 
        WHEN inventory_turnover >= 4 THEN 'X' -- Fast Moving
        WHEN inventory_turnover >= 1.5 THEN 'Y' -- Slow Moving
        ELSE 'Z' -- Stagnant
    END AS xyz_class
FROM ranked_revenue;


# To know the number of CZ products are available
SELECT 
    abc_class, 
    xyz_class, 
    COUNT(sku_id) AS sku_count,
    ROUND(SUM(annual_revenue), 2) AS total_revenue_impact,
    ROUND(SUM(capital_tied_up), 2) AS total_capital_tied_up
FROM (
    WITH revenue_summary AS (
        SELECT 
            sku_id, 
            category,
            inventory_on_hand,
            unit_cost,
            (units_sold_last_12m * selling_price) as annual_revenue,
            (inventory_on_hand * unit_cost) as capital_tied_up,
            ROUND(units_sold_last_12m / NULLIF(inventory_on_hand, 0), 2) AS inventory_turnover,
            SUM(units_sold_last_12m * selling_price) OVER() as total_company_revenue
        FROM `sku rationalization`.homegear_inventory_data
    ),
    ranked_revenue AS (
        SELECT *,
            SUM(annual_revenue) OVER(ORDER BY annual_revenue DESC) / total_company_revenue as cumulative_pct
        FROM revenue_summary
    )
    SELECT *,
        CASE 
            WHEN cumulative_pct <= 0.70 THEN 'A'
            WHEN cumulative_pct <= 0.90 THEN 'B'
            ELSE 'C'
        END AS abc_class,
        CASE 
            WHEN inventory_turnover >= 4 THEN 'X' 
            WHEN inventory_turnover >= 1.5 THEN 'Y' 
            ELSE 'Z' 
        END AS xyz_class
    FROM ranked_revenue
) AS matrix_results
GROUP BY abc_class, xyz_class
ORDER BY abc_class, xyz_class;



