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
  static readonly locationDegreeFactor: number = 100000;

  result: string;

  createEggBoxModel: {
    barcode?: number,
    longitude?: number,
    latitude?: number
  } = {};

  setTrackRecordModel: {
    id?: number,
    longitude?: number,
    latitude?: number
  } = {};

  setEggBoxInfectedModel: {
    id?: number
  } = {};

  getEggBoxModel: {
    id?: number
  } = {};

  retrievedEggBox: {
    barcode: number,
    farmer: string,
    isInfected: boolean,
    timestamp: Date,
    longitude: number,
    latitude: number
  };

  getTrackRecordOfEggBoxModel: {
    eggBoxId?: number,
    index?: number
  } = {index: 0};

  private supplyChainList: any;

  private account: any;

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
      this.account = accounts[0];
    });
    //this.httpClient.get("assets/SupplyChainList.json").subscribe(artifacts => {
      let contract = TruffleContract(artifacts);
      contract.setProvider(web3Provider);
      contract.deployed().then(instance => {
        this.supplyChainList = instance;
        //instance.createEggBox(1, 2, 3, {from: window.web3.eth.accounts[0]});
      });
    //});
  }

  createEggBox(): void {
    this.supplyChainList.createEggBox.sendTransaction(
      this.createEggBoxModel.barcode,
      this.createEggBoxModel.longitude * AppComponent.locationDegreeFactor,
      this.createEggBoxModel.latitude * AppComponent.locationDegreeFactor,
      this.createTrasactionInfo());
  }

  setTrackRecord(): void {
    this.supplyChainList.setTrackRecord.sendTransaction(
      this.setTrackRecordModel.id,
      new Date().getTime() / 1000,
      this.setTrackRecordModel.longitude * AppComponent.locationDegreeFactor,
      this.setTrackRecordModel.latitude * AppComponent.locationDegreeFactor,
      this.createTrasactionInfo()
    );
  }

  setEggBoxInfected(): void {
    this.supplyChainList.setEggBoxInfected.sendTransaction(
      this.setEggBoxInfectedModel.id,
      this.createTrasactionInfo()
    );
  }

  async getEggBox() {
    let result: any;
    try {
      result = await this.supplyChainList.getEggBox.call(this.getEggBoxModel.id);
    } catch {
      alert("Invalid ID!");
      return;
    }

    this.retrievedEggBox = {
      barcode: result[0],
      farmer: result[1],
      isInfected: result[2],
      timestamp: new Date(result[3] * 1000),
      longitude: result[4] / AppComponent.locationDegreeFactor,
      latitude: result[5] / AppComponent.locationDegreeFactor
    };
    this.getTrackRecordOfEggBoxModel.eggBoxId = this.getEggBoxModel.id;
    this.getTrackRecordOfEggBoxModel.index = 0;
  }

  async onTrackRecordIndexChanged(newIndex: number) {
    let result: any;
    try {
      result = await this.supplyChainList.getTrackRecordOfEggBox.call(this.getTrackRecordOfEggBoxModel.eggBoxId, newIndex);
    } catch {
      if (this.getTrackRecordOfEggBoxModel.index == null) {
        this.getTrackRecordOfEggBoxModel.index = 0;
      } else {
        this.getTrackRecordOfEggBoxModel.index = null;
      }

      // Index not available, do nothing.
      return;
    }

    this.getTrackRecordOfEggBoxModel.index = newIndex;
    this.retrievedEggBox.timestamp = new Date(result[0] * 1000);
    this.retrievedEggBox.longitude = result[1] / AppComponent.locationDegreeFactor;
    this.retrievedEggBox.latitude = result[2] / AppComponent.locationDegreeFactor;
  }

  updateAllInfectedEggBoxes(): void {
    this.supplyChainList.updateAllInfectedEggBoxes.sendTransaction(
      this.getTrackRecordOfEggBoxModel.eggBoxId,
      this.getTrackRecordOfEggBoxModel.index,
      this.createTrasactionInfo());
  }

  private createTrasactionInfo(): { from: string } {
    return { from: this.account };
  }
}
