try {
    var recognition = new webkitSpeechRecognition();
} catch(e) {
    var recognition = Object;
}
recognition.continuous = true;
recognition.interimResults = true;

var interimResult = '';
var textArea = $('#message');
var textAreaID = 'message';

function recordClick(){
  // That means we are not recording, so we start recording and reset buffers.
  if($("#recordBtn").hasClass("speech-mic")) {
    // Toggle recording button to show it is recording
    $("#recordBtn").toggleClass("speech-mic-works")
    $("#recordBtn").toggleClass("speech-mic");
    startRecognition();
  }
  else{
    recognition.stop();
  }
};

var startRecognition = function() {
    textArea.focus();
    recognition.start();
};

recognition.onresult = function (event) {
    for (var i = event.resultIndex; i < event.results.length; ++i) {
        if (event.results[i].isFinal) {
            insertAtCaret(textAreaID, event.results[i][0].transcript);
        }
    }
};
recognition.onend = function() {
    $("#recordBtn").toggleClass("speech-mic-works")
    $("#recordBtn").toggleClass("speech-mic");
};
