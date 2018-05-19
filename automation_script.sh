#!/bin/sh
#
#Escolha de código.
echo "Digite (1) para adicionar um novo usuário;
Digite (2) para alterar a senha do usuário;
Digite (3) para adicionar um grupo;
Digite (4) para adicionar um usuário à um grupo;
Digite (5) para remover um usuário;
Digite (6) para remover um grupo;
Digite (7) para executar a relação de usuários; \n"
read chose
#
case $chose in
        1)#Adicionar usuário
                echo -n "Digite o nome do usuário: \n"
                read username
                getent passwd $username >> /dev/null
                if [ $? -eq 0 ] ; then
                        echo -n "Usuário já existente, encerrando script\n"
                else
                        useradd -d /home/$username -m $username
                fi
                echo "digite uma senha: \n"
                read password
                usermod $username -p $password
                echo "Usuário criado com sucesso"
                ;;
        2)#Alterar senha
                echo "Escolha um usuário: \n"
                read username
                getent passwd $username >> /dev/null
                if [ $? -eq 0 ] ; then
                        echo -n "Digite uma nova senha senha: \n"
                        read password
                        usermod -p $password $username
                        echo "Senha alterada com sucesso"
                else
                        echo "Usuário inexistente, encerrando script\n"
                fi
                ;;
        3)#Adicionar a um grupo
                echo "Digite o nome do grupo"
                read groupname
                getent group $groupname >> /dev/null
                if [ $? -eq 0 ] ; then
                        echo "Grupo existente, encerrando script"
                else
                        echo "Criando grupo: \n"
                        groupadd $groupname
                        sleep 1
                        echo "Grupo adicionado com sucesso"
                fi
                ;;
        4)#Adicionando usuário a um grupo
                echo "Digite o nome do usuário: \n"
                read username
                getent passwd $username >> /dev/null
                if [ $? -eq 0 ] ; then
                        echo -n "Digite um grupo: \n"
                        read groupname
                        getent group $groupname >> /dev/null
                        if [ $? -eq 0 ] ; then
                                echo "Grupo existente\n"
                                sleep 2
                                echo "Adicionando usuário ao grupo"
                                        usermod -G $groupname $username
                                        sleep 2
                                echo "Usuário adicionado ao grupo com sucesso"
                        else
                                echo "Grupo não existente, encerrando script"
                        fi
                else
                        echo "Usuário não existe, encerrando script"
                fi
                ;;
        5)#Remoção de usuário
                echo "Digite o nome do usuário: \n"
                read username
                getent passwd $username >> /dev/null
                if [ $? -eq 0 ] ; then
                        echo "Removendo usuário"
                        deluser $username
                        sleep 2
                        echo "Usuario removido com sucesso"
                else
                        echo "Usuario inexistente, encerrando script\n"
                fi
                ;;
        6)#Remoção de grupo
                echo "Digite o nome do grupo: \n"
                read groupname
                getent group $groupname >> /dev/null
                if [ $? -eq 0] ; then
                        echo "Removendo grupo"
                        groupdel $groupname
                        echo "Grupo removido com sucesso"
                else
                        echo "Grupo inexistente, encerrando script"
                fi
                ;;
        7)#Executar relação de usuários
                echo "Listando usuários"
                cat /etc/group
                ;;
esac
exit






