import React from "react";

import { NetworkErrorMessage } from "./NetworkErrorMessage";

export function ConnectWallet({ connectWallet, networkError, dismiss }) {
  return (
    <div className="vh-100" style={{backgroundColor: "#00ccff"}}>
      <div className="container">
        <div className="row justify-content-md-center">
          <div className="col-12 text-center">
            {/* Metamask network should be set to Localhost:8545. */}
            {networkError && (
              <NetworkErrorMessage 
                message={networkError} 
                dismiss={dismiss} 
              />
            )}
          </div>
          <div className="col-6 p-4 text-light text-center">

            <p class="h3" >Connect your wallet to create or evolve your monster.</p>
            <div style={{backgroundColor: "#00ccff"}} className="h-75 p-4 col-12">
          <img className="w-50 m-2" src={require(`../assets/mon_egg_jiggle.gif`)} ></img>
          </div>
            <button
            style={{backgroundColor: "#00ff00"}}
              className="btn text-light"
              type="button"
              onClick={connectWallet}
            >
              Connect Wallet
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}