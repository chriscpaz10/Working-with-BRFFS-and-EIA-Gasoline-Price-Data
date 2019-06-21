clear 
cd "/Users/christiancarrillo/Documents/Thesis"
use "/Users/christiancarrillo/Documents/Thesis/Gasoline_PricesTax.dta"


* Coding states as FIPS to match masters dataset 
rename _state state 

gen _state = 0 

replace _state = 1 if state == "Alabama"
replace _state = 2 if state == "Alaska" 
replace _state = 4 if state == "Arizona "
replace _state = 5 if state == "Arkansas" 
replace _state = 6 if state == "California" 
replace _state = 8 if state == "Colorado"
replace _state = 9 if state == "Connecticut"
replace _state = 10 if state == "Delaware" 
replace _state = 11 if state == "District of Columbia" 
replace _state = 12 if state == "Florida" 
replace _state = 13 if state == "Georgia" 
replace _state = 15 if state == "Hawaii" 
replace _state = 16 if state == "Idaho" 
replace _state = 17 if state == "Illinois"
replace _state = 18 if state =="Indiana"
replace _state = 19 if state =="Iowa" 
replace _state = 20 if state == "Kansas" 
replace _state = 21 if state == "Kentucky"
replace _state = 22 if state == "Louisiana" 
replace _state = 23 if state == "Maine" 
replace _state = 24 if state == "Maryland" 
replace _state = 25 if state == "Massachusetts" 
replace _state = 26 if state == "Michigan" 
replace _state = 27 if state == "Minnesota" 
replace _state = 28 if state == "Mississippi" 
replace _state = 29 if state == "Missouri" 
replace _state = 30 if state == "Montana" 
replace _state = 31 if state == "Nebraska" 
replace _state = 32 if state == "Nevada" 
replace _state = 33 if state == "New Hampshire" 
replace _state = 34 if state == "New Jersey" 
replace _state = 35 if state == "New Mexico" 
replace _state = 36 if state == "New York" 
replace _state = 37 if state == "North Carolina" 
replace _state = 38 if state == "North Dakota" 
replace _state = 39 if state == "Ohio" 
replace _state = 40 if state == "Oklahoma" 
replace _state = 41 if state == "Oregon" 
replace _state = 42 if state == "Pennsylvania" 
replace _state = 44 if state == "Rhode Island" 
replace _state = 45 if state == "South Carolina" 
replace _state = 46 if state == "South Dakota" 
replace _state = 47 if state == "Tennessee" 
replace _state = 48 if state == "Texas" 
replace _state = 49 if state == "Utah" 
replace _state = 50 if state == "Vermont" 
replace _state = 51 if state == "Virginia" 
replace _state = 53 if state == "Washington" 
replace _state = 54 if state == "West Virginia" 
replace _state = 55 if state == "Wisconsin" 
replace _state = 56 if state == "Wyoming" 

label define _statelabel 1"Alabama" 2"Alaska" 4"Arizona" 5"Arkansas" 6"California" 8"Colorado" 9"Conneticut" 10"Delaware" 11"District of Columbia" 12"Florida" 13"Georgia" 15"Hawaii" 16"Idaho" 17" Illinois" 18"Indiana" 19"Iowa" 20"Kansas" 21"Kentucky" 22"Louisiana" 23"Maine" 24"Maryland" 25"Massachusetts" 26"Michigan" 27"Minnesota" 28"Mississippi" 29"Missouri" 30"Montana" 31"Nebraska" 32"Nevada" 33"New Hampshire" 34"New Jersey" 35"New Mexico" 36"New York" 37"North Carolina" 38"North Dakota" 39"Ohio" 40"Oklahoma" 41"Oregon" 42"Pennsylvania" 44"Rhode Island" 45"South Carolina" 46"South Dakota" 47"Tennessee" 48"Texas" 49"Utah" 50"Vermont" 51"Virginia" 53"Washington" 54"West Virginia" 55"Wisconsin" 56"Wyoming" 66"Guam" 72"Puerto Rico" 78"Virgin Islands" 
label values _state _statelabel 
drop if (_state ==66 | _state==72 | _state==78 |_state ==11| _state == 15| _state == 2)

drop _merge  state
save "PricesRates.dta", replace 

preserve
keep if year == 2016 
save "PriceRate16", replace
restore 

preserve
keep if year == 2015
save "PriceRate15", replace 
restore 

preserve
keep if year == 2014
save "PriceRate14", replace 
restore 

preserve
keep if year == 2013
save "PriceRate13", replace 
restore 

preserve
keep if year == 2012
save "PriceRate12", replace 
restore 

preserve
keep if year == 2011
save "PriceRate11", replace 
restore 

preserve
keep if year == 2010
save "PriceRate10", replace 
restore 

clear 
*==============================================================================*
use "/Users/christiancarrillo/Documents/BRFSS/edit_brfss16.dta"
mmerge _state month year using "PriceRate16", ///
type(n:1) ///
unmatched(master) ///
umatch(_state month year) 




