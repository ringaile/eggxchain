# Setting up the application on Linux/Ubuntu
## Ethereum backend
* Install npm, truffle, ganache, metamask plugin for chrome browser.
* Start ganache.
* Enter ganache RPC port in truffle.js.
* Change to directory "eggxchange".
* Execute: "truffle migrate --compile-all --network ganache"
* Configure metamask in chrome:
** Connect to a Custom RPC and enter the address provided by ganache.
** Create a new account.

## Angular frontend
* Install Angular CLI: "sudo npm install -g @angular/cli".
* Change to directory "eggxchain-ui".
* Execute: "ng serve"
* Open browser: "http://localhost:4200/"
