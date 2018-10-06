import { Component } from '@angular/core';

import * as Web3 from 'web3';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  result: string;

  constructor() {
    let web3 = new Web3.providers.HttpProvider("http://localhost:7545");
  }
}
