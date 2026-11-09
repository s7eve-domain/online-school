# SwidHub API (proposed REST endpoints)
Auth: `POST /auth/register` `POST /auth/login` `POST /auth/oauth/google` `POST /auth/forgot` `POST /auth/reset`
Courses: `GET /courses?category=&level=&language=&maxHours=&minRating=&price=&sort=&page=` · `GET /courses/:id` · `POST /courses` (instructor) · `PATCH /courses/:id` · `POST /courses/:id/lessons` · `POST /courses/:id/enroll`
Learning: `POST /lessons/:id/complete` · `PUT /lessons/:id/notes` · `POST /quizzes/:id/submit` · `GET /certificates/:courseId`
Mentors: `GET /mentors?field=&skill=&minYears=&maxPrice=&language=&country=&minRating=&day=` · `GET /mentors/:id` · `GET /mentors/:id/slots?from=&tz=` · `POST /mentors/apply` · `PUT /mentors/me/availability` · `POST /mentors/match`
Sessions: `POST /sessions` · `PATCH /sessions/:id` (accept, decline, cancel) · `GET /me/sessions` · `POST /sessions/:id/review`
Chat: WebSocket `/ws` (events: `message`, `typing`) · `GET /messages/:userId`
Payments: `POST /checkout/session` (creates Stripe Checkout session) · `POST /webhooks/stripe` · `POST /coupons/validate` · `POST /payouts` (Stripe Connect transfer, mentor receives 60%)
Admin (role=admin): `GET /admin/stats` · `PATCH /admin/users/:id` · `PATCH /admin/mentors/:id/approve` · `PATCH /admin/courses/:id` · `GET/PATCH /admin/reports` · `CRUD /admin/posts` · `CRUD /admin/categories`
