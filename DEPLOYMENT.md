# Jungle Rails - Render Deployment Guide

## 🚀 Quick Deploy to Render

This app is configured for one-click deployment to Render.

### Prerequisites
- GitHub account (already done ✓)
- Render account (free) - [Sign up at render.com](https://render.com)

### Deployment Steps

#### 1. Create Render Account
- Go to [render.com](https://render.com)
- Sign up with your GitHub account

#### 2. Deploy from GitHub
- Click **"New +"** → **"Blueprint"**
- Connect your GitHub repository: `HaithamCa/jungle-rails`
- Render will detect the `render.yaml` file automatically
- Click **"Apply"**

#### 3. Set Environment Variables
Once the blueprint is created, go to your web service settings and add:

**Required:**
- `SECRET_KEY_BASE`: `48eaaa29239f2670c85f5e8375d97b7fdd91b4d891fea589c847ee7e0ef196605e2d30b7255176dbf0e6cc0d43eb6ade3a72bda609eb1eb2f52daf581c9250ca`

**For Stripe (if using payments):**
- `STRIPE_PUBLISHABLE_KEY`: Your Stripe publishable key
- `STRIPE_SECRET_KEY`: Your Stripe secret key

#### 4. Wait for Deployment
- First deploy takes 5-10 minutes
- Render will:
  - Install Ruby gems
  - Create PostgreSQL database
  - Run migrations
  - Seed initial data
  - Start the app

#### 5. Access Your App
- Your app will be live at: `https://jungle-rails-XXXX.onrender.com`
- Render provides a free SSL certificate automatically

---

## 📝 Default Admin Account

After deployment, you can login as admin with:
- **Email:** `admin@jungle.test`
- **Password:** `password`

**⚠️ Important:** Change this password immediately after first login!

---

## 🎨 Features Included

✅ Modern design with dark mode support  
✅ User authentication & authorization  
✅ Admin dashboard (user-level permissions)  
✅ Product catalog with categories  
✅ Shopping cart with inventory protection  
✅ Sold-out item handling  
✅ Live password validation on signup  
✅ Stripe payment integration ready  
✅ Mobile responsive  
✅ PostgreSQL database  

---

## 🔧 Local Development

```bash
# Install dependencies
bundle install

# Setup database
rake db:create db:migrate db:seed

# Start server
bin/rails server

# Visit http://localhost:3000
```

---

## 📱 Portfolio Use

Perfect for showing:
- Full-stack Rails development
- Modern UI/UX design
- Dark mode implementation
- E-commerce functionality
- User authentication
- Admin systems
- Test-driven development (RSpec)
- PostgreSQL & Active Record

---

## 🐛 Troubleshooting

**Database connection error:**
- Check that DATABASE_URL is set correctly
- Verify PostgreSQL service is running

**Assets not loading:**
- Ensure `rake assets:precompile` ran successfully
- Check Render build logs

**Need help?**
- Check Render dashboard logs
- Review build output
- Contact: [Your Email]

---

**Live URL:** https://jungle-rails-XXXX.onrender.com _(update after deployment)_  
**GitHub:** https://github.com/HaithamCa/jungle-rails
