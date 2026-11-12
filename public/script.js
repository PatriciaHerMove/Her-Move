const menuToggle = document.querySelector('.menu-toggle');
const mainNav = document.querySelector('.main-nav');

menuToggle.addEventListener('click', () => {
  const isOpen = mainNav.classList.toggle('open');
  menuToggle.setAttribute('aria-expanded', String(isOpen));
});

mainNav.querySelectorAll('a').forEach((link) => {
  link.addEventListener('click', () => {
    mainNav.classList.remove('open');
    menuToggle.setAttribute('aria-expanded', 'false');
  });
});

// Until the real provider and business contact details are supplied, actions
// explicitly demonstrate the future flow without reserving or charging anything.
const demoDialog = document.querySelector('#demo-dialog');
const demoDescription = document.querySelector('#demo-description');
document.querySelectorAll('.dummy-action').forEach((button) => {
  button.addEventListener('click', () => {
    demoDescription.textContent = `${button.dataset.offer}: Diese Funktion ist noch eine Demo. Die Buchungs- und Kontaktdaten werden vor dem Start ergänzt.`;
    demoDialog.showModal();
  });
});
demoDialog.querySelector('.dialog-close').addEventListener('click', () => demoDialog.close());

// Escape also closes the mobile menu, returning focus to its trigger.
document.addEventListener('keydown', (event) => {
  if (event.key === 'Escape' && mainNav.classList.contains('open')) {
    mainNav.classList.remove('open');
    menuToggle.setAttribute('aria-expanded', 'false');
    menuToggle.focus();
  }
});

const mapPanel = document.querySelector('#studio-map');
const mapPlaceholder = mapPanel.querySelector('.map-placeholder');
const mapLoad = document.querySelector('.map-load');
const mapClose = document.querySelector('.map-close');

mapLoad.addEventListener('click', () => {
  const frame = document.createElement('iframe');
  frame.src = mapPanel.dataset.mapUrl;
  frame.title = 'Karte: Gute32, Gutenbergstraße 32, 12557 Berlin-Köpenick';
  frame.loading = 'lazy';
  frame.referrerPolicy = 'strict-origin-when-cross-origin';
  frame.setAttribute('allowfullscreen', '');
  mapPanel.replaceChildren(frame);
  mapClose.hidden = false;
  mapClose.focus();
});

mapClose.addEventListener('click', () => {
  mapPanel.replaceChildren(mapPlaceholder);
  mapClose.hidden = true;
  mapLoad.focus();
});
