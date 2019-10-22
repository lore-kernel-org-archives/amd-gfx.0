From: Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v5 07/14] drm/dp_mst: Don't forget to update port->input
 in drm_dp_mst_handle_conn_stat()
Date: Tue, 22 Oct 2019 16:14:35 -0400
Message-ID: <20191022201435.GD212858@art_vandelay>
References: <20191022023641.8026-1-lyude@redhat.com>
 <20191022023641.8026-8-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191022023641.8026-8-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Sean Paul <sean@poorly.run>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Oct 21, 2019 at 10:36:02PM -0400, Lyude Paul wrote:
> This probably hasn't caused any problems up until now since it's
> probably nearly impossible to encounter this in the wild, however if we
> were to receive a connection status notification from the MST hub after
> resume while we're in the middle of reprobing the link addresses for a
> topology then there's a much larger chance that a port could have
> changed from being an output port to input port (or vice versa). If we
> forget to update this bit of information, we'll potentially ignore a
> valid PDT change on a downstream port because we think it's an input
> port.
> 
> So, make sure we read the input_port field in connection status
> notifications in drm_dp_mst_handle_conn_stat() to prevent this from
> happening once we've implemented suspend/resume reprobing.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Sean Paul <sean@poorly.run>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 52 +++++++++++++++++++--------
>  1 file changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 7bf4db91ff90..c8e218b902ae 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2079,18 +2079,40 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
>  {
>  	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
>  	struct drm_dp_mst_port *port;
> -	int old_ddps;
> -	bool dowork = false;
> +	int old_ddps, ret;
> +	u8 new_pdt;
> +	bool dowork = false, create_connector = false;
>  
>  	port = drm_dp_get_port(mstb, conn_stat->port_number);
>  	if (!port)
>  		return;
>  
> -	/* Locking is only needed if the port's exposed to userspace */
> -	if (port->connector)
> +	if (port->connector) {
> +		if (!port->input && conn_stat->input_port) {
> +			/*
> +			 * We can't remove a connector from an already exposed
> +			 * port, so just throw the port out and make sure we
> +			 * reprobe the link address of it's parent MSTB
> +			 */
> +			drm_dp_mst_topology_unlink_port(mgr, port);
> +			mstb->link_address_sent = false;
> +			dowork = true;
> +			goto out;
> +		}
> +
> +		/*
> +		 * Locking is only needed if the port's exposed to userspace
> +		 */

optional nit: this will still fit on one line

>  		drm_modeset_lock(&mgr->base.lock, NULL);
> +	} else if (port->input && !conn_stat->input_port) {
> +		create_connector = true;
> +		/* Reprobe link address so we get num_sdp_streams */
> +		mstb->link_address_sent = false;
> +		dowork = true;
> +	}
>  
>  	old_ddps = port->ddps;
> +	port->input = conn_stat->input_port;
>  	port->mcs = conn_stat->message_capability_status;
>  	port->ldps = conn_stat->legacy_device_plug_status;
>  	port->ddps = conn_stat->displayport_device_plug_status;
> @@ -2103,21 +2125,23 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
>  		}
>  	}
>  
> -	if (!port->input) {
> -		int ret = drm_dp_port_set_pdt(port,
> -					      conn_stat->peer_device_type);
> -		if (ret == 1) {
> -			dowork = true;
> -		} else if (ret < 0) {
> -			DRM_ERROR("Failed to change PDT for port %p: %d\n",
> -				  port, ret);
> -			dowork = false;
> -		}
> +	new_pdt = port->input ? DP_PEER_DEVICE_NONE : conn_stat->peer_device_type;
> +
> +	ret = drm_dp_port_set_pdt(port, new_pdt);
> +	if (ret == 1) {
> +		dowork = true;
> +	} else if (ret < 0) {
> +		DRM_ERROR("Failed to change PDT for port %p: %d\n",
> +			  port, ret);
> +		dowork = false;
>  	}
>  
>  	if (port->connector)
>  		drm_modeset_unlock(&mgr->base.lock);
> +	else if (create_connector)
> +		drm_dp_mst_port_add_connector(mstb, port);
>  
> +out:
>  	drm_dp_mst_topology_put_port(port);
>  	if (dowork)
>  		queue_work(system_long_wq, &mstb->mgr->work);
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
