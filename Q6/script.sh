#!/usr/bin/ksh
#Filtrando os lcientes que possuem um empréstimo imobiliário
awk -F";" '$7 ~ "yes"' ../data/bank-full.csv > ./outputs/clients-with-housing-loan.dat
#Quantificando clientes com um empréstimo imobiliário e com caraterísticas pessoais como tipo de emprego, eduação e estado civil
#Os arquivos job.dat education.dat e marital.dat contêm os valores que as variáveis job education e marital podem assumir.
for j in  job education marital;
do
#Escreve em um arquivo a quantidade de clientes com empréstimo imobiliário para cada variável em job, education e marital.
for i in $(cat $j.dat); do grep -c "$i" ./outputs/clients-with-housing-loan.dat > ./outputs/$j-$i.dat; done
done
#print outputs para construir a tabela 4
cd outputs
echo "\#counting job"
awk ' { print FILENAME,$0 } ' job-*
echo "\#counting marital"
awk ' { print FILENAME,$0 } ' marital-*
echo "\#counting education"
awk ' { print FILENAME,$0 } ' education-*
cd ..
#Analisando por idade
awk -F";" 'NR>1{print $1}' ./outputs/clients-with-housing-loan.dat > ./outputs/age.dat
#Analisando por balance
awk -F";" 'NR>1{print $6}' ./outputs/clients-with-housing-loan.dat> ./outputs/balance.dat

