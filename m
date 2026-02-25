Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF58DFCE085
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 13:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB1E210E948;
	Thu, 26 Feb 2026 13:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="V3jgCVhI";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADCA910E8A5;
 Wed, 25 Feb 2026 17:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1772038990; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Stq7NiyxW5CF/ZYpj1nqvMDannoyZwlnMzQ/PgyeF0NaxkMVUlI68eDs/afuHnbr2+WHFmRQZxfJTlYWlLd0zyLWqjjWUVTxJnumFxAofhYeOXCqmvKvqp555F7wVXsQumH5tw1GduK4PpZ5MrE99aPbOnBScVHIW5+7cxFCsaM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772038990;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3RYgv+ynJj3S1QIru3Hn9dqc29aPNWjUzmoSLU7r5Kw=; 
 b=a5Oe0Ndnnz06KHDJo5Dq3J6MK/1KLjOuG3mwgwqqqQbKovJWasZ2MCpjlf8ey6OnHnCH4SKGA2z2D1avhxLtcyK+FRyYoZXnSih4UZM7quz5VNvfSBEPZ9pvoY+A2AMBB4eNwEzhaTesQui5FtYM0obtGOLyxS312/LjUHkL7vg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772038990; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=3RYgv+ynJj3S1QIru3Hn9dqc29aPNWjUzmoSLU7r5Kw=;
 b=V3jgCVhIW8MxRWz+GFV+y8JHyIm3dWD68I3G+7EGdF+br4N512+++HwmFH7XXJyX
 VTX84XBJmyiXwt+qxWxRcDszqGbmzTaLyzaROG7CcMhxb7bXr21EUYFCQsl2vZalyv8
 FARjC/W5DW9MnsdktyO2a03wVkp5f4pro6xFBbTQ=
Received: by mx.zohomail.com with SMTPS id 1772038989356790.0109700812275;
 Wed, 25 Feb 2026 09:03:09 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
 Liu Ying <victor.liu@nxp.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 14/14] drm/display: hdmi: Use drm_output_color_format
 instead of hdmi_colorspace
Date: Wed, 25 Feb 2026 18:03:00 +0100
Message-ID: <8234454.EvYhyI6sBW@workhorse>
In-Reply-To: <20260224-drm-rework-color-formats-v1-14-bebc76604ada@kernel.org>
References: <20260224-drm-rework-color-formats-v1-0-bebc76604ada@kernel.org>
 <20260224-drm-rework-color-formats-v1-14-bebc76604ada@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Mailman-Approved-At: Thu, 26 Feb 2026 13:55:07 +0000
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

On Tuesday, 24 February 2026 11:58:53 Central European Standard Time Maxime Ripard wrote:
> The hdmi_colorspace enum was defined to represent the colorspace value
> of the HDMI infoframes. It was later used by some HDMI drivers to
> express the output format they should be setting up.
> 
> During the introduction of the HDMI helpers, it then was used to
> represent it in the drm_connector_hdmi_state structure.
> 
> However, it's always been somewhat redundant with the DRM_COLOR_FORMAT_*
> defines, and now with the drm_output_color_format enum. Let's
> consolidate around drm_output_color_format in drm_connector_hdmi_state
> to facilitate the current effort to provide a global output format
> selection mechanism.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/bridge/inno-hdmi.c                 |   6 +-
>  drivers/gpu/drm/bridge/ite-it6263.c                |   2 +-
>  drivers/gpu/drm/display/drm_hdmi_helper.c          |   7 +-
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  52 ++++--
>  drivers/gpu/drm/drm_bridge.c                       |   2 +-
>  drivers/gpu/drm/drm_connector.c                    |  14 +-
>  drivers/gpu/drm/mediatek/mtk_hdmi_v2.c             |   8 +-
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |   2 +-
>  drivers/gpu/drm/tests/drm_connector_test.c         |  80 ++++-----
>  drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 182 ++++++++++-----------
>  drivers/gpu/drm/vc4/vc4_hdmi.c                     |  18 +-
>  drivers/gpu/drm/vc4/vc4_hdmi.h                     |   2 +-
>  include/drm/display/drm_hdmi_helper.h              |   3 +-
>  include/drm/drm_connector.h                        |   7 +-
>  14 files changed, 205 insertions(+), 180 deletions(-)
> 
> [... snip ...]
>
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 4f5b27fab475c7c733622eb8727927571f3fb8fe..171cd495976a3e16f201fd339d3d42a09dc3b63f 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> [... snip ...]
>  
> @@ -1424,25 +1424,25 @@ drm_hdmi_connector_get_broadcast_rgb_name(enum drm_hdmi_broadcast_rgb broadcast_
>  	return broadcast_rgb_names[broadcast_rgb].name;
>  }
>  EXPORT_SYMBOL(drm_hdmi_connector_get_broadcast_rgb_name);
>  
>  static const char * const output_format_str[] = {
> -	[HDMI_COLORSPACE_RGB]		= "RGB",
> -	[HDMI_COLORSPACE_YUV420]	= "YUV 4:2:0",
> -	[HDMI_COLORSPACE_YUV422]	= "YUV 4:2:2",
> -	[HDMI_COLORSPACE_YUV444]	= "YUV 4:4:4",
> +	[DRM_OUTPUT_COLOR_FORMAT_RGB444]	= "RGB",
> +	[DRM_OUTPUT_COLOR_FORMAT_YCBCR420]	= "YUV 4:2:0",
> +	[DRM_OUTPUT_COLOR_FORMAT_YCBCR422]	= "YUV 4:2:2",
> +	[DRM_OUTPUT_COLOR_FORMAT_YCBCR444]	= "YUV 4:4:4",
>  };
>  
>  /*
>   * drm_hdmi_connector_get_output_format_name() - Return a string for HDMI connector output format
>   * @fmt: Output format to compute name of
>   *
>   * Returns: the name of the output format, or NULL if the type is not
>   * valid.
>   */
>  const char *
> -drm_hdmi_connector_get_output_format_name(enum hdmi_colorspace fmt)
> +drm_hdmi_connector_get_output_format_name(enum drm_output_color_format fmt)
>  {
>  	if (fmt >= ARRAY_SIZE(output_format_str))
>  		return NULL;

Almost unrelated nit: we might want to also `fmt < 0 ||` here, since the
base type of enums is a signed int. I almost caught myself using this function
as a way to quickly check if a supplied color format property from userspace
was valid, which would've had some unpleasant consequences for the kernel's
memory.

Alternatively, I make my own switch-case based "is this a valid enum value"
function. I probably should do that actually, but my laziness lead me to
make sure we only have a single source of truth of what counts as a valid
enum value.

>  
>  	return output_format_str[fmt];
> [... snip ...]

Thanks for your work on this series, I was afraid of getting rid of
DRM_COLOR_FORMAT_* myself because I suspected it was going to be a
fairly large refactor across every driver. Guess I was both right
and wrong: it touches many files, but all the replacements are
fairly simple. :)

Kind regards,
Nicolas Frattaroli


