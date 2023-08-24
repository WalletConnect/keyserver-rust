local grafana        = import '../../../grafonnet-lib/grafana.libsonnet';
local panels         = grafana.panels;
local targets        = grafana.targets;

local defaults  = import '../../defaults.libsonnet';

{
  new(ds, vars)::
    panels.timeseries(
      title       = 'Identity - Invalid JWT during Unregistration',
      datasource  = ds.prometheus,
    )
    .configure(defaults.configuration.timeseries)

    .addTarget(targets.prometheus(
      datasource  = ds.prometheus,
      expr        = 'sum(rate(invalid_identity_unregister_jwt{aws_ecs_task_family="%s"}[5m]))' % vars.ecs_task_family,
      refId       = "sources",
      exemplar    = true,
    ))
}
