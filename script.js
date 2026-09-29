const navbar=document.getElementById("navbar");
const menuToggle=document.getElementById("menuToggle");
const navMenu=document.getElementById("navMenu");

window.addEventListener("scroll",()=>navbar.classList.toggle("scrolled",window.scrollY>40));

menuToggle.addEventListener("click",()=>navMenu.classList.toggle("open"));
document.querySelectorAll("#navMenu a").forEach(a=>a.addEventListener("click",()=>navMenu.classList.remove("open")));

const observer=new IntersectionObserver(entries=>{
  entries.forEach(entry=>{if(entry.isIntersecting) entry.target.classList.add("visible")});
},{threshold:.12});
document.querySelectorAll(".reveal").forEach(el=>observer.observe(el));

document.querySelectorAll(".filter").forEach(button=>{
  button.addEventListener("click",()=>{
    document.querySelectorAll(".filter").forEach(b=>b.classList.remove("active"));
    button.classList.add("active");
    const filter=button.dataset.filter;
    document.querySelectorAll(".food-card").forEach(card=>{
      const show=filter==="all"||card.dataset.category===filter;
      card.classList.toggle("hidden",!show);
    });
  });
});

const dateInput=document.querySelector('input[name="date"]');
const today=new Date().toISOString().split("T")[0];
dateInput.min=today;

document.getElementById("reservationForm").addEventListener("submit",e=>{
  e.preventDefault();
  const form=new FormData(e.target);
  const message=document.getElementById("formMessage");
  message.textContent=`Thank you, ${form.get("name")}! Your reservation request for ${form.get("guests")} has been received.`;
  e.target.reset();
  dateInput.min=today;
});
