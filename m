From: Lyude Paul <lyude@redhat.com>
Subject: Re: [Intel-gfx] [PATCH 3/6] drm/i915: Leave intel_conn->mst_port
 set, use mst_port_gone instead
Date: Fri, 21 Sep 2018 16:17:16 -0400
Message-ID: <472fd6a7a46d44c079ce45b67ed23dee35dd96cf.camel@redhat.com>
References: <20180918230637.20700-1-lyude@redhat.com>
         <20180918230637.20700-4-lyude@redhat.com>
         <20180921092746.GC11082@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180921092746.GC11082@phenom.ffwll.local>
Sender: stable-owner@vger.kernel.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, 2018-09-21 at 11:27 +0200, Daniel Vetter wrote:
> On Tue, Sep 18, 2018 at 07:06:19PM -0400, Lyude Paul wrote:
> > Currently we set intel_connector->mst_port to NULL to signify that the
> > MST port has been removed from the system so that we can prevent further
> > action on the port such as connector probes, mode probing, etc.
> > However, we're going to need access to intel_connector->mst_port in
> > order to fixup ->best_encoder() so that it can always return the correct
> > encoder for an MST port to prevent legacy DPMS prop changes from
> > failing. This should be safe, so instead keep intel_connector->mst_port
> > always set and instead add intel_connector->mst_port_gone in order to
> > signify whether or not the connector has disappeared from the system.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: stable@vger.kernel.org
> 
> Hm, how exactly do legacy DPMS setprop blow up here? Or at least I can't
> come up with a scenario that's specific to legacy props, atomic should be
> equally affected. By the time we land in this code, the core code already
> remapping it to be purely an atomic update.
So, what I've been seeing with X that's been blowing this up:
 * Hotplug event gets received, X does reprobe
 * Notices MST connectors are now disconnected, sets DPMS from on->off
 * During atomic_check, drm_atomic_helper_check_modeset() is called
 * update_connector_routing() gets called
 * funcs->best_encoder() returns NULL for the encoder
 * update_connector_routing() fails atomic commit with "No suitable encoder
   found", line 320 of drm_atomic_helper
> 
> Another thought: Should we handle at least some of this in the probe
> helpers? I.e. once you unplugged a drm_connector, it always shows
> disconnected and mode list is gone, instead of duplicating this over all
> drivers. We could just check connector->registered.
oooh, good idea! I will certainly go do that
> 
> Thanks, Daniel
> > ---
> >  drivers/gpu/drm/i915/intel_dp_mst.c | 14 +++++++-------
> >  drivers/gpu/drm/i915/intel_drv.h    |  1 +
> >  2 files changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c
> > b/drivers/gpu/drm/i915/intel_dp_mst.c
> > index 4ecd65375603..fcb9b87b9339 100644
> > --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> > +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> > @@ -311,9 +311,8 @@ static int intel_dp_mst_get_ddc_modes(struct
> > drm_connector *connector)
> >  	struct edid *edid;
> >  	int ret;
> >  
> > -	if (!intel_dp) {
> > +	if (intel_connector->mst_port_gone)
> >  		return intel_connector_update_modes(connector, NULL);
> > -	}
> >  
> >  	edid = drm_dp_mst_get_edid(connector, &intel_dp->mst_mgr,
> > intel_connector->port);
> >  	ret = intel_connector_update_modes(connector, edid);
> > @@ -328,9 +327,10 @@ intel_dp_mst_detect(struct drm_connector *connector,
> > bool force)
> >  	struct intel_connector *intel_connector =
> > to_intel_connector(connector);
> >  	struct intel_dp *intel_dp = intel_connector->mst_port;
> >  
> > -	if (!intel_dp)
> > +	if (intel_connector->mst_port_gone)
> >  		return connector_status_disconnected;
> > -	return drm_dp_mst_detect_port(connector, &intel_dp->mst_mgr,
> > intel_connector->port);
> > +	return drm_dp_mst_detect_port(connector, &intel_dp->mst_mgr,
> > +				      intel_connector->port);
> >  }
> >  
> >  static void
> > @@ -370,7 +370,7 @@ intel_dp_mst_mode_valid(struct drm_connector
> > *connector,
> >  	int bpp = 24; /* MST uses fixed bpp */
> >  	int max_rate, mode_rate, max_lanes, max_link_clock;
> >  
> > -	if (!intel_dp)
> > +	if (intel_connector->mst_port_gone)
> >  		return MODE_ERROR;
> >  
> >  	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
> > @@ -402,7 +402,7 @@ static struct drm_encoder
> > *intel_mst_atomic_best_encoder(struct drm_connector *c
> >  	struct intel_dp *intel_dp = intel_connector->mst_port;
> >  	struct intel_crtc *crtc = to_intel_crtc(state->crtc);
> >  
> > -	if (!intel_dp)
> > +	if (intel_connector->mst_port_gone)
> >  		return NULL;
> >  	return &intel_dp->mst_encoders[crtc->pipe]->base.base;
> >  }
> > @@ -514,7 +514,7 @@ static void intel_dp_destroy_mst_connector(struct
> > drm_dp_mst_topology_mgr *mgr,
> >  						   connector);
> >  	/* prevent race with the check in ->detect */
> >  	drm_modeset_lock(&connector->dev->mode_config.connection_mutex, NULL);
> > -	intel_connector->mst_port = NULL;
> > +	intel_connector->mst_port_gone = true;
> >  	drm_modeset_unlock(&connector->dev->mode_config.connection_mutex);
> >  
> >  	drm_connector_put(connector);
> > diff --git a/drivers/gpu/drm/i915/intel_drv.h
> > b/drivers/gpu/drm/i915/intel_drv.h
> > index 8fc61e96754f..87ce772ae7f8 100644
> > --- a/drivers/gpu/drm/i915/intel_drv.h
> > +++ b/drivers/gpu/drm/i915/intel_drv.h
> > @@ -409,6 +409,7 @@ struct intel_connector {
> >  	void *port; /* store this opaque as its illegal to dereference it */
> >  
> >  	struct intel_dp *mst_port;
> > +	bool mst_port_gone;
> >  
> >  	/* Work struct to schedule a uevent on link train failure */
> >  	struct work_struct modeset_retry_work;
> > -- 
> > 2.17.1
> > 
> > _______________________________________________
> > Intel-gfx mailing list
> > Intel-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> 
> 
-- 
Cheers,
	Lyude Paul
