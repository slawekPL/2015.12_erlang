-record(talk,  {title :: string(), start_time :: calendar:datetime(), end_time :: calendar:datetime(), location :: string()}).
-record(state, {table :: ets:tab()}).