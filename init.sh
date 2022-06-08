echo -e "\033[32mConfiguring App\033[0m"

read -p "Enter your Host Name (Default 127.0.0.1) : " IP
read -p "Enter your API Port (Default 9997) : " PORT
read -p "Enter your UI Port (Default 9999) : " UI_PORT

read -p "Enter your AUTH_USER (Default admin) : " AUTH_USER
read -p "Enter your AUTH_PASS (Default password) : " AUTH_PASS

read -p "Enter your APP_NAME (Default Data_eXchange_Controller) : " APP_NAME
read -p "Enter your APP_URL (Default http://databroker.global) : " APP_URL
read -p "Enter your SUPPORT_EMAIL (Default support@databroker.global) : " SUPPORT_EMAIL

sed -i "s/XXXX/${PORT:="9997"}/g" ./docker-compose.yml
sed -i "s/YYYY/${UI_PORT:="9999"}/g" ./docker-compose.yml

echo "DXC_HOST=http://${IP:="127.0.0.1"}:${PORT:="9997"}" > "./.env"
echo "DXC_SERVER_HOST=http://${IP:="127.0.0.1"}:${PORT:="9997"}" >> "./.env"

echo "AUTH_USER=${AUTH_USER:="admin"}" >> "./.env"
echo "AUTH_PASS=${AUTH_PASS:="password"}" >> "./.env"

echo "APP_NAME=${APP_NAME:="Data_eXchange_Controller"}" >> "./.env"
echo "APP_URL=${APP_URL:="http://databroker.global"}" >> "./.env"
echo "SUPPORT_EMAIL=${SUPPORT_EMAIL:="support@databroker.global"}" >> "./.env"

echo -e "\033[32mCreated environment file successfully!\033[0m"

echo -e "\033[32mSetting Up Application (Make sure your docker demon is running)\033[0m"
docker-compose down
docker-compose up --build -d
echo -e "\033[32mSetup is done\033[0m"
echo -e "\033[32mApplication UI is running at : http://$IP:${UI_PORT:="9999"}\033[0m"
echo -e "\033[32mApplication API is running at : http://$IP:${PORT:="9997"}\033[0m"
