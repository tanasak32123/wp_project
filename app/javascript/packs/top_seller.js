let date_input = document.querySelectorAll("input");
let form = document.querySelector("#form");

console.log(form)

document.getElementById("search").addEventListener("click", (event) => {
    event.preventDefault();
    let allValidate = true;
    let start_date = document.getElementById("start_date").value;
    let end_date = document.getElementById("end_date").value;
    date_input.forEach((e) => {
        if (e.value == "") {
            setNotValid(e);
            document.querySelector(`#${e.id}-feedback`).innerHTML = `Please select a ${e.id}`;
            allValidate = false;
        } else {
            setValid(e);
        }
    })

    if (allValidate) {
        if (start_date <= end_date) {
            // console.log('search');
            form.submit();
        } else {
            document.getElementById("start_date").valueAsDate = null;
            document.getElementById("end_date").valueAsDate = null;
            document.querySelector(`#start_date-feedback`).innerHTML = `Not valid date`;
            setNotValid(document.querySelector(`#start_date`));
            setNotValid(document.querySelector(`#end_date`));
        }
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