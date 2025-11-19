Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C248CF2579
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 04:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A34810E566;
	Wed, 19 Nov 2025 04:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kxF0S5kZ";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2731310E566;
 Wed, 19 Nov 2025 04:33:25 +0000 (UTC)
Received: from pendragon.ideasonboard.com (unknown [205.220.129.225])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 25D80B5;
 Wed, 19 Nov 2025 05:31:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1763526679;
 bh=pOisxB3tPa0K5/tNqcYR/OeTkmkwk8Z8S0wlo+6AupQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kxF0S5kZUsvvw0wJKW8N6wnNELjuWBHspI4m8nki/bfePMBcyASbRxjpLA36Q8y7B
 WPZPyAqzNkNASh/wBGP3/9d5XnWO/tqy1iwqU2wdW+BbyCT4CXGzwWmtoiuLCnH6cK
 4BS5eEyiMbS+ndMBlf+npVIth7IEJeyw1pUmM67s=
Date: Wed, 19 Nov 2025 13:32:46 +0900
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, kernel@collabora.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Subject: Re: [PATCH v4 04/10] drm/bridge: Act on the DRM color format property
Message-ID: <20251119043246.GY10711@pendragon.ideasonboard.com>
References: <20251117-color-format-v4-0-0ded72bd1b00@collabora.com>
 <20251117-color-format-v4-4-0ded72bd1b00@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251117-color-format-v4-4-0ded72bd1b00@collabora.com>
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

On Mon, Nov 17, 2025 at 08:11:48PM +0100, Nicolas Frattaroli wrote:
> The new DRM color format property allows userspace to request a specific
> color format on a connector. In turn, this fills the connector state's
> color_format member to switch color formats.
> 
> Make drm_bridges consider the color_format set in the connector state
> during the atomic bridge check. Specifically, reject any output bus
> formats that do not correspond to the requested color format.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/drm_bridge.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 8f355df883d8..b7df5cbad832 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -1052,6 +1052,59 @@ static int select_bus_fmt_recursive(struct drm_bridge *first_bridge,
>  	return ret;
>  }
>  
> +static bool __pure bus_format_is_color_fmt(u32 bus_fmt, enum drm_color_format fmt)
> +{
> +	if (bus_fmt == MEDIA_BUS_FMT_FIXED)
> +		return true;
> +
> +	switch (fmt) {
> +	case DRM_COLOR_FORMAT_NONE:
> +	case DRM_COLOR_FORMAT_AUTO:
> +		return true;
> +	case DRM_COLOR_FORMAT_RGB444:
> +		switch (bus_fmt) {
> +		case MEDIA_BUS_FMT_RGB888_1X24:
> +		case MEDIA_BUS_FMT_RGB101010_1X30:
> +		case MEDIA_BUS_FMT_RGB121212_1X36:
> +		case MEDIA_BUS_FMT_RGB161616_1X48:
> +			return true;
> +		default:
> +			return false;
> +		}
> +	case DRM_COLOR_FORMAT_YCBCR444:
> +		switch (bus_fmt) {
> +		case MEDIA_BUS_FMT_YUV8_1X24:
> +		case MEDIA_BUS_FMT_YUV10_1X30:
> +		case MEDIA_BUS_FMT_YUV12_1X36:
> +		case MEDIA_BUS_FMT_YUV16_1X48:
> +			return true;
> +		default:
> +			return false;
> +		}
> +	case DRM_COLOR_FORMAT_YCBCR422:
> +		switch (bus_fmt) {
> +		case MEDIA_BUS_FMT_UYVY8_1X16:
> +		case MEDIA_BUS_FMT_UYVY10_1X20:
> +		case MEDIA_BUS_FMT_UYVY12_1X24:
> +			return true;
> +		default:
> +			return false;
> +		}
> +	case DRM_COLOR_FORMAT_YCBCR420:
> +		switch (bus_fmt) {
> +		case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
> +		case MEDIA_BUS_FMT_UYYVYY10_0_5X30:
> +		case MEDIA_BUS_FMT_UYYVYY12_0_5X36:
> +		case MEDIA_BUS_FMT_UYYVYY16_0_5X48:
> +			return true;
> +		default:
> +			return false;
> +		}
> +	}

I'd find this more readable:

	if (fmt == DRM_COLOR_FORMAT_NONE || fmt == DRM_COLOR_FORMAT_AUTO)
		return true;

	switch (bus_fmt) {
	case MEDIA_BUS_FMT_RGB888_1X24:
	case MEDIA_BUS_FMT_RGB101010_1X30:
	case MEDIA_BUS_FMT_RGB121212_1X36:
	case MEDIA_BUS_FMT_RGB161616_1X48:
		return fmt == DRM_COLOR_FORMAT_RGB444:

	case MEDIA_BUS_FMT_YUV8_1X24:
	case MEDIA_BUS_FMT_YUV10_1X30:
	case MEDIA_BUS_FMT_YUV12_1X36:
	case MEDIA_BUS_FMT_YUV16_1X48:
		return fmt == DRM_COLOR_FORMAT_YCBCR444;

	case MEDIA_BUS_FMT_UYVY8_1X16:
	case MEDIA_BUS_FMT_UYVY10_1X20:
	case MEDIA_BUS_FMT_UYVY12_1X24:
		return fmt == DRM_COLOR_FORMAT_YCBCR422;

	case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
	case MEDIA_BUS_FMT_UYYVYY10_0_5X30:
	case MEDIA_BUS_FMT_UYYVYY12_0_5X36:
	case MEDIA_BUS_FMT_UYYVYY16_0_5X48:
		return fmt == DRM_COLOR_FORMAT_YCBCR420;

	default:
		return false;
	}

but it could be a matter for personal preference ?

I'm also a bit concerned about the 

	if (fmt == DRM_COLOR_FORMAT_NONE || fmt == DRM_COLOR_FORMAT_AUTO)

test. What's the difference between NONE and AUTO ? Is it meaningful, or
should the two enumerators be merged into a single one ?

> +
> +	return false;
> +}
> +
>  /*
>   * This function is called by &drm_atomic_bridge_chain_check() just before
>   * calling &drm_bridge_funcs.atomic_check() on all elements of the chain.
> @@ -1137,6 +1190,10 @@ drm_atomic_bridge_chain_select_bus_fmts(struct drm_bridge *bridge,
>  	}
>  
>  	for (i = 0; i < num_out_bus_fmts; i++) {
> +		if (!bus_format_is_color_fmt(out_bus_fmts[i], conn_state->color_format)) {
> +			ret = -ENOTSUPP;
> +			continue;
> +		}
>  		ret = select_bus_fmt_recursive(bridge, last_bridge, crtc_state,
>  					       conn_state, out_bus_fmts[i]);
>  		if (ret != -ENOTSUPP)

-- 
Regards,

Laurent Pinchart
