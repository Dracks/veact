# Veact
I'm trying to create some tool similar to React for the web,

## How to run it
You need to execute the following two comands in two terminals
1. Run the transpilation to js_browser
```sh
v -b js_browser veact.v
```
2. Run some server to serve the root of the project (I have a copy of verve)
```sh
v run verve.v
```


## Status

Seems that currently the transpilation of V to js_browser doesn't work fine. 

Is doing some ugly stuff, and missing some objects with the types I created

Example of ugly stuff
```js
function main__Component_T_main__Object_main__Object_get_element_T_main__Object_main__Object(c) {
c = new $ref(c)
	try {
		let _tmp34;
		if (_tmp34 = c.val.old, _tmp34.state == 0) {
			let [ast.IfGuardVar{
    name: 'cached'
    is_mut: false
    pos: token.Pos{
        len: 6
        line_nr: 43
        pos: 814
        col: 4
        last_line: 43
    }
}][0].name = _tmp34.data;
			return cached;
		} else {
			let err = _tmp34.err;
			/** @type {main__Element} */
			const e = main__Component_T_main__Object_main__Object_render_T_main__Object_main__Object(c.valueOf(),);
			/** @type {main__Element} */
			c.val.old = e;
			return e;
		}
	} catch (e) { 
		if (e instanceof ReturnException) { return e.val; } 
		throw e;
	}
}
```