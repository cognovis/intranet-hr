set absence_link \
    [export_vars \
        -base "/intranet-timesheet2/absences/index" \
        -url [list [list user_selection $employee_id] [list timescale all]]]

#set absence_link_html "<a href=\"$absence_link\">User Absences</a>"

set html [im_menu_ul_list -package_key "intranet-hr" "user_reports_component_menu" [list user_selection $employee_id]]
