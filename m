Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C3EFD3770
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 16:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0237010E7A8;
	Wed, 25 Feb 2026 16:14:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6996C10E7A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 16:14:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5B201713
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 08:14:31 -0800 (PST)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 D99E13F73B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 08:14:37 -0800 (PST)
Date: Wed, 25 Feb 2026 16:12:08 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Liu Ying <victor.liu@nxp.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 10/14] drm/arm: komeda: Convert to drm_output_color_format
Message-ID: <aZ8fWNYrwyxr0vqC@e142607>
References: <20260224-drm-rework-color-formats-v1-0-bebc76604ada@kernel.org>
 <20260224-drm-rework-color-formats-v1-10-bebc76604ada@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224-drm-rework-color-formats-v1-10-bebc76604ada@kernel.org>
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 24, 2026 at 11:58:49AM +0100, Maxime Ripard wrote:
> Now that we introduced a new drm_output_color_format enum to represent
> what DRM_COLOR_FORMAT_* bits were representing, we can switch to the new
> enum.
> 
> The main different is that while DRM_COLOR_FORMAT_ was a bitmask,
> drm_output_color_format is a proper enum. However, the enum was done is
> such a way than DRM_COLOR_FORMAT_X = BIT(DRM_OUTPUT_COLOR_FORMAT_X) so
> the transitition is easier.
> 
> The only thing we need to consider is if the original code meant to use
> that value as a bitmask, in which case we do need to keep the bit shift,
> or as a discriminant in which case we don't.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

For the first patch in the series that introduces the enum and this one:

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/display/komeda/d71/d71_component.c     | 14 +++++++-------
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c           |  2 +-
>  drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h       |  5 +++--
>  drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c |  2 +-
>  4 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index 67e5d3b4190f62549bc8da700deb4b15e138b515..27ca2930cdac6e76a058102ea2c1d8306d85e751 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -1078,15 +1078,15 @@ static void d71_improc_update(struct komeda_component *c,
>  	}
>  
>  	mask |= IPS_CTRL_YUV | IPS_CTRL_CHD422 | IPS_CTRL_CHD420;
>  
>  	/* config color format */
> -	if (st->color_format == DRM_COLOR_FORMAT_YCBCR420)
> +	if (st->color_format == DRM_OUTPUT_COLOR_FORMAT_YCBCR420)
>  		ctrl |= IPS_CTRL_YUV | IPS_CTRL_CHD422 | IPS_CTRL_CHD420;
> -	else if (st->color_format == DRM_COLOR_FORMAT_YCBCR422)
> +	else if (st->color_format == DRM_OUTPUT_COLOR_FORMAT_YCBCR422)
>  		ctrl |= IPS_CTRL_YUV | IPS_CTRL_CHD422;
> -	else if (st->color_format == DRM_COLOR_FORMAT_YCBCR444)
> +	else if (st->color_format == DRM_OUTPUT_COLOR_FORMAT_YCBCR444)
>  		ctrl |= IPS_CTRL_YUV;
>  
>  	malidp_write32_mask(reg, BLK_CONTROL, mask, ctrl);
>  }
>  
> @@ -1143,16 +1143,16 @@ static int d71_improc_init(struct d71_dev *d71,
>  		return PTR_ERR(c);
>  	}
>  
>  	improc = to_improc(c);
>  	improc->supported_color_depths = BIT(8) | BIT(10);
> -	improc->supported_color_formats = DRM_COLOR_FORMAT_RGB444 |
> -					  DRM_COLOR_FORMAT_YCBCR444 |
> -					  DRM_COLOR_FORMAT_YCBCR422;
> +	improc->supported_color_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
> +					  BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) |
> +					  BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422);
>  	value = malidp_read32(reg, BLK_INFO);
>  	if (value & IPS_INFO_CHD420)
> -		improc->supported_color_formats |= DRM_COLOR_FORMAT_YCBCR420;
> +		improc->supported_color_formats |= BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
>  
>  	improc->supports_csc = true;
>  	improc->supports_gamma = true;
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index 5a66948ffd24343cfc144e9b500679fd0c6bf43b..e78604469ef74800a4cac1e854821578b7e7bce8 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -38,11 +38,11 @@ void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
>  			min_bpc = conn_bpc;
>  	}
>  
>  	/* connector doesn't config any color_format, use RGB444 as default */
>  	if (!conn_color_formats)
> -		conn_color_formats = DRM_COLOR_FORMAT_RGB444;
> +		conn_color_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444);
>  
>  	*color_depths = GENMASK(min_bpc, 0);
>  	*color_formats = conn_color_formats;
>  }
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index ac8725e248537e5737d16cd36860401c42073500..dbe93894b2f6a193e24963d497ebb7b717ce3ebb 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -315,20 +315,21 @@ struct komeda_splitter_state {
>  	u16 overlap;
>  };
>  
>  struct komeda_improc {
>  	struct komeda_component base;
> -	u32 supported_color_formats;  /* DRM_RGB/YUV444/YUV420*/
> +	u32 supported_color_formats;  /* BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444/YUV444/YUV420) */
>  	u32 supported_color_depths; /* BIT(8) | BIT(10)*/
>  	u8 supports_degamma : 1;
>  	u8 supports_csc : 1;
>  	u8 supports_gamma : 1;
>  };
>  
>  struct komeda_improc_state {
>  	struct komeda_component_state base;
> -	u8 color_format, color_depth;
> +	enum drm_output_color_format color_format;
> +	u8 color_depth;
>  	u16 hsize, vsize;
>  	u32 fgamma_coeffs[KOMEDA_N_GAMMA_COEFFS];
>  	u32 ctm_coeffs[KOMEDA_N_CTM_COEFFS];
>  };
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index f4e76b46ca327a1c5db9bdbdd9550b45190b30d8..6f9b10cc831ff748296b9ed30b6de398c90c4786 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -797,11 +797,11 @@ komeda_improc_validate(struct komeda_improc *improc,
>  					 improc->supported_color_formats);
>  			return -EINVAL;
>  		}
>  
>  		st->color_depth = __fls(avail_depths);
> -		st->color_format = BIT(__ffs(avail_formats));
> +		st->color_format = __ffs(avail_formats);
>  	}
>  
>  	if (kcrtc_st->base.color_mgmt_changed) {
>  		drm_lut_to_fgamma_coeffs(kcrtc_st->base.gamma_lut,
>  					 st->fgamma_coeffs);
> 
> -- 
> 2.52.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
