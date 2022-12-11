let form = document.getElementById("form");
let elements = document.querySelectorAll(".form");

document.getElementById("update").addEventListener("click", (event) => {
    event.preventDefault();
    let notValidate = false;
    elements.forEach((e) => {
        let notValid = false;
        // console.log(e.value)
        if (e.value == "") {
            // console.log(e.id)
            if (e.id == "role") {
                document.querySelector(
                    `#${e.id}-feedback`
                ).innerHTML = `Please select your new ${e.id}`;
            } else {
                document.querySelector(
                    `#${e.id}-feedback`
                ).innerHTML = `Please enter your new ${e.id}`;
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
