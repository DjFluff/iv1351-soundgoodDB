#!/bin/sh

cat create.sql > full.sql
cat tables/person.sql >> full.sql
cat tables/contact_person.sql >> full.sql
cat tables/genre.sql >> full.sql
cat tables/instrument_type.sql >> full.sql
cat tables/location.sql >> full.sql
cat tables/pricing_scheme.sql >> full.sql
cat tables/skill_level.sql >> full.sql

cat tables/instructor.sql >> full.sql
cat tables/instructor_available_times.sql >> full.sql

cat tables/student.sql >> full.sql
cat tables/student_instruments.sql >> full.sql
cat tables/rentable_instrument.sql >> full.sql
cat tables/lease.sql >> full.sql

cat tables/booking.sql >> full.sql
cat tables/lesson.sql >> full.sql
cat tables/ensemble.sql >> full.sql
cat tables/instrument_lesson.sql >> full.sql
cat tables/enrollment.sql >> full.sql
