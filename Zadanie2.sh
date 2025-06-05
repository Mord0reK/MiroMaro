echo "Podaj nazwę pierwszego użytkownika:"
read user1
echo ""
echo "Podaj nazwę drugiego użytkownika:"
read user2


echo ""

if [ -d /home/$user1 ]; then
    echo "Użytkownik $user1 istnieje."
else
    echo "Użytkownik $user1 nie istnieje."
    echo "Utwórz użytkownika $user1 aby kontynuować."
    exit 1
fi

if [ -d /home/$user2 ]; then
    echo "Użytkownik $user2 istnieje."
else
    echo "Użytkownik $user2 nie istnieje."
    echo "Utwórz użytkownika $user2 aby kontynuować."
    exit 1
fi

sudo -n true 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Podaj poświadczenia do utworzenia katalogów (hasło do podniesienia uprawnień do root):"
    sudo -v
    echo ""
else
    echo "Masz już uprawnienia do tworzenia katalogów. Poświadczenia root nie są wymagane."
    echo ""
fi

sudo mkdir -p /home/$user1/flash$user1/
echo "Utworzono katalog /home/$user1/flash$user1/"
sudo mkdir -p /home/$user2/flash$user2/
echo "Utworzono katalog /home/$user2/flash$user2/"
echo ""

cat /var/log/apt/history.log | grep "^Start-Date: $(date +%Y-%m-%d)" -A 5 > plik_stworzony_prze_flash$user1.temp
journalctl --since "today" --until "tomorrow" -o short-iso >> plik_stworzony_prze_flash$user1.temp

cat /var/log/apt/history.log | grep "^Start-Date: $(date +%Y-%m-%d)" -A 5 > plik_stworzony_prze_flash$user2.temp
journalctl --since "today" --until "tomorrow" -o short-iso >> plik_stworzony_prze_flash$user2.temp

echo "Dane z plików history.log i journalctl zostały zapisane do tymczasowych plików."
echo ""
sudo mv plik_stworzony_prze_flash$user1.temp /home/$user1/flash$user1/plik_stworzony_prze_flash$user1.txt
sudo mv plik_stworzony_prze_flash$user2.temp /home/$user2/flash$user2/plik_stworzony_prze_flash$user2.txt
sudo chown $user1:$user1 /home/$user1/flash$user1/plik_stworzony_prze_flash$user1.txt
sudo chown $user2:$user2 /home/$user2/flash$user2/plik_stworzony_prze_flash$user2.txt

echo "Pliki plik_usera_$user1.txt i plik_usera_$user2.txt zostały utworzone w katalogach domowych użytkowników."
echo "Skrypt zakończył działanie."