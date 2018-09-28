#!/bin/bash
# Genera o encabeçamento da Tabela em formato CSV
echo  "Profissão;Total de empréstimos;Total  de empréstimos de vivienda;Total de empréstimos pessoais;Somente empréstimos de vivenda;Somente empréstimos pessoais">./outputs/output-profession-with-loans.csv
# Perform a filtragem dos dados para clientes que tem empréstimo de viviênda
awk -F";" '$7 ~ "yes" {print $2,$7,$8}' ../data/bank-full.csv>./outputs/housing-loan-vs-profession.dat
# Perform a filtragem dos dados para clientes que tem empréstimo pessoal
awk -F";" '$8 ~ "yes" {print $2,$7,$8}' ../data/bank-full.csv>./outputs/personal-loan-vs-profession.dat
# Perform a filtragem dos dados para clientes que tem empréstimo de viviênda OU empréstimo pessoal
awk -F";" '($7 ~ "yes") || ($8 ~ "yes") {print $2,$7,$8}' ../data/bank-full.csv>./outputs/housing-or-personal-loans-vs-profession.dat
# Perform a filtragem dos dados para clientes que tem SOMENTE empréstimo de viviênda
awk -F";" '($7 ~ "yes") && ($8 ~ "no") {print $2,$7,$8}' ../data/bank-full.csv>./outputs/only-housing-loan-vs-profession.dat
# Perform a filtragem dos dados para clientes que tem SOMENTE empréstimo de pessoal
awk -F";" '($7 ~ "no") && ($8 ~ "yes") {print $2,$7,$8}' ../data/bank-full.csv>./outputs/only-personal-loan-vs-profession.dat
for i in $(cat professions.dat | xargs) 
do
# contagem pro profissão sobre a filtragem feita anteriormente
n=`grep -c $i ./outputs/housing-or-personal-loans-vs-profession.dat`
l=`grep -c $i ./outputs/housing-loan-vs-profession.dat`
m=`grep -c $i ./outputs/personal-loan-vs-profession.dat`
r=`grep -c $i ./outputs/only-housing-loan-vs-profession.dat`
s=`grep -c $i ./outputs/only-personal-loan-vs-profession.dat`
# colocação da colagem na tabela em formato CSV
echo "$i;$n;$l;$m;$r;$s" >./outputs/>output-profession-with-loans.csv
done
