import js.dom

type Element = JS.HTMLElement

const document = dom.document

struct Object {
	d string
}

interface IComp {
	set_props(p Object)
	should_update(new Object)
	component_update()
	get_element() Element
}

struct Component[P,S] {
pub mut:
	props P
	state P
	
	components map[string]IComp = map[string]IComp{}
	pending []&IComp = []&IComp{}
	old ?Element
}

fn (c Component[P,S]) r[P,S,T, R](id string, childProps R){
	if old_component := c.components[id]{
		if old_component.should_update(childProps){
			old_component.set_props(childProps)
			pending << &old_component
		}
		return old_component.get_element()
	} else {
		new_component := T{}
		new_component.set_props(childProps)
		c.components[id]=new_component
		pending << &new_component
	}
}

fn (mut c Component[P,S]) get_element() Element{
	if cached := c.old {
		return cached
	} else {
		e := c.render()
		c.old = e
		return e
	}
}

fn (c Component[P,S]) render() Element {
	return tag(t: 'div', text: 'Calling to not valid')
}

struct App{
	Component[Object, Object]
}

struct Tag{
	t string [required]
	text string
}

[inline]
fn tag(t Tag) Element{
	mut tag := document.createElement(t.t.str)
	tag.textContent = t.text.str
	return tag
}

fn (a App) render () Element{
	return tag(t: 'div', text: 'Hello world')
}


fn start(){
	c := App{}
	mut body := document.getElementById('body'.str) or { panic(err)}
	body.appendChild(c.render())
}

fn main(){
	dom.document.addEventListener('DOMContentLoaded'.str, fn (ev JS.Event){start()}, JS.EventListenerOptions{})
}