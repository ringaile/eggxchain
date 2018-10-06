import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';

//import * as Web3 from 'web3';
import * as TruffleContract from 'truffle-contract';

declare let require: any;
const Web3 = require('web3');

declare let window: any;

const artifacts = require('../../../build/contracts/SupplyChainList.json');

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  result: string;

  constructor(private httpClient: HttpClient) {
    window.addEventListener('load', (event) => {
      this.bootstrapWeb3();
    });
  }

  private bootstrapWeb3(): void {
    //let web3Provider = (window.web3 && window.web3.currentProvider) || new Web3.providers.HttpProvider("http://localhost:7545");
    let web3Provider = window.web3.currentProvider;
    let web3 = new Web3(web3Provider);
    web3.eth.getAccounts((err, accounts) => {
      this.result = accounts.length;
    });
    //this.httpClient.get("assets/SupplyChainList.json").subscribe(artifacts => {
      let contract = TruffleContract(artifacts);
      contract.setProvider(web3Provider);
      contract.deployed().then(instance => {
        instance.createEggBox(1, 2, 3);
      });
    //});
  }
}
