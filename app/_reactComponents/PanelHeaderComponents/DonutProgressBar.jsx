import React from "react";

const DonutProgressBar = () => {
  return (
    <svg x="0px" y="0px" width="450px" height="300px" viewBox="0 0 600 100">
      <circle
        className="background"
        fill="rgb(129,212,229)"
        stroke="none"
        cx="170"
        cy="50"
        r="150"
      />
      <circle
        className="donut"
        fill="rgb(238,161,119)"
        stroke="none"
        cx="170"
        cy="50"
        r="100"
        opacity="1"
      />
      <circle
        className="donut"
        fill="rgb(109,68,69)"
        stroke="none"
        cx="170"
        cy="50"
        r="85"
      />
      <circle
        className="background"
        fill="rgb(129,212,229)"
        stroke="none"
        cx="170"
        cy="50"
        r="35"
      />
      <circle
        className="bite-1"
        opacity="1"
        fill="rgb(129,212,229)"
        stroke="none"
        cx="90"
        cy="100"
        r="25"
      />
      <circle
        className="bite-2"
        opacity="0"
        fill="rgb(129,212,229)"
        stroke="none"
        cx="120"
        cy="120"
        r="35"
      />
      <circle
        className="bite-3"
        opacity="0"
        fill="rgb(129,212,229)"
        stroke="none"
        cx="150"
        cy="130"
        r="25"
      />
      <circle
        className="bite-4"
        opacity="0"
        fill="rgb(129,212,229)"
        stroke="none"
        cx="130"
        cy="100"
        r="25"
      />
      <circle
        className="bite-4"
        opacity="0"
        fill="rgb(129,212,229)"
        stroke="none"
        cx="130"
        cy="100"
        r="25"
      />
      <circle
        className="bite-5"
        opacity="0"
        fill="rgb(129,212,229)"
        stroke="none"
        cx="180"
        cy="140"
        r="25"
      />
      <circle
        className="bite-6"
        opacity="0"
        fill="rgb(129,212,229)"
        stroke="none"
        cx="160"
        cy="100"
        r="30"
      />
      <circle
        className="bite-7"
        opacity="0"
        fill="rgb(129,212,229)"
        stroke="none"
        cx="190"
        cy="140"
        r="35"
      />
      <circle
        className="bite-8"
        opacity="0"
        fill="rgb(129,212,229)"
        stroke="none"
        cx="220"
        cy="130"
        r="25"
      />
      <circle
        className="bite-9"
        fill="rgb(129,212,229)"
        stroke="none"
        opacity="0"
        cx="195"
        cy="100"
        r="35"
      />
    </svg>
  );
};

export default DonutProgressBar;
