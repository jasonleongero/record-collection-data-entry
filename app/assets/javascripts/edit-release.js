(function () {
    var MINIMUM_NUMBER_OF_TRACKS = 1;
    
    window.onload = function () {
        document.querySelectorAll(".list-controls").forEach(function (control) {
            registerListeners(control);
        });
    };
    
    function registerListeners(button) {        
        button.onclick = function (e) {
            e.preventDefault();
            
            var button = e.target;
            var parentDiv = button.parentNode;
            var buttonFunction = getButtonFunction(button);
            var whichForm = button.parentNode.parentNode.parentNode.getAttribute("class");
            
            switch (buttonFunction) {
            case "add-above":
                insertFormRowBefore(parentDiv, whichForm);
                break;
            case "add-below":
                insertFormRowBefore(parentDiv.nextSibling, whichForm);
                break;
            case "remove":
                parentDiv.parentNode.removeChild(parentDiv, whichForm);
                break;
            case "add-row":
                whichForm = button.parentNode.getAttribute("class");
                insertFormRowBefore(null, whichForm);
                break;
            default:
            }
        };
    }
    
    function getButtonFunction(button) {
        var buttonCssClass = button.getAttribute("class");
        var pattern = /(add-row)|(add-above)|(add-below)|(remove)/;
        var match = pattern.exec(buttonCssClass);
        
        return match[0];
    }
    
    function insertFormRowBefore(parentDiv, whichForm) {
        var newDiv = document.createElement("div");
        
        var trackNumberField = document.createElement("input");
        var trackTitleField = document.createElement("input");
        var trackMinutesField = document.createElement("input");
        var colonSpan = document.createElement("span");
        var trackSecondsField = document.createElement("input");
        
        var formatNameField = document.createElement("input");
        var formatQuantityField = document.createElement("input");
        
        var insertAboveButton = document.createElement("button");
        var insertBelowButton = document.createElement("button");
        var removeButton = document.createElement("button");
        
        if (whichForm === "track-form") {
            [trackNumberField, trackTitleField].forEach(function (input) {
                input.setAttribute("type", "text");
            });
            
            trackNumberField.setAttribute("class", "track-form-number-field");
            trackNumberField.setAttribute("name", "track_number[]");
            trackTitleField.setAttribute("class", "track-form-title-field");
            trackTitleField.setAttribute("name", "track_title[]");
            
            [trackMinutesField, trackSecondsField].forEach(function (input) {
                input.setAttribute("type", "number");
                input.setAttribute("class", "track-form-duration-field");
            });
            
            trackMinutesField.setAttribute("name", "track_minutes[]");
            trackSecondsField.setAttribute("name", "track_seconds[]");
            
            colonSpan.textContent = ":";
            
            [trackNumberField, trackTitleField, trackMinutesField, colonSpan, trackSecondsField].forEach(function (input) {
                var textNode = document.createTextNode("\n    ");
                
                newDiv.appendChild(input);
                newDiv.appendChild(textNode);
            });
        }
        
        if (whichForm === "format-form") {
            formatNameField.setAttribute("type", "text");
            formatQuantityField.setAttribute("type", "number");
            
            formatNameField.setAttribute("class", "format-form-name-field");
            formatQuantityField.setAttribute("class", "format-form-quantity-field");
            
            formatNameField.setAttribute("name", "format_name[]");
            formatQuantityField.setAttribute("name", "format_quantity[]");
            formatQuantityField.setAttribute("value", "1");
            
            [formatNameField, formatQuantityField].forEach(function (input) {
                var textNode = document.createTextNode("\n    ");
                
                newDiv.appendChild(input);
                newDiv.appendChild(textNode);
            });
        }
        
        insertAboveButton.innerHTML = "<i class=\"fa fa-caret-up\"></i>";
        insertAboveButton.setAttribute("class", "track-controls add-above");
        insertBelowButton.innerHTML = "<i class=\"fa fa-caret-down\"></i>";
        insertBelowButton.setAttribute("class", "track-controls add-below");
        removeButton.innerHTML = "<i class=\"fa fa-ban\"></i>";
        removeButton.setAttribute("class", "track-controls remove");
        
        if (parentDiv !== null) {
            parentDiv.parentNode.insertBefore(newDiv, parentDiv);
        } else {
            var form = document.querySelector("." + whichForm);
            var itemsContainer = form.getElementsByTagName("div")[0];
            
            itemsContainer.appendChild(newDiv);
        }
 
        [insertAboveButton, insertBelowButton, removeButton].forEach(function (input) {
            var textNode = document.createTextNode("\n    ");
            
            newDiv.appendChild(input);
            newDiv.appendChild(textNode);
        });
        
        [insertAboveButton, insertBelowButton, removeButton].forEach(function (button) {
            registerListeners(button);
        });
    }
})();