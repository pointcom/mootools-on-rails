Element.HtmlToDom = function(el, html) {
	var range = el.ownerDocument.createRange();
	range.selectNodeContents(el);
	range.collapse(true);

	return(range.createContextualFragment(html.stripScripts()));
}

Element.implement({
	replace: function(content) {
		var el = Element.HtmlToDom(this, content);		
		this.parentNode.replaceChild(el, this);
		content.stripScripts(true);
	},
	
	replaceHTML: function(content) {		
		this.set('html', content);		
		content.stripScripts(true);
	},	
	
	append: function(position, content) {
		var el = Element.HtmlToDom(this, content);
		var inserter = Element.Inserters[position];
			
		inserter(el, this);
		content.stripScripts(true);
	},
	
	appendTop: function(content) { this.append('top', content); },
	
	appendBottom: function(content) { this.append('bottom', content); },
	
	appendAfter: function(content) { this.append('after', content); },
	
	appendBefore: function(content) { this.append('before', content); }	
});	

