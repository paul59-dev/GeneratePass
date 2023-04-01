require 'sqlite3'
require 'io/console'

def clear_screen
    system('clear') || system('cls')
end

db = SQLite3::Database.new('passwordDataBase.db')
db.execute("CREATE TABLE IF NOT EXISTS password (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(255) NOT NULL, password TEXT, date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP)")

def view_your_create_password(db, name, password)
    puts_color(35, "Nom du compte : #{name}, Mot de passe : #{password}")
    puts_color(32, "On bien été enregistrer !")
end

def puts_color(color_code, text)
    puts "\e[#{color_code}m#{text}\e[0m"
end

clear_screen()

def menu
    puts ""
    puts_color(37, "Bienvenues sur le createur de mot de passe")
    sleep(1)
    puts ""
    puts_color(32, "1. Créer son mot de passe")
    puts_color(32, "2. Voir vos mot de passe")
    puts_color(32, "3. Supprimer un mot de passe")
    puts_color(32, "4. Générer un mot de passe sécuriser aléatoire")
    puts_color(32, "5. Modifier un mot de passe")
    puts_color(32, "6. Suprimer tout les mot des passe")
    puts_color(32, "7. Quitter l'application")
    puts ""
end

def see_double_account(db, account, password)
    result  = db.execute("SELECT COUNT(*) FROM password WHERE name = ?", account)
    if result[0][0] > 0
        puts_color(31, "Vous avez déjà un mot de passe pour ce compte") 
    else
        current_datetime = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        db.execute("INSERT INTO password (name, password, date_added) VALUES (?, ?, ?)", [account, password, current_datetime])
        view_your_create_password(db, account, password)
    end
end

def create_password(db)
    puts ""
    loop do
        puts_color(33, "1. Tapez votre compte et associer d'un mot de passe personnalisé")
        puts_color(33, "2. Retourner au menu")
        puts ""
        print "Votre choix : "
        choise = gets.chomp.strip
        case choise
            when "1"
                print "Nom du compte : "
                account_name = gets.chomp
                account_name = account_name.strip
                print "Créer votre mot de passe : "
                password = gets.chomp
                password = password.strip
                see_double_account(db, account_name, password)
                break
            when "2"
                return
            else 
                puts_color(31, "Tapez 1 ou tapez 2 sur votre clavier !") 
        end
    end
end

def see_password(db)
    looks = db.execute("SELECT * FROM password")
    result = db.execute("SELECT COUNT(*) FROM password")
  
    if result[0][0] > 0
        puts "/" * 100
        puts ""
        puts "| %-30s | %-30s | %-30s" % ["Nom", "Mot de passe", "Dates"] # Utilisation de la syntaxe de formatage de chaîne pour aligner les colonnes
        puts "|" + "-" * 98 + "|"
        looks.each do |look|
            puts "| %-30s | %-30s | %-30s |" % [look[1], look[2], look[3]] # Utilisation de la syntaxe de formatage de chaîne pour aligner les colonnes
        end
        puts "|" + "-" * 98 + "|"
        puts ""
        puts "/" * 100
    else 
        puts "Vous n'avez pas de compte, ni de mot de passe enregistré !"
    end
end

def delete_password(db)
    puts ""
    loop do
        puts_color(33, "1. Supprimer un compte et un mot de passe déjà enregistré !")
        puts_color(33, "2. Retourner au menu")
        puts ""
        print "Votre choix : "
        choise = gets.chomp.strip
        case choise
            when "1"
                print "Entrer le nom du compte pour suprimer le mot de passe : "
                name = gets.chomp
                result = db.execute("SELECT COUNT(*) FROM password WHERE name = ?", [name])
                if result[0][0] > 0
                    db.execute("DELETE FROM password WHERE name = ?", [name])
                    puts_color(32, "Le compte et le mot de passe pour #{account_name} a été supprimer avec succès !")
                    break
                else
                    puts "Aucun mot de passe pour ce nom !"
                end
            when "2"
                return
            else 
                puts_color(31, "Tapez 1 ou tapez 2 sur votre clavier !") 
        end
    end
end

def generate_password(db)
    puts ""
    loop do
        puts_color(33, "1. Générer un mot de passe sécuriser pour votre compte !")
        puts_color(33, "2. Retourner au menu")
        puts ""
        print "Votre choix : "
        choise = gets.chomp.strip
        case choise
            when "1"
                chars = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
                password = (0..15).map { chars.sample }.join
                print "Nom du compte : "
                account_name = gets.chomp
                account_name = account_name.strip
                see_double_account(db, account_name, password)
                break
            when "2"
                return
            else 
                puts_color(31, "Tapez 1 ou tapez 2 sur votre clavier !") 
        end
    end
end

def update_password(db)
    loop do
        puts ""
        puts_color(33, "1. Modifier un mot de passe pour un compte déjà existant !")
        puts_color(33, "2. Retourner au menu")
        puts ""
        print "Votre choix : "
        choise = gets.chomp.strip
        case choise
            when "1"
                print "Nom du compte pour lequel vous souhaitez modifier le mot de passe : "
                account_name = gets.chomp
                account_name = account_name.strip
                result = db.execute("SELECT COUNT(*) FROM password WHERE name = ?", [account_name])
                if result[0][0] > 0
                    print "Nouveau mot de passe pour #{account_name} : "
                    new_password = gets.chomp
                    new_password = new_password.strip
                    db.execute("UPDATE password SET password = ? WHERE name = ?", [new_password, account_name])
                    puts_color(32, "Le mot de passe pour #{account_name} a été mis à jour avec succès !")
                    break
                else
                    puts_color(31, "Aucun mot de passe pour ce nom !")
                end
            when "2"
                return
            else 
                puts_color(31, "Tapez 1 ou tapez 2 sur votre clavier !") 
        end
    end
end

def delete_all(db)
    puts ""
    loop do
        puts_color(33, "1. Supprimer tout vos mots de passes")
        puts_color(33, "2. Retourner au menu")
        puts ""
        print "Votre choix : "
        choise = gets.chomp.strip
        case choise
            when "1"
                break
            when "2"
                return
            else 
                puts_color(31, "Tapez 1 ou tapez 2 sur votre clavier !") 
        end
    end
    loop do
        puts "Voulez-vous suprimer tout vos compte et mot de passe ? (y/n)"
        response = gets.chomp.strip
        case response
            when "y" 
                puts_color(31, "Etes-vous sur ? (y/n)")
                response = gets.chomp.strip
                if response == "y"
                    db.execute("DROP TABLE IF EXISTS password")
                    puts_color(31, "Tout vos mot de passe on été supprimer !")
                    db.execute("CREATE TABLE IF NOT EXISTS password (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(255) NOT NULL, password TEXT, CURRENT_TIMESTAMP)")
                    break
                elsif response == "n"
                    puts_color(34, "OUFFF ! Garder vos mots de passe on sait jamais !")
                    break
                else 
                    puts_color(31, "Vous devez inscrire (y) ou (n)")
                end
            when "n"
                puts_color(34, "OUFFF ! Garder vos mots de passe on sait jamais !")
                break
            else 
                puts_color(31, "Vous devez inscrire (y) ou (n)")
        end 
    end
end

def main(db)
    loop do
        trap('INT', 'SIG_IGN')
        menu()
        print "Entrer votre réponce : "
        choise_menu = gets.chomp
        puts "Le choix est #{choise_menu}"
        puts ""

        case choise_menu
            when "1"
                clear_screen()
                create_password(db)
            when "2"
                clear_screen()
                see_password(db)
            when "3"
                clear_screen()
                delete_password(db)
            when "4"
                clear_screen()
                generate_password(db)
            when "5"
                clear_screen()
                update_password(db)
            when "6"
                clear_screen()
                delete_all(db)
            when "7"
                clear_screen()
                puts""
                puts_color(33, "Merci d'avoir utiliser notre programme ! A bientôt !")
                exit #arrete le programme
            else 
                clear_screen()
                puts_color(31, "Vous n'avez pas choisi une option valide !")
        end
    end
end

main(db)
db.close
gets.chomp