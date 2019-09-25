From: Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2 18/27] drm/dp_mst: Remove lies in {up,down}_rep_recv
 documentation
Date: Wed, 25 Sep 2019 15:32:11 -0400
Message-ID: <20190925193211.GJ218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-19-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190903204645.25487-19-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Sep 03, 2019 at 04:45:56PM -0400, Lyude Paul wrote:
> These are most certainly accessed from far more than the mgr work. In
> fact, up_req_recv is -only- ever accessed from outside the mgr work.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  include/drm/drm_dp_mst_helper.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index f253ee43e9d9..8ba2a01324bb 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -489,15 +489,11 @@ struct drm_dp_mst_topology_mgr {
>  	int conn_base_id;
>  
>  	/**
> -	 * @down_rep_recv: Message receiver state for down replies. This and
> -	 * @up_req_recv are only ever access from the work item, which is
> -	 * serialised.
> +	 * @down_rep_recv: Message receiver state for down replies.
>  	 */
>  	struct drm_dp_sideband_msg_rx down_rep_recv;
>  	/**
> -	 * @up_req_recv: Message receiver state for up requests. This and
> -	 * @down_rep_recv are only ever access from the work item, which is
> -	 * serialised.
> +	 * @up_req_recv: Message receiver state for up requests.
>  	 */
>  	struct drm_dp_sideband_msg_rx up_req_recv;
>  
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
