From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 3/3] drm/dp_mst: Add __must_check to
 drm_dp_mst_topology_mgr_resume()
Date: Tue, 8 Jan 2019 09:06:35 +0100
Message-ID: <20190108080635.GO21184@phenom.ffwll.local>
References: <20190108005651.25967-1-lyude@redhat.com>
 <20190108005651.25967-4-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190108005651.25967-4-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Jerry Zuo <Jerry.Zuo@amd.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Jan 07, 2019 at 07:56:47PM -0500, Lyude Paul wrote:
> Since I've had to fix two cases of drivers not checking the return code
> from this function, let's make the compiler complain so this doesn't
> come up again in the future.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Jerry Zuo <Jerry.Zuo@amd.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 3 ++-
>  include/drm/drm_dp_mst_helper.h       | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 2ab16c9e6243..13a7e497bfe2 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2226,7 +2226,8 @@ EXPORT_SYMBOL(drm_dp_mst_topology_mgr_suspend);
>   * if the device fails this returns -1, and the driver should do
>   * a full MST reprobe, in case we were undocked.
>   */
> -int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr)
> +int __must_check

I think you need the must_check only in the header. With that fixed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr)
>  {
>  	int ret = 0;
>  
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index 371cc2816477..4355b55d0081 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -614,7 +614,8 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
>  			      struct drm_dp_mst_topology_mgr *mgr);
>  
>  void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr);
> -int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
> +int __must_check
> +drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
>  struct drm_dp_mst_topology_state *drm_atomic_get_mst_topology_state(struct drm_atomic_state *state,
>  								    struct drm_dp_mst_topology_mgr *mgr);
>  int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
