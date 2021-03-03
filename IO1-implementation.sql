create or replace package pridej_sluzbu
    authid definer
as
    SERVICE_TYPE_LIMIT constant integer := 5;
    SERVICE_USAGE_LIMIT constant integer := 5;

    procedure add_service(student_key integer, employee_key integer, order_date date, execution_date date,
                          service_type integer);
    function service_count(service_type integer) return integer;
    function times_used(student_key integer) return integer;
end pridej_sluzbu;
/

drop sequence service_id;
create sequence service_id;

create or replace package body pridej_sluzbu as
    procedure add_service(student_key integer, employee_key integer, order_date date, execution_date date,
                          service_type integer) as
        service_type_limit_exceeded exception;
        usage_limit_exceeded exception;
    begin
        if service_count(service_type) >= SERVICE_TYPE_LIMIT then
            raise service_type_limit_exceeded;
        end if;
        if times_used(student_key) >= SERVICE_USAGE_LIMIT then
            raise usage_limit_exceeded;
        end if;

        INSERT INTO service (service_key, student_student_key, employee_employee_key, "date", execution_date,
                             service_type_key)
        values (service_id.nextval, student_key, employee_key, order_date, execution_date, service_type);

        dbms_output.put_line('Sluzba byla pridana.');
    exception
        when service_type_limit_exceeded then
            raise_application_error(-20001, 'Can not use service with service_type_key ' || service_type || ' more than ' ||
                                            SERVICE_TYPE_LIMIT || ' times');
        when usage_limit_exceeded then
            raise_application_error(-20002,
                                    'Student with student_key ' || student_key || ' can not use services more than ' ||
                                    SERVICE_USAGE_LIMIT || ' times');
    end;

    function service_count(service_type integer) return integer as
        s_count integer;
    begin
        select count(1) into s_count from service where service_type_key = service_type;
        return s_count;
    end;

    function times_used(student_key integer) return integer as
        used_service integer;
    begin
        select count(1) into used_service from service where student_student_key = student_key;
        return used_service;
    end;
end pridej_sluzbu;
/

begin
        pridej_sluzbu.add_service(1, 1, date '2020-01-01', date '2020-01-01', 1);
end;
/
