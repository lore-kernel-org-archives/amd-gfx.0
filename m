From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [WIP PATCH 01/15] drm/dp_mst: Remove bogus conditional in
 drm_dp_update_payload_part1()
Date: Fri, 14 Dec 2018 09:42:21 +0100
Message-ID: <20181214084220.GL21184@phenom.ffwll.local>
References: <20181214012604.13746-1-lyude@redhat.com>
 <20181214012604.13746-2-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181214012604.13746-2-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>, Juston Li <juston.li@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Dec 13, 2018 at 08:25:30PM -0500, Lyude Paul wrote:
> There's no reason we need this, it's just confusing looking.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Juston Li <juston.li@intel.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index ad0fb6d003be..9b1b5c9b1fa0 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1896,9 +1896,7 @@ int drm_dp_update_payload_part1(struct drm_dp_mst_topology_mgr *mgr)
>  			req_payload.num_slots = 0;
>  		}
>  
> -		if (mgr->payloads[i].start_slot != req_payload.start_slot) {
> -			mgr->payloads[i].start_slot = req_payload.start_slot;
> -		}
> +		mgr->payloads[i].start_slot = req_payload.start_slot;

Entertaining!

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  		/* work out what is required to happen with this payload */
>  		if (mgr->payloads[i].num_slots != req_payload.num_slots) {
>  
> -- 
> 2.19.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
