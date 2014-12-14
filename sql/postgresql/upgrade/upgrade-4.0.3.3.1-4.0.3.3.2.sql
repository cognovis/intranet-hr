SELECT acs_log__debug('/packages/intranet-timesheet2/sql/postgresql/upgrade/upgrade-4.0.3.3.1-4.0.3.3.2.sql','');

-- -------------------------------------------------------
-- Create new Absence types for weekends
-- -------------------------------------------------------

CREATE OR REPLACE FUNCTION inline_0 () 
RETURNS INTEGER AS
$$
declare
begin

    perform im_component_plugin__delete(plugin_id) 
    from im_component_plugins 
    where plugin_name in ('User Reports');

    perform im_component_plugin__new (
        null,                               -- plugin_id
        'im_component_plugin',              -- object_type
        now(),                              -- creation_date
        null,                               -- creation_user
        null,                               -- creation_ip
        null,                               -- context_id
        'User Reports',                     -- plugin_name
        'intranet-timesheet2',              -- package_name
        'left',                             -- location
        '/intranet/users/view',             -- page_url
        null,                               -- view_name
        20,                                 -- sort_order
        E'im_user_reports_component -user_id [im_coalesce $user_id_from_search [ad_get_user_id]]'     -- component_tcl
    );

    perform acs_permission__grant_permission(
        plugin_id,
        (select group_id from groups where group_name = 'Employees'),
        'read')
    from im_component_plugins 
    where plugin_name in ('User Reports')
    and package_name = 'intranet-timesheet2';

    return 1;

end;
$$ LANGUAGE 'plpgsql';

SELECT inline_0 ();
DROP FUNCTION inline_0 ();

