#!/usr/bin/ksh
rm ./outputs/histo-yes.dat ./outputs/histo-no.dat
#Filtragem de dados segundo o valor binário de yes ou no para o campo de si o cliente subscreveu ao investimento
 awk -F";" '$17 ~ /yes/ {printf "%s \n", $13}' ../data/bank-full.csv >./outputs/yes.dat
 awk -F";" '$17 ~ /no/ {printf "%s \n",$13}' ../data/bank-full.csv >./outputs/no.dat
#Realização do histograma para cada yes ou no em função do número de contatos
for i in {1..65..1}; do l=`grep -c "^$i "  ./outputs/yes.dat`; echo $i $l >>./outputs/histo-yes.dat; done
for i in {1..65..1}; do l=`grep -c "^$i " ./outputs/no.dat`; echo $i $l >>./outputs/histo-no.dat; done
#o hitograma anterior converstido em porcentagens relativas ao total de clientes contatados
awk '{print $1,$2/45211*100}' ./outputs/histo-yes.dat >./outputs/histo-yes-porcetangem.dat
awk '{print $1,$2/45211*100}' ./outputs/histo-no.dat >./outputs/histo-no-porcetangem.dat
# Calcula a somatoria acumulativa da porcentegem de clientes contatados em função do número de contatos.
paste ./outputs/histo-yes-porcetangem.dat ./outputs/histo-no-porcetangem.dat | awk '{print $2+$4}'  | awk '{ for (i=1; i<=NF; ++i) {sum[i]+=$i; $i=sum[i] }; print $0}' >./outputs/columna-somatoria-acumulativa.data
paste ./outputs/histo-yes-porcetangem.dat ./outputs/columna-somatoria-acumulativa.data | awk '{print $1,$3}' >./outputs/somatoria-acumulativa.dat
rm  ./outputs/columna-somatoria-acumulativa.data
# usar os dados dos histogramas para conocer el total de contatos feitos para um grupo de clientes dentro do conjunto de un valor de número de contatos. Por exemplo,  o total de contatos feitos aos clientes com número de contatos igual a três é 16563. Este valor se obtém fazendo a seguint conta: o número de clientes qcom número de contato três (5521) VEZES o número de contato (3)
echo "#\"número de contatos\" \"total de contatos realizados\"" >./outputs/medicao-esforco.dat
paste ./outputs/histo-yes.dat ./outputs/histo-no.dat | awk '{print $1,($2+$4)*$1}' >> ./outputs/medicao-esforco.dat
sum=`awk 'NR>1{sum += $2}END{print sum}' ./outputs/medicao-esforco.dat`
awk -v a=$sum 'NR>1{print $1,$2/a*100}' ./outputs/medicao-esforco.dat > ./outputs/medicao-esforco-porcentagem.dat
# Calcula a somatoria acumulativa do total de contatos feitos.
awk '{print $2}' ./outputs/medicao-esforco-porcentagem.dat | awk '{ for (i=1; i<=NF; ++i) {sum[i]+=$i; $i=sum[i] }; print $0}' >./outputs/columna-somatoria-acumulativa.data
paste ./outputs/histo-yes-porcetangem.dat ./outputs/columna-somatoria-acumulativa.data | awk '{print $1,$3}' >./outputs/somatoria-acumulativa-medicao-esforco-porcentagem.dat
rm  ./outputs/columna-somatoria-acumulativa.data

