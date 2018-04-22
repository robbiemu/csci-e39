import React from 'react'
import PropTypes from 'prop-types'

class AdTile extends React.Component {
  constructor (props) {
    super(props)
  }

  render () {
    return (
      <figure className="AdTile tile component">
        <p><a href={this.props.link}><img className="ad-img" src={this.props.url} /></a></p>
        <figcaption className="menu-text">{this.props.text}</figcaption>
      </figure>
    )
  }
}

AdTile.propTypes = {
  link: PropTypes.string.required,
  url: PropTypes.string.required,
  text:  PropTypes.string.required
}

export default AdTile
