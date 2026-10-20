// Shows messages from the server and checks the register form before it is sent.

const messages = {
  username: "Username must be 3 to 30 characters: letters, numbers and _ only.",
  email: "Please enter a valid email address.",
  short: "Password must be at least 8 characters.",
  match: "The two passwords do not match.",
  taken: "That username or email is already registered.",
  invalid: "Wrong username/email or password.",
  needlogin: "Please log in to see your dashboard.",
  slow: "Too many attempts. Please wait a few minutes and try again.",
  server: "Something went wrong on our side. Please try again."
};

function show_message(text, kind)
{
  const box = document.querySelector("#message");
  box.textContent = text;          // textContent keeps the text safe
  box.className = kind;            // "error" or "ok"
}

// Read ?error=... or ?registered=1 from the URL
const params = new URLSearchParams(window.location.search);

if(params.get("error"))
  show_message(messages[params.get("error")] || messages.server, "error");
else if(params.get("registered"))
  show_message("Account created! You can log in now.", "ok");
else if(params.get("loggedout"))
  show_message("You have been logged out.", "ok");

// Check the register form before sending it to the server
const register_form = document.querySelector("#register_form");
if(register_form)
{
  register_form.addEventListener("submit", function(event)
  {
    const pw = document.querySelector("#pw").value;
    const pw2 = document.querySelector("#pw2").value;
    if(pw.length < 8)
    {
      event.preventDefault();
      show_message(messages.short, "error");
    }
    else if(pw !== pw2)
    {
      event.preventDefault();
      show_message(messages.match, "error");
    }
  });
}
