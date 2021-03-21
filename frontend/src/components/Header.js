import React from "react";

export function Header() {
    return (
        <div>
            <div className="fixed-top" width="100%">
                <div className="container-fluid">
                    <div className="row">
                        <div style={{ backgroundColor: "#00ff00", height: 140 }} className="row justify-content-md-center">
                            <img className="w-50 m-2" src={require(`../assets/top_bar_art.png`)} ></img>
                        </div>
                    </div>        
                </div>
            </div>
        </div>
    );
}