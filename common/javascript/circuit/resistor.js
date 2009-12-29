/* The following line (global) is for JSLint */
/*global console, Flash, r_values */

function Resistor() {
    this.colorMap[-1] = 'gold';
    this.colorMap[-2] = 'silver';
    
    this.nominalValue = 0.0; //resistance value specified by band colors;
    this.realValue = 0.0; //real resistance value in Ohms
    this.tolerance = 0.0; //tolerance value
    
    this.colors = [];
    
    this.r_values1pct = this.filter(r_values.r_values1pct);
    this.r_values2pct = this.filter(r_values.r_values2pct);
}
Resistor.prototype =
{
    colorMap : { 0 : 'black', 1 : 'brown', 2 : 'red', 3 : 'orange',
        4 : 'yellow', 5 : 'green', 6 : 'blue', 7 : 'violet', 8 : 'grey',
        9 : 'white' },
        
    toleranceColorMap : { 0.01 : 'brown', 0.02 : 'red', 5e-3 : 'green',
        2.5e-3 : 'blue', 1e-3 : 'violet', 5e-4 : 'gray', 5e-2 : 'gold',
        0.1 : 'silver', 0.2 : 'none' },
    //toleranceValues : [ 0.01, 0.02, 5e-3, 2.5e-3, 1e-3, 5e-4, 5e-2,
    //                    0.1, 0.2],
    toleranceValues : [ 0.01, 0.02 ],
    
    getRealValue : function() {
        return this.realValue;
    },
    
    setRealValue : function(value) {
        this.realValue = value;
    },
    
    getNominalValue : function() {
        return this.nominalValue;
    },
    
    show : function() {
        Flash.sendCommand('show_resistor');
    },
    
    randomize : function() {
        var ix = this.randInt(0, 1);
        var values;
        this.tolerance = this.toleranceValues[ix];
        if (this.tolerance == 0.01) {
            values = this.r_values1pct;
        }
        else {
            values = this.r_values2pct;
        }
        this.nominalValue = values[this.randInt(0, values.length-1)];
        this.realValue = this.calcRealValue(this.nominalValue, this.tolerance);
        this.colors = this.getColors(this.nominalValue, this.tolerance);
        console.log('r=' + this.nominalValue + ' t=' + this.tolerance);
        console.log('colors=' + this.colors);
        console.log('Sending colors=' + this.colors.join('|'));
        Flash.sendCommand('set_resistor_label', this.colors);
    },
    
    // rvalue: resistance value
    getColors : function(rvalue, tolerance) {
        for (var exp = 0; exp < 9; ++exp) {
            if (Math.floor(rvalue / Math.pow(10, exp)) === 0) {
                break;
            }
        }
        var sig1 = Math.floor(rvalue / Math.pow(10, exp-1));
        var tempValue = rvalue - sig1 * Math.pow(10, exp-1);
        var sig2 = Math.floor(tempValue / Math.pow(10, exp-2));
        tempValue = tempValue - sig2 * Math.pow(10, exp-2);
        var sig3 = Math.floor(tempValue / Math.pow(10, exp-3));
        return [this.colorMap[sig1], this.colorMap[sig2], this.colorMap[sig3],
                this.colorMap[exp-3], this.toleranceColorMap[tolerance]];
    },
    
    calcRealValue : function(nominalValue, tolerance) {
        var chance = Math.random();
        if (chance > 0.8) {
            var chance2 = Math.random();
            if (chance2 < 0.5) {
                return nominalValue + nominalValue * (tolerance + Math.random() * tolerance);
            }
            else {
                return nominalValue - nominalValue * (tolerance + Math.random() * tolerance);
            }
        }

        // Multiply 0.9 just to be comfortably within tolerance
        var realTolerance = tolerance * 0.9;
        return nominalValue * this.randFloat(1 - realTolerance, 1 + realTolerance);
    },
    
    randInt : function(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    },
    
    randFloat : function(min, max) {
        return this.randPseudoGaussian(3) * (max - min) + min;
    },
    
    randPseudoGaussian : function(n) {
        var r = 0.0;
        for (var i = 0; i < n; ++i) {
            r += Math.random();
        }
        return r / n;
    },
    
    // Filter resistance values according to the requirements of this resistor
    filter : function(in_values) {
        var values = [];
        for (var i = 0; i < in_values.length; ++i) {
            if (in_values[i] >= 10.0 && in_values[i] < 2e6) {
                values.push(in_values[i]);
            }
        }
        return values;
    }
};
