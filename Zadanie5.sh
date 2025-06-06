# 5. Zbuduj mechanizm tworzący plik wykonywalny sh który na pamięci flash, będzie potrafił zrobić kopie plików bieżącego usera utworzonych i zmodyfikowanych w katalogu bieżącym przez niego

if [ $? -ne 0 ]; then
    echo "Podaj poświadczenia do podniesienia uprawnień do root by utworzyć skrypt."
    sudo -v
    echo ""
else
    echo "Skrypt uruchomiony z uprawnieniami root."
    echo ""
fi

user=$(whoami)

echo "Podaj ścieżkę do pliku logicznego pamięci flash np (/dev/sdb1):"
read flash

echo "Podaj katalog, w którym chcesz utworzyć kopię plików (np. /home/$user/backup):"
read backup_dir

sudo mkdir -p $backup_dir
sudo mount $flash $backup_dir

sudo find /home/$user -type f -newermt "$(date +%Y-%m-%d)" -exec cp {} $backup_dir \;
sudo umount $backup_dir

echo ""
echo "Kopia plików bieżącego użytkownika została utworzona w katalogu $backup_dir."
echo "Skrypt zakończył działanie."
