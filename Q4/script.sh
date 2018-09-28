#!/bin/bash
#Separação dos cliente que foram previamente contatados
grep -v ";-1;" ../data/bank-full.csv >./outputs/clients-were-contacted-prev-campaign.dat
#separaração dos campos de sucesso na campanha prévia e dos resultados desta campanha.
 awk -F";" 'NR>1{print $16,$17}' ./outputs/clients-were-contacted-prev-campaign.dat  > ./outputs/previous-campaign-vs-this-campaign.dat
#contagem da diferentes possibilidades. Por exemplo: a) quantidade de clientes que com SUCESS na campanha prévia mas que dizeram NO nesta campanha. b)  Quantidade de clientes que com SUCCESS  na campanha prévia mas que dizeram SIM nesta campanha. Assim cruzando as alternativas de success failure unkown e other da campnha prévia com as possibilidades de YES or NO da presente campanha. Estes dados se usaram para construir a Tabela 2.
for i in success failure unknown other ; do grep -c "$i...no" ./outputs/previous-campaign-vs-this-campaign.dat > ./outputs/previous-$i-this-no.dat;  grep -c "$i...yes" ./outputs/previous-campaign-vs-this-campaign.dat > ./outputs/previous-$i-this-yes.dat; done
#impressão dos valores apra gerar a tabela 2
echo " ;Previous campaign">./outputs/tabela-2.csv
echo "this campaign;success;failure;unknown;other">>./outputs/tabela-2.csv
for i in yes no; do echo "$i;$(cat ./outputs/previous-success-this-$i.dat);$(cat ./outputs/previous-failure-this-$i.dat);$(cat ./outputs/previous-unknown-this-$i.dat);$(cat ./outputs/previous-other-this-$i.dat)" >>./outputs/tabela-2.csv ; done

