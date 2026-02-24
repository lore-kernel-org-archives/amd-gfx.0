Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EE1E9B258
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 12:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F33410E2C8;
	Tue, 24 Feb 2026 12:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bONciwJu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D5B10E2C8;
 Tue, 24 Feb 2026 12:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771937032; x=1803473032;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=GYIQtbOzePAjqzLuQH8+HHBY0PZDV/oocDXPjvOLjg4=;
 b=bONciwJuVEWEuEIUKBbTrgtxFX+nKBpNVz4AJdTbDKA99nP4ca5WipG5
 x37YdCglFQsLMX4GYFvvc9Vqxj5ugy8ftpTrmpFsOtljqjkcUwsB3V+b7
 4aM50gfcQ9g3THOwvwbgzTuwOAYMyciKqjKg7sx0vVD01HF95WZsS1efc
 30nQ2fNV+quC97z599rV3rvPdQ+KCDbb0IxJvM6SkEVcJly6KjMNdAFqq
 EBBXEp3M/6o8lv01nq8il+x0ct8VDDnAllJrif/o9IWxeTsr0m649zZnH
 y6mz2N9SSC1tUBJYh1LVLxnRIWSX+Postchns2Xnh/Uc+eHIFdp8glAZ7 g==;
X-CSE-ConnectionGUID: lJW5wbxzT4K/MHz9anj8zw==
X-CSE-MsgGUID: CsGtKx2QSC2nl0B602SWkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72853986"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="72853986"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 04:43:52 -0800
X-CSE-ConnectionGUID: yhhIkH3dTBCEo6bY5mI5tw==
X-CSE-MsgGUID: 52bV+SrBTRymLIB6WF2upQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="214131396"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.246.20])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 04:43:40 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>, Nicolas Frattaroli
 <nicolas.frattaroli@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, Alex
 Deucher <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Andy Yan
 <andy.yan@rock-chips.com>, Liviu Dudau <liviu.dudau@arm.com>, Chun-Kuang
 Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Sandy Huang
 <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Liu
 Ying <victor.liu@nxp.com>, Chen-Yu Tsai <wens@kernel.org>, Samuel Holland
 <samuel@sholland.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>, Raspberry Pi Kernel
 Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 14/14] drm/display: hdmi: Use drm_output_color_format
 instead of hdmi_colorspace
In-Reply-To: <20260224-drm-rework-color-formats-v1-14-bebc76604ada@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260224-drm-rework-color-formats-v1-0-bebc76604ada@kernel.org>
 <20260224-drm-rework-color-formats-v1-14-bebc76604ada@kernel.org>
Date: Tue, 24 Feb 2026 14:43:37 +0200
Message-ID: <6bcc885f3d4c2327a9b1ca4b4521c4e59c68a414@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, 24 Feb 2026, Maxime Ripard <mripard@kernel.org> wrote:
> diff --git a/include/drm/display/drm_hdmi_helper.h b/include/drm/display/drm_hdmi_helper.h
> index 09145c9ee9fc0cd839242f2373b305940e06e157..414e134ca23bcdcdd6ef491812ed0a9020b204ba 100644
> --- a/include/drm/display/drm_hdmi_helper.h
> +++ b/include/drm/display/drm_hdmi_helper.h
> @@ -2,10 +2,11 @@
>  
>  #ifndef DRM_HDMI_HELPER
>  #define DRM_HDMI_HELPER
>  
>  #include <linux/hdmi.h>
> +#include <drm/drm_connector.h>

You could avoid the include by forward declaring the enum, which is not
strictly standard C but allowed by both GCC and Clang, and quite useful
in reducing header dependencies.

BR,
Jani.

>  
>  struct drm_connector;
>  struct drm_connector_state;
>  struct drm_display_mode;
>  
> @@ -24,11 +25,11 @@ drm_hdmi_infoframe_set_hdr_metadata(struct hdmi_drm_infoframe *frame,
>  void drm_hdmi_avi_infoframe_content_type(struct hdmi_avi_infoframe *frame,
>  					 const struct drm_connector_state *conn_state);
>  
>  unsigned long long
>  drm_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
> -			    unsigned int bpc, enum hdmi_colorspace fmt);
> +			    unsigned int bpc, enum drm_output_color_format fmt);
>  
>  void
>  drm_hdmi_acr_get_n_cts(unsigned long long tmds_char_rate,
>  		       unsigned int sample_rate,
>  		       unsigned int *out_n,

-- 
Jani Nikula, Intel
