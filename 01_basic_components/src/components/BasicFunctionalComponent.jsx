import { useState } from 'react';
import '../styles/App.css';

function BasicFunctionalComponent(props) {
  // Set the initial state with hooks
  // const { aNameProp, setANameProp } = props || "World";
  const [ nameFromState, setNameFromState ] = useState(props.aNameProp || "World");
  return (
    <div
      style={{
        backgroundColor: 'gold',
        padding: '1rem',
        border: '1px solid black',
        margin: '1rem auto',
        textAlign: 'center',
        width: '40vw'
      }}
    >
      <h1>Basic Functional Component</h1>
      <p>Hello {nameFromState}!</p>
    </div>
  );
}

export default BasicFunctionalComponent;
