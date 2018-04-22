import React from 'react'
import PropTypes from 'prop-types'

class ChannelTile extends React.Component {
  constructor (props) {
    super(props)
  }

  render () {
    return (
      <figure className="ChannelTile tile component">
        <p><i className={['fas', this.props.icon].join(' ')}></i></p>
        <figcaption className="menu-text">{this.props.text}</figcaption>
      </figure>
    )
  }
}

ChannelTile.propTypes = {
  icon: PropTypes.string.required,
  text: PropTypes.string.required
}

export default ChannelTile
