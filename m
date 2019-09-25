From: Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2 17/27] drm/dp_mst: Rename drm_dp_add_port and
 drm_dp_update_port
Date: Wed, 25 Sep 2019 15:30:09 -0400
Message-ID: <20190925193009.GI218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-18-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190903204645.25487-18-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Sep 03, 2019 at 04:45:55PM -0400, Lyude Paul wrote:
> The names for these functions are rather confusing. drm_dp_add_port()
> sounds like a function that would simply create a port and add it to a
> topology, and do nothing more. Similarly, drm_dp_update_port() would be
> assumed to be the function that should be used to update port
> information after initial creation.
> 
> While those assumptions are currently correct in how these functions are
> used, a quick glance at drm_dp_add_port() reveals that drm_dp_add_port()
> can also update the information on a port, and seems explicitly designed
> to do so. This can be explained pretty simply by the fact that there's
> more situations that would involve updating the port information based
> on a link address response as opposed to a connection status
> notification than the driver's initial topology probe. Case in point:
> reprobing link addresses after suspend/resume.
> 
> Since we're about to start using drm_dp_add_port() differently for
> suspend/resume reprobing, let's rename both functions to clarify what
> they actually do.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 9944ef2ce885..cfaf9eb7ace9 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1900,9 +1900,10 @@ void drm_dp_mst_connector_early_unregister(struct drm_connector *connector,
>  }
>  EXPORT_SYMBOL(drm_dp_mst_connector_early_unregister);
>  
> -static void drm_dp_add_port(struct drm_dp_mst_branch *mstb,
> -			    struct drm_device *dev,
> -			    struct drm_dp_link_addr_reply_port *port_msg)
> +static void
> +drm_dp_mst_handle_link_address_port(struct drm_dp_mst_branch *mstb,
> +				    struct drm_device *dev,
> +				    struct drm_dp_link_addr_reply_port *port_msg)
>  {
>  	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
>  	struct drm_dp_mst_port *port;
> @@ -2011,8 +2012,9 @@ static void drm_dp_add_port(struct drm_dp_mst_branch *mstb,
>  	drm_dp_mst_topology_put_port(port);
>  }
>  
> -static void drm_dp_update_port(struct drm_dp_mst_branch *mstb,
> -			       struct drm_dp_connection_status_notify *conn_stat)
> +static void
> +drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
> +			    struct drm_dp_connection_status_notify *conn_stat)
>  {
>  	struct drm_dp_mst_port *port;
>  	int old_ddps;
> @@ -2464,7 +2466,8 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
>  	drm_dp_check_mstb_guid(mstb, reply->guid);
>  
>  	for (i = 0; i < reply->nports; i++)
> -		drm_dp_add_port(mstb, mgr->dev, &reply->ports[i]);
> +		drm_dp_mst_handle_link_address_port(mstb, mgr->dev,
> +						    &reply->ports[i]);
>  
>  	drm_kms_helper_hotplug_event(mgr->dev);
>  
> @@ -3324,7 +3327,7 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
>  	}
>  
>  	if (msg.req_type == DP_CONNECTION_STATUS_NOTIFY) {
> -		drm_dp_update_port(mstb, &msg.u.conn_stat);
> +		drm_dp_mst_handle_conn_stat(mstb, &msg.u.conn_stat);
>  
>  		DRM_DEBUG_KMS("Got CSN: pn: %d ldps:%d ddps: %d mcs: %d ip: %d pdt: %d\n",
>  			      msg.u.conn_stat.port_number,
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
