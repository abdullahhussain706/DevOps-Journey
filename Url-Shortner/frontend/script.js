
const form = document.getElementById("shorten-form");
const originalUrlInput = document.getElementById("original-url");

const result = document.getElementById("result");
const shortUrlInput = document.getElementById("short-url");
const copyButton = document.getElementById("copy-button");
const errorMessage = document.getElementById("error-message");

form.addEventListener("submit", async function (event) {
    event.preventDefault();

    const originalUrl = originalUrlInput.value.trim();

    hideError();

    if (!isValidUrl(originalUrl)) {
        showError("Please enter a valid URL.");
        return;
    }

    try {
        const response = await fetch("/api/urls", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                original_url: originalUrl
            })
        });

        const data = await response.json();

        if (!response.ok) {
            showError("Failed to shorten URL.");
            return;
        }

        // Build the short URL using the current website address.
        shortUrlInput.value =
            `${window.location.origin}/${data.short_code}`;

        result.classList.remove("hidden");

    } catch (error) {
        console.error(error);
        showError("Unable to connect to the backend.");
    }
});


copyButton.addEventListener("click", async function () {
    const shortUrl = shortUrlInput.value;

    if (!shortUrl) {
        return;
    }

    try {
        if (navigator.clipboard && window.isSecureContext) {
            await navigator.clipboard.writeText(shortUrl);
        } else {
            // Fallback for HTTP websites.
            shortUrlInput.select();
            shortUrlInput.setSelectionRange(0, 99999);

            const copied = document.execCommand("copy");

            if (!copied) {
                throw new Error("Copy failed");
            }
        }

        copyButton.textContent = "Copied!";

        setTimeout(function () {
            copyButton.textContent = "Copy";
        }, 1500);

    } catch (error) {
        console.error(error);
        showError("Please copy the URL manually.");
    }
});


function isValidUrl(value) {
    try {
        new URL(value);
        return true;
    } catch {
        return false;
    }
}


function showError(message) {
    errorMessage.textContent = message;
    errorMessage.classList.remove("hidden");
}


function hideError() {
    errorMessage.textContent = "";
    errorMessage.classList.add("hidden");
}
