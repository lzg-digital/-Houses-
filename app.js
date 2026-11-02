// 😴 houses Front-end Script
console.log("houses system loaded.");
document.getElementById('login-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    if(username === '113333') {
        alert('Karibu Boss! Umefanikiwa kuingia.');
        // Direct dashboard redirect logic
    } else {
        alert('Uthibitishaji unaendelea...');
    }
});
