import React from "react";

export function MonsterDisplay({ dna, nftExists }) {
    const imageStyles = {
        position: "absolute",
        height: 500,
        width: 500
    }

    console.log(nftExists)
    
    return (
        <div style={{ width: 500, height: 500 }}>
            { dna[0] > 0 ? <img style={ imageStyles } src={require(`../parts/arms_000${dna[0]}.svg`)}></img> : null }
            { nftExists ? <img style={ imageStyles } src={require(`../parts/body_0001.svg`)}></img> : null}
            { dna[2] > 0 ? <img style={ imageStyles } src={require(`../parts/ears_000${dna[2]}.svg`)}></img> : null }
            { dna[3] > 0 ? <img style={ imageStyles } src={require(`../parts/eyes_000${dna[3]}.svg`)}></img> : null }
            { dna[4] > 0 ? <img style={ imageStyles } src={require(`../parts/legs_000${dna[4]}.svg`)}></img> : null }
            { dna[5] > 0 ? <img style={ imageStyles } src={require(`../parts/nose_000${dna[5]}.svg`)}></img> : null }
            { nftExists ? <img style={ imageStyles } src={require(`../parts/wings_0001.svg`)}></img> : null }
        </div>
    );
}

// arms: 0,
// body: 1,
// ears: 0,
// eyes: 0,
// legs: 0,
// nose: 0,
// mouth: 0,
// wings: 0,