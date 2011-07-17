<%inherit file="/base.mako"/>
<%def name="id()">task</%def>
<%def name="title()">Tile - ${tile.x} / ${tile.y}</%def>
<div class="content group wrap">
    <h1>${tile.job.title}</h1>
    <section class="task">
        <h2>${tile.x} / ${tile.y}</h2>
    </section>
    <section class="map">
        <div id="map"></div>
    </section>
</div>
<script type="text/javascript">
    var tiles = ${feature|n};
</script>
<script type="text/javascript" src="http://openlayers.org/dev/OpenLayers.js"></script>
<script type="text/javascript" src="${request.static_url('OSMTM:static/Div.js')}"></script>
<script type="text/javascript" src="${request.static_url('OSMTM:static/Static.js')}"></script>
<script type="text/javascript" src="${request.static_url('OSMTM:static/task.js')}"></script>
