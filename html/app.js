window.addEventListener('message', (event) => {
    let data = event.data;
    
    if (data.action === 'ShowBlood') {
        const bloodImage = $('#blood-image');
        bloodImage.attr('src', data.image);
        bloodImage.fadeIn(125);
        
        setTimeout(() => {
            bloodImage.fadeOut(125);
        }, 450);
    }
});
