From: Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2 08/27] drm/dp_mst: Remove PDT teardown in
 drm_dp_destroy_port() and refactor
Date: Wed, 25 Sep 2019 15:00:58 -0400
Message-ID: <20190925190058.GF218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-9-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190903204645.25487-9-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Sep 03, 2019 at 04:45:46PM -0400, Lyude Paul wrote:
> This will allow us to add some locking for port->* members, in
> particular the PDT and ->connector, which can't be done from
> drm_dp_destroy_port() since we don't know what locks the caller might be
> holding.

Might be nice to mention that this is already done in the delayed destroy worker
so readers don't need to go looking for it. Perhaps update this when you apply
the patch.

> 
> Changes since v2:
> * Clarify commit message
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 40 +++++++++++----------------
>  1 file changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index f5f1d8b50fb6..af3189df28aa 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1511,31 +1511,22 @@ static void drm_dp_destroy_port(struct kref *kref)
>  		container_of(kref, struct drm_dp_mst_port, topology_kref);
>  	struct drm_dp_mst_topology_mgr *mgr = port->mgr;
>  
> -	if (!port->input) {
> -		kfree(port->cached_edid);
> +	/* There's nothing that needs locking to destroy an input port yet */
> +	if (port->input) {
> +		drm_dp_mst_put_port_malloc(port);
> +		return;
> +	}
>  
> -		/*
> -		 * The only time we don't have a connector
> -		 * on an output port is if the connector init
> -		 * fails.
> -		 */
> -		if (port->connector) {
> -			/* we can't destroy the connector here, as
> -			 * we might be holding the mode_config.mutex
> -			 * from an EDID retrieval */
> +	kfree(port->cached_edid);
>  
> -			mutex_lock(&mgr->delayed_destroy_lock);
> -			list_add(&port->next, &mgr->destroy_port_list);
> -			mutex_unlock(&mgr->delayed_destroy_lock);
> -			schedule_work(&mgr->delayed_destroy_work);
> -			return;
> -		}
> -		/* no need to clean up vcpi
> -		 * as if we have no connector we never setup a vcpi */
> -		drm_dp_port_teardown_pdt(port, port->pdt);
> -		port->pdt = DP_PEER_DEVICE_NONE;
> -	}
> -	drm_dp_mst_put_port_malloc(port);
> +	/*
> +	 * we can't destroy the connector here, as we might be holding the
> +	 * mode_config.mutex from an EDID retrieval
> +	 */
> +	mutex_lock(&mgr->delayed_destroy_lock);
> +	list_add(&port->next, &mgr->destroy_port_list);
> +	mutex_unlock(&mgr->delayed_destroy_lock);
> +	schedule_work(&mgr->delayed_destroy_work);
>  }
>  
>  /**
> @@ -3998,7 +3989,8 @@ static void drm_dp_tx_work(struct work_struct *work)
>  static inline void
>  drm_dp_delayed_destroy_port(struct drm_dp_mst_port *port)
>  {
> -	port->mgr->cbs->destroy_connector(port->mgr, port->connector);
> +	if (port->connector)
> +		port->mgr->cbs->destroy_connector(port->mgr, port->connector);
>  
>  	drm_dp_port_teardown_pdt(port, port->pdt);
>  	port->pdt = DP_PEER_DEVICE_NONE;
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
