###
The tag editing toolbar functionality for cells.
###

{Button, FormControl, FormGroup, InputGroup} = require('react-bootstrap')
{React, ReactDOM, rclass, rtypes}  = require('../smc-react')

misc = require('smc-util/misc')

exports.TagsToolbar = rclass
    propTypes :
        actions : rtypes.object.isRequired
        cell    : rtypes.immutable.Map.isRequired

    getInitialState: ->
        input : ''

    render_tag: (tag) ->
        <span key={tag}>
            {tag}
        </span>

    render_tags: ->
        t = @props.cell.get('tags')?.toJS()
        if not t?
            return
        return (@render_tag(tag) for tag in misc.keys(t).sort())

    render_tag_input: ->
        <FormControl
            onFocus     = {@props.actions.blur_lock}
            onBlur      = {@props.actions.focus_unlock}
            autoFocus   = {true}
            ref         = 'input'
            type        = 'text'
            value       = {@state.input}
            onChange    = {=>@setState(input : ReactDOM.findDOMNode(@refs.input).value)}
            style       = {flex:1}
            bsSize      = {'small'}
            />

    render_add_button: ->
        <Button
            bsSize   = 'small'
            disabled = {@state.input.length == 0}
            title    = 'Add tag or tags (separate by spaces)'
        >
            Add
        </Button>

    render_input: ->
        <div style={display:'flex'}>
            {@render_tag_input()}
            {@render_add_button()}
        </div>


    render: ->
        <div>
            {@render_tags()}
            {@render_input()}
        </div>