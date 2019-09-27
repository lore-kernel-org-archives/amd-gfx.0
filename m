From: Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2 26/27] drm/dp_mst: Also print unhashed pointers for
 malloc/topology references
Date: Fri, 27 Sep 2019 10:25:10 -0400
Message-ID: <20190927142510.GS218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-27-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190903204645.25487-27-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Sep 03, 2019 at 04:46:04PM -0400, Lyude Paul wrote:
> Currently we only print mstb/port pointer addresses in our malloc and
> topology refcount functions using the hashed-by-default %p, but
> unfortunately if you're trying to debug a use-after-free error caused by
> a refcounting error then this really isn't terribly useful. On the other
> hand though, everything in the rest of the DP MST helpers uses hashed
> pointer values as well and probably isn't useful to convert to unhashed.
> So, let's just get the best of both worlds and print both the hashed and
> unhashed pointer in our malloc/topology refcount debugging output. This
> will hopefully make it a lot easier to figure out which port/mstb is
> causing KASAN to get upset.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

It's really too bad there isn't a CONFIG_DEBUG_SHOW_PK_ADDRESSES or even a value
of kptr_restrict value that bypasses pointer hashing. I'm sure we're not the
only ones to feel this pain. Maybe everyone just hacks vsnprintf...

As it is, I'm not totally sold on exposing the actual addresses unconditionally.
What do you think about pulling the print out into a function and only printing
px if a debug kconfig is set?

Sean

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 34 ++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 2fe24e366925..5b5c0b3b3c0e 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1327,7 +1327,8 @@ static void
>  drm_dp_mst_get_mstb_malloc(struct drm_dp_mst_branch *mstb)
>  {
>  	kref_get(&mstb->malloc_kref);
> -	DRM_DEBUG("mstb %p (%d)\n", mstb, kref_read(&mstb->malloc_kref));
> +	DRM_DEBUG("mstb %p/%px (%d)\n",
> +		  mstb, mstb, kref_read(&mstb->malloc_kref));
>  }
>  
>  /**
> @@ -1344,7 +1345,8 @@ drm_dp_mst_get_mstb_malloc(struct drm_dp_mst_branch *mstb)
>  static void
>  drm_dp_mst_put_mstb_malloc(struct drm_dp_mst_branch *mstb)
>  {
> -	DRM_DEBUG("mstb %p (%d)\n", mstb, kref_read(&mstb->malloc_kref) - 1);
> +	DRM_DEBUG("mstb %p/%px (%d)\n",
> +		  mstb, mstb, kref_read(&mstb->malloc_kref) - 1);
>  	kref_put(&mstb->malloc_kref, drm_dp_free_mst_branch_device);
>  }
>  
> @@ -1379,7 +1381,8 @@ void
>  drm_dp_mst_get_port_malloc(struct drm_dp_mst_port *port)
>  {
>  	kref_get(&port->malloc_kref);
> -	DRM_DEBUG("port %p (%d)\n", port, kref_read(&port->malloc_kref));
> +	DRM_DEBUG("port %p/%px (%d)\n",
> +		  port, port, kref_read(&port->malloc_kref));
>  }
>  EXPORT_SYMBOL(drm_dp_mst_get_port_malloc);
>  
> @@ -1396,7 +1399,8 @@ EXPORT_SYMBOL(drm_dp_mst_get_port_malloc);
>  void
>  drm_dp_mst_put_port_malloc(struct drm_dp_mst_port *port)
>  {
> -	DRM_DEBUG("port %p (%d)\n", port, kref_read(&port->malloc_kref) - 1);
> +	DRM_DEBUG("port %p/%px (%d)\n",
> +		  port, port, kref_read(&port->malloc_kref) - 1);
>  	kref_put(&port->malloc_kref, drm_dp_free_mst_port);
>  }
>  EXPORT_SYMBOL(drm_dp_mst_put_port_malloc);
> @@ -1447,8 +1451,8 @@ drm_dp_mst_topology_try_get_mstb(struct drm_dp_mst_branch *mstb)
>  	int ret = kref_get_unless_zero(&mstb->topology_kref);
>  
>  	if (ret)
> -		DRM_DEBUG("mstb %p (%d)\n", mstb,
> -			  kref_read(&mstb->topology_kref));
> +		DRM_DEBUG("mstb %p/%px (%d)\n",
> +			  mstb, mstb, kref_read(&mstb->topology_kref));
>  
>  	return ret;
>  }
> @@ -1471,7 +1475,8 @@ static void drm_dp_mst_topology_get_mstb(struct drm_dp_mst_branch *mstb)
>  {
>  	WARN_ON(kref_read(&mstb->topology_kref) == 0);
>  	kref_get(&mstb->topology_kref);
> -	DRM_DEBUG("mstb %p (%d)\n", mstb, kref_read(&mstb->topology_kref));
> +	DRM_DEBUG("mstb %p/%px (%d)\n",
> +		  mstb, mstb, kref_read(&mstb->topology_kref));
>  }
>  
>  /**
> @@ -1489,8 +1494,8 @@ static void drm_dp_mst_topology_get_mstb(struct drm_dp_mst_branch *mstb)
>  static void
>  drm_dp_mst_topology_put_mstb(struct drm_dp_mst_branch *mstb)
>  {
> -	DRM_DEBUG("mstb %p (%d)\n",
> -		  mstb, kref_read(&mstb->topology_kref) - 1);
> +	DRM_DEBUG("mstb %p/%px (%d)\n",
> +		  mstb, mstb, kref_read(&mstb->topology_kref) - 1);
>  	kref_put(&mstb->topology_kref, drm_dp_destroy_mst_branch_device);
>  }
>  
> @@ -1546,8 +1551,8 @@ drm_dp_mst_topology_try_get_port(struct drm_dp_mst_port *port)
>  	int ret = kref_get_unless_zero(&port->topology_kref);
>  
>  	if (ret)
> -		DRM_DEBUG("port %p (%d)\n", port,
> -			  kref_read(&port->topology_kref));
> +		DRM_DEBUG("port %p/%px (%d)\n",
> +			  port, port, kref_read(&port->topology_kref));
>  
>  	return ret;
>  }
> @@ -1569,7 +1574,8 @@ static void drm_dp_mst_topology_get_port(struct drm_dp_mst_port *port)
>  {
>  	WARN_ON(kref_read(&port->topology_kref) == 0);
>  	kref_get(&port->topology_kref);
> -	DRM_DEBUG("port %p (%d)\n", port, kref_read(&port->topology_kref));
> +	DRM_DEBUG("port %p/%px (%d)\n",
> +		  port, port, kref_read(&port->topology_kref));
>  }
>  
>  /**
> @@ -1585,8 +1591,8 @@ static void drm_dp_mst_topology_get_port(struct drm_dp_mst_port *port)
>   */
>  static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port)
>  {
> -	DRM_DEBUG("port %p (%d)\n",
> -		  port, kref_read(&port->topology_kref) - 1);
> +	DRM_DEBUG("port %p/%px (%d)\n",
> +		  port, port, kref_read(&port->topology_kref) - 1);
>  	kref_put(&port->topology_kref, drm_dp_destroy_port);
>  }
>  
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
