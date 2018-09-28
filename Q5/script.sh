# Número de !/bin/bash
# Número de Clientes com crédito em default e que apresentam um balance negativo
awk -F";" '$5 ~ "yes" && $6 < 0 ' ../data/bank-full.csv | wc -l > ./outputs/balance-negative.dat
# Número de Clientes com crédito em default e que apresentam um balance neutro
awk -F";" '$5 ~ "yes" && $6 == 0 ' ../data/bank-full.csv | wc -l > ./outputs/balance-zero.dat
# Número de Clientes com crédito em default e que apresentam um balance positivo
awk -F";" '$5 ~ "yes" && $6 > 0 ' ../data/bank-full.csv | wc -l > ./outputs/balance-positive.dat
# Número de Clientes com crédito em default e possuem empréstimo imobiliário
awk -F";" '$5 ~ "yes" && $7 ~ "yes" && $8 ~ "no"' ../data/bank-full.csv | wc -l > ./outputs/having-housing-loan.dat
# Número de Clientes com crédito em default e possuem empréstimo personal
awk -F";" '$5 ~ "yes" && $7 ~ "no" && $8 ~ "yes"' ../data/bank-full.csv | wc -l > ./outputs/having-personal-loan.dat
# Número de Clientes com crédito em default e possuem algun empréstimo pessoal ou imobiliário   
awk -F";" '$5 ~ "yes" && ($7 ~ "yes" || $8 ~ "yes")' ../data/bank-full.csv | wc -l > ./outputs/having-a-loan.dat
# Número de Clientes com crédito em default e possuem nenhum empréstimo pessoal ou imobiliário
awk -F";" '$5 ~ "yes" && $7 ~ "no" && $8 ~ "no"' ../data/bank-full.csv | wc -l > ./outputs/having-none-loan.dat
# Número de Clientes com crédito em default e possuem os dois empréstimos, imobiliário e pessoal
awk -F";" '$5 ~ "yes" && $7 ~ "yes" && $8 ~ "yes"' ../data/bank-full.csv | wc -l > ./outputs/having-a-housing-and-personal-loans.dat
# Número de Clientes com crédito em default e possuem algun empréstimo e seu balance é negativo
awk -F";" '$5 ~ "yes" && $6< 0 && ($7 ~ "yes" || $8 ~ "yes")' ../data/bank-full.csv | wc -l > ./outputs/having-a-loan-and-balance-negative.dat
echo ";balance;empréstimo" > ./outputs/tabela3.csv
echo "negativo;zero;postitivo;imobiliário;pessoal;algum empréstimo;não tendo empréstimo imobiliário ou pessoal;dois empréstimos: imobiliário e pessoal;algum empréstimo e balance negativo" >> ./outputs/tabela3.csv
echo "$(cat ./outputs/balance-negative.dat); $(cat ./outputs/balance-zero.dat); $(cat ./outputs/balance-positive.dat); $(cat ./outputs/having-housing-loan.dat); $(cat ./outputs/having-personal-loan.dat); $(cat ./outputs/having-a-loan.dat); $(cat ./outputs/having-none-loan.dat); $(cat ./outputs/having-a-housing-and-personal-loans.dat); $(cat ./outputs/having-a-loan-and-balance-negative.dat)" >> ./outputs/tabela3.csv
