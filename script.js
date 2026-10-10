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
// 1. Configure the email transport system
const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'ambatihemasai2468@gmail.com', // Replace with your Gmail address
        pass: 'gtpc vmch hkkg qfxm' // Replace with the App Password (no spaces)
    }
});

// 2. Create a function to send the email notification
function sendBookingNotification(customerName, date, time) {
    const mailOptions = {
        from: 'your-email@gmail.com',
        to: 'admin-email@gmail.com', // The email address where you want to receive the alerts
        subject: 'New Table Booking Alert!',
        text: `Hello Admin, \n\nA new table booking has been received!\n\nCustomer Name: ${customerName}\nBooking Date: ${date}\nBooking Time: ${time}\n\nPlease keep the table ready.`
    };

    transporter.sendMail(mailOptions, function(error, info){
        if (error) {
            console.log('Error sending email:', error);
        } else {
            console.log('Success! Email sent: ' + info.response);
        }
    });
}
  e.target.reset();
  dateInput.min=today;
});
