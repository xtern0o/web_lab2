// import './toastify.min';

const canvas = document.querySelector("#map-canvas");
const ctx = canvas.getContext("2d");
const width = canvas.width;
const height = canvas.height;
const centerX = width / 2;
const centerY = height / 2;


const rCheckGroup = document.querySelectorAll("input[name=r]");
const xRadioGroup = document.querySelectorAll("input[name=x]");
const yField = document.querySelector("input[name=y]");

const clearButton = document.getElementById("clear-button");

const form = document.querySelector("#control-form");

const maxLength = 8;

const tableH = document.querySelector("#table-h");

const coordP = document.querySelector("#current_coord");
const canvasWrapper = document.querySelector("#canvas-wrapper");


var errorCount = 0;


clearButton.onclick = function clearForm() {
    xRadioGroup.forEach(radio => {
        radio.checked = false;
    });

    rCheckGroup.forEach(check => {
        check.checked = false;
    })

    yField.value = "";
    refreshCanvas();
};

form.addEventListener("submit", event => {
    const res = validateForm();
    if (!res.valid) {
        event.preventDefault();
        showFormError(`Ошибка валидации данных. ${res.message}`)
        return false;
    }

})

rCheckGroup.forEach(check => {
    check.addEventListener('change', event => {
        drawFigureOnCanvas();
    })
})


function validateX() {
    const selectedX = document.querySelector('input[name="x"]:checked');
    if (!selectedX) {
        return false;
    }
    return true;
}

function validateY() {
    const yValue = yField.value.trim();
    if (yValue === '') {
        return false;
    }

    const yNumber = parseFloat(yValue);
    if (isNaN(yNumber)) {
        return false;
    }

    if (yNumber <= -5 || yNumber >= 3) {
        return false;
    }

    return true;
}

function validateR() {
    const rValues = document.querySelectorAll('input[name="r"]:checked');

    return rValues.length > 0;
}

function validateForm() {
    if (!validateX()) {
        return {
            "valid": false,
            "message": "Выберите одно из доступных значений X"
        }
    }
    if (!validateY()) {
        return {
            "valid": false,
            "message": "Y должно быть числом от -5 до 3 не включительно"
        }
    }
    if (!validateR()) {
        return {
            "valid": false,
            "message": "Выберите один или более значений R"
        }
    }
    return {
        "valid": true,
        "message": "Данные корректны"
    }
}



function refreshCanvas() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    drawCoordinateSystem();
    drawAllDots();
}

function getRadians(degrees) {
    return (Math.PI / 180) * degrees;
}

function drawFigureOnCanvas() {
    const width = canvas.width;
    const height = canvas.height;
    const centerX = width / 2;
    const centerY = height / 2;
    const areaColor = "rgba(0, 48, 73, 0.6)"

    const rChecked = document.querySelectorAll('input[name="r"]:checked');

    refreshCanvas();

    rChecked.forEach(cb => {
        let rValue = parseFloat(cb.value);

        ctx.fillStyle = areaColor;

        ctx.fillRect(centerX - rValue * one, centerY - rValue * one, rValue * one, rValue * one);

        ctx.beginPath();
        ctx.moveTo(centerX, centerY);
        ctx.lineTo(centerX, centerY - rValue * one / 2);
        ctx.lineTo(centerX + rValue * one / 2, centerY);
        ctx.closePath();
        ctx.fill();

        ctx.beginPath();
        ctx.arc(centerX, centerY, rValue * one / 2, getRadians(0), getRadians(90));
        ctx.lineTo(centerX, centerY);
        ctx.closePath();
        ctx.fill();
    });

    drawAllDots();

}

yField.addEventListener("input", () => {
    if (yField.value.length > maxLength) {
        yField.value = yField.value.slice(0, maxLength)
    }
})

function showFormError(text) {
    const errorDiv = document.createElement("div");
    errorDiv.setAttribute("id", "error-div-" + ++errorCount);
    errorDiv.setAttribute("class", "inline-error-container");
    errorDiv.innerHTML = `
        <img src="img/danger-18465_256.gif" width="50">
        <div>
            <h2 style="text-align: center; color: #780000">Ошибка</h2>
            <p id="error-info-p">${text}</p>
        </div>
        <button class="close-button" id="close-error-button-${errorCount}">x</button>
    `;

    tableH.before(errorDiv);
    document.querySelector("#close-error-button-" + errorCount).addEventListener("click", () => {
        const thisDiv = document.querySelector("#error-div-" + errorCount);
        thisDiv.remove();
        errorCount--;
    })

    timedRemoveElement("#error-div-" + errorCount)

}

async function timedRemoveElement(node_selector) {
    setTimeout(() => {
        const thisDiv = document.querySelector(node_selector);
        if (thisDiv) {
            thisDiv.remove();
            errorCount--;
        }
    }, 3000);
}

// рисование точки по абсолютный координатам
function drawDot(x, y, success) {
    const color = success ? "green" : "red";
    const strokeColor = "black";
    const radius = 5;

    ctx.beginPath();
    ctx.arc(x, y, radius, 0, 2 * Math.PI);
    ctx.fillStyle = color;
    ctx.fill();
    ctx.strokeStyle = strokeColor;
    ctx.stroke();
}

// абсолютные координаты в системные
function absToSystemCoord(x, y) {
    const logicalX = (x - centerX) / one;
    const logicalY = (centerY - y) / one;

    return {x: logicalX.toFixed(2), y: logicalY.toFixed(3)};
}

// системные координаты в абсолютные
function systemToAbsCoord(x, y) {
    const absX = x * one + centerX;
    const absY = centerY - y * one;

    return {x: absX, y: absY};
}

function drawAllDots() {
    console.log("Рисуем все точки")
    console.log(points)
    points.forEach(dot => {
        let absCoords = systemToAbsCoord(dot.x, dot.y);
        drawDot(absCoords.x, absCoords.y, dot.hit);
    });
}



canvas.addEventListener("mousemove", event => {
    const rect = canvas.getBoundingClientRect();

    currentX = event.clientX - rect.left;
    currentY = event.clientY - rect.top;

    trueCoords = absToSystemCoord(currentX, currentY);
    trueX = trueCoords.x;
    trueY = trueCoords.y;

    coordP.textContent = `x: ${trueX}, y: ${trueY}`
})
canvas.addEventListener("mouseleave", event => {
    coordP.textContent = "---";
})

canvas.addEventListener("click", event => {
    let localCanvas = document.querySelector("#map-canvas");

    const rChecked = document.querySelectorAll('input[name="r"]:checked');
    if (rChecked.length === 0) {
        Toastify({
            text: "Сначала выберите радиус (R)!",
            duration: 3000,
            position: "center",
            backgroundColor: "#780000",
            avatar: "img/danger-18465_256.gif"
        }).showToast();
        return;
    }

    const rect = localCanvas.getBoundingClientRect();
    const clickX = event.clientX - rect.left;
    const clickY = event.clientY - rect.top;

    const systemCoords = absToSystemCoord(clickX, clickY);

    const allowedX = [-2, -1.5, -1, -0.5, 0, 0.5, 1, 1.5, 2];
    let closestX = allowedX.reduce((prev, curr) =>
        Math.abs(curr - systemCoords.x) < Math.abs(prev - systemCoords.x) ? curr : prev
    );
    xRadioGroup.forEach(radio => radio.checked = false);
    let xRadio = document.querySelector(`input[name="x"][value="${closestX}"]`);
    if (xRadio) xRadio.checked = true;

    if (-5 >= systemCoords.y || 3 <= systemCoords.y) {
        showFormError("Y должен быть от -5 до 3 не включительно")
        return;
    }
    yField.value = systemCoords.y;

    form.submit();
})

window.addEventListener('load', refreshCanvas)

