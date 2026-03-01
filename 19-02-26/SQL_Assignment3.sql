
---creating tables

create table routes (
    route_id int primary key,
    route_name varchar(100) not null,
    transport_type varchar(10) check (transport_type in ('bus','train')),
    is_active bit default 1
);

create table stops (
    stop_id int primary key,
    stop_name varchar(100) not null,
    city varchar(50) not null,
    lat decimal(9,6),
    long decimal(9,6)
);

create table route_stops (
    route_stop_id int primary key,
    route_id int not null,
    stop_id int not null,
    sequence_number int not null,
    distance_from_start decimal(5,2),
    constraint route_fk foreign key (route_id) references routes(route_id),
    constraint stop_fk foreign key (stop_id) references stops(stop_id),
    constraint uq_route_sequence unique (route_id, sequence_number)
);

create table vehicles (
    vehicle_id int primary key,
    vehicle_number varchar(20) unique not null,
    vehicle_type varchar(10) check (vehicle_type in ('bus','train')),
    capacity int not null,
    is_active bit default 1
);
 

create table passengers (
    passenger_id int primary key,
    name varchar(100) not null,
    email varchar(100) unique,
    phone varchar(15)
);

create table tickets (
    ticket_id int primary key,
    passenger_id int not null,
    issue_time datetime not null,
    expiry_time datetime not null,
    is_active bit default 1,
    constraint fk_ticket_passenger foreign key (passenger_id) references passengers(passenger_id),
    constraint chk_ticket_validity check (expiry_time > issue_time)
);


create table trips (
    trip_id int primary key,
    route_id int not null,
    vehicle_id int not null,
    start_time datetime not null,
    end_time datetime not null,
    current_status varchar(15) check (current_status in ('on-time','delayed','cancelled')),
	constraint fk_trip_route foreign key (route_id) references routes(route_id),
    constraint fk_trip_vehicle foreign key (vehicle_id) references vehicles(vehicle_id),
    constraint chk_trip_time check (end_time > start_time)
);

create table trip_status_log (
    log_id int primary key,
    trip_id int not null,
    status varchar(15) check (status in ('on-time','delayed','cancelled')),
    status_timestamp datetime not null,
    constraint fk_trip_log foreign key (trip_id) references trips(trip_id)
);

create table ticket_scan_log (
    scan_id int primary key,
    ticket_id int not null,
    trip_id int not null,
    stop_id int not null,
    scan_time datetime not null,
    validation_status varchar(15) check (validation_status in ('valid','expired','reused')),
    constraint fk_scan_ticket foreign key (ticket_id) references tickets(ticket_id),
    constraint fk_scan_trip foreign key (trip_id) references trips(trip_id),
    constraint fk_scan_stop foreign key (stop_id) references stops(stop_id)
);


---modifications

EXEC sp_rename 'stops.lat', 'latitude', 'COLUMN';
EXEC sp_rename 'stops.long', 'longitude', 'COLUMN';

create table drivers (
    driver_id int primary key,
    driver_name varchar(100) not null,
    license_number varchar(50) unique not null,
    phone varchar(15),
    experience_years int,
    is_active bit default 1
);

alter table trips
add driver_id int;

alter table trips
add constraint fk_trip_driver
foreign key (driver_id) references drivers(driver_id);

alter table tickets
add number_of_persons int not null default 1;

alter table tickets
add price decimal(8,2) not null default 0.00;

create table payments (
    payment_id int primary key,
    ticket_id int not null,
    payment_time datetime not null,
    amount decimal(8,2) not null,
    payment_method varchar(20) check (payment_method in ('cash','card','upi')),
    payment_status varchar(15) check (payment_status in ('pending','completed','failed')),
    
    constraint fk_payment_ticket foreign key (ticket_id) references tickets(ticket_id)
);

---inserting values

insert into routes values
(1, '9x Charminar-IDPL', 'Bus', 1),
(2, '10k KPHB-Secunderabad', 'Bus', 1),
(3, '9k Balanagar-Charminar', 'Bus', 1),
(4, '8r Risalabazar-Charminar', 'Bus', 1),
(5, '30l ApurupaC-Charminar', 'Train', 1),
(6, '10g Secunderabad-Sanathnagar', 'Train', 1);

insert into stops values
(101, 'Charminar', 'Hyderabad', 17.4399, 78.4983),
(102, 'Afzalgunj', 'Hyderabad', 17.4399, 78.4983),
(103, 'L.pool', 'Hyderabad', 17.4399, 78.4983),
(104, 'Moosapet', 'Hyderabad', 17.4399, 78.4983),
(105, 'Balanagar', 'Hyderabad', 17.4399, 78.4983),
(106, 'IDPL', 'Hyderabad', 17.4399, 78.4983),
(107, 'KPHB', 'Hyderabad', 17.4399, 78.4983),
(108, 'Ameerpet', 'Hyderabad', 17.4399, 78.4983),
(109, 'Secunderabad', 'Hyderabad', 17.4399, 78.4983),
(110, 'ABIDS', 'Hyderabad', 17.4399, 78.4983),
(111, 'Koti', 'Hyderabad', 17.4399, 78.4983),
(112, 'ApurupaC', 'Hyderabad', 17.4399, 78.4983),
(113, 'Risalabazar', 'Hyderabad', 17.4399, 78.4983),
(114, 'Bollarum', 'Hyderabad', 17.4399, 78.4983),
(115, 'JBS', 'Hyderabad', 17.4399, 78.4983),
(116, 'Nampally', 'Hyderabad', 17.4399, 78.4983),
(117, 'Jeedimetla', 'Hyderabad', 17.4399, 78.4983),
(118, 'Paradise', 'Hyderabad', 17.4399, 78.4983),
(119, 'Begumpet', 'Hyderabad', 17.4399, 78.4983),
(120, 'Erragada', 'Hyderabad', 17.4399, 78.4983),
(121, 'Sanathnagar', 'Hyderabad', 17.4399, 78.4983);

insert into route_stops values
(1, 1, 101, 1, 0),
(2, 1, 102, 2, 3),
(3, 1, 103, 3, 6),
(4, 1, 104, 4, 9),
(5, 1, 105, 5, 12),
(6, 1, 106, 6, 15),

(7, 2, 107, 1, 0),
(8, 2, 108, 2, 3),
(9, 2, 109, 3, 6),

(10, 3, 105, 1, 0),
(11, 3, 104, 2, 3),
(12, 3, 110, 3, 6),
(13, 3, 111, 4, 9),
(14, 3, 102, 5, 12),
(15, 3, 101, 6, 15),

(16, 4, 113, 1, 0),
(17, 4, 114, 2, 3),
(18, 4, 115, 3, 6),
(19, 4, 116, 4, 9),
(20, 4, 102, 5, 12),
(21, 4, 101, 6, 15),

(22, 5, 112, 1, 0),
(23, 5, 117, 2, 3),
(24, 5, 104, 3, 6),
(25, 5, 110, 4, 9),
(26, 5, 111, 5, 12),
(27, 5, 102, 6, 15),
(28, 5, 101, 7, 18),

(29, 6, 109, 1, 0),
(30, 6, 118, 2, 3),
(31, 6, 119, 3, 6),
(32, 6, 120, 4, 9),
(33, 6, 121, 5, 12);

insert into vehicles values
(201, 'TS08', 'Bus', 50, 1),
(202, 'TS09', 'Bus', 45, 1),
(203, 'TS10', 'Bus', 50, 1),
(204, 'TS11', 'Bus', 45, 1),
(205, 'TS12', 'Bus', 50, 1),
(206, 'TS13', 'Bus', 45, 1),
(301, 'Train01', 'Train', 800, 1),
(302, 'Train02', 'Train', 900, 1),
(303, 'Train03', 'Train', 1000, 1);

insert into passengers values
(1, 'Harati', 'harati@gmail.com', '9876543210'),
(2, 'Reneesh', 'reneesh@gmail.com', '9988776655'),
(3, 'Grishma', 'grishma@gmail.com', '9875664890'),
(4, 'Vignesh', 'vignesh@gmail.com', '6785432567'),
(5, 'Srinivas', 'srinivas@gmail.com', '8796655340');


insert into tickets values
(5001, 1, '2026-02-25 08:05', '2026-02-25 09:35', 1),
(5002, 2, '2026-02-25 11:05', '2026-02-25 12:35', 1),
(5003, 3, '2026-02-25 08:05', '2026-02-25 09:35', 1),
(5004, 4, '2026-02-25 11:05', '2026-02-25 12:35', 1),
(5005, 5, '2026-02-25 08:05', '2026-02-25 09:35', 1);


insert into trips values
(1001, 1, 201, '2026-02-25 08:00', '2026-02-25 09:00', 'On-Time'),
(1002, 2, 202, '2026-02-25 11:00', '2026-02-25 13:00', 'On-Time'),
(1003, 3, 201, '2026-02-25 08:00', '2026-02-25 09:00', 'On-Time'),
(1004, 4, 204, '2026-02-25 11:00', '2026-02-25 13:00', 'On-Time'),
(1005, 5, 301, '2026-02-25 08:00', '2026-02-25 09:00', 'On-Time'),
(1006, 6, 302, '2026-02-25 11:00', '2026-02-25 13:00', 'On-Time');

insert into ticket_scan_log values
(1, 5001, 1001, 101, '2026-02-25 08:10', 'Valid'),
(2, 5001, 1001, 103, '2026-02-25 08:14', 'Valid'),
(3, 5001, 1001, 105, '2026-02-25 09:40', 'Expired'), 
(4, 5003, 1005, 117, '2026-02-25 08:20', 'Valid'),
(5, 5003, 1005, 111, '2026-02-25 08:22', 'Valid'),  
(6, 5004, 1003, 105, '2026-02-25 11:15', 'Valid'),
(7, 5004, 1003, 104, '2026-02-25 12:14', 'Valid'),
(8, 5002, 1006, 105, '2026-02-25 13:01', 'Expired');

insert into trip_status_log values
(1, 1001, 'on-time',  '2026-02-25 08:00'),
(2, 1001, 'delayed',  '2026-02-25 08:30'),
(3, 1002, 'on-time',  '2026-02-25 11:00'),
(4, 1003, 'on-time',   '2026-02-25 08:00'),
(5, 1003, 'cancelled', '2026-02-25 08:20'),
(6, 1004, 'on-time',  '2026-02-25 11:00'),
(7, 1004, 'delayed',  '2026-02-25 11:45'),
(8,1006, 'delayed',  '2026-02-25 12:00');

/*
SQL Questions

Find routes where stop sequence numbers are missing or repeated. 
Show vehicles that were assigned to more than one route at the same time. 
Find tickets that were used after their 90-minute validity period expired. 
Show trips that were first marked On-Time but later changed to Delayed. 
Find tickets that were scanned more than once within 5 minutes.
*/

select route_id, sequence_number, count(*) as total
from route_stops 
group by route_id, sequence_number
having count(*)>1;

select t1.vehicle_id,t1.trip_id as trip1, t2.trip_id as trip2
from trips t1
join trips t2
on t1.vehicle_id = t2.vehicle_id
where t1.trip_id != t2.trip_id and t1.trip_id < t2.trip_id;

select ts.ticket_id 
from tickets as t
join ticket_scan_log as ts
on t.ticket_id = ts.ticket_id
where ts.scan_time > t.expiry_time;

select trip_id
from trip_status_log as t1
where t1.status = 'delayed'
and exists (
select trip_id
from trip_status_log t2
where t2.trip_id = t1.trip_id
and t2.status = 'on-time');

select s1.ticket_id
from ticket_scan_log s1
join ticket_scan_log s2
on s1.ticket_id = s2.ticket_id
and s1.scan_id < s2.scan_id
and datediff(minute, s1.scan_time, s2.scan_time) <= 5;


