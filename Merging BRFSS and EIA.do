*==============================================================================*
* Tiltle: Merging DofileC.do
* Author: Christian Carrillo 
* Date Created: 5/2/2018
* date Modified: 5/2/2018
*         Merging BRFSS w/ gasoline prices & creating Masters Data
*==============================================================================*
clear 
cap log close 
set more off 

global logdir "/Users/christiancarrillo/Documents/Thesis(2)"
global datadir "/Users/christiancarrillo/Documents/Thesis(2)"
global resdir "/Users/christiancarrillo/Documents/Thesis(2)"
*==============================================================================*
* Cleaning for 2016 & merging with Price and Tax rate 2016
*==============================================================================*
cd "/Users/christiancarrillo/Documents/BRFSS"
use "/Users/christiancarrillo/Documents/BRFSS/BRFSS_2016.dta"

global ylist _state fmonth idate imonth iday iyear dispcode seqno _psu stateres genhlth ///
physhlth poorhlth hlthpln1 medcost asthma3 asthnow asthmage asattack aservist ///
asdrvist asrchkup asactlim asymptom asthmed3 casthno2 casthdx2 _ltasth1 _casthm1 ///
_asthms1 sex marital educa _educag renthom1 veteran3 employ1 children _chldcnt ///
 income2 _incomg weight2 height3 mscode smoke100 lastsmk2 usenow3 alcday5 avedrnk2 ///
drnk3ge5 maxdrnks crgvpers qstver _strwt _llcpwt _cprace _casthm1 _asthms1 _prace1 ///
_mrace1 _hispanc _race _ageg5yr _age65yr _age80 _age_g _bmi5 _incomg _smoker3 ///
_rfsmok3 htin4 htm4 wtkg3 _drnkwek _race_g1 _racegr3 exerany2 smokday2 asnoslep asinhalr 
keep $ylist 

destring imonth, gen(month) 
destring iyear, gen(year) 
destring seqno, replace 

drop if year == 2017


label define _statelabel 1"Alabama" 2"Alaska" 4"Arizona" 5"Arkansas" 6"California" ///
 8"Colorado" 9"Conneticut" 10"Delaware" 11"District of Columbia" 12"Florida" 13"Georgia" ///
 15"Hawaii" 16"Idaho" 17" Illinois" 18"Indiana" 19"Iowa" 20"Kansas" 21"Kentucky" 22"Louisiana" ///
 23"Maine" 24"Maryland" 25"Massachusetts" 26"Michigan" 27"Minnesota" 28"Mississippi" 29"Missouri" ///
 30"Montana" 31"Nebraska" 32"Nevada" 33"New Hampshire" 34"New Jersey" 35"New Mexico" 36"New York" ///
 37"North Carolina" 38"North Dakota" 39"Ohio" 40"Oklahoma" 41"Oregon" 42"Pennsylvania" 44"Rhode Island" ///
 45"South Carolina" 46"South Dakota" 47"Tennessee" 48"Texas" 49"Utah" 50"Vermont" 51"Virginia" 53"Washington" ///
 54"West Virginia" 55"Wisconsin" 56"Wyoming" 66"Guam" 72"Puerto Rico" 78"Virgin Islands" 
label values _state _statelabel 
drop if (_state ==66 | _state==72 | _state==78 |_state ==11| _state == 15| _state == 2)

cd "/Users/christiancarrillo/Documents/Thesis(2)"
save "edit_brfss16.dta", replace  


mmerge _state month year using "PriceRate16", ///
type(n:1) ///
unmatched(master) ///
umatch(_state month year) 

save "2016_BRFSScomplete.dta", replace 
*==============================================================================*
* Cleaning for 2015 & merging with Price and Tax rate 2015
*==============================================================================*
cd "/Users/christiancarrillo/Documents/BRFSS"
use "/Users/christiancarrillo/Documents/BRFSS/BRFSS_2015.dta"

global ylist _state fmonth idate imonth iday iyear dispcode seqno _psu stateres genhlth ///
physhlth poorhlth hlthpln1 medcost asthma3 asthnow asthmage asattack aservist ///
asdrvist asrchkup asactlim asymptom asthmed3 casthno2 casthdx2 _ltasth1 _casthm1 ///
_asthms1 sex marital educa _educag renthom1 veteran3 employ1 children _chldcnt ///
 income2 _incomg weight2 height3 mscode smoke100 lastsmk2 usenow3 alcday5 avedrnk2 ///
drnk3ge5 maxdrnks crgvpers qstver _strwt _llcpwt _cprace _casthm1 _asthms1 _prace1 ///
_mrace1 _hispanc _race _ageg5yr _age65yr _age80 _age_g _bmi5 _incomg _smoker3 ///
_rfsmok3 htin4 htm4 wtkg3 _drnkwek _race_g1 _racegr3 exerany2 smokday2 asnoslep asinhalr 
keep $ylist 

destring imonth, gen(month) 
destring iyear, gen(year) 

drop if year == 2016 


label define _statelabel 1"Alabama" 2"Alaska" 4"Arizona" 5"Arkansas" 6"California" ///
 8"Colorado" 9"Conneticut" 10"Delaware" 11"District of Columbia" 12"Florida" 13"Georgia" ///
 15"Hawaii" 16"Idaho" 17" Illinois" 18"Indiana" 19"Iowa" 20"Kansas" 21"Kentucky" 22"Louisiana" ///
 23"Maine" 24"Maryland" 25"Massachusetts" 26"Michigan" 27"Minnesota" 28"Mississippi" 29"Missouri" ///
 30"Montana" 31"Nebraska" 32"Nevada" 33"New Hampshire" 34"New Jersey" 35"New Mexico" 36"New York" ///
 37"North Carolina" 38"North Dakota" 39"Ohio" 40"Oklahoma" 41"Oregon" 42"Pennsylvania" 44"Rhode Island" ///
 45"South Carolina" 46"South Dakota" 47"Tennessee" 48"Texas" 49"Utah" 50"Vermont" 51"Virginia" 53"Washington" ///
 54"West Virginia" 55"Wisconsin" 56"Wyoming" 66"Guam" 72"Puerto Rico" 78"Virgin Islands" 
label values _state _statelabel 
drop if (_state ==66 | _state==72 | _state==78 |_state ==11| _state == 15| _state == 2)

cd "/Users/christiancarrillo/Documents/Thesis(2)"
save "edit_brfss15.dta", replace  

mmerge _state month year using "PriceRate15", ///
type(n:1) ///
unmatched(master) ///
umatch(_state month year) 

save "2015_BRFSScomplete.dta", replace 

*==============================================================================*
* Cleaning 2014 & merging with gasoline price and tax rates
*==============================================================================*
clear  

cd "/Users/christiancarrillo/Documents/BRFSS"
use "/Users/christiancarrillo/Documents/BRFSS/BRFSS_2014.dta"

global ylist _state fmonth idate imonth iday iyear dispcode seqno _psu stateres genhlth ///
physhlth poorhlth hlthpln1 medcost asthma3 asthnow asthmage asattack aservist ///
asdrvist asrchkup asactlim asymptom asthmed3 casthno2 casthdx2 _ltasth1 _casthm1 ///
_asthms1 sex marital educa _educag renthom1 veteran3 employ1 children _chldcnt ///
 income2 _incomg weight2 height3 mscode smoke100 lastsmk2 usenow3 alcday5 avedrnk2 ///
drnk3ge5 maxdrnks qstver _strwt _llcpwt _cprace _casthm1 _asthms1 _prace1 ///
_mrace1 _hispanc _race _ageg5yr _age65yr _age80 _age_g _bmi5 _incomg _smoker3 ///
_rfsmok3 htin4 htm4 wtkg3 _race_g1 _racegr3 exerany2 smokday2 asnoslep asinhalr 

keep $ylist 

destring imonth, gen(month) 
destring iyear, gen(year) 

drop if year == 2015 


label define _statelabel 1"Alabama" 2"Alaska" 4"Arizona" 5"Arkansas" 6"California" ///
 8"Colorado" 9"Conneticut" 10"Delaware" 11"District of Columbia" 12"Florida" 13"Georgia" ///
 15"Hawaii" 16"Idaho" 17" Illinois" 18"Indiana" 19"Iowa" 20"Kansas" 21"Kentucky" 22"Louisiana" ///
 23"Maine" 24"Maryland" 25"Massachusetts" 26"Michigan" 27"Minnesota" 28"Mississippi" 29"Missouri" ///
 30"Montana" 31"Nebraska" 32"Nevada" 33"New Hampshire" 34"New Jersey" 35"New Mexico" 36"New York" ///
 37"North Carolina" 38"North Dakota" 39"Ohio" 40"Oklahoma" 41"Oregon" 42"Pennsylvania" 44"Rhode Island" ///
 45"South Carolina" 46"South Dakota" 47"Tennessee" 48"Texas" 49"Utah" 50"Vermont" 51"Virginia" 53"Washington" ///
 54"West Virginia" 55"Wisconsin" 56"Wyoming" 66"Guam" 72"Puerto Rico" 78"Virgin Islands" 
label values _state _statelabel 
drop if (_state ==66 | _state==72 | _state==78 |_state ==11| _state == 15| _state == 2)

cd "/Users/christiancarrillo/Documents/Thesis(2)"
save "edit_brfss14.dta", replace  


mmerge _state month year using "PriceRate14", ///
type(n:1) ///
unmatched(master) ///
umatch(_state month year) 

save "2014_BRFSScomplete.dta", replace 

*==============================================================================*
* Cleaning 2013 & merging with gasoline price and tax rates
*==============================================================================*
clear  

cd "/Users/christiancarrillo/Documents/BRFSS"
use "/Users/christiancarrillo/Documents/BRFSS/BRFSS_2013.dta"

global ylist _state fmonth idate imonth iday iyear dispcode seqno _psu stateres genhlth ///
physhlth poorhlth hlthpln1 medcost asthma3 asthnow asthmage asattack aservist ///
asdrvist asrchkup asactlim asymptom asthmed3 casthno2 casthdx2 _ltasth1 _casthm1 ///
_asthms1 sex marital educa _educag renthom1 veteran3 employ1 children _chldcnt ///
 income2 _incomg weight2 height3 mscode smoke100 lastsmk2 usenow3 alcday5 avedrnk2 ///
drnk3ge5 maxdrnks qstver _strwt _llcpwt _casthm1 _asthms1 _prace1 ///
_mrace1 _hispanc _race _ageg5yr _age65yr _age80 _age_g _bmi5 _incomg _smoker3 ///
_rfsmok3 htin4 htm4 wtkg3 _race_g1 _racegr3 exerany2 smokday2 asnoslep asinhalr

keep $ylist 

destring imonth, gen(month) 
destring iyear, gen(year) 
tab year
drop if year == 2014 


label define _statelabel 1"Alabama" 2"Alaska" 4"Arizona" 5"Arkansas" 6"California" ///
 8"Colorado" 9"Conneticut" 10"Delaware" 11"District of Columbia" 12"Florida" 13"Georgia" ///
 15"Hawaii" 16"Idaho" 17" Illinois" 18"Indiana" 19"Iowa" 20"Kansas" 21"Kentucky" 22"Louisiana" ///
 23"Maine" 24"Maryland" 25"Massachusetts" 26"Michigan" 27"Minnesota" 28"Mississippi" 29"Missouri" ///
 30"Montana" 31"Nebraska" 32"Nevada" 33"New Hampshire" 34"New Jersey" 35"New Mexico" 36"New York" ///
 37"North Carolina" 38"North Dakota" 39"Ohio" 40"Oklahoma" 41"Oregon" 42"Pennsylvania" 44"Rhode Island" ///
 45"South Carolina" 46"South Dakota" 47"Tennessee" 48"Texas" 49"Utah" 50"Vermont" 51"Virginia" 53"Washington" ///
 54"West Virginia" 55"Wisconsin" 56"Wyoming" 66"Guam" 72"Puerto Rico" 78"Virgin Islands" 
label values _state _statelabel 
drop if (_state ==66 | _state==72 | _state==78 |_state ==11| _state == 15| _state == 2)

cd "/Users/christiancarrillo/Documents/Thesis(2)"
save "edit_brfss13.dta", replace  


mmerge _state month year using "PriceRate13", ///
type(n:1) ///
unmatched(master) ///
umatch(_state month year) 
* Note: All matched 

save "2013_BRFSScomplete.dta", replace 

*==============================================================================*
* Cleaning 2012 & merging with gasoline price and tax rates
*==============================================================================*
clear  

cd "/Users/christiancarrillo/Documents/BRFSS"
use "/Users/christiancarrillo/Documents/BRFSS/BRFSS_2012.dta"

rename employ employ1 
rename hispanc2 _hispanc
rename _race_g _race_g1
rename _racegr2 _racegr3
rename _mrace _mrace1

global ylist _state fmonth idate imonth iday iyear dispcode seqno _psu  genhlth ///
physhlth poorhlth hlthpln1 medcost asthma3 asthnow asthmage asattack aservist ///
asdrvist asrchkup asactlim asymptom asthmed3 casthno2 casthdx2 _ltasth1 _casthm1 ///
_asthms1 sex marital educa _educag renthom1 veteran3 employ1 children _chldcnt ///
 income2 _incomg weight2 height3 mscode smoke100 lastsmk2 usenow3 alcday5 avedrnk2 ///
drnk3ge5 maxdrnks qstver _strwt _llcpwt _casthm1 _asthms1  ///
 _ageg5yr _age65yr _age_g _bmi5 _incomg _smoker3 ///
_rfsmok3 htin4 htm4 wtkg3 _hispanc _race_g1 _racegr3 _mrace1 exerany2 smokday2 asnoslep asinhalr

keep $ylist 

destring imonth, gen(month) 
destring iyear, gen(year) 
tab year
drop if year == 2013 


label define _statelabel 1"Alabama" 2"Alaska" 4"Arizona" 5"Arkansas" 6"California" ///
 8"Colorado" 9"Conneticut" 10"Delaware" 11"District of Columbia" 12"Florida" 13"Georgia" ///
 15"Hawaii" 16"Idaho" 17" Illinois" 18"Indiana" 19"Iowa" 20"Kansas" 21"Kentucky" 22"Louisiana" ///
 23"Maine" 24"Maryland" 25"Massachusetts" 26"Michigan" 27"Minnesota" 28"Mississippi" 29"Missouri" ///
 30"Montana" 31"Nebraska" 32"Nevada" 33"New Hampshire" 34"New Jersey" 35"New Mexico" 36"New York" ///
 37"North Carolina" 38"North Dakota" 39"Ohio" 40"Oklahoma" 41"Oregon" 42"Pennsylvania" 44"Rhode Island" ///
 45"South Carolina" 46"South Dakota" 47"Tennessee" 48"Texas" 49"Utah" 50"Vermont" 51"Virginia" 53"Washington" ///
 54"West Virginia" 55"Wisconsin" 56"Wyoming" 66"Guam" 72"Puerto Rico" 78"Virgin Islands" 
label values _state _statelabel 
drop if (_state ==66 | _state==72 | _state==78 |_state ==11| _state == 15| _state == 2)

cd "/Users/christiancarrillo/Documents/Thesis(2)"
save "edit_brfss12.dta", replace  


mmerge _state month year using "PriceRate12", /// 
type(n:1) ///
unmatched(master) ///
umatch(_state month year) 
* Note: not _prace _mrace _race _age80 Added: hispanc3

save "2012_BRFSScomplete.dta", replace 


*==============================================================================*
* Cleaning 2011 & merging with gasoline price and tax rates
*==============================================================================*
clear  

cd "/Users/christiancarrillo/Documents/BRFSS"
use "/Users/christiancarrillo/Documents/BRFSS/BRFSS_2011.dta"

rename employ employ1 
rename hispanc2 _hispanc
rename _race_g _race_g1
rename _racegr2 _racegr3
rename _mrace _mrace1

global ylist _state fmonth idate imonth iday iyear dispcode seqno _psu  genhlth ///
physhlth poorhlth hlthpln1 medcost asthma3 asthnow asthmage asattack aservist ///
asdrvist asrchkup asactlim asymptom asthmed3 casthno2 casthdx2 _ltasth1 _casthm1 ///
_asthms1 sex marital educa _educag renthom1 veteran3 employ1 children _chldcnt ///
 income2 _incomg weight2 height3 mscode smoke100 lastsmk2 usenow3 alcday5 avedrnk2 ///
drnk3ge5 maxdrnks qstver _strwt _llcpwt _casthm1 _asthms1  ///
 _ageg5yr _age65yr _age_g _bmi5 _incomg _smoker3 ///
_rfsmok3 htin4 htm4 wtkg3 _hispanc _race_g1 _racegr3 _mrace1 exerany2 smokday2 asnoslep asinhalr

keep $ylist 

destring imonth, gen(month) 
destring iyear, gen(year) 
tab year
drop if year == 2012 


label define _statelabel 1"Alabama" 2"Alaska" 4"Arizona" 5"Arkansas" 6"California" ///
 8"Colorado" 9"Conneticut" 10"Delaware" 11"District of Columbia" 12"Florida" 13"Georgia" ///
 15"Hawaii" 16"Idaho" 17" Illinois" 18"Indiana" 19"Iowa" 20"Kansas" 21"Kentucky" 22"Louisiana" ///
 23"Maine" 24"Maryland" 25"Massachusetts" 26"Michigan" 27"Minnesota" 28"Mississippi" 29"Missouri" ///
 30"Montana" 31"Nebraska" 32"Nevada" 33"New Hampshire" 34"New Jersey" 35"New Mexico" 36"New York" ///
 37"North Carolina" 38"North Dakota" 39"Ohio" 40"Oklahoma" 41"Oregon" 42"Pennsylvania" 44"Rhode Island" ///
 45"South Carolina" 46"South Dakota" 47"Tennessee" 48"Texas" 49"Utah" 50"Vermont" 51"Virginia" 53"Washington" ///
 54"West Virginia" 55"Wisconsin" 56"Wyoming" 66"Guam" 72"Puerto Rico" 78"Virgin Islands" 
label values _state _statelabel 
drop if (_state ==66 | _state==72 | _state==78 |_state ==11| _state == 15| _state == 2)

cd "/Users/christiancarrillo/Documents/Thesis(2)"
save "edit_brfss11.dta", replace  


mmerge _state month year using "PriceRate11", ///
type(n:1) ///
unmatched(master) ///
umatch(_state month year) 
* Note: not _prace _mrace _race _age80 Added: hispanc3 (w/r to 2016) 

save "2011_BRFSScomplete.dta", replace 
*Note: Similar as 2012 

*==============================================================================*
* Cleaning 2010 & merging with gasoline price and tax rates
*==============================================================================*
clear  

cd "/Users/christiancarrillo/Documents/BRFSS"
use "/Users/christiancarrillo/Documents/BRFSS/BRFSS_2010.dta"

rename employ employ1 
rename hispanc2 _hispanc
rename _race_g _race_g1
rename _racegr2 _racegr3
rename hlthplan hlthpln1
rename asthma2 asthma3
rename _ltasthm _ltasth1
rename _casthma  _casthm1
rename _asthmst _asthms1
rename veteran2 veteran3
rename lastsmk1 lastsmk2
rename alcday4 alcday5
rename _finalwt _llcpwt
rename _bmi4 _bmi5
rename htin3 htin4
rename htm3 htm4
rename wtkg2 wtkg3 
rename _mrace _mrace1

global ylist _state fmonth idate imonth iday iyear dispcode seqno _psu  genhlth ///
physhlth poorhlth hlthpln1 medcost asthma3 asthnow asthmage asattack aservist ///
asdrvist asrchkup asactlim asymptom asthmed3 casthno2 casthdx2 _ltasth1 _casthm1 ///
_asthms1 sex marital educa _educag renthom1 veteran3 employ1 children _chldcnt ///
 income2 _incomg weight2 height3 mscode smoke100 lastsmk2 usenow3 alcday5 avedrnk2 ///
drnk3ge5 maxdrnks qstver _strwt _llcpwt _casthm1 _asthms1  ///
 _ageg5yr _age65yr _age_g _bmi5 _incomg _smoker3 ///
_rfsmok3 htin4 htm4 wtkg3 _hispanc _race_g1 _racegr3 _mrace1 exerany2 smokday2 asnoslep asinhalr

keep $ylist 

destring imonth, gen(month) 
destring iyear, gen(year) 
tab year
drop if year == 2011 


label define _statelabel 1"Alabama" 2"Alaska" 4"Arizona" 5"Arkansas" 6"California" ///
 8"Colorado" 9"Conneticut" 10"Delaware" 11"District of Columbia" 12"Florida" 13"Georgia" ///
 15"Hawaii" 16"Idaho" 17" Illinois" 18"Indiana" 19"Iowa" 20"Kansas" 21"Kentucky" 22"Louisiana" ///
 23"Maine" 24"Maryland" 25"Massachusetts" 26"Michigan" 27"Minnesota" 28"Mississippi" 29"Missouri" ///
 30"Montana" 31"Nebraska" 32"Nevada" 33"New Hampshire" 34"New Jersey" 35"New Mexico" 36"New York" ///
 37"North Carolina" 38"North Dakota" 39"Ohio" 40"Oklahoma" 41"Oregon" 42"Pennsylvania" 44"Rhode Island" ///
 45"South Carolina" 46"South Dakota" 47"Tennessee" 48"Texas" 49"Utah" 50"Vermont" 51"Virginia" 53"Washington" ///
 54"West Virginia" 55"Wisconsin" 56"Wyoming" 66"Guam" 72"Puerto Rico" 78"Virgin Islands" 
label values _state _statelabel 
drop if (_state ==66 | _state==72 | _state==78 |_state ==11| _state == 15| _state == 2)

cd "/Users/christiancarrillo/Documents/Thesis(2)"
save "edit_brfss10.dta", replace  


mmerge _state month year using "PriceRate10", ///
type(n:1) ///
unmatched(master) ///
umatch(_state month year) 
* Note: not _prace _mrace _race _age80 Added: hispanc3 (w/r to 2016) 

save "2010_BRFSScomplete.dta", replace 
*Note: Similar as 2012 


*==============================================================================*
*                 Appending datasets and creating masters data 
*==============================================================================*
cd "/Users/christiancarrillo/Documents/Thesis(2)" 
use "/Users/christiancarrillo/Documents/Thesis(2)/2016_BRFSScomplete.dta"


append using "2015_BRFSScomplete.dta"
append using "2014_BRFSScomplete.dta"
append using "2013_BRFSScomplete.dta"
append using "2012_BRFSScomplete.dta"
append using "2011_BRFSScomplete.dta"
append using "2010_BRFSScomplete.dta"

save "BRFSS_Complete.dta", replace

erase PriceRate16.dta
erase PriceRate15.dta
erase PriceRate14.dta
erase PriceRate13.dta
erase PriceRate12.dta
erase PriceRate11.dta
erase PriceRate10.dta

erase edit_brfss16.dta
erase edit_brfss15.dta
erase edit_brfss14.dta
erase edit_brfss13.dta
erase edit_brfss12.dta
erase edit_brfss11.dta
erase edit_brfss10.dta

erase 2016_BRFSScomplete.dta
erase 2015_BRFSScomplete.dta
erase 2014_BRFSScomplete.dta
erase 2013_BRFSScomplete.dta
erase 2012_BRFSScomplete.dta
erase 2011_BRFSScomplete.dta
erase 2010_BRFSScomplete.dta

cap log close 
