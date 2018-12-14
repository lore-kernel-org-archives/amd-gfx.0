From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [WIP PATCH 06/15] drm/i915: Keep malloc references to MST ports
Date: Fri, 14 Dec 2018 10:32:55 +0100
Message-ID: <20181214093255.GO21184@phenom.ffwll.local>
References: <20181214012604.13746-1-lyude@redhat.com>
 <20181214012604.13746-7-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181214012604.13746-7-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Dec 13, 2018 at 08:25:35PM -0500, Lyude Paul wrote:
> So that the ports stay around until we've destroyed the connectors, in
> order to ensure that we don't pass an invalid pointer to any MST helpers
> once we introduce the new MST VCPI helpers.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/i915/intel_connector.c | 4 ++++
>  drivers/gpu/drm/i915/intel_dp_mst.c    | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/intel_connector.c b/drivers/gpu/drm/i915/intel_connector.c
> index 18e370f607bc..37d2c644f4b8 100644
> --- a/drivers/gpu/drm/i915/intel_connector.c
> +++ b/drivers/gpu/drm/i915/intel_connector.c
> @@ -95,6 +95,10 @@ void intel_connector_destroy(struct drm_connector *connector)
>  	intel_panel_fini(&intel_connector->panel);
>  
>  	drm_connector_cleanup(connector);
> +
> +	if (intel_connector->port)

We set this as the first thing in intel_dp_add_mst_connector, so this
check isn't doing anything.

> +		drm_dp_mst_put_port_malloc(intel_connector->port);
> +
>  	kfree(connector);
>  }
>  
> diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
> index f05427b74e34..4d6ced34d465 100644
> --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> @@ -484,6 +484,8 @@ static struct drm_connector *intel_dp_add_mst_connector(struct drm_dp_mst_topolo
>  	if (ret)
>  		goto err;
>  
> +	drm_dp_mst_get_port_malloc(port);

Needs to be moved up where we assing intel_connector->port, or it'll
underflow on cleanup on error paths.

> +
>  	return connector;
>  
>  err:
> -- 
> 2.19.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
