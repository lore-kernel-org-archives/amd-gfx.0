From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [WIP PATCH 04/15] drm/dp_mst: Stop releasing VCPI when removing
 ports from topology
Date: Fri, 14 Dec 2018 10:40:44 +0100
Message-ID: <20181214094044.GQ21184@phenom.ffwll.local>
References: <20181214012604.13746-1-lyude@redhat.com>
 <20181214012604.13746-5-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181214012604.13746-5-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Dec 13, 2018 at 08:25:33PM -0500, Lyude Paul wrote:
> This has never actually worked, and isn't needed anyway: the driver's
> always going to try to deallocate VCPI when it tears down the display
> that the VCPI belongs to.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index c196fb580beb..ae9d019af9f2 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1084,8 +1084,6 @@ static void drm_dp_destroy_port(struct kref *kref)
>  	struct drm_dp_mst_topology_mgr *mgr = port->mgr;
>  
>  	if (!port->input) {
> -		port->vcpi.num_slots = 0;
> -
>  		kfree(port->cached_edid);
>  
>  		/*
> @@ -3381,12 +3379,6 @@ static void drm_dp_destroy_connector_work(struct work_struct *work)
>  		drm_dp_port_teardown_pdt(port, port->pdt);
>  		port->pdt = DP_PEER_DEVICE_NONE;
>  
> -		if (!port->input && port->vcpi.vcpi > 0) {
> -			drm_dp_mst_reset_vcpi_slots(mgr, port);
> -			drm_dp_update_payload_part1(mgr);
> -			drm_dp_mst_put_payload_id(mgr, port->vcpi.vcpi);
> -		}
> -
>  		drm_dp_mst_put_port_malloc(port);
>  		send_hotplug = true;
>  	}
> -- 
> 2.19.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
