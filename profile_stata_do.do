cd "F:\Private\2022\UHasselt\Paper5\profile_regression_death" 


* Regression profile of COVID-19 deaths in Rwanda


list names if gender == "NA"
tab gender
replace gender = "1" in 1596
replace gender = "0" in 1760
replace gender = "0" in 1828
replace gender = "1" in 2018
replace gender = "0" in 2045
tab gender

tab days
list dateofdeath admissiondate if days=="NA"
tab outcome if days=="NA"
tab treat outcome if days=="NA"
codebook days
encode days,gen(days1)
replace days1=0 if days=="NA"
codebook days1
recode days1(0/14 = 1 " 0-14 Days")(15/29 = 2 "15-29 Days")(30/max = 3 "30 Days +"),gen(days2)
tab days2
tab outcome days2
tab days2 outcome
tab days2 outcome if outcome==1
di 430/1228
tab days1
codebook days1

gen comorb1 = comorb
replace comorb1 = "0" if comorb =="NA"
tab comorb1
encode comorb1,gen(comorb2)

label def co1 1" No Comorbity" 2 " One comorbity" 3 "Pregnant women" 4 "Asthma" 5 "HIV Positive" 6 "Diabetes" 7 "Two comorbities" 8 "3+ comorbidities"
label values comorb2 co1

gen type_vacc1= type_vacc
replace type_vacc1= "10" if type_vacc1=="NA"
replace type_vacc1= "2" if vacc == 1 & type_vacc == "NA"
replace type_vacc1= "2" if vacc == 1 & type_vacc == "10"

destring type_vacc1,gen(type_vacc2)

label def co2 1 "1AstraZeneca & 2 Moderna" 2 "2Pfizer & Moderna" 3"AstraZeneca, Pfizer & Moderna" 4 "Moderna" 5 "AstraZeneca" 6 "Pfizer" 7 "Johnson & Johnson" 8 "Sputnik" 9 "Sinopharm" 10 "Unknown" 11 "AstraZeneca & Pfizer"
label values type_vacc2 co2

label def co3 0 "Not vaccineted" 1 " Vaccineted"
label values vacc co3

gen treat1 = treat
replace treat1 = "-1" if treat == "NA"
replace treat1 = "-1" if treat == "8"
replace treat1 = "1" if treat == "0"
replace treat1 = "1" if treat == "2"
replace treat1 = "1" if treat == "3"
replace treat1 = "4" if treat == "5"
replace treat1 = "4" if treat == "6"
replace treat1 = "4" if treat == "7"

replace treat1 = "0" if treat1 == "-1"
replace treat1 = "2" if treat1 == "4"

label def co4 0 "No medecine" 1 "FVP/IVM/O2/ABT" 2 "MAB/Cocktail" 
destring treat1,gen(treat2)
label values treat2 co4

gen agecat1=agecat
replace agecat1 = "3" if agecat=="NA"

destring agecat1,gen(agecat2)

label def co5 0"<20 Years" 1 "20-30 Years" 2 "30-40 Years" 3 "40-50 Years" 4"50-60 Years" 5 "60-70 Years" 6 "70-80 Years" 7 "80+ Years"
label values agecat2 co5

label def co6 0 "Female" 1 "Males"
destring gender,gen(gender1)
label values gender1 co6

gen dosenumber1= dosenumber
replace dosenumber1 = 1 if dosenumber == 0 & vacc ==1 

tabout outcome gender1 agecat2 treat2 vacc type_vacc2 dosenumber1 comorb2 days2 using table1.txt,oneway c(freq col)replace

tabout gender1 agecat2 treat2 vacc type_vacc2 dosenumber1 comorb2 days2 outcome using table2.txt, c(freq col)replace

 tabout gender1 agecat2 treat2 vacc type_vacc2 dosenumber1 comorb2 days2 outcome  using table3.txt,c(row ci) f(1 1) clab(Row_% 95%_CI) svy stats(chi2) replace

xi:logistic outcome i.gender1
xi:svy:logistic outcome i.gender1 i.agecat2
xi:svy:logistic outcome i.gender1 i.agecat2 i.treat2
xi:svy:logistic outcome i.gender1 i.agecat2 i.treat2 i.vacc 
xi:svy:logistic outcome i.gender1 i.agecat2 i.treat2 i.vacc i.type_vacc2
xi:svy:logistic outcome i.gender1 i.agecat2 i.treat2 i.vacc i.type_vacc2 i.dosenumber1
xi:svy:logistic outcome i.gender1 i.agecat2 i.treat2 i.vacc i.type_vacc2 i.dosenumber1 i.comorb2
xi:svy:logistic outcome i.gender1 i.agecat2 i.treat2 i.vacc i.comorb2
xi:svy:logistic outcome i.gender1 i.agecat2 i.treat2 i.vacc i.comorb2 i.days2
