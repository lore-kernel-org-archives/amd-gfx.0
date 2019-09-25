From: Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2 14/27] drm/dp_mst: Destroy topology_mgr mutexes
Date: Wed, 25 Sep 2019 15:14:08 -0400
Message-ID: <20190925191408.GG218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-15-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190903204645.25487-15-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Sep 03, 2019 at 04:45:52PM -0400, Lyude Paul wrote:
> Turns out we've been forgetting for a while now to actually destroy any
> of the mutexes that we create in drm_dp_mst_topology_mgr. So, let's do
> that.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Cleanup is overrated :)

Reviewed-by: Sean Paul <sean@poorly.run>


> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 74161f442584..2f88cc173500 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -4339,6 +4339,11 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_mst_topology_mgr *mgr)
>  	mgr->aux = NULL;
>  	drm_atomic_private_obj_fini(&mgr->base);
>  	mgr->funcs = NULL;
> +
> +	mutex_destroy(&mgr->delayed_destroy_lock);
> +	mutex_destroy(&mgr->payload_lock);
> +	mutex_destroy(&mgr->qlock);
> +	mutex_destroy(&mgr->lock);
>  }
>  EXPORT_SYMBOL(drm_dp_mst_topology_mgr_destroy);
>  
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
