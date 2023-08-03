# Tcl /TK script - Cisco IOS tslsh#
 URA - IVR - AUTO ATTENDANT
 
# URA/IVR Básica em TCL para Cisco IOS

Este repositório contém um script TCL para implementar uma URA/IVR básica no Cisco IOS. A URA permite que os interlocutores escolham entre diferentes setores pressionando os números correspondentes aos ramais ou hunt group associados, ou aguarda para falar com a telefonista. O script foi desenvolvido para uso em Gateways Cisco IOS e oferece uma interface simples para interagir com os usuários.

## Funcionamento

O script oferece as seguintes opções para os interlocutores:

## Um prompt de áudio será mapeado no script no formato *.wav vide nota no "Requisitos".

1. Pressione 1 para o setor A (ramal 1111).
2. Pressione 2 para o setor B (ramal 2222).
3. Pressione 3 para o setor C (ramal 3333).
4. Pressione 4 para o setor D (ramal 4444).
5. Aguarde para falar com a telefonista (ramal 5555).

Caso nenhum número seja pressionado em 10 segundos, a chamada será encaminhada para um hunt group secundário.
Caso nenhuma ação seja selecionada o script repetirar o prompt audio (return to menu) por 3 vezes e finalizará.

## Configuração

Para usar este script em seu ambiente, siga as etapas abaixo:

1. Grave os prompts de áudio para as mensagens de boas-vindas e instruções de menu em formato WAV.
2. Salve os arquivos de áudio na raiz da flash do Cisco IOS. Substitua `nome_do_prompt.wav` pelo nome correto dos arquivos de áudio no script TCL.
3. Adicione os comandos de encaminhamento para os números de ramal/hunt group corretos no lugar dos comentários `;# Comando de encaminhamento para o setor aqui`.

## Requisitos

- Plataforma Cisco IOS compatível.
- Arquivos de áudio gravados em formato WAV para as mensagens de boas-vindas e instruções de menu.
  Audio Sample Size : 8-bit words
  8000 samples per second
  Audio Format: CCITT u-law
  Channels: 1 (Mono, not stereo)
  Bit Rate: 8-bits x 8000 = 64Kbit Audio
  
## Uso

1. Copie o script TCL para o gateway Cisco IOS.
2. Execute o script no modo TCL do IOS.

## Public Reference:
https://www.cisco.com/c/en/us/td/docs/ios-xml/ios/voice/cube/configuration/cube-book/cube-book_chapter_01000101.html
https://community.cisco.com/t5/collaboration-knowledge-base/tcl-script-for-voice-gateway/ta-p/3619417

Example:

Loading the script:
=============
R1#conf t
R1(config)#application
R1(config-app)#service application_name script_url

for example:
-----------------
R1(config)#application
R1(config-app)#service newapp tftp://x.x.x.x/voip/test/xyz.tcl

Once the configs are done you can issue the following command to check whether the script has been loaded properly or not.The status should be in the registered state.

R1#sh call app voice newapp

Mapping to the dial-peer:
==================
To invoke your Tcl IVR script to handle a call, you must associate the application configured with an inbound dial peer. To associate your script with an inbound dial peer, enter the following commands in configuration mode:

R1(config)# dial-peer voice number voip
R1(conf-dial-peer)# incoming called-number destination_number
R1(conf-dial-peer)# service application_name

In these commands:
¿number uniquely identifies the dial peer. (This number has local significance only.)
¿destination_number specifies the destination telephone number. Valid entries are any series of digits that specify the E.164 telephone number.
¿application_name is the abbreviated name that you assigned when you loaded the application


for example:
------------------
R1(config)# dial-peer voice 3 voip
R1(conf-dial-peer)# incoming called-number 125
R1(conf-dial-peer)# service newapp

