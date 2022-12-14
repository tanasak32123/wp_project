if (user_type == 'buyer') {
    document.getElementById("market").onclick = (e) => {
        e.preventDefault();
        location.href = "/my_market";
    };

    document.getElementById("purchase").onclick = (e) => {
        e.preventDefault();
        location.href = "/purchase_history";
    };
}

if (user_type == 'seller') {
    document.getElementById("sale").onclick = (e) => {
        e.preventDefault();
        location.href = "/sale_history";
    };

    document.getElementById("inventory").onclick = (e) => {
        e.preventDefault();
        location.href = "/my_inventory";
    };

    document.getElementById("top_seller").onclick = (e) => {
        e.preventDefault();
        location.href = "/top_seller";
    };
}