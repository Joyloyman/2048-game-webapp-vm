ENV['VAGRANT_SERVER_URL'] = 'https://vagrant.elab.pro'
Vagrant.configure("2") do |config|
    config.vm.network "public_network"
    config.vm.define "game01" do |game01| 
        game01.vm.box = "ubuntu/focal64"
        game01.vm.network "forwarded_port", guest: 8080, host: 8080
        game01.vm.provision "shell", inline: <<-SHELL
            sudo apt-get update
            sudo apt-get install -y nginx
        SHELL
        # Скрипт провижининга для установки Docker
        game01.vm.provision "shell", inline: <<-SHELL
            sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
            sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
            sudo apt-get update
            sudo apt-get install -y docker-ce
            sudo usermod -aG docker vagrant

        # Скрипт провижинга для установки NodeJS 16
            if type node; then
            echo "Node.js is installed."
            node -v
            else
                # Добавление репозитория NodeSource для Node.js 16.x
                curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
            
                # Установка Node.js и npm
                sudo apt-get install -y nodejs
            
                # Проверка версии Node.js и npm
                node -v
                npm -v 
            fi
        # Путь, где должен быть клонирован репозиторий
        REPO_DIR=/home/vagrant/web-app/2048-game
        # URL репозитория для клонирования
        REPO_URL=https://gitfront.io/r/deusops/JnacRhR4iD8q/2048-game.git
    
        # Проверка, существует ли директория репозитория
        if [ -d "$REPO_DIR" ]; then
            echo "Репозиторий уже существует. Переходим к обновлению..."
            # Переходим в директорию репозитория и выполняем git pull для обновления
            cd $REPO_DIR
            git pull
        else
            echo "Репозиторий не найден. Клонируем..."
            # Клонирование репозитория
             git clone $REPO_URL $REPO_DIR
        fi
            # Перейдите в директорию вашего приложения
            cd /home/vagrant/web-app/2048-game
            npm install --include=dev
            npm run build
            # Запуск приложения в фоновом режиме
            nohup npm start > /dev/null 2>&1 &
        SHELL
    end
end