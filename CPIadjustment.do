
/* CPI values were obtaine from https://data.bls.gov/pdq/SurveyOutputServle
prices are adjusted to 2016 us dollars. */

gen log_cpi_price = ln(cpi_adjusted_price) 
* I actualy merged CPI data to 
use "/Users/christiancarrillo/Documents/Thesis(2)/Data(2),dta.dta"
sort year month 
mmerge year month using "CPI_prices.dta", type(n:1) 
