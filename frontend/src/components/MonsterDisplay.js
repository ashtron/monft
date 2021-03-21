import React from "react";

export function MonsterDisplay({ dna, nftExists, balance }) {
    const imageStyles = {
        position: "absolute",
        height: 500,
        width: 500
    }

    const image = [
        dna[0] > 0 ? <img style={ imageStyles } src={require(`../parts/arms_000${dna[0]}.svg`)}></img> : null,
        <img style={ imageStyles } src={require(`../parts/body_0001.svg`)}></img>,
        dna[2] > 0 ? <img style={ imageStyles } src={require(`../parts/ears_000${dna[2]}.svg`)}></img> : null,
        dna[3] > 0 ? <img style={ imageStyles } src={require(`../parts/eyes_000${dna[3]}.svg`)}></img> : null,
        dna[4] > 0 ? <img style={ imageStyles } src={require(`../parts/legs_000${dna[4]}.svg`)}></img> : null,
        dna[5] > 0 ? <img style={ imageStyles } src={require(`../parts/nose_000${dna[5]}.svg`)}></img> : null,
        dna[6] > 0 ? <img style={ imageStyles } src={require(`../parts/mouth_000${dna[6]}.svg`)}></img> : null,
        dna[7] > 0 ? <img style={ imageStyles } src={require(`../parts/wings_0001.svg`)}></img> : null
    ]

    return (
        <div style={{ width: 500, height: 500, marginTop: 105 }}>
            { balance && balance > 0 ? image : null }
        </div>
    );
}