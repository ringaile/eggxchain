# eggXchain
Each box of eggs has an ID associated with it.
Each box has a GPS sensor with updates of the coordinates at each time.
Once the egg is marked as infected, all the eggs that have been at the same time in the same location are marked as infected too.
An end user can check if the egg is infected and get the updated information.
This is a decentralised solution based on Blockchain Ethereum platform (not only one server exists, but we have distributed servers/nodes).

## Setting up the application on Linux/Ubuntu
### Ethereum backend
* Install npm, truffle, ganache, metamask plugin for chrome browser.
* Start ganache.
* Enter ganache RPC port in truffle.js.
* Change to directory "eggxchange".
* Execute: "truffle migrate --compile-all --network ganache"
* Configure metamask in chrome:
** Connect to a Custom RPC and enter the address provided by ganache.
** Create a new account.

### Angular frontend
* Install Angular CLI: "sudo npm install -g @angular/cli".
* Change to directory "eggxchain-ui".
* Execute: "ng serve"
* Open browser: "http://localhost:4200/"

# Contact
Yen: yen.chiayi@gmail.com
Julia: iuliia.guk@web.de
Marko: black-comb@web.de
Ringaile: ringaile@gmail.com
Bita: bitaa.re@gmail.com