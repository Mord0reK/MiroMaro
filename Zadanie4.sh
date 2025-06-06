# Zbuduj mechanizm tworzący plik wykonywalny sh - tworzący użytkownika, zakladający w jego katalogu domowym folder Upload_user i pozwalający wszystkim innym user-om tego systemu odczyt danych z tego folderu.

if [ $? -ne 0 ]; then
    echo "Podaj poświadczenia do podniesienia uprawnień do root by utworzyć użytkownika."
    sudo -v
    echo ""
else
    echo "Skrypt uruchomiony z uprawnieniami root."
    echo ""
fi

echo "Podaj nazwę użytkownika do utworzenia:"
read user

echo "Wprowadź hasło dla użytkownika $user:"
sudo adduser $user --gecos "" --quiet

sudo mkdir -p /home/$user/Upload_user
sudo chmod 755 /home/$user/Upload_user
sudo chown $user:$user /home/$user/Upload_user

echo ""
echo "Utworzono katalog /home/$user/Upload_user z uprawnieniami do odczytu dla wszystkich użytkowników."
echo "Skrypt zakończył działanie."