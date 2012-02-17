<%!
    import markdown
%>
% if not tile:
    <form action="${request.route_url('task_take_random', job=job.id, checkin=0)}">
        <input type="submit" class="btn btn-primary input" href="${request.route_url('task_take_random', job=job.id, checkin=0)}" rel="twipsy" data-original-title="The task will be chosen for you by the system" value="Take a task" />
        Or choose one by <strong>clicking</strong> on the map.
    </form>
    <p class="small">If you're an experienced mapper, you can also be given a task to <a href="${request.route_url('task_take_random', job=job.id, checkin=1)}" id="validate">validate</a>.</p>
% else:
        <div> 
            % if tile.username:
            <form action="${request.route_url('task_done', job=tile.job_id, x=tile.x, y=tile.y)}" class="form-horizontal">
                <div class="well">
                    <p>1. Open the area in your favorite editing tool.</p>
                    <div class="row">
                        <div class="span1">&nbsp;</div>
                        <div class="span4">
                            <div id="export">
                                <a class="btn btn-small btn-info" data-toggle="modal" href="#josm_export_info" id="josm">JOSM</a>
                                <a class="btn btn-small btn-info" data-toggle="modal" href="#potlatch2_export_info" id="potlatch2">Potlatch 2</a>
                                <a class="btn btn-small btn-info" href="javascript:void(0);" id="wp">Walking Papers</a>
                            </div>
                        </div>
                    </div>
                </div>
            % if tile.checkin == 0:
                <div class="well">
                    <p>2. Trace the elements as asked in the job&apos;s
                    <a href="javascript:void(0);" rel="popover" data-content="${markdown.markdown(tile.job.description)|h}" title="Description">description</a>
                    and <a href="javascript:void(0);" rel="popover" data-content="${markdown.markdown(tile.job.workflow)|h}" title="Workflow">workflow.</a></p>
                    <%include file="imagery.mako" />
                </div>
                <div class="well">
                    <p>3. Add a comment and mark the task as done.</p>
                    <div class="control-group">
                        <label for="task_comment" class="control-label">Comment</label>
                        <div class="controls">
                            <textarea id="task_comment" name="comment"></textarea>
                        </div>
                    </div>
                    <div class="input">
                        <input type="submit" class="btn btn-primary" value="Mark task as done"/>
                    </div>
                </div>
            % else:
                <div class="well">
                    <p>2. Review the work done as asked in the job&apos;s 
                    <a href="javascript:void(0);" rel="popover" data-content="${tile.job.description|h}" title="Description">description</a>
                    and <a href="javascript:void(0);" rel="popover" data-content="${tile.job.workflow|h}" title="Workflow">workflow.</a></p>
                    <%include file="imagery.mako" />
                    <%include file="task.comments.mako" />
                </div>
                <div class="well">
                    <p>3. Give a thumb up if work is correct and complete, or send the task back to the queue.</p>
                    <div class="control-group">
                        <label for="task_comment" class="control-label">Comment</label>
                        <div class="controls">
                            <textarea id="task_comment" name="comment"></textarea>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="controls">
                        <button type="submit" value="Invalidate" name="invalidate" class="btn thumbdown input btn-danger">
                            <img src="${request.static_url('OSMTM:static/thumb.png')}" />
                            Invalidate
                        </button>
                        <button type="submit" value="Validate" name="validate" class="btn thumbup btn-success">
                            <img src="${request.static_url('OSMTM:static/thumb-up.png')}" />
                            Validate
                        </button>
                        </div>
                    </div>
                </div>
            % endif
            <p>
                Can't work on this task right now? No problem.
                <a href="${request.route_url('task_unlock', job=tile.job_id, x=tile.x, y=tile.y)}" id="unlock">Unlock it!</a>. Otherwise, it will be automatically unlocked in <span id="countdown"></span> minutes.
            </p>
            </form>
            <div id="josm_export_info" class="modal hide fade" style="display:none;">
                <div class="modal-header">
                    <a href="#" class="close" data-dismiss="modal">&times;</a>
                    <h3>Using JOSM?</h3>
                </div>
                <div class="modal-body">
                    <p>If you have JOSM already running, closing this dialog box should load data for the area of the current task,</dd>
                    <p>Or you can manually open JOSM using the following <a href="${request.route_url('task_export', job=tile.job_id, x=tile.x, y=tile.y)}" target="_blank">.osm file.</a>
                    <span class="help-block">Right-click on the link to download the file.</span>
                    </p>
                </div>
            </div>
            <div id="potlatch2_export_info" class="modal hide fade" style="display:none;">
                <div class="modal-header">
                    <a href="#" class="close" data-dismiss="modal">&times;</a>
                    <h3>Using Potlatch2?</h3>
                </div>
                <div class="modal-body">
                    <p>
                    Please consider adding the tasks extent as a new vector file using the following url: <br />
                    <code>${request.route_url('task_export', job=tile.job_id, x=tile.x, y=tile.y)}</code><br />
                    </p>
                    <p class="help-block">Copy the above link and close this dialog box. You'll then be redirected to Potlatch.</p>
                </div>
            </div>
            % endif
        </div>

    <script type="text/javascript">
        <%
            from geojson import dumps
            feature = dumps(tile.to_polygon())
        %>
        var tiles = ${feature|n};
    </script>
% endif
