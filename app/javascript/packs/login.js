let elements = document.querySelectorAll("input.form-control");
let form = document.querySelector("form");

document.getElementById("sign_in").addEventListener("click", (event) => {
  event.preventDefault();
  let notValidate = false;
  elements.forEach((e) => {
    if (e.value == "") {
      setNotValid(e);
      document.querySelector(`#${e.id}-feedback`).innerHTML = `Please enter your ${e.id}`;
      notValidate = true;
    } else {
      setValid(e);
      document.querySelector(`#${e.id}-feedback`).innerHTML = "";
    }
  });
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
