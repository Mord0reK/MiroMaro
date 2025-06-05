echo "Podaj nazwę pierwszego użytkownika do utworzenia:"
read user1 
echo ""
echo "Podaj nazwę drugiego użytkownika do utworzenia:"
read user2

sudo -n true 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Podaj poświadczenia do utworzenia użytkowników (hasło do podniesienia uprawnień do root):"
    sudo -v
    echo ""
    else
        echo "Masz już uprawnienia do tworzenia użytkowników. Poświadczenia root nie są wymagane."
        echo ""
fi

echo "Wprowadź hasło dla użytkownika $user1:"

sudo adduser --gecos "" $user1 --quiet

echo "Wprowadź hasło dla użytkownika $user2:"
echo ""

sudo adduser --gecos "" $user2 --quiet

echo "Użytkownicy $user1 i $user2 zostali utworzeni."
echo ""

echo "Podaj dane do pliku plik_usera_$user1.txt:"
read dane1
echo ""
echo "Podaj dane do pliku plik_usera_$user2.txt:"
read dane2

echo "$dane1" > $user1.temp
echo "$dane2" > $user2.temp
sudo mv $user1.temp /home/$user1/plik_usera_$user1.txt
sudo mv $user2.temp /home/$user2/plik_usera_$user2.txt
sudo chown $user1:$user1 /home/$user1/plik_usera_$user1.txt
sudo chown $user2:$user2 /home/$user2/plik_usera_$user2.txt

echo "Pliki plik_usera_$user1.txt i plik_usera_$user2.txt zostały utworzone w katalogach domowych użytkowników."
echo "Skrypt zakończył działanie."