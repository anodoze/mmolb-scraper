--
-- PostgreSQL database dump
--

\restrict bgfVe3OyOWofkc9Nt4ypFCyGft2oSRihRB4rbABwstdTaJFkgROowpXwlqAwMxL

-- Dumped from database version 17.6
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: refresh_materialized_view(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.refresh_materialized_view(view_name text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  EXECUTE 'REFRESH MATERIALIZED VIEW CONCURRENTLY ' || quote_ident(view_name);
END;
$$;


ALTER FUNCTION public.refresh_materialized_view(view_name text) OWNER TO postgres;

--
-- Name: rls_auto_enable(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.rls_auto_enable() RETURNS event_trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pg_catalog'
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN
    SELECT *
    FROM pg_event_trigger_ddl_commands()
    WHERE command_tag IN ('CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO')
      AND object_type IN ('table','partitioned table')
  LOOP
     IF cmd.schema_name IS NOT NULL AND cmd.schema_name IN ('public') AND cmd.schema_name NOT IN ('pg_catalog','information_schema') AND cmd.schema_name NOT LIKE 'pg_toast%' AND cmd.schema_name NOT LIKE 'pg_temp%' THEN
      BEGIN
        EXECUTE format('alter table if exists %s enable row level security', cmd.object_identity);
        RAISE LOG 'rls_auto_enable: enabled RLS on %', cmd.object_identity;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE LOG 'rls_auto_enable: failed to enable RLS on %', cmd.object_identity;
      END;
     ELSE
        RAISE LOG 'rls_auto_enable: skip % (either system schema or not in enforced list: %.)', cmd.object_identity, cmd.schema_name;
     END IF;
  END LOOP;
END;
$$;


ALTER FUNCTION public.rls_auto_enable() OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_
        -- Filter by action early - only get subscriptions interested in this action
        -- action_filter column can be: '*' (all), 'INSERT', 'UPDATE', or 'DELETE'
        and (subs.action_filter = '*' or subs.action_filter = action::text);

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
declare
  res jsonb;
begin
  if type_::text = 'bytea' then
    return to_jsonb(val);
  end if;
  execute format('select to_jsonb(%L::'|| type_::text || ')', val) into res;
  return res;
end
$$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS TABLE(wal jsonb, is_rls_enabled boolean, subscription_ids uuid[], errors text[], slot_changes_count bigint)
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
  WITH pub AS (
    SELECT
      concat_ws(
        ',',
        CASE WHEN bool_or(pubinsert) THEN 'insert' ELSE NULL END,
        CASE WHEN bool_or(pubupdate) THEN 'update' ELSE NULL END,
        CASE WHEN bool_or(pubdelete) THEN 'delete' ELSE NULL END
      ) AS w2j_actions,
      coalesce(
        string_agg(
          realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
          ','
        ) filter (WHERE ppt.tablename IS NOT NULL AND ppt.tablename NOT LIKE '% %'),
        ''
      ) AS w2j_add_tables
    FROM pg_publication pp
    LEFT JOIN pg_publication_tables ppt ON pp.pubname = ppt.pubname
    WHERE pp.pubname = publication
    GROUP BY pp.pubname
    LIMIT 1
  ),
  -- MATERIALIZED ensures pg_logical_slot_get_changes is called exactly once
  w2j AS MATERIALIZED (
    SELECT x.*, pub.w2j_add_tables
    FROM pub,
         pg_logical_slot_get_changes(
           slot_name, null, max_changes,
           'include-pk', 'true',
           'include-transaction', 'false',
           'include-timestamp', 'true',
           'include-type-oids', 'true',
           'format-version', '2',
           'actions', pub.w2j_actions,
           'add-tables', pub.w2j_add_tables
         ) x
  ),
  -- Count raw slot entries before apply_rls/subscription filter
  slot_count AS (
    SELECT count(*)::bigint AS cnt
    FROM w2j
    WHERE w2j.w2j_add_tables <> ''
  ),
  -- Apply RLS and filter as before
  rls_filtered AS (
    SELECT xyz.wal, xyz.is_rls_enabled, xyz.subscription_ids, xyz.errors
    FROM w2j,
         realtime.apply_rls(
           wal := w2j.data::jsonb,
           max_record_bytes := max_record_bytes
         ) xyz(wal, is_rls_enabled, subscription_ids, errors)
    WHERE w2j.w2j_add_tables <> ''
      AND xyz.subscription_ids[1] IS NOT NULL
  )
  -- Real rows with slot count attached
  SELECT rf.wal, rf.is_rls_enabled, rf.subscription_ids, rf.errors, sc.cnt
  FROM rls_filtered rf, slot_count sc

  UNION ALL

  -- Sentinel row: always returned when no real rows exist so Elixir can
  -- always read slot_changes_count. Identified by wal IS NULL.
  SELECT null, null, null, null, sc.cnt
  FROM slot_count sc
  WHERE NOT EXISTS (SELECT 1 FROM rls_filtered)
$$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: allow_any_operation(text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_any_operation(expected_operations text[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT CASE
      WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
      ELSE raw_operation
    END AS current_operation
    FROM current_operation
  )
  SELECT EXISTS (
    SELECT 1
    FROM normalized n
    CROSS JOIN LATERAL unnest(expected_operations) AS expected_operation
    WHERE expected_operation IS NOT NULL
      AND expected_operation <> ''
      AND n.current_operation = CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END
  );
$$;


ALTER FUNCTION storage.allow_any_operation(expected_operations text[]) OWNER TO supabase_storage_admin;

--
-- Name: allow_only_operation(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_only_operation(expected_operation text) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT
      CASE
        WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
        ELSE raw_operation
      END AS current_operation,
      CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END AS requested_operation
    FROM current_operation
  )
  SELECT CASE
    WHEN requested_operation IS NULL OR requested_operation = '' THEN FALSE
    ELSE COALESCE(current_operation = requested_operation, FALSE)
  END
  FROM normalized;
$$;


ALTER FUNCTION storage.allow_only_operation(expected_operation text) OWNER TO supabase_storage_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


ALTER FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;

    -- Configuration
    v_is_asc BOOLEAN;
    v_prefix TEXT;
    v_start TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_is_asc := lower(coalesce(sort_order, 'asc')) = 'asc';
    v_prefix := coalesce(prefix_param, '');
    v_start := CASE WHEN coalesce(next_token, '') <> '' THEN next_token ELSE coalesce(start_after, '') END;
    v_file_batch_size := LEAST(GREATEST(max_keys * 2, 100), 1000);

    -- Calculate upper bound for prefix filtering (bytewise, using COLLATE "C")
    IF v_prefix = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix, 1) = delimiter_param THEN
        v_upper_bound := left(v_prefix, -1) || chr(ascii(delimiter_param) + 1);
    ELSE
        v_upper_bound := left(v_prefix, -1) || chr(ascii(right(v_prefix, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'AND o.name COLLATE "C" < $3 ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'AND o.name COLLATE "C" >= $3 ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- ========================================================================
    -- SEEK INITIALIZATION: Determine starting position
    -- ========================================================================
    IF v_start = '' THEN
        IF v_is_asc THEN
            v_next_seek := v_prefix;
        ELSE
            -- DESC without cursor: find the last item in range
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;

            IF v_next_seek IS NOT NULL THEN
                v_next_seek := v_next_seek || delimiter_param;
            ELSE
                RETURN;
            END IF;
        END IF;
    ELSE
        -- Cursor provided: determine if it refers to a folder or leaf
        IF EXISTS (
            SELECT 1 FROM storage.objects o
            WHERE o.bucket_id = _bucket_id
              AND o.name COLLATE "C" LIKE v_start || delimiter_param || '%'
            LIMIT 1
        ) THEN
            -- Cursor refers to a folder
            IF v_is_asc THEN
                v_next_seek := v_start || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_start || delimiter_param;
            END IF;
        ELSE
            -- Cursor refers to a leaf object
            IF v_is_asc THEN
                v_next_seek := v_start || delimiter_param;
            ELSE
                v_next_seek := v_start;
            END IF;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= max_keys;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(v_peek_name, v_prefix, delimiter_param);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Emit and skip to next folder (no heap access needed)
            name := rtrim(v_common_prefix, delimiter_param);
            id := NULL;
            updated_at := NULL;
            created_at := NULL;
            last_accessed_at := NULL;
            metadata := NULL;
            RETURN NEXT;
            v_count := v_count + 1;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := left(v_common_prefix, -1) || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_common_prefix;
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query USING _bucket_id, v_next_seek,
                CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix) ELSE v_prefix END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(v_current.name, v_prefix, delimiter_param);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := v_current.name;
                    EXIT;
                END IF;

                -- Emit file
                name := v_current.name;
                id := v_current.id;
                updated_at := v_current.updated_at;
                created_at := v_current.created_at;
                last_accessed_at := v_current.last_accessed_at;
                metadata := v_current.metadata;
                RETURN NEXT;
                v_count := v_count + 1;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := v_current.name || delimiter_param;
                ELSE
                    v_next_seek := v_current.name;
                END IF;

                EXIT WHEN v_count >= max_keys;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text, sort_order text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.protect_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if storage.allow_delete_query is set to 'true'
    IF COALESCE(current_setting('storage.allow_delete_query', true), 'false') != 'true' THEN
        RAISE EXCEPTION 'Direct deletion from storage tables is not allowed. Use the Storage API instead.'
            USING HINT = 'This prevents accidental data loss from orphaned objects.',
                  ERRCODE = '42501';
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.protect_delete() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;
    v_delimiter CONSTANT TEXT := '/';

    -- Configuration
    v_limit INT;
    v_prefix TEXT;
    v_prefix_lower TEXT;
    v_is_asc BOOLEAN;
    v_order_by TEXT;
    v_sort_order TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;
    v_skipped INT := 0;
BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_limit := LEAST(coalesce(limits, 100), 1500);
    v_prefix := coalesce(prefix, '') || coalesce(search, '');
    v_prefix_lower := lower(v_prefix);
    v_is_asc := lower(coalesce(sortorder, 'asc')) = 'asc';
    v_file_batch_size := LEAST(GREATEST(v_limit * 2, 100), 1000);

    -- Validate sort column
    CASE lower(coalesce(sortcolumn, 'name'))
        WHEN 'name' THEN v_order_by := 'name';
        WHEN 'updated_at' THEN v_order_by := 'updated_at';
        WHEN 'created_at' THEN v_order_by := 'created_at';
        WHEN 'last_accessed_at' THEN v_order_by := 'last_accessed_at';
        ELSE v_order_by := 'name';
    END CASE;

    v_sort_order := CASE WHEN v_is_asc THEN 'asc' ELSE 'desc' END;

    -- ========================================================================
    -- NON-NAME SORTING: Use path_tokens approach (unchanged)
    -- ========================================================================
    IF v_order_by != 'name' THEN
        RETURN QUERY EXECUTE format(
            $sql$
            WITH folders AS (
                SELECT path_tokens[$1] AS folder
                FROM storage.objects
                WHERE objects.name ILIKE $2 || '%%'
                  AND bucket_id = $3
                  AND array_length(objects.path_tokens, 1) <> $1
                GROUP BY folder
                ORDER BY folder %s
            )
            (SELECT folder AS "name",
                   NULL::uuid AS id,
                   NULL::timestamptz AS updated_at,
                   NULL::timestamptz AS created_at,
                   NULL::timestamptz AS last_accessed_at,
                   NULL::jsonb AS metadata FROM folders)
            UNION ALL
            (SELECT path_tokens[$1] AS "name",
                   id, updated_at, created_at, last_accessed_at, metadata
             FROM storage.objects
             WHERE objects.name ILIKE $2 || '%%'
               AND bucket_id = $3
               AND array_length(objects.path_tokens, 1) = $1
             ORDER BY %I %s)
            LIMIT $4 OFFSET $5
            $sql$, v_sort_order, v_order_by, v_sort_order
        ) USING levels, v_prefix, bucketname, v_limit, offsets;
        RETURN;
    END IF;

    -- ========================================================================
    -- NAME SORTING: Hybrid skip-scan with batch optimization
    -- ========================================================================

    -- Calculate upper bound for prefix filtering
    IF v_prefix_lower = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix_lower, 1) = v_delimiter THEN
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(v_delimiter) + 1);
    ELSE
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(right(v_prefix_lower, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'AND lower(o.name) COLLATE "C" < $3 ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'AND lower(o.name) COLLATE "C" >= $3 ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- Initialize seek position
    IF v_is_asc THEN
        v_next_seek := v_prefix_lower;
    ELSE
        -- DESC: find the last item in range first (static SQL)
        IF v_upper_bound IS NOT NULL THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower AND lower(o.name) COLLATE "C" < v_upper_bound
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSIF v_prefix_lower <> '' THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSE
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        END IF;

        IF v_peek_name IS NOT NULL THEN
            v_next_seek := lower(v_peek_name) || v_delimiter;
        ELSE
            RETURN;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= v_limit;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek AND lower(o.name) COLLATE "C" < v_upper_bound
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix_lower <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(lower(v_peek_name), v_prefix_lower, v_delimiter);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Handle offset, emit if needed, skip to next folder
            IF v_skipped < offsets THEN
                v_skipped := v_skipped + 1;
            ELSE
                name := split_part(rtrim(storage.get_common_prefix(v_peek_name, v_prefix, v_delimiter), v_delimiter), v_delimiter, levels);
                id := NULL;
                updated_at := NULL;
                created_at := NULL;
                last_accessed_at := NULL;
                metadata := NULL;
                RETURN NEXT;
                v_count := v_count + 1;
            END IF;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := lower(left(v_common_prefix, -1)) || chr(ascii(v_delimiter) + 1);
            ELSE
                v_next_seek := lower(v_common_prefix);
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix_lower is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query
                USING bucketname, v_next_seek,
                    CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix_lower) ELSE v_prefix_lower END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(lower(v_current.name), v_prefix_lower, v_delimiter);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := lower(v_current.name);
                    EXIT;
                END IF;

                -- Handle offset skipping
                IF v_skipped < offsets THEN
                    v_skipped := v_skipped + 1;
                ELSE
                    -- Emit file
                    name := split_part(v_current.name, v_delimiter, levels);
                    id := v_current.id;
                    updated_at := v_current.updated_at;
                    created_at := v_current.created_at;
                    last_accessed_at := v_current.last_accessed_at;
                    metadata := v_current.metadata;
                    RETURN NEXT;
                    v_count := v_count + 1;
                END IF;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := lower(v_current.name) || v_delimiter;
                ELSE
                    v_next_seek := lower(v_current.name);
                END IF;

                EXIT WHEN v_count >= v_limit;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_by_timestamp(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_cursor_op text;
    v_query text;
    v_prefix text;
BEGIN
    v_prefix := coalesce(p_prefix, '');

    IF p_sort_order = 'asc' THEN
        v_cursor_op := '>';
    ELSE
        v_cursor_op := '<';
    END IF;

    v_query := format($sql$
        WITH raw_objects AS (
            SELECT
                o.name AS obj_name,
                o.id AS obj_id,
                o.updated_at AS obj_updated_at,
                o.created_at AS obj_created_at,
                o.last_accessed_at AS obj_last_accessed_at,
                o.metadata AS obj_metadata,
                storage.get_common_prefix(o.name, $1, '/') AS common_prefix
            FROM storage.objects o
            WHERE o.bucket_id = $2
              AND o.name COLLATE "C" LIKE $1 || '%%'
        ),
        -- Aggregate common prefixes (folders)
        -- Both created_at and updated_at use MIN(obj_created_at) to match the old prefixes table behavior
        aggregated_prefixes AS (
            SELECT
                rtrim(common_prefix, '/') AS name,
                NULL::uuid AS id,
                MIN(obj_created_at) AS updated_at,
                MIN(obj_created_at) AS created_at,
                NULL::timestamptz AS last_accessed_at,
                NULL::jsonb AS metadata,
                TRUE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NOT NULL
            GROUP BY common_prefix
        ),
        leaf_objects AS (
            SELECT
                obj_name AS name,
                obj_id AS id,
                obj_updated_at AS updated_at,
                obj_created_at AS created_at,
                obj_last_accessed_at AS last_accessed_at,
                obj_metadata AS metadata,
                FALSE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NULL
        ),
        combined AS (
            SELECT * FROM aggregated_prefixes
            UNION ALL
            SELECT * FROM leaf_objects
        ),
        filtered AS (
            SELECT *
            FROM combined
            WHERE (
                $5 = ''
                OR ROW(
                    date_trunc('milliseconds', %I),
                    name COLLATE "C"
                ) %s ROW(
                    COALESCE(NULLIF($6, '')::timestamptz, 'epoch'::timestamptz),
                    $5
                )
            )
        )
        SELECT
            split_part(name, '/', $3) AS key,
            name,
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
        FROM filtered
        ORDER BY
            COALESCE(date_trunc('milliseconds', %I), 'epoch'::timestamptz) %s,
            name COLLATE "C" %s
        LIMIT $4
    $sql$,
        p_sort_column,
        v_cursor_op,
        p_sort_column,
        p_sort_order,
        p_sort_order
    );

    RETURN QUERY EXECUTE v_query
    USING v_prefix, p_bucket_id, p_level, p_limit, p_start_after, p_sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_sort_col text;
    v_sort_ord text;
    v_limit int;
BEGIN
    -- Cap limit to maximum of 1500 records
    v_limit := LEAST(coalesce(limits, 100), 1500);

    -- Validate and normalize sort_order
    v_sort_ord := lower(coalesce(sort_order, 'asc'));
    IF v_sort_ord NOT IN ('asc', 'desc') THEN
        v_sort_ord := 'asc';
    END IF;

    -- Validate and normalize sort_column
    v_sort_col := lower(coalesce(sort_column, 'name'));
    IF v_sort_col NOT IN ('name', 'updated_at', 'created_at') THEN
        v_sort_col := 'name';
    END IF;

    -- Route to appropriate implementation
    IF v_sort_col = 'name' THEN
        -- Use list_objects_with_delimiter for name sorting (most efficient: O(k * log n))
        RETURN QUERY
        SELECT
            split_part(l.name, '/', levels) AS key,
            l.name AS name,
            l.id,
            l.updated_at,
            l.created_at,
            l.last_accessed_at,
            l.metadata
        FROM storage.list_objects_with_delimiter(
            bucket_name,
            coalesce(prefix, ''),
            '/',
            v_limit,
            start_after,
            '',
            v_sort_ord
        ) l;
    ELSE
        -- Use aggregation approach for timestamp sorting
        -- Not efficient for large datasets but supports correct pagination
        RETURN QUERY SELECT * FROM storage.search_by_timestamp(
            prefix, bucket_name, v_limit, levels, start_after,
            v_sort_ord, v_sort_col, sort_column_after
        );
    END IF;
END;
$$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.custom_oauth_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_type text NOT NULL,
    identifier text NOT NULL,
    name text NOT NULL,
    client_id text NOT NULL,
    client_secret text NOT NULL,
    acceptable_client_ids text[] DEFAULT '{}'::text[] NOT NULL,
    scopes text[] DEFAULT '{}'::text[] NOT NULL,
    pkce_enabled boolean DEFAULT true NOT NULL,
    attribute_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    authorization_params jsonb DEFAULT '{}'::jsonb NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    email_optional boolean DEFAULT false NOT NULL,
    issuer text,
    discovery_url text,
    skip_nonce_check boolean DEFAULT false NOT NULL,
    cached_discovery jsonb,
    discovery_cached_at timestamp with time zone,
    authorization_url text,
    token_url text,
    userinfo_url text,
    jwks_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT custom_oauth_providers_authorization_url_https CHECK (((authorization_url IS NULL) OR (authorization_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_authorization_url_length CHECK (((authorization_url IS NULL) OR (char_length(authorization_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_client_id_length CHECK (((char_length(client_id) >= 1) AND (char_length(client_id) <= 512))),
    CONSTRAINT custom_oauth_providers_discovery_url_length CHECK (((discovery_url IS NULL) OR (char_length(discovery_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_identifier_format CHECK ((identifier ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::text)),
    CONSTRAINT custom_oauth_providers_issuer_length CHECK (((issuer IS NULL) OR ((char_length(issuer) >= 1) AND (char_length(issuer) <= 2048)))),
    CONSTRAINT custom_oauth_providers_jwks_uri_https CHECK (((jwks_uri IS NULL) OR (jwks_uri ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_jwks_uri_length CHECK (((jwks_uri IS NULL) OR (char_length(jwks_uri) <= 2048))),
    CONSTRAINT custom_oauth_providers_name_length CHECK (((char_length(name) >= 1) AND (char_length(name) <= 100))),
    CONSTRAINT custom_oauth_providers_oauth2_requires_endpoints CHECK (((provider_type <> 'oauth2'::text) OR ((authorization_url IS NOT NULL) AND (token_url IS NOT NULL) AND (userinfo_url IS NOT NULL)))),
    CONSTRAINT custom_oauth_providers_oidc_discovery_url_https CHECK (((provider_type <> 'oidc'::text) OR (discovery_url IS NULL) OR (discovery_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_issuer_https CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NULL) OR (issuer ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_requires_issuer CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NOT NULL))),
    CONSTRAINT custom_oauth_providers_provider_type_check CHECK ((provider_type = ANY (ARRAY['oauth2'::text, 'oidc'::text]))),
    CONSTRAINT custom_oauth_providers_token_url_https CHECK (((token_url IS NULL) OR (token_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_token_url_length CHECK (((token_url IS NULL) OR (char_length(token_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_userinfo_url_https CHECK (((userinfo_url IS NULL) OR (userinfo_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_userinfo_url_length CHECK (((userinfo_url IS NULL) OR (char_length(userinfo_url) <= 2048)))
);


ALTER TABLE auth.custom_oauth_providers OWNER TO supabase_auth_admin;

--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: webauthn_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    challenge_type text NOT NULL,
    session_data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    CONSTRAINT webauthn_challenges_challenge_type_check CHECK ((challenge_type = ANY (ARRAY['signup'::text, 'registration'::text, 'authentication'::text])))
);


ALTER TABLE auth.webauthn_challenges OWNER TO supabase_auth_admin;

--
-- Name: webauthn_credentials; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_credentials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    credential_id bytea NOT NULL,
    public_key bytea NOT NULL,
    attestation_type text DEFAULT ''::text NOT NULL,
    aaguid uuid,
    sign_count bigint DEFAULT 0 NOT NULL,
    transports jsonb DEFAULT '[]'::jsonb NOT NULL,
    backup_eligible boolean DEFAULT false NOT NULL,
    backed_up boolean DEFAULT false NOT NULL,
    friendly_name text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE auth.webauthn_credentials OWNER TO supabase_auth_admin;

--
-- Name: leagues; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leagues (
    id text NOT NULL,
    name text NOT NULL,
    color text,
    emoji text,
    league_type text
);


ALTER TABLE public.leagues OWNER TO postgres;

--
-- Name: player_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_attributes (
    player_id text NOT NULL,
    discipline double precision,
    vision double precision,
    intimidation double precision,
    muscle double precision,
    contact double precision,
    cunning double precision,
    selflessness double precision,
    determination double precision,
    wisdom double precision,
    insight double precision,
    aiming double precision,
    lift double precision,
    control double precision,
    velocity double precision,
    rotation double precision,
    stuff double precision,
    deception double precision,
    intuition double precision,
    persuasion double precision,
    presence double precision,
    defiance double precision,
    accuracy double precision,
    stamina double precision,
    guts double precision,
    performance double precision,
    speed double precision,
    greed double precision,
    stealth double precision,
    arm double precision,
    dexterity double precision,
    reaction double precision,
    acrobatics double precision,
    agility double precision,
    patience double precision,
    awareness double precision,
    composure double precision,
    luck double precision
);


ALTER TABLE public.player_attributes OWNER TO postgres;

--
-- Name: players; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players (
    id text NOT NULL,
    team_id text,
    first_name text,
    last_name text,
    suffix text,
    number integer,
    "position" text,
    position_type text,
    level integer,
    last_updated timestamp with time zone,
    slot text
);


ALTER TABLE public.players OWNER TO postgres;

--
-- Name: teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teams (
    id text NOT NULL,
    league_id text,
    name text NOT NULL,
    location text,
    emoji text,
    color text,
    wins integer,
    losses integer,
    rundiff integer,
    last_updated timestamp with time zone
);


ALTER TABLE public.teams OWNER TO postgres;

--
-- Name: mv_attribute_leaderboard; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW public.mv_attribute_leaderboard AS
 WITH unpivoted AS (
         SELECT pa.player_id,
            p.first_name,
            p.last_name,
            p.suffix,
            p."position",
            t.name AS team_name,
            t.location AS team_location,
            t.id AS team_id,
            t.emoji AS team_emoji,
            a.attr_name,
            a.attr_value
           FROM (((public.player_attributes pa
             JOIN public.players p ON ((pa.player_id = p.id)))
             JOIN public.teams t ON ((p.team_id = t.id)))
             CROSS JOIN LATERAL ( VALUES ('Discipline'::text,pa.discipline), ('Vision'::text,pa.vision), ('Intimidation'::text,pa.intimidation), ('Muscle'::text,pa.muscle), ('Contact'::text,pa.contact), ('Cunning'::text,pa.cunning), ('Selflessness'::text,pa.selflessness), ('Determination'::text,pa.determination), ('Wisdom'::text,pa.wisdom), ('Insight'::text,pa.insight), ('Aiming'::text,pa.aiming), ('Lift'::text,pa.lift), ('Control'::text,pa.control), ('Velocity'::text,pa.velocity), ('Rotation'::text,pa.rotation), ('Stuff'::text,pa.stuff), ('Deception'::text,pa.deception), ('Intuition'::text,pa.intuition), ('Persuasion'::text,pa.persuasion), ('Presence'::text,pa.presence), ('Defiance'::text,pa.defiance), ('Accuracy'::text,pa.accuracy), ('Stamina'::text,pa.stamina), ('Guts'::text,pa.guts), ('Performance'::text,pa.performance), ('Speed'::text,pa.speed), ('Greed'::text,pa.greed), ('Stealth'::text,pa.stealth), ('Arm'::text,pa.arm), ('Dexterity'::text,pa.dexterity), ('Reaction'::text,pa.reaction), ('Acrobatics'::text,pa.acrobatics), ('Agility'::text,pa.agility), ('Patience'::text,pa.patience), ('Awareness'::text,pa.awareness), ('Composure'::text,pa.composure), ('Luck'::text,pa.luck)) a(attr_name, attr_value))
        ), ranked AS (
         SELECT unpivoted.player_id,
            unpivoted.first_name,
            unpivoted.last_name,
            unpivoted.suffix,
            unpivoted."position",
            unpivoted.team_name,
            unpivoted.team_location,
            unpivoted.team_id,
            unpivoted.team_emoji,
            unpivoted.attr_name,
            unpivoted.attr_value,
            row_number() OVER (PARTITION BY unpivoted.attr_name ORDER BY unpivoted.attr_value DESC NULLS LAST) AS rank_overall
           FROM unpivoted
        )
 SELECT player_id,
    first_name,
    last_name,
    suffix,
    "position",
    team_name,
    team_location,
    team_id,
    team_emoji,
    attr_name,
    attr_value,
    rank_overall
   FROM ranked
  WHERE (rank_overall <= 10)
  WITH NO DATA;


ALTER MATERIALIZED VIEW public.mv_attribute_leaderboard OWNER TO postgres;

--
-- Name: mv_games_played; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW public.mv_games_played AS
 SELECT l.league_type,
    LEAST(max((t.wins + t.losses)), 120) AS games_played
   FROM (public.teams t
     JOIN public.leagues l ON ((t.league_id = l.id)))
  GROUP BY l.league_type
  WITH NO DATA;


ALTER MATERIALIZED VIEW public.mv_games_played OWNER TO postgres;

--
-- Name: player_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_stats (
    player_id text NOT NULL,
    plate_appearances integer,
    at_bats integer,
    runs integer,
    singles integer,
    doubles integer,
    triples integer,
    home_runs integer,
    runs_batted_in integer,
    walked integer,
    struck_out integer,
    hit_by_pitch integer,
    stolen_bases integer,
    caught_stealing integer,
    left_on_base integer,
    sac_flies integer,
    reached_on_error integer,
    grounded_into_double_play integer,
    hits double precision GENERATED ALWAYS AS (
CASE
    WHEN (at_bats > 0) THEN ((((singles + doubles) + triples) + home_runs))::double precision
    ELSE NULL::double precision
END) STORED,
    ba double precision GENERATED ALWAYS AS (
CASE
    WHEN (at_bats > 0) THEN (((((singles + doubles) + triples) + home_runs))::double precision / (at_bats)::double precision)
    ELSE NULL::double precision
END) STORED,
    obp double precision GENERATED ALWAYS AS (
CASE
    WHEN ((((at_bats + walked) + hit_by_pitch) + sac_flies) > 0) THEN (((((((singles + doubles) + triples) + home_runs) + walked) + hit_by_pitch))::double precision / ((((at_bats + walked) + hit_by_pitch) + sac_flies))::double precision)
    ELSE NULL::double precision
END) STORED,
    slg double precision GENERATED ALWAYS AS (
CASE
    WHEN (at_bats > 0) THEN (((((singles + (2 * doubles)) + (3 * triples)) + (4 * home_runs)))::double precision / (at_bats)::double precision)
    ELSE NULL::double precision
END) STORED,
    ops double precision GENERATED ALWAYS AS (
CASE
    WHEN ((at_bats > 0) AND ((((at_bats + walked) + hit_by_pitch) + sac_flies) > 0)) THEN ((((((((singles + doubles) + triples) + home_runs) + walked) + hit_by_pitch))::double precision / ((((at_bats + walked) + hit_by_pitch) + sac_flies))::double precision) + (((((singles + (2 * doubles)) + (3 * triples)) + (4 * home_runs)))::double precision / (at_bats)::double precision))
    ELSE NULL::double precision
END) STORED,
    babip double precision GENERATED ALWAYS AS (
CASE
    WHEN ((((at_bats - struck_out) - home_runs) + sac_flies) > 0) THEN ((((singles + doubles) + triples))::double precision / ((((at_bats - struck_out) - home_runs) + sac_flies))::double precision)
    ELSE NULL::double precision
END) STORED,
    putouts integer,
    assists integer,
    errors integer,
    double_plays integer,
    force_outs integer,
    runners_caught_stealing integer,
    allowed_stolen_bases integer,
    rcs_pct double precision GENERATED ALWAYS AS (
CASE
    WHEN ((runners_caught_stealing + allowed_stolen_bases) > 0) THEN ((runners_caught_stealing)::double precision / ((runners_caught_stealing + allowed_stolen_bases))::double precision)
    ELSE NULL::double precision
END) STORED,
    appearances integer,
    starts integer,
    wins integer,
    losses integer,
    saves integer,
    holds integer,
    outs integer,
    batters_faced integer,
    hits_allowed integer,
    home_runs_allowed integer,
    earned_runs integer,
    walks integer,
    strikeouts integer,
    pitches_thrown integer,
    complete_games integer,
    shutouts integer,
    no_hitters integer,
    quality_starts integer,
    hit_batters integer,
    mound_visits integer,
    inherited_runners integer,
    inherited_runs_allowed integer,
    games_finished integer,
    innings_pitched double precision GENERATED ALWAYS AS (
CASE
    WHEN (outs > 0) THEN ((outs)::double precision / (3)::double precision)
    ELSE NULL::double precision
END) STORED,
    era double precision GENERATED ALWAYS AS (
CASE
    WHEN (outs > 0) THEN (((earned_runs)::double precision / (outs)::double precision) * (27)::double precision)
    ELSE NULL::double precision
END) STORED,
    whip double precision GENERATED ALWAYS AS (
CASE
    WHEN (outs > 0) THEN (((walks + hits_allowed))::double precision / ((outs)::double precision / (3)::double precision))
    ELSE NULL::double precision
END) STORED,
    k9 double precision GENERATED ALWAYS AS (
CASE
    WHEN (outs > 0) THEN (((strikeouts)::double precision / (outs)::double precision) * (27)::double precision)
    ELSE NULL::double precision
END) STORED,
    bb9 double precision GENERATED ALWAYS AS (
CASE
    WHEN (outs > 0) THEN (((walks)::double precision / (outs)::double precision) * (27)::double precision)
    ELSE NULL::double precision
END) STORED,
    h9 double precision GENERATED ALWAYS AS (
CASE
    WHEN (outs > 0) THEN (((hits_allowed)::double precision / (outs)::double precision) * (27)::double precision)
    ELSE NULL::double precision
END) STORED,
    hr9 double precision GENERATED ALWAYS AS (
CASE
    WHEN (outs > 0) THEN (((home_runs_allowed)::double precision / (outs)::double precision) * (27)::double precision)
    ELSE NULL::double precision
END) STORED,
    last_updated timestamp with time zone
);


ALTER TABLE public.player_stats OWNER TO postgres;

--
-- Name: mv_batting_leaderboard; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW public.mv_batting_leaderboard AS
 WITH enriched AS (
         SELECT ps.player_id,
            p.first_name,
            p.last_name,
            p."position",
            p.suffix,
            t.name AS team_name,
            t.id AS team_id,
            t.location AS team_location,
            t.emoji AS team_emoji,
            l.id AS league_id,
            l.name AS league_name,
            l.league_type,
            ((gp.games_played)::numeric * 3.1) AS pa_threshold,
            ps.plate_appearances,
            ps.ba,
            ps.obp,
            ps.slg,
            ps.ops,
            ps.babip,
            ps.hits,
            ps.singles,
            ps.doubles,
            ps.triples,
            ps.home_runs,
            ps.walked,
            ps.hit_by_pitch,
            ps.stolen_bases,
            ps.caught_stealing,
            ps.struck_out
           FROM ((((public.player_stats ps
             JOIN public.players p ON ((ps.player_id = p.id)))
             JOIN public.teams t ON ((p.team_id = t.id)))
             JOIN public.leagues l ON ((t.league_id = l.id)))
             JOIN public.mv_games_played gp ON ((gp.league_type = l.league_type)))
        ), rate_ranked AS (
         SELECT enriched.player_id,
            enriched.first_name,
            enriched.last_name,
            enriched."position",
            enriched.suffix,
            enriched.team_name,
            enriched.team_id,
            enriched.team_location,
            enriched.team_emoji,
            enriched.league_id,
            enriched.league_name,
            enriched.league_type,
            enriched.pa_threshold,
            enriched.plate_appearances,
            enriched.ba,
            enriched.obp,
            enriched.slg,
            enriched.ops,
            enriched.babip,
            enriched.hits,
            enriched.singles,
            enriched.doubles,
            enriched.triples,
            enriched.home_runs,
            enriched.walked,
            enriched.hit_by_pitch,
            enriched.stolen_bases,
            enriched.caught_stealing,
            enriched.struck_out,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.ba DESC NULLS LAST) AS rn_ba,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.obp DESC NULLS LAST) AS rn_obp,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.slg DESC NULLS LAST) AS rn_slg,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.ops DESC NULLS LAST) AS rn_ops,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.babip DESC NULLS LAST) AS rn_babip
           FROM enriched
          WHERE ((enriched.plate_appearances)::numeric >= enriched.pa_threshold)
        ), count_ranked AS (
         SELECT enriched.player_id,
            enriched.first_name,
            enriched.last_name,
            enriched."position",
            enriched.suffix,
            enriched.team_name,
            enriched.team_id,
            enriched.team_location,
            enriched.team_emoji,
            enriched.league_id,
            enriched.league_name,
            enriched.league_type,
            enriched.pa_threshold,
            enriched.plate_appearances,
            enriched.ba,
            enriched.obp,
            enriched.slg,
            enriched.ops,
            enriched.babip,
            enriched.hits,
            enriched.singles,
            enriched.doubles,
            enriched.triples,
            enriched.home_runs,
            enriched.walked,
            enriched.hit_by_pitch,
            enriched.stolen_bases,
            enriched.caught_stealing,
            enriched.struck_out,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.hits DESC NULLS LAST) AS rn_hits,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.singles DESC NULLS LAST) AS rn_singles,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.doubles DESC NULLS LAST) AS rn_doubles,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.triples DESC NULLS LAST) AS rn_triples,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.home_runs DESC NULLS LAST) AS rn_hr,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.walked DESC NULLS LAST) AS rn_walks,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.hit_by_pitch DESC NULLS LAST) AS rn_hbp,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.stolen_bases DESC NULLS LAST) AS rn_sb,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.caught_stealing DESC NULLS LAST) AS rn_cs,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.struck_out DESC NULLS LAST) AS rn_k
           FROM enriched
        ), combined_rate_ranked AS (
         SELECT enriched.player_id,
            enriched.first_name,
            enriched.last_name,
            enriched."position",
            enriched.suffix,
            enriched.team_name,
            enriched.team_id,
            enriched.team_location,
            enriched.team_emoji,
            enriched.league_id,
            enriched.league_name,
            enriched.league_type,
            enriched.pa_threshold,
            enriched.plate_appearances,
            enriched.ba,
            enriched.obp,
            enriched.slg,
            enriched.ops,
            enriched.babip,
            enriched.hits,
            enriched.singles,
            enriched.doubles,
            enriched.triples,
            enriched.home_runs,
            enriched.walked,
            enriched.hit_by_pitch,
            enriched.stolen_bases,
            enriched.caught_stealing,
            enriched.struck_out,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.ba DESC NULLS LAST) AS rn_ba,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.obp DESC NULLS LAST) AS rn_obp,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.slg DESC NULLS LAST) AS rn_slg,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.ops DESC NULLS LAST) AS rn_ops,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.babip DESC NULLS LAST) AS rn_babip
           FROM enriched
          WHERE ((enriched.plate_appearances)::numeric >= enriched.pa_threshold)
        ), combined_count_ranked AS (
         SELECT enriched.player_id,
            enriched.first_name,
            enriched.last_name,
            enriched."position",
            enriched.suffix,
            enriched.team_name,
            enriched.team_id,
            enriched.team_location,
            enriched.team_emoji,
            enriched.league_id,
            enriched.league_name,
            enriched.league_type,
            enriched.pa_threshold,
            enriched.plate_appearances,
            enriched.ba,
            enriched.obp,
            enriched.slg,
            enriched.ops,
            enriched.babip,
            enriched.hits,
            enriched.singles,
            enriched.doubles,
            enriched.triples,
            enriched.home_runs,
            enriched.walked,
            enriched.hit_by_pitch,
            enriched.stolen_bases,
            enriched.caught_stealing,
            enriched.struck_out,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.hits DESC NULLS LAST) AS rn_hits,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.singles DESC NULLS LAST) AS rn_singles,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.doubles DESC NULLS LAST) AS rn_doubles,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.triples DESC NULLS LAST) AS rn_triples,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.home_runs DESC NULLS LAST) AS rn_hr,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.walked DESC NULLS LAST) AS rn_walks,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.hit_by_pitch DESC NULLS LAST) AS rn_hbp,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.stolen_bases DESC NULLS LAST) AS rn_sb,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.caught_stealing DESC NULLS LAST) AS rn_cs,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.struck_out DESC NULLS LAST) AS rn_k
           FROM enriched
        )
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.plate_appearances,
    rate_ranked.pa_threshold,
    rate_ranked.ba AS stat_value,
    'Batting Average (BA)'::text AS stat_key,
    rate_ranked.rn_ba AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_ba <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.plate_appearances,
    rate_ranked.pa_threshold,
    rate_ranked.obp AS stat_value,
    'On Base Percentage (OBP)'::text AS stat_key,
    rate_ranked.rn_obp AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_obp <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.plate_appearances,
    rate_ranked.pa_threshold,
    rate_ranked.slg AS stat_value,
    'Slugging Percentage (SLG)'::text AS stat_key,
    rate_ranked.rn_slg AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_slg <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.plate_appearances,
    rate_ranked.pa_threshold,
    rate_ranked.ops AS stat_value,
    'On Base Plus Slugging (OPS)'::text AS stat_key,
    rate_ranked.rn_ops AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_ops <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.plate_appearances,
    rate_ranked.pa_threshold,
    rate_ranked.babip AS stat_value,
    'Batting Average on Balls in Play (BABIP)'::text AS stat_key,
    rate_ranked.rn_babip AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_babip <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.hits AS stat_value,
    'Hits'::text AS stat_key,
    count_ranked.rn_hits AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_hits <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.singles AS stat_value,
    'Singles'::text AS stat_key,
    count_ranked.rn_singles AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_singles <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.doubles AS stat_value,
    'Doubles'::text AS stat_key,
    count_ranked.rn_doubles AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_doubles <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.triples AS stat_value,
    'Triples'::text AS stat_key,
    count_ranked.rn_triples AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_triples <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.home_runs AS stat_value,
    'Home Runs'::text AS stat_key,
    count_ranked.rn_hr AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_hr <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.walked AS stat_value,
    'Walks (BB)'::text AS stat_key,
    count_ranked.rn_walks AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_walks <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.hit_by_pitch AS stat_value,
    'Hit By Pitch (HBP)'::text AS stat_key,
    count_ranked.rn_hbp AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_hbp <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.stolen_bases AS stat_value,
    'Stolen Bases'::text AS stat_key,
    count_ranked.rn_sb AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_sb <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.caught_stealing AS stat_value,
    'Caught Stealing'::text AS stat_key,
    count_ranked.rn_cs AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_cs <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.struck_out AS stat_value,
    'Struck Out'::text AS stat_key,
    count_ranked.rn_k AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_k <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.plate_appearances,
    combined_rate_ranked.pa_threshold,
    combined_rate_ranked.ba AS stat_value,
    'Batting Average (BA)'::text AS stat_key,
    combined_rate_ranked.rn_ba AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_ba <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.plate_appearances,
    combined_rate_ranked.pa_threshold,
    combined_rate_ranked.obp AS stat_value,
    'On Base Percentage (OBP)'::text AS stat_key,
    combined_rate_ranked.rn_obp AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_obp <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.plate_appearances,
    combined_rate_ranked.pa_threshold,
    combined_rate_ranked.slg AS stat_value,
    'Slugging Percentage (SLG)'::text AS stat_key,
    combined_rate_ranked.rn_slg AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_slg <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.plate_appearances,
    combined_rate_ranked.pa_threshold,
    combined_rate_ranked.ops AS stat_value,
    'On Base Plus Slugging (OPS)'::text AS stat_key,
    combined_rate_ranked.rn_ops AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_ops <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.plate_appearances,
    combined_rate_ranked.pa_threshold,
    combined_rate_ranked.babip AS stat_value,
    'Batting Average on Balls in Play (BABIP)'::text AS stat_key,
    combined_rate_ranked.rn_babip AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_babip <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.hits AS stat_value,
    'Hits'::text AS stat_key,
    combined_count_ranked.rn_hits AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_hits <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.singles AS stat_value,
    'Singles'::text AS stat_key,
    combined_count_ranked.rn_singles AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_singles <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.doubles AS stat_value,
    'Doubles'::text AS stat_key,
    combined_count_ranked.rn_doubles AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_doubles <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.triples AS stat_value,
    'Triples'::text AS stat_key,
    combined_count_ranked.rn_triples AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_triples <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.home_runs AS stat_value,
    'Home Runs'::text AS stat_key,
    combined_count_ranked.rn_hr AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_hr <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.walked AS stat_value,
    'Walks'::text AS stat_key,
    combined_count_ranked.rn_walks AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_walks <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.hit_by_pitch AS stat_value,
    'Hit By Pitch (HBP)'::text AS stat_key,
    combined_count_ranked.rn_hbp AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_hbp <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.stolen_bases AS stat_value,
    'Stolen Bases'::text AS stat_key,
    combined_count_ranked.rn_sb AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_sb <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.caught_stealing AS stat_value,
    'Caught Stealing'::text AS stat_key,
    combined_count_ranked.rn_cs AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_cs <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.struck_out AS stat_value,
    'Struck Out'::text AS stat_key,
    combined_count_ranked.rn_k AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_k <= 10)
  WITH NO DATA;


ALTER MATERIALIZED VIEW public.mv_batting_leaderboard OWNER TO postgres;

--
-- Name: mv_league_batting_context; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW public.mv_league_batting_context AS
 WITH qualified AS (
         SELECT ps.ba,
            ps.obp,
            ps.slg,
            ps.ops,
            ps.babip,
            ps.plate_appearances,
            ps.hits,
            ps.at_bats,
            ps.walked,
            ps.hit_by_pitch,
            ps.sac_flies,
            ps.singles,
            ps.doubles,
            ps.triples,
            ps.home_runs,
            ps.struck_out,
            l.id AS league_id,
            l.name AS league_name,
            l.league_type
           FROM ((((public.player_stats ps
             JOIN public.players p ON ((ps.player_id = p.id)))
             JOIN public.teams t ON ((p.team_id = t.id)))
             JOIN public.leagues l ON ((t.league_id = l.id)))
             JOIN public.mv_games_played gp ON ((gp.league_type = l.league_type)))
          WHERE ((ps.plate_appearances)::numeric >= ((gp.games_played)::numeric * 3.1))
        ), agg AS (
         SELECT qualified.league_id,
            qualified.league_name,
            qualified.league_type,
            count(*) AS qualified_batters,
            sum(qualified.hits) AS sum_h,
            sum(qualified.at_bats) AS sum_ab,
            sum(qualified.walked) AS sum_bb,
            sum(qualified.hit_by_pitch) AS sum_hbp,
            sum(qualified.sac_flies) AS sum_sf,
            sum(qualified.singles) AS sum_1b,
            sum(qualified.doubles) AS sum_2b,
            sum(qualified.triples) AS sum_3b,
            sum(qualified.home_runs) AS sum_hr,
            sum(qualified.struck_out) AS sum_k
           FROM qualified
          GROUP BY qualified.league_type, qualified.league_id, qualified.league_name
        ), with_rates AS (
         SELECT agg.league_id,
            agg.league_name,
            agg.league_type,
            agg.qualified_batters,
            agg.sum_h,
            agg.sum_ab,
            agg.sum_bb,
            agg.sum_hbp,
            agg.sum_sf,
            agg.sum_1b,
            agg.sum_2b,
            agg.sum_3b,
            agg.sum_hr,
            agg.sum_k,
            (agg.sum_h / (NULLIF(agg.sum_ab, 0))::double precision) AS avg_ba,
            (((agg.sum_h + (agg.sum_bb)::double precision) + (agg.sum_hbp)::double precision) / (NULLIF((((agg.sum_ab + agg.sum_bb) + agg.sum_hbp) + agg.sum_sf), 0))::double precision) AS avg_obp,
            (((((agg.sum_1b)::numeric + (2.0 * (agg.sum_2b)::numeric)) + (3.0 * (agg.sum_3b)::numeric)) + (4.0 * (agg.sum_hr)::numeric)) / (NULLIF(agg.sum_ab, 0))::numeric) AS avg_slg,
            ((agg.sum_h - (agg.sum_hr)::double precision) / (NULLIF((((agg.sum_ab - agg.sum_k) - agg.sum_hr) + agg.sum_sf), 0))::double precision) AS avg_babip
           FROM agg
        ), final AS (
         SELECT with_rates.league_id,
            with_rates.league_name,
            with_rates.league_type,
            with_rates.qualified_batters,
            with_rates.sum_h,
            with_rates.sum_ab,
            with_rates.sum_bb,
            with_rates.sum_hbp,
            with_rates.sum_sf,
            with_rates.sum_1b,
            with_rates.sum_2b,
            with_rates.sum_3b,
            with_rates.sum_hr,
            with_rates.sum_k,
            with_rates.avg_ba,
            with_rates.avg_obp,
            with_rates.avg_slg,
            with_rates.avg_babip,
            (with_rates.avg_obp + (with_rates.avg_slg)::double precision) AS avg_ops
           FROM with_rates
        )
 SELECT final.league_id,
    final.league_name,
    final.league_type,
    final.qualified_batters,
    final.sum_h,
    final.sum_ab,
    final.sum_bb,
    final.sum_hbp,
    final.sum_sf,
    final.sum_1b,
    final.sum_2b,
    final.sum_3b,
    final.sum_hr,
    final.sum_k,
    final.avg_ba,
    final.avg_obp,
    final.avg_slg,
    final.avg_babip,
    final.avg_ops
   FROM final
  WHERE (final.league_type = 'Lesser'::text)
UNION ALL
 SELECT '__lesser__'::text AS league_id,
    'All Lesser'::text AS league_name,
    'Lesser'::text AS league_type,
    sum(final.qualified_batters) AS qualified_batters,
    sum(final.sum_h) AS sum_h,
    sum(final.sum_ab) AS sum_ab,
    sum(final.sum_bb) AS sum_bb,
    sum(final.sum_hbp) AS sum_hbp,
    sum(final.sum_sf) AS sum_sf,
    sum(final.sum_1b) AS sum_1b,
    sum(final.sum_2b) AS sum_2b,
    sum(final.sum_3b) AS sum_3b,
    sum(final.sum_hr) AS sum_hr,
    sum(final.sum_k) AS sum_k,
    (sum(final.sum_h) / (NULLIF(sum(final.sum_ab), (0)::numeric))::double precision) AS avg_ba,
    (((sum(final.sum_h) + (sum(final.sum_bb))::double precision) + (sum(final.sum_hbp))::double precision) / (NULLIF((((sum(final.sum_ab) + sum(final.sum_bb)) + sum(final.sum_hbp)) + sum(final.sum_sf)), (0)::numeric))::double precision) AS avg_obp,
    ((((sum(final.sum_1b) + (2.0 * sum(final.sum_2b))) + (3.0 * sum(final.sum_3b))) + (4.0 * sum(final.sum_hr))) / NULLIF(sum(final.sum_ab), (0)::numeric)) AS avg_slg,
    ((sum(final.sum_h) - (sum(final.sum_hr))::double precision) / (NULLIF((((sum(final.sum_ab) - sum(final.sum_k)) - sum(final.sum_hr)) + sum(final.sum_sf)), (0)::numeric))::double precision) AS avg_babip,
    ((((sum(final.sum_h) + (sum(final.sum_bb))::double precision) + (sum(final.sum_hbp))::double precision) / (NULLIF((((sum(final.sum_ab) + sum(final.sum_bb)) + sum(final.sum_hbp)) + sum(final.sum_sf)), (0)::numeric))::double precision) + (((((sum(final.sum_1b) + (2.0 * sum(final.sum_2b))) + (3.0 * sum(final.sum_3b))) + (4.0 * sum(final.sum_hr))) / NULLIF(sum(final.sum_ab), (0)::numeric)))::double precision) AS avg_ops
   FROM final
  WHERE (final.league_type = 'Lesser'::text)
UNION ALL
 SELECT '__greater__'::text AS league_id,
    'All Greater'::text AS league_name,
    'Greater'::text AS league_type,
    sum(final.qualified_batters) AS qualified_batters,
    sum(final.sum_h) AS sum_h,
    sum(final.sum_ab) AS sum_ab,
    sum(final.sum_bb) AS sum_bb,
    sum(final.sum_hbp) AS sum_hbp,
    sum(final.sum_sf) AS sum_sf,
    sum(final.sum_1b) AS sum_1b,
    sum(final.sum_2b) AS sum_2b,
    sum(final.sum_3b) AS sum_3b,
    sum(final.sum_hr) AS sum_hr,
    sum(final.sum_k) AS sum_k,
    (sum(final.sum_h) / (NULLIF(sum(final.sum_ab), (0)::numeric))::double precision) AS avg_ba,
    (((sum(final.sum_h) + (sum(final.sum_bb))::double precision) + (sum(final.sum_hbp))::double precision) / (NULLIF((((sum(final.sum_ab) + sum(final.sum_bb)) + sum(final.sum_hbp)) + sum(final.sum_sf)), (0)::numeric))::double precision) AS avg_obp,
    ((((sum(final.sum_1b) + (2.0 * sum(final.sum_2b))) + (3.0 * sum(final.sum_3b))) + (4.0 * sum(final.sum_hr))) / NULLIF(sum(final.sum_ab), (0)::numeric)) AS avg_slg,
    ((sum(final.sum_h) - (sum(final.sum_hr))::double precision) / (NULLIF((((sum(final.sum_ab) - sum(final.sum_k)) - sum(final.sum_hr)) + sum(final.sum_sf)), (0)::numeric))::double precision) AS avg_babip,
    ((((sum(final.sum_h) + (sum(final.sum_bb))::double precision) + (sum(final.sum_hbp))::double precision) / (NULLIF((((sum(final.sum_ab) + sum(final.sum_bb)) + sum(final.sum_hbp)) + sum(final.sum_sf)), (0)::numeric))::double precision) + (((((sum(final.sum_1b) + (2.0 * sum(final.sum_2b))) + (3.0 * sum(final.sum_3b))) + (4.0 * sum(final.sum_hr))) / NULLIF(sum(final.sum_ab), (0)::numeric)))::double precision) AS avg_ops
   FROM final
  WHERE (final.league_type = 'Greater'::text)
  WITH NO DATA;


ALTER MATERIALIZED VIEW public.mv_league_batting_context OWNER TO postgres;

--
-- Name: mv_league_pitching_context; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW public.mv_league_pitching_context AS
 WITH qualified AS (
         SELECT ps.earned_runs,
            ps.innings_pitched,
            ps.hits_allowed,
            ps.home_runs_allowed,
            ps.walks,
            ps.strikeouts,
            ps.era,
            ps.whip,
            ps.k9,
            ps.bb9,
            ps.h9,
            ps.hr9,
            l.id AS league_id,
            l.name AS league_name,
            l.league_type
           FROM ((((public.player_stats ps
             JOIN public.players p ON ((ps.player_id = p.id)))
             JOIN public.teams t ON ((p.team_id = t.id)))
             JOIN public.leagues l ON ((t.league_id = l.id)))
             JOIN public.mv_games_played gp ON ((gp.league_type = l.league_type)))
          WHERE ((ps.innings_pitched >= (((gp.games_played)::numeric * 1.0))::double precision) AND (ps.innings_pitched > (0)::double precision))
        ), agg AS (
         SELECT qualified.league_id,
            qualified.league_name,
            qualified.league_type,
            count(*) AS qualified_pitchers,
            sum(qualified.earned_runs) AS sum_er,
            sum(qualified.innings_pitched) AS sum_ip,
            sum(qualified.hits_allowed) AS sum_h,
            sum(qualified.home_runs_allowed) AS sum_hr,
            sum(qualified.walks) AS sum_bb,
            sum(qualified.strikeouts) AS sum_k
           FROM qualified
          GROUP BY qualified.league_type, qualified.league_id, qualified.league_name
        ), with_rates AS (
         SELECT agg.league_id,
            agg.league_name,
            agg.league_type,
            agg.qualified_pitchers,
            agg.sum_er,
            agg.sum_ip,
            agg.sum_h,
            agg.sum_hr,
            agg.sum_bb,
            agg.sum_k,
            ((((agg.sum_er)::numeric * 9.0))::double precision / NULLIF(agg.sum_ip, (0)::double precision)) AS avg_era,
            (((agg.sum_h + agg.sum_bb))::double precision / NULLIF(agg.sum_ip, (0)::double precision)) AS avg_whip,
            ((((agg.sum_k)::numeric * 9.0))::double precision / NULLIF(agg.sum_ip, (0)::double precision)) AS avg_k9,
            ((((agg.sum_bb)::numeric * 9.0))::double precision / NULLIF(agg.sum_ip, (0)::double precision)) AS avg_bb9,
            ((((agg.sum_h)::numeric * 9.0))::double precision / NULLIF(agg.sum_ip, (0)::double precision)) AS avg_h9,
            ((((agg.sum_hr)::numeric * 9.0))::double precision / NULLIF(agg.sum_ip, (0)::double precision)) AS avg_hr9,
            (((((agg.sum_er)::numeric * 9.0))::double precision / NULLIF(agg.sum_ip, (0)::double precision)) - (((((13.0 * (agg.sum_hr)::numeric) + (3.0 * (agg.sum_bb)::numeric)) - (2.0 * (agg.sum_k)::numeric)))::double precision / NULLIF(agg.sum_ip, (0)::double precision))) AS fip_constant
           FROM agg
        ), lesser_subleagues AS (
         SELECT with_rates.league_id,
            with_rates.league_name,
            with_rates.league_type,
            with_rates.qualified_pitchers,
            with_rates.sum_er,
            with_rates.sum_ip,
            with_rates.sum_h,
            with_rates.sum_hr,
            with_rates.sum_bb,
            with_rates.sum_k,
            with_rates.avg_era,
            with_rates.avg_whip,
            with_rates.avg_k9,
            with_rates.avg_bb9,
            with_rates.avg_h9,
            with_rates.avg_hr9,
            with_rates.fip_constant
           FROM with_rates
          WHERE (with_rates.league_type = 'Lesser'::text)
        ), lesser_rollup AS (
         SELECT '__lesser__'::text AS league_id,
            'All Lesser'::text AS league_name,
            'Lesser'::text AS league_type,
            sum(with_rates.qualified_pitchers) AS qualified_pitchers,
            sum(with_rates.sum_er) AS sum_er,
            sum(with_rates.sum_ip) AS sum_ip,
            sum(with_rates.sum_h) AS sum_h,
            sum(with_rates.sum_hr) AS sum_hr,
            sum(with_rates.sum_bb) AS sum_bb,
            sum(with_rates.sum_k) AS sum_k,
            (((sum(with_rates.sum_er) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_era,
            (((sum(with_rates.sum_h) + sum(with_rates.sum_bb)))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_whip,
            (((sum(with_rates.sum_k) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_k9,
            (((sum(with_rates.sum_bb) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_bb9,
            (((sum(with_rates.sum_h) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_h9,
            (((sum(with_rates.sum_hr) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_hr9,
            ((((sum(with_rates.sum_er) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) - (((((13.0 * sum(with_rates.sum_hr)) + (3.0 * sum(with_rates.sum_bb))) - (2.0 * sum(with_rates.sum_k))))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision))) AS fip_constant
           FROM with_rates
          WHERE (with_rates.league_type = 'Lesser'::text)
        ), greater_unified AS (
         SELECT '__greater__'::text AS league_id,
            'All Greater'::text AS league_name,
            'Greater'::text AS league_type,
            sum(with_rates.qualified_pitchers) AS qualified_pitchers,
            sum(with_rates.sum_er) AS sum_er,
            sum(with_rates.sum_ip) AS sum_ip,
            sum(with_rates.sum_h) AS sum_h,
            sum(with_rates.sum_hr) AS sum_hr,
            sum(with_rates.sum_bb) AS sum_bb,
            sum(with_rates.sum_k) AS sum_k,
            (((sum(with_rates.sum_er) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_era,
            (((sum(with_rates.sum_h) + sum(with_rates.sum_bb)))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_whip,
            (((sum(with_rates.sum_k) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_k9,
            (((sum(with_rates.sum_bb) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_bb9,
            (((sum(with_rates.sum_h) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_h9,
            (((sum(with_rates.sum_hr) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_hr9,
            ((((sum(with_rates.sum_er) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) - (((((13.0 * sum(with_rates.sum_hr)) + (3.0 * sum(with_rates.sum_bb))) - (2.0 * sum(with_rates.sum_k))))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision))) AS fip_constant
           FROM with_rates
          WHERE (with_rates.league_type = 'Greater'::text)
        )
 SELECT lesser_subleagues.league_id,
    lesser_subleagues.league_name,
    lesser_subleagues.league_type,
    lesser_subleagues.qualified_pitchers,
    lesser_subleagues.sum_er,
    lesser_subleagues.sum_ip,
    lesser_subleagues.sum_h,
    lesser_subleagues.sum_hr,
    lesser_subleagues.sum_bb,
    lesser_subleagues.sum_k,
    lesser_subleagues.avg_era,
    lesser_subleagues.avg_whip,
    lesser_subleagues.avg_k9,
    lesser_subleagues.avg_bb9,
    lesser_subleagues.avg_h9,
    lesser_subleagues.avg_hr9,
    lesser_subleagues.fip_constant
   FROM lesser_subleagues
UNION ALL
 SELECT lesser_rollup.league_id,
    lesser_rollup.league_name,
    lesser_rollup.league_type,
    lesser_rollup.qualified_pitchers,
    lesser_rollup.sum_er,
    lesser_rollup.sum_ip,
    lesser_rollup.sum_h,
    lesser_rollup.sum_hr,
    lesser_rollup.sum_bb,
    lesser_rollup.sum_k,
    lesser_rollup.avg_era,
    lesser_rollup.avg_whip,
    lesser_rollup.avg_k9,
    lesser_rollup.avg_bb9,
    lesser_rollup.avg_h9,
    lesser_rollup.avg_hr9,
    lesser_rollup.fip_constant
   FROM lesser_rollup
UNION ALL
 SELECT greater_unified.league_id,
    greater_unified.league_name,
    greater_unified.league_type,
    greater_unified.qualified_pitchers,
    greater_unified.sum_er,
    greater_unified.sum_ip,
    greater_unified.sum_h,
    greater_unified.sum_hr,
    greater_unified.sum_bb,
    greater_unified.sum_k,
    greater_unified.avg_era,
    greater_unified.avg_whip,
    greater_unified.avg_k9,
    greater_unified.avg_bb9,
    greater_unified.avg_h9,
    greater_unified.avg_hr9,
    greater_unified.fip_constant
   FROM greater_unified
  WITH NO DATA;


ALTER MATERIALIZED VIEW public.mv_league_pitching_context OWNER TO postgres;

--
-- Name: mv_pitching_leaderboard; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW public.mv_pitching_leaderboard AS
 WITH enriched AS (
         SELECT ps.player_id,
            p.first_name,
            p.last_name,
            p."position",
            p.suffix,
            t.name AS team_name,
            t.id AS team_id,
            t.location AS team_location,
            t.emoji AS team_emoji,
            l.id AS league_id,
            l.name AS league_name,
            l.league_type,
            ((gp.games_played)::numeric * 1.0) AS ip_threshold,
            ps.innings_pitched,
            ps.era,
            ps.whip,
            ps.k9,
            ps.bb9,
            ps.h9,
            ps.hr9,
            ps.strikeouts,
            ps.hit_batters,
            ((((((13.0 * (ps.home_runs_allowed)::numeric) + (3.0 * (ps.walks)::numeric)) - (2.0 * (ps.strikeouts)::numeric)))::double precision / NULLIF(ps.innings_pitched, (0)::double precision)) + lpc.fip_constant) AS fip
           FROM (((((public.player_stats ps
             JOIN public.players p ON ((ps.player_id = p.id)))
             JOIN public.teams t ON ((p.team_id = t.id)))
             JOIN public.leagues l ON ((t.league_id = l.id)))
             JOIN public.mv_games_played gp ON ((gp.league_type = l.league_type)))
             JOIN public.mv_league_pitching_context lpc ON ((lpc.league_id =
                CASE
                    WHEN (l.league_type = 'Greater'::text) THEN '__greater__'::text
                    ELSE l.id
                END)))
        ), rate_ranked AS (
         SELECT enriched.player_id,
            enriched.first_name,
            enriched.last_name,
            enriched."position",
            enriched.suffix,
            enriched.team_name,
            enriched.team_id,
            enriched.team_location,
            enriched.team_emoji,
            enriched.league_id,
            enriched.league_name,
            enriched.league_type,
            enriched.ip_threshold,
            enriched.innings_pitched,
            enriched.era,
            enriched.whip,
            enriched.k9,
            enriched.bb9,
            enriched.h9,
            enriched.hr9,
            enriched.strikeouts,
            enriched.hit_batters,
            enriched.fip,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.era) AS rn_era,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.fip) AS rn_fip,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.whip) AS rn_whip,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.k9 DESC NULLS LAST) AS rn_k9,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.bb9) AS rn_bb9,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.h9) AS rn_h9,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.hr9) AS rn_hr9
           FROM enriched
          WHERE (enriched.innings_pitched >= (enriched.ip_threshold)::double precision)
        ), count_ranked AS (
         SELECT enriched.player_id,
            enriched.first_name,
            enriched.last_name,
            enriched."position",
            enriched.suffix,
            enriched.team_name,
            enriched.team_id,
            enriched.team_location,
            enriched.team_emoji,
            enriched.league_id,
            enriched.league_name,
            enriched.league_type,
            enriched.ip_threshold,
            enriched.innings_pitched,
            enriched.era,
            enriched.whip,
            enriched.k9,
            enriched.bb9,
            enriched.h9,
            enriched.hr9,
            enriched.strikeouts,
            enriched.hit_batters,
            enriched.fip,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.innings_pitched DESC NULLS LAST) AS rn_ip,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.strikeouts DESC NULLS LAST) AS rn_k,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.hit_batters DESC NULLS LAST) AS rn_hbp
           FROM enriched
        ), combined_rate_ranked AS (
         SELECT enriched.player_id,
            enriched.first_name,
            enriched.last_name,
            enriched."position",
            enriched.suffix,
            enriched.team_name,
            enriched.team_id,
            enriched.team_location,
            enriched.team_emoji,
            enriched.league_id,
            enriched.league_name,
            enriched.league_type,
            enriched.ip_threshold,
            enriched.innings_pitched,
            enriched.era,
            enriched.whip,
            enriched.k9,
            enriched.bb9,
            enriched.h9,
            enriched.hr9,
            enriched.strikeouts,
            enriched.hit_batters,
            enriched.fip,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.era) AS rn_era,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.fip) AS rn_fip,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.whip) AS rn_whip,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.k9 DESC NULLS LAST) AS rn_k9,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.bb9) AS rn_bb9,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.h9) AS rn_h9,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.hr9) AS rn_hr9
           FROM enriched
          WHERE (enriched.innings_pitched >= (enriched.ip_threshold)::double precision)
        ), combined_count_ranked AS (
         SELECT enriched.player_id,
            enriched.first_name,
            enriched.last_name,
            enriched."position",
            enriched.suffix,
            enriched.team_name,
            enriched.team_id,
            enriched.team_location,
            enriched.team_emoji,
            enriched.league_id,
            enriched.league_name,
            enriched.league_type,
            enriched.ip_threshold,
            enriched.innings_pitched,
            enriched.era,
            enriched.whip,
            enriched.k9,
            enriched.bb9,
            enriched.h9,
            enriched.hr9,
            enriched.strikeouts,
            enriched.hit_batters,
            enriched.fip,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.innings_pitched DESC NULLS LAST) AS rn_ip,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.strikeouts DESC NULLS LAST) AS rn_k,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.hit_batters DESC NULLS LAST) AS rn_hbp
           FROM enriched
        )
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.innings_pitched,
    rate_ranked.ip_threshold,
    rate_ranked.era AS stat_value,
    'Earned Run Average (ERA)'::text AS stat_key,
    rate_ranked.rn_era AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_era <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.innings_pitched,
    rate_ranked.ip_threshold,
    rate_ranked.fip AS stat_value,
    'Fielding Independent Pitching (FIP)'::text AS stat_key,
    rate_ranked.rn_fip AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_fip <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.innings_pitched,
    rate_ranked.ip_threshold,
    rate_ranked.whip AS stat_value,
    'Walks and Hits per Inning Pitched (WHIP)'::text AS stat_key,
    rate_ranked.rn_whip AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_whip <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.innings_pitched,
    rate_ranked.ip_threshold,
    rate_ranked.k9 AS stat_value,
    'Strikeouts per 9 Innings (K/9)'::text AS stat_key,
    rate_ranked.rn_k9 AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_k9 <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.innings_pitched,
    rate_ranked.ip_threshold,
    rate_ranked.bb9 AS stat_value,
    'Walks per 9 Innings (BB/9)'::text AS stat_key,
    rate_ranked.rn_bb9 AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_bb9 <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.innings_pitched,
    rate_ranked.ip_threshold,
    rate_ranked.h9 AS stat_value,
    'Hits per 9 Innings (H/9)'::text AS stat_key,
    rate_ranked.rn_h9 AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_h9 <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.innings_pitched,
    rate_ranked.ip_threshold,
    rate_ranked.hr9 AS stat_value,
    'Homeruns per 9 Innings (HR/9)'::text AS stat_key,
    rate_ranked.rn_hr9 AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_hr9 <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.innings_pitched,
    count_ranked.ip_threshold,
    count_ranked.innings_pitched AS stat_value,
    'Innings Pitched (IP)'::text AS stat_key,
    count_ranked.rn_ip AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_ip <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.innings_pitched,
    count_ranked.ip_threshold,
    count_ranked.strikeouts AS stat_value,
    'Strikeouts'::text AS stat_key,
    count_ranked.rn_k AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_k <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.innings_pitched,
    count_ranked.ip_threshold,
    count_ranked.hit_batters AS stat_value,
    'Hit Batters'::text AS stat_key,
    count_ranked.rn_hbp AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_hbp <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.innings_pitched,
    combined_rate_ranked.ip_threshold,
    combined_rate_ranked.era AS stat_value,
    'Earned Run Average (ERA)'::text AS stat_key,
    combined_rate_ranked.rn_era AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_era <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.innings_pitched,
    combined_rate_ranked.ip_threshold,
    combined_rate_ranked.fip AS stat_value,
    'Fielding Independent Pitching (FIP)'::text AS stat_key,
    combined_rate_ranked.rn_fip AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_fip <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.innings_pitched,
    combined_rate_ranked.ip_threshold,
    combined_rate_ranked.whip AS stat_value,
    'Walks and Hits per Inning Pitched (WHIP)'::text AS stat_key,
    combined_rate_ranked.rn_whip AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_whip <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.innings_pitched,
    combined_rate_ranked.ip_threshold,
    combined_rate_ranked.k9 AS stat_value,
    'Strikeouts per 9 Innings (K/9)'::text AS stat_key,
    combined_rate_ranked.rn_k9 AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_k9 <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.innings_pitched,
    combined_rate_ranked.ip_threshold,
    combined_rate_ranked.bb9 AS stat_value,
    'Walks per 9 Innings (BB/9)'::text AS stat_key,
    combined_rate_ranked.rn_bb9 AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_bb9 <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.innings_pitched,
    combined_rate_ranked.ip_threshold,
    combined_rate_ranked.h9 AS stat_value,
    'Hits per 9 Innings (H/9)'::text AS stat_key,
    combined_rate_ranked.rn_h9 AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_h9 <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.innings_pitched,
    combined_rate_ranked.ip_threshold,
    combined_rate_ranked.hr9 AS stat_value,
    'Homeruns per 9 Innings (HR/9)'::text AS stat_key,
    combined_rate_ranked.rn_hr9 AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_hr9 <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.innings_pitched,
    combined_count_ranked.ip_threshold,
    combined_count_ranked.innings_pitched AS stat_value,
    'Innings Pitched (IP)'::text AS stat_key,
    combined_count_ranked.rn_ip AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_ip <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.innings_pitched,
    combined_count_ranked.ip_threshold,
    combined_count_ranked.strikeouts AS stat_value,
    'Strikeouts'::text AS stat_key,
    combined_count_ranked.rn_k AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_k <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.innings_pitched,
    combined_count_ranked.ip_threshold,
    combined_count_ranked.hit_batters AS stat_value,
    'Hit Batters'::text AS stat_key,
    combined_count_ranked.rn_hbp AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_hbp <= 10)
  WITH NO DATA;


ALTER MATERIALIZED VIEW public.mv_pitching_leaderboard OWNER TO postgres;

--
-- Name: player_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_details (
    player_id text NOT NULL,
    details jsonb,
    last_updated timestamp with time zone
);


ALTER TABLE public.player_details OWNER TO postgres;

--
-- Name: scrape_runs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scrape_runs (
    id integer NOT NULL,
    started_at timestamp with time zone,
    finished_at timestamp with time zone,
    teams_scraped integer,
    errors integer,
    notes text
);


ALTER TABLE public.scrape_runs OWNER TO postgres;

--
-- Name: scrape_runs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.scrape_runs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.scrape_runs_id_seq OWNER TO postgres;

--
-- Name: scrape_runs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.scrape_runs_id_seq OWNED BY public.scrape_runs.id;


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    action_filter text DEFAULT '*'::text,
    CONSTRAINT subscription_action_filter_check CHECK ((action_filter = ANY (ARRAY['*'::text, 'INSERT'::text, 'UPDATE'::text, 'DELETE'::text])))
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb,
    metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.vector_indexes OWNER TO supabase_storage_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: scrape_runs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scrape_runs ALTER COLUMN id SET DEFAULT nextval('public.scrape_runs_id_seq'::regclass);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_identifier_key UNIQUE (identifier);


--
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webauthn_challenges webauthn_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_pkey PRIMARY KEY (id);


--
-- Name: webauthn_credentials webauthn_credentials_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_pkey PRIMARY KEY (id);


--
-- Name: leagues leagues_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leagues
    ADD CONSTRAINT leagues_pkey PRIMARY KEY (id);


--
-- Name: player_attributes player_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_attributes
    ADD CONSTRAINT player_attributes_pkey PRIMARY KEY (player_id);


--
-- Name: player_details player_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_details
    ADD CONSTRAINT player_details_pkey PRIMARY KEY (player_id);


--
-- Name: player_stats player_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_stats
    ADD CONSTRAINT player_stats_pkey PRIMARY KEY (player_id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: scrape_runs scrape_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scrape_runs
    ADD CONSTRAINT scrape_runs_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_created_at_idx ON auth.custom_oauth_providers USING btree (created_at);


--
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_enabled_idx ON auth.custom_oauth_providers USING btree (enabled);


--
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_identifier_idx ON auth.custom_oauth_providers USING btree (identifier);


--
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_provider_type_idx ON auth.custom_oauth_providers USING btree (provider_type);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: webauthn_challenges_expires_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_expires_at_idx ON auth.webauthn_challenges USING btree (expires_at);


--
-- Name: webauthn_challenges_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_user_id_idx ON auth.webauthn_challenges USING btree (user_id);


--
-- Name: webauthn_credentials_credential_id_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX webauthn_credentials_credential_id_key ON auth.webauthn_credentials USING btree (credential_id);


--
-- Name: webauthn_credentials_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_credentials_user_id_idx ON auth.webauthn_credentials USING btree (user_id);


--
-- Name: mv_attribute_leaderboard_player_id_attr_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX mv_attribute_leaderboard_player_id_attr_name_idx ON public.mv_attribute_leaderboard USING btree (player_id, attr_name);


--
-- Name: mv_batting_leaderboard_player_id_stat_key_league_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX mv_batting_leaderboard_player_id_stat_key_league_id_idx ON public.mv_batting_leaderboard USING btree (player_id, stat_key, league_id);


--
-- Name: mv_games_played_league_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX mv_games_played_league_type_idx ON public.mv_games_played USING btree (league_type);


--
-- Name: mv_league_batting_context_league_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX mv_league_batting_context_league_id_idx ON public.mv_league_batting_context USING btree (league_id);


--
-- Name: mv_league_pitching_context_league_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX mv_league_pitching_context_league_id_idx ON public.mv_league_pitching_context USING btree (league_id);


--
-- Name: mv_pitching_leaderboard_player_id_stat_key_league_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX mv_pitching_leaderboard_player_id_stat_key_league_id_idx ON public.mv_pitching_leaderboard USING btree (player_id, stat_key, league_id);


--
-- Name: player_attributes_accuracy_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_accuracy_idx ON public.player_attributes USING btree (accuracy);


--
-- Name: player_attributes_acrobatics_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_acrobatics_idx ON public.player_attributes USING btree (acrobatics);


--
-- Name: player_attributes_agility_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_agility_idx ON public.player_attributes USING btree (agility);


--
-- Name: player_attributes_aiming_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_aiming_idx ON public.player_attributes USING btree (aiming);


--
-- Name: player_attributes_arm_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_arm_idx ON public.player_attributes USING btree (arm);


--
-- Name: player_attributes_awareness_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_awareness_idx ON public.player_attributes USING btree (awareness);


--
-- Name: player_attributes_composure_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_composure_idx ON public.player_attributes USING btree (composure);


--
-- Name: player_attributes_contact_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_contact_idx ON public.player_attributes USING btree (contact);


--
-- Name: player_attributes_control_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_control_idx ON public.player_attributes USING btree (control);


--
-- Name: player_attributes_cunning_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_cunning_idx ON public.player_attributes USING btree (cunning);


--
-- Name: player_attributes_deception_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_deception_idx ON public.player_attributes USING btree (deception);


--
-- Name: player_attributes_defiance_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_defiance_idx ON public.player_attributes USING btree (defiance);


--
-- Name: player_attributes_determination_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_determination_idx ON public.player_attributes USING btree (determination);


--
-- Name: player_attributes_dexterity_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_dexterity_idx ON public.player_attributes USING btree (dexterity);


--
-- Name: player_attributes_discipline_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_discipline_idx ON public.player_attributes USING btree (discipline);


--
-- Name: player_attributes_greed_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_greed_idx ON public.player_attributes USING btree (greed);


--
-- Name: player_attributes_guts_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_guts_idx ON public.player_attributes USING btree (guts);


--
-- Name: player_attributes_insight_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_insight_idx ON public.player_attributes USING btree (insight);


--
-- Name: player_attributes_intimidation_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_intimidation_idx ON public.player_attributes USING btree (intimidation);


--
-- Name: player_attributes_intuition_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_intuition_idx ON public.player_attributes USING btree (intuition);


--
-- Name: player_attributes_lift_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_lift_idx ON public.player_attributes USING btree (lift);


--
-- Name: player_attributes_luck_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_luck_idx ON public.player_attributes USING btree (luck);


--
-- Name: player_attributes_muscle_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_muscle_idx ON public.player_attributes USING btree (muscle);


--
-- Name: player_attributes_patience_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_patience_idx ON public.player_attributes USING btree (patience);


--
-- Name: player_attributes_performance_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_performance_idx ON public.player_attributes USING btree (performance);


--
-- Name: player_attributes_persuasion_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_persuasion_idx ON public.player_attributes USING btree (persuasion);


--
-- Name: player_attributes_player_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_player_id_idx ON public.player_attributes USING btree (player_id);


--
-- Name: player_attributes_presence_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_presence_idx ON public.player_attributes USING btree (presence);


--
-- Name: player_attributes_reaction_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_reaction_idx ON public.player_attributes USING btree (reaction);


--
-- Name: player_attributes_rotation_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_rotation_idx ON public.player_attributes USING btree (rotation);


--
-- Name: player_attributes_selflessness_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_selflessness_idx ON public.player_attributes USING btree (selflessness);


--
-- Name: player_attributes_speed_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_speed_idx ON public.player_attributes USING btree (speed);


--
-- Name: player_attributes_stamina_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_stamina_idx ON public.player_attributes USING btree (stamina);


--
-- Name: player_attributes_stealth_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_stealth_idx ON public.player_attributes USING btree (stealth);


--
-- Name: player_attributes_stuff_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_stuff_idx ON public.player_attributes USING btree (stuff);


--
-- Name: player_attributes_velocity_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_velocity_idx ON public.player_attributes USING btree (velocity);


--
-- Name: player_attributes_vision_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_vision_idx ON public.player_attributes USING btree (vision);


--
-- Name: player_attributes_wisdom_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_attributes_wisdom_idx ON public.player_attributes USING btree (wisdom);


--
-- Name: player_details_player_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_details_player_id_idx ON public.player_details USING btree (player_id);


--
-- Name: player_stats_ba_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_ba_idx ON public.player_stats USING btree (ba);


--
-- Name: player_stats_babip_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_babip_idx ON public.player_stats USING btree (babip);


--
-- Name: player_stats_bb9_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_bb9_idx ON public.player_stats USING btree (bb9);


--
-- Name: player_stats_caught_stealing_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_caught_stealing_idx ON public.player_stats USING btree (caught_stealing);


--
-- Name: player_stats_doubles_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_doubles_idx ON public.player_stats USING btree (doubles);


--
-- Name: player_stats_era_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_era_idx ON public.player_stats USING btree (era);


--
-- Name: player_stats_h9_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_h9_idx ON public.player_stats USING btree (h9);


--
-- Name: player_stats_hit_batters_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_hit_batters_idx ON public.player_stats USING btree (hit_batters);


--
-- Name: player_stats_hit_by_pitch_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_hit_by_pitch_idx ON public.player_stats USING btree (hit_by_pitch);


--
-- Name: player_stats_hits_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_hits_idx ON public.player_stats USING btree (hits);


--
-- Name: player_stats_home_runs_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_home_runs_idx ON public.player_stats USING btree (home_runs);


--
-- Name: player_stats_hr9_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_hr9_idx ON public.player_stats USING btree (hr9);


--
-- Name: player_stats_innings_pitched_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_innings_pitched_idx ON public.player_stats USING btree (innings_pitched);


--
-- Name: player_stats_k9_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_k9_idx ON public.player_stats USING btree (k9);


--
-- Name: player_stats_losses_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_losses_idx ON public.player_stats USING btree (losses);


--
-- Name: player_stats_obp_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_obp_idx ON public.player_stats USING btree (obp);


--
-- Name: player_stats_ops_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_ops_idx ON public.player_stats USING btree (ops);


--
-- Name: player_stats_plate_appearances_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_plate_appearances_idx ON public.player_stats USING btree (plate_appearances);


--
-- Name: player_stats_player_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_player_id_idx ON public.player_stats USING btree (player_id);


--
-- Name: player_stats_quality_starts_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_quality_starts_idx ON public.player_stats USING btree (quality_starts);


--
-- Name: player_stats_rcs_pct_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_rcs_pct_idx ON public.player_stats USING btree (rcs_pct);


--
-- Name: player_stats_runs_batted_in_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_runs_batted_in_idx ON public.player_stats USING btree (runs_batted_in);


--
-- Name: player_stats_saves_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_saves_idx ON public.player_stats USING btree (saves);


--
-- Name: player_stats_shutouts_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_shutouts_idx ON public.player_stats USING btree (shutouts);


--
-- Name: player_stats_singles_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_singles_idx ON public.player_stats USING btree (singles);


--
-- Name: player_stats_slg_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_slg_idx ON public.player_stats USING btree (slg);


--
-- Name: player_stats_stolen_bases_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_stolen_bases_idx ON public.player_stats USING btree (stolen_bases);


--
-- Name: player_stats_strikeouts_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_strikeouts_idx ON public.player_stats USING btree (strikeouts);


--
-- Name: player_stats_struck_out_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_struck_out_idx ON public.player_stats USING btree (struck_out);


--
-- Name: player_stats_triples_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_triples_idx ON public.player_stats USING btree (triples);


--
-- Name: player_stats_walked_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_walked_idx ON public.player_stats USING btree (walked);


--
-- Name: player_stats_walks_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_walks_idx ON public.player_stats USING btree (walks);


--
-- Name: player_stats_whip_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_whip_idx ON public.player_stats USING btree (whip);


--
-- Name: player_stats_wins_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX player_stats_wins_idx ON public.player_stats USING btree (wins);


--
-- Name: players_team_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX players_team_id_idx ON public.players USING btree (team_id);


--
-- Name: teams_league_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX teams_league_id_idx ON public.teams USING btree (league_id);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_action_filter_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_action_filter_key ON realtime.subscription USING btree (subscription_id, entity, filters, action_filter);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_buckets_delete BEFORE DELETE ON storage.buckets FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_objects_delete BEFORE DELETE ON storage.objects FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: webauthn_challenges webauthn_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: webauthn_credentials webauthn_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: player_attributes player_attributes_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_attributes
    ADD CONSTRAINT player_attributes_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: player_details player_details_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_details
    ADD CONSTRAINT player_details_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: player_stats player_stats_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player_stats
    ADD CONSTRAINT player_stats_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: players players_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: teams teams_league_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_league_id_fkey FOREIGN KEY (league_id) REFERENCES public.leagues(id);


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: leagues; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.leagues ENABLE ROW LEVEL SECURITY;

--
-- Name: player_attributes; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.player_attributes ENABLE ROW LEVEL SECURITY;

--
-- Name: player_details; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.player_details ENABLE ROW LEVEL SECURITY;

--
-- Name: player_stats; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.player_stats ENABLE ROW LEVEL SECURITY;

--
-- Name: players; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.players ENABLE ROW LEVEL SECURITY;

--
-- Name: leagues public read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "public read" ON public.leagues FOR SELECT USING (true);


--
-- Name: player_attributes public read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "public read" ON public.player_attributes FOR SELECT USING (true);


--
-- Name: player_details public read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "public read" ON public.player_details FOR SELECT USING (true);


--
-- Name: player_stats public read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "public read" ON public.player_stats FOR SELECT USING (true);


--
-- Name: players public read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "public read" ON public.players FOR SELECT USING (true);


--
-- Name: scrape_runs public read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "public read" ON public.scrape_runs FOR SELECT USING (true);


--
-- Name: teams public read; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "public read" ON public.teams FOR SELECT USING (true);


--
-- Name: scrape_runs; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.scrape_runs ENABLE ROW LEVEL SECURITY;

--
-- Name: teams; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.teams ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION pg_reload_conf(); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pg_catalog.pg_reload_conf() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION refresh_materialized_view(view_name text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.refresh_materialized_view(view_name text) TO anon;
GRANT ALL ON FUNCTION public.refresh_materialized_view(view_name text) TO authenticated;
GRANT ALL ON FUNCTION public.refresh_materialized_view(view_name text) TO service_role;


--
-- Name: FUNCTION rls_auto_enable(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.rls_auto_enable() TO anon;
GRANT ALL ON FUNCTION public.rls_auto_enable() TO authenticated;
GRANT ALL ON FUNCTION public.rls_auto_enable() TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE custom_oauth_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.custom_oauth_providers TO postgres;
GRANT ALL ON TABLE auth.custom_oauth_providers TO dashboard_user;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- Name: TABLE oauth_client_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_client_states TO postgres;
GRANT ALL ON TABLE auth.oauth_client_states TO dashboard_user;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE webauthn_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_challenges TO postgres;
GRANT ALL ON TABLE auth.webauthn_challenges TO dashboard_user;


--
-- Name: TABLE webauthn_credentials; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_credentials TO postgres;
GRANT ALL ON TABLE auth.webauthn_credentials TO dashboard_user;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE leagues; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.leagues TO anon;
GRANT ALL ON TABLE public.leagues TO authenticated;
GRANT ALL ON TABLE public.leagues TO service_role;


--
-- Name: TABLE player_attributes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.player_attributes TO anon;
GRANT ALL ON TABLE public.player_attributes TO authenticated;
GRANT ALL ON TABLE public.player_attributes TO service_role;


--
-- Name: TABLE players; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.players TO anon;
GRANT ALL ON TABLE public.players TO authenticated;
GRANT ALL ON TABLE public.players TO service_role;


--
-- Name: TABLE teams; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.teams TO anon;
GRANT ALL ON TABLE public.teams TO authenticated;
GRANT ALL ON TABLE public.teams TO service_role;


--
-- Name: TABLE mv_attribute_leaderboard; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.mv_attribute_leaderboard TO anon;
GRANT ALL ON TABLE public.mv_attribute_leaderboard TO authenticated;
GRANT ALL ON TABLE public.mv_attribute_leaderboard TO service_role;


--
-- Name: TABLE mv_games_played; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.mv_games_played TO anon;
GRANT ALL ON TABLE public.mv_games_played TO authenticated;
GRANT ALL ON TABLE public.mv_games_played TO service_role;


--
-- Name: TABLE player_stats; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.player_stats TO anon;
GRANT ALL ON TABLE public.player_stats TO authenticated;
GRANT ALL ON TABLE public.player_stats TO service_role;


--
-- Name: TABLE mv_batting_leaderboard; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.mv_batting_leaderboard TO anon;
GRANT ALL ON TABLE public.mv_batting_leaderboard TO authenticated;
GRANT ALL ON TABLE public.mv_batting_leaderboard TO service_role;


--
-- Name: TABLE mv_league_batting_context; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.mv_league_batting_context TO anon;
GRANT ALL ON TABLE public.mv_league_batting_context TO authenticated;
GRANT ALL ON TABLE public.mv_league_batting_context TO service_role;


--
-- Name: TABLE mv_league_pitching_context; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.mv_league_pitching_context TO anon;
GRANT ALL ON TABLE public.mv_league_pitching_context TO authenticated;
GRANT ALL ON TABLE public.mv_league_pitching_context TO service_role;


--
-- Name: TABLE mv_pitching_leaderboard; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.mv_pitching_leaderboard TO anon;
GRANT ALL ON TABLE public.mv_pitching_leaderboard TO authenticated;
GRANT ALL ON TABLE public.mv_pitching_leaderboard TO service_role;


--
-- Name: TABLE player_details; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.player_details TO anon;
GRANT ALL ON TABLE public.player_details TO authenticated;
GRANT ALL ON TABLE public.player_details TO service_role;


--
-- Name: TABLE scrape_runs; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.scrape_runs TO anon;
GRANT ALL ON TABLE public.scrape_runs TO authenticated;
GRANT ALL ON TABLE public.scrape_runs TO service_role;


--
-- Name: SEQUENCE scrape_runs_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.scrape_runs_id_seq TO anon;
GRANT ALL ON SEQUENCE public.scrape_runs_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.scrape_runs_id_seq TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.buckets FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.buckets TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE buckets_vectors; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.buckets_vectors TO service_role;
GRANT SELECT ON TABLE storage.buckets_vectors TO authenticated;
GRANT SELECT ON TABLE storage.buckets_vectors TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.objects FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.objects TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE vector_indexes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.vector_indexes TO service_role;
GRANT SELECT ON TABLE storage.vector_indexes TO authenticated;
GRANT SELECT ON TABLE storage.vector_indexes TO anon;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: ensure_rls; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER ensure_rls ON ddl_command_end
         WHEN TAG IN ('CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO')
   EXECUTE FUNCTION public.rls_auto_enable();


ALTER EVENT TRIGGER ensure_rls OWNER TO postgres;

--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

\unrestrict bgfVe3OyOWofkc9Nt4ypFCyGft2oSRihRB4rbABwstdTaJFkgROowpXwlqAwMxL

