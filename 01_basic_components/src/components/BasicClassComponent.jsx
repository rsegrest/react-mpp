import { Component } from 'react';
import '../styles/App.css';

class BasicFunctionalComponent extends Component {
  constructor(props) {
    super(props);
    this.state = { myNameFromState: props.aNameProp || "World" };
  }
  render() {
    const { myNameFromState } = this.state;

    return (
      <div
        style={{
          color: 'white',
          backgroundColor: 'slateblue',
          padding: '1rem',
          border: '1px solid black',
          width: '40vw',
          margin: '1rem auto',
          textAlign: 'center',
        }}
      >
        <h1>Basic Class Component</h1>
        <p>Hello {myNameFromState}!</p>
      </div>
    )
  }
}

export default BasicFunctionalComponent;
