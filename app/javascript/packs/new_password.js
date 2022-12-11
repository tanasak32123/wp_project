let form = document.getElementById("form");
let elements = document.querySelectorAll(".form");

document.getElementById("confirm").addEventListener("click", (event) => {
    event.preventDefault();
    let notValidate = false;

    elements.forEach((e) => {
        let notValid = false;
        if (e.value == "") {
            if (e.id == 'newPassword') {
                document.querySelector(
                    `#${e.id}-feedback`
                ).innerHTML = `Please enter your new password`;
            } else {
                document.querySelector(
                    `#${e.id}-feedback`
                ).innerHTML = `Please enter your re-enter password`;
            }
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

    let newPassword = document.querySelector("#newPassword");
    let re_password = document.querySelector("#re-password");
    let newPassword_feedback = document.querySelector("#newPassword-feedback");
    let re_password_feedback = document.querySelector("#re-password-feedback");

    if (
        newPassword.value &&
        re_password.value &&
        newPassword.value != re_password.value
    ) {
        setNotValid(newPassword);
        setNotValid(re_password);
        newPassword_feedback.innerHTML = "Password and re-password is not match";
        re_password_feedback.innerHTML = "";
        newPassword.value = "";
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
