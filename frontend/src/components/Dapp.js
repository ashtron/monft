import React from "react";

import { ethers } from "ethers";

import TokenArtifact from "../contracts/Token.json";
import MonFTArtifact from "../contracts/MonFT.json";
import contractAddress from "../contracts/contract-address.json";

import { NoWalletDetected } from "./NoWalletDetected";
import { ConnectWallet } from "./ConnectWallet";
import { Loading } from "./Loading";
import { Transfer } from "./Transfer";
import { TransactionErrorMessage } from "./TransactionErrorMessage";
import { WaitingForTransactionMessage } from "./WaitingForTransactionMessage";
import { NoTokensMessage } from "./NoTokensMessage";
import { MonsterDisplay } from "./MonsterDisplay";
import { Mint } from "./Mint";
import { Mutate } from "./Mutate";
import { Header } from "./Header";

const HARDHAT_NETWORK_ID = '31337';

const ERROR_CODE_TX_REJECTED_BY_USER = 4001;

export class Dapp extends React.Component {
  constructor(props) {
    super(props);

    this.initialState = {
      selectedAddress: undefined,
      balance: undefined,
      txBeingSent: undefined,
      transactionError: undefined,
      networkError: undefined,
      dna: undefined,
      nftId: undefined,
      nftExists: false
    };

    this.state = this.initialState;

    this._mint = this._mint.bind(this);
    this._updateMonFT = this._updateMonFT.bind(this);
    this._mutate = this._mutate.bind(this);
    this._transferMon = this._transferMon.bind(this);
  }

  render() {
    document.body.style = "background: #00ccff;";

    if (window.ethereum === undefined) {
      return <NoWalletDetected />;
    }

    if (!this.state.selectedAddress) {
      return (
        <ConnectWallet 
          connectWallet={() => this._connectWallet()} 
          networkError={this.state.networkError}
          dismiss={() => this._dismissNetworkError()}
        />
      );
    }

    if (!this.state.dna) {
      return <Loading />;
    }

    return (
      <div className="container p-4">
        <Header />

        <div className="row justify-content-md-center">
          <MonsterDisplay dna={this.state.dna} nftExists={this.state.nftExists} balance={this.state.balance} />
        </div>

        <div className="row justify-content-md-center" style={{ marginBottom: 15 }}>
          <Mint mint={this._mint} />
        </div>

        <div className="row justify-content-md-center" style={{ marginBottom: 15 }}>
          <Mutate mutate={this._mutate} />
        </div>

        <div className="row justify-content-md-center" style={{ marginBottom: 15 }}>
          <Transfer from={this.state.selectedAddress} transferMon={this._transferMon} />
        </div>
      </div>
    );
  }

  componentWillUnmount() {
    this._stopPollingData();
  }

  async _connectWallet() {
    const [selectedAddress] = await window.ethereum.enable();

    if (!this._checkNetwork()) {
      return;
    }

    this._initialize(selectedAddress);

    window.ethereum.on("accountsChanged", ([newAddress]) => {
      this._stopPollingData();
      if (newAddress === undefined) {
        return this._resetState();
      }
      
      this._initialize(newAddress);
    });
    
    window.ethereum.on("networkChanged", ([networkId]) => {
      this._stopPollingData();
      this._resetState();
    });
  }

  _initialize(userAddress) {
    this.setState({
      selectedAddress: userAddress,
    });

    this._intializeEthers();
    this._startPollingData();
  }

  async _intializeEthers() {
    this._provider = new ethers.providers.Web3Provider(window.ethereum);

    this._token = new ethers.Contract(
      contractAddress.Token,
      TokenArtifact.abi,
      this._provider.getSigner(0)
    );

    this._monFT = new ethers.Contract(
      contractAddress.MonFT,
      MonFTArtifact.abi,
      this._provider.getSigner(0)
    );
  }

  _startPollingData() {
    this._pollDataInterval = setInterval(() => this._update(), 1000);

    this._updateBalance();
    this._updateMonFT();
  }

  _update() {
    this._updateMonFT();
    this._updateBalance();
  }

  async _updateMonFT() {
    const dnaBigNums = (await this._monFT.getBodyData(1)).concat(await this._monFT.getFaceData(1));
    const dna = dnaBigNums.map(gene => Number(gene));
  
    this.setState({ dna: dna });
    console.log(this.state.dna);
  }

  _stopPollingData() {
    clearInterval(this._pollDataInterval);
    this._pollDataInterval = undefined;
  }

  async _mint() {
    await this._monFT.mintMon();
    this.setState({ nftExists: true });
  }

  async _mutate() {
    const overrides = {
      gasLimit: 307580
    }

    if (this.state.balance) {
      await this._monFT.mutate(1, overrides);
    }
  }

  async _updateBalance() {
    const balance = Number(await this._monFT.balanceOf(this.state.selectedAddress));
    this.setState({ balance });
  }

  async _transferMon(from, to, id) {
    const overrides = {
      gasLimit: 307580
    }

    await this._monFT.transferMon(from, to, id, overrides);
  }

  _dismissTransactionError() {
    this.setState({ transactionError: undefined });
  }

  _dismissNetworkError() {
    this.setState({ networkError: undefined });
  }

  _getRpcErrorMessage(error) {
    if (error.data) {
      return error.data.message;
    }

    return error.message;
  }

  _resetState() {
    this.setState(this.initialState);
  }

  _checkNetwork() {
    if (window.ethereum.networkVersion === HARDHAT_NETWORK_ID) {
      return true;
    }

    this.setState({ 
      networkError: 'Please connect Metamask to Localhost:8545'
    });

    return false;
  }
}
