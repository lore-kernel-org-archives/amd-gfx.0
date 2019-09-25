From: Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2 01/27] drm/dp_mst: Move link address dumping into a
 function
Date: Wed, 25 Sep 2019 13:45:00 -0400
Message-ID: <20190925174500.GB218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-2-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190903204645.25487-2-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Sep 03, 2019 at 04:45:39PM -0400, Lyude Paul wrote:
> Makes things easier to read.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Reviewed-by: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 35 ++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 82add736e17d..36db66a0ddb1 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2103,6 +2103,28 @@ static void drm_dp_queue_down_tx(struct drm_dp_mst_topology_mgr *mgr,
>  	mutex_unlock(&mgr->qlock);
>  }
>  
> +static void
> +drm_dp_dump_link_address(struct drm_dp_link_address_ack_reply *reply)
> +{
> +	struct drm_dp_link_addr_reply_port *port_reply;
> +	int i;
> +
> +	for (i = 0; i < reply->nports; i++) {
> +		port_reply = &reply->ports[i];
> +		DRM_DEBUG_KMS("port %d: input %d, pdt: %d, pn: %d, dpcd_rev: %02x, mcs: %d, ddps: %d, ldps %d, sdp %d/%d\n",
> +			      i,
> +			      port_reply->input_port,
> +			      port_reply->peer_device_type,
> +			      port_reply->port_number,
> +			      port_reply->dpcd_revision,
> +			      port_reply->mcs,
> +			      port_reply->ddps,
> +			      port_reply->legacy_device_plug_status,
> +			      port_reply->num_sdp_streams,
> +			      port_reply->num_sdp_stream_sinks);
> +	}
> +}
> +
>  static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
>  				     struct drm_dp_mst_branch *mstb)
>  {
> @@ -2128,18 +2150,7 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
>  			DRM_DEBUG_KMS("link address nak received\n");
>  		} else {
>  			DRM_DEBUG_KMS("link address reply: %d\n", txmsg->reply.u.link_addr.nports);
> -			for (i = 0; i < txmsg->reply.u.link_addr.nports; i++) {
> -				DRM_DEBUG_KMS("port %d: input %d, pdt: %d, pn: %d, dpcd_rev: %02x, mcs: %d, ddps: %d, ldps %d, sdp %d/%d\n", i,
> -				       txmsg->reply.u.link_addr.ports[i].input_port,
> -				       txmsg->reply.u.link_addr.ports[i].peer_device_type,
> -				       txmsg->reply.u.link_addr.ports[i].port_number,
> -				       txmsg->reply.u.link_addr.ports[i].dpcd_revision,
> -				       txmsg->reply.u.link_addr.ports[i].mcs,
> -				       txmsg->reply.u.link_addr.ports[i].ddps,
> -				       txmsg->reply.u.link_addr.ports[i].legacy_device_plug_status,
> -				       txmsg->reply.u.link_addr.ports[i].num_sdp_streams,
> -				       txmsg->reply.u.link_addr.ports[i].num_sdp_stream_sinks);
> -			}
> +			drm_dp_dump_link_address(&txmsg->reply.u.link_addr);
>  
>  			drm_dp_check_mstb_guid(mstb, txmsg->reply.u.link_addr.guid);
>  
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
