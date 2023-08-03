proc menu {} {
    set timeout 10
    set ramal ""
    puts "prompt here: Bem-vindo à URA! Pressione 1 para o setor A (ramal 1111), 2 para o setor B (ramal 2222), 3 para o setor C (ramal 3333), 4 para o setor D (ramal 4444) ou aguarde para falar com a telefonista (ramal 5555)."

    while {true} {
        set input [read stdin $timeout]
        if {[string length $input] > 0} {
            set ramal $input
            break
        } else {
            # Caso não seja digitado nenhum ramal em 10 segundos, encaminhar para outro hunt group
            puts "Tempo esgotado, encaminhando para o hunt group secundário."
            exec tclquit
        }
    }

    # Verificar se o ramal digitado é válido
    if {[regexp {^\d+$} $ramal]} {
        if {$ramal == "1111"} {
            puts "Encaminhando para o setor A (ramal 1111)."
            ;# Comando de encaminhamento para o setor A (hunt group 1) aqui
        } elseif {$ramal == "2222"} {
            puts "Encaminhando para o setor B (ramal 2222)."
            ;# Comando de encaminhamento para o setor B (hunt group 2) aqui
        } elseif {$ramal == "3333"} {
            puts "Encaminhando para o setor C (ramal 3333)."
            ;# Comando de encaminhamento para o setor C (hunt group 3) aqui
        } elseif {$ramal == "4444"} {
            puts "Encaminhando para o setor D (ramal 4444)."
            ;# Comando de encaminhamento para o setor D (hunt group 4) aqui
        } elseif {$ramal == "5555"} {
            puts "Encaminhando para a telefonista (ramal 5555)."
            ;# Comando de encaminhamento para a telefonista (hunt group 5) aqui
        } else {
            puts "Ramal inválido. Encaminhando para o hunt group secundário."
            exec tclquit
        }
    } else {
        puts "Ramal inválido. Encaminhando para o hunt group secundário(ramal 5555)."
        exec tclquit
    }
}

# Mapeamento do prompt de áudio:
# Substitua o nome_do_prompt.wav pelo nome do arquivo *.wav que estará na raiz da flash do Cisco IOS.
puts "play prompt nome_do_prompt.wav"

menu
