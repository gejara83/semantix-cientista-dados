#!/usr/bin/ksh
rm ./outputs/histo-yes.dat ./outputs/histo-no.dat
#Filtragem de dados segundo o valor binário de yes ou no para o campo de si o cliente subscreveu ao investimento
 awk -F";" '$17 ~ /yes/ {printf "%s \n", $13}' ../data/bank-full.csv >./outputs/yes.dat
 awk -F";" '$17 ~ /no/ {printf "%s \n", $13}' ../data/bank-full.csv >./outputs/no.dat
#Realização do histograma  que representa o número de clientes contatados que dizeram yes ou no em função do número de contatos realizados
for i in {1..65..1}; do l=`grep -c "^$i "  ./outputs/yes.dat`; echo $i $l >>./outputs/histo-yes.dat; done
for i in {1..65..1}; do l=`grep -c "^$i "  ./outputs/no.dat`; echo $i $l >>./outputs/histo-no.dat; done
