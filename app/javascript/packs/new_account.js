let elements = document.querySelectorAll(".form");
let form = document.querySelector("form");

document.getElementById("create").addEventListener("click", (event) => {
  event.preventDefault();
  let notValidate = false;
  elements.forEach((e) => {
    let notValid = false;
    if (e.value == "") {
      if (e.id == "role") {
        document.querySelector(
          `#${e.id}-f eedback`
        ).innerHTML = `Please select your ${e.id}`;
      } else {
        document.querySelector(
          `#${e.id}-feedback`
        ).innerHTML = `Please enter your ${e.id}`;
      }
      notValid = true;
    } else if (e.id == "email" && !validateEmail(e.value)) {
      document.querySelector(
        `#${e.id}-feedback`
      ).innerHTML = `Please enter a valid email`;
      notValid = true;
    }

    if (notValid) {
      setNotValid(e);
      notValidate = true;
    } else {
      setValid(e);
      document.querySelector(`#${e.id}-feedback`).innerHTML = "";
    }
  });

  let password = document.querySelector("#password");
  let re_password = document.querySelector("#re-password");
  let password_feedback = document.querySelector("#password-feedback");
  let re_password_feedback = document.querySelector("#re-password-feedback");

  if (
    password.value &&
    re_password.value &&
    password.value != re_password.value
  ) {
    setNotValid(password);
    setNotValid(re_password);
    password_feedback.innerHTML = "Password and re-password is not match";
    re_password_feedback.innerHTML = "";
    password.value = "";
    re_password.value = "";
    notValidate = true;
  }

  if (!notValidate) {
    form.submit();
  }
});

const setValid = (element) => {
  element.classList.add("is-valid");
  element.classList.remove("is-invalid");
};

const setNotValid = (element) => {
  element.classList.remove("is-valid");
  element.classList.add("is-invalid");
};

const validateEmail = (email) => {
  return String(email)
    .toLowerCase()
    .match(
      /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    );
};
