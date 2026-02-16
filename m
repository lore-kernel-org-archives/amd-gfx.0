Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3E3E68144
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D8A10E45B;
	Tue, 17 Feb 2026 08:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="ACSZ/i+t";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19CC110E3E5;
 Mon, 16 Feb 2026 20:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=ngboZP6RIhPLTK4sHHipZMO6vB+HpttFiw7t3wOgM8g=; b=ACSZ/i+ttVMlGxaUyvJib7QK/t
 K6d4cFwUFYgRGVmD3huPTFnVWI1TPRE1HiMKV0ngwmX3PszBCG94mjloI8UEp2ttYfs55r3AwAoWE
 jURYrg+YBx+E3Y3qrCx0XXYQMobsg0bjfPMpK1LXS+yjL6rADH7dGlHyo+QgMOJAhqUdb0haDG4D2
 zsRooq6wjrwb/iGhJOcNnh9Diw/BOAPBpJhlIfmIxtC4EmeKlXp458kUGSwMWhPTnRrR2ObYc522+
 kMoutKL7YBxMHcmVjJM5NrhA21lRDdGXUlfNAgRmUEHzqRArCQokmA5y22hl7Rl7r9w5eU/08j39R
 dcutj0HA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1vs5Kg-00000007GA9-3C2d; Mon, 16 Feb 2026 20:36:38 +0000
Message-ID: <e80c212c-9220-4621-8b21-5ce382ed92e5@infradead.org>
Date: Mon, 16 Feb 2026 12:36:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 20/20] drm/bridge: Document bridge chain format
 selection
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@collabora.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-doc@vger.kernel.org
References: <20260216-color-format-v8-0-5722ce175dd5@collabora.com>
 <20260216-color-format-v8-20-5722ce175dd5@collabora.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260216-color-format-v8-20-5722ce175dd5@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 17 Feb 2026 08:05:08 +0000
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



On 2/16/26 5:01 AM, Nicolas Frattaroli wrote:
> The bridge chain format selection behaviour was, until now,
> undocumented. With the addition of the "color format" DRM property, it's
> not sufficiently complex enough that documentation is warranted,
> especially for driver authors trying to do the right thing.
> 
> Add a high-level overview of how the process is supposed to work, and
> mention what the display driver is supposed to do if it wants to make
> use of this functionality.
> 
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  Documentation/gpu/drm-kms-helpers.rst |  6 ++++++
>  drivers/gpu/drm/drm_bridge.c          | 39 +++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
> index 781129f78b06..47c4f593cf9d 100644
> --- a/Documentation/gpu/drm-kms-helpers.rst
> +++ b/Documentation/gpu/drm-kms-helpers.rst
> @@ -181,6 +181,12 @@ Bridge Operations
>  .. kernel-doc:: drivers/gpu/drm/drm_bridge.c
>     :doc: bridge operations
>  
> +Bridge Chain Format Selection
> +-----------------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/drm_bridge.c
> +   :doc: bridge chain format selection
> +
>  Bridge Connector Helper
>  -----------------------
>  
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 36a5158f0554..93ef52c37e2c 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -198,6 +198,45 @@
>   * driver.
>   */
>  
> +/**
> + * DOC: bridge chain format selection
> + *
> + * A bridge chain, from display output processor to connector, may contain
> + * bridges capable of converting between bus formats on their inputs, and
> + * output formats on their outputs. For example, a bridge may be able to convert
> + * from RGB to YCbCr 4:4:4, and pass through YCbCr 4:2:0 as-is, but not convert
> + * from RGB to YCbCr 4:2:0. This means not all input formats map to all output
> + * formats.
> + *
> + * Further adding to this, a desired output color format, as specified with the
> + * "color format" DRM property, might not correspond to what the display driver
> + * should set at its output 1:1. The bridge chain it feeds into may only be able

Preferably put "1:1" after "might not correspond".

> + * to reach the desired output format, if a conversion from a different starting
> + * format is performed.
> + *
> + * To deal with this complexity, the recursive bridge chain bus format selection
> + * logic starts with the last bridge in the chain, usually the connector, and
> + * then recursively walks the chain of bridges backwards to the first bridge,
> + * trying to find a path.
> + *
> + * For a display driver to work in such a scenario, it should read the first
> + * bridge's bridge state to figure out which bus format the chain resolved to.
> + * If the first bridge's input format resolved to %MEDIA_BUS_FMT_FIXED, then its
> + * output format should be used.
> + *
> + * Special handling is done for HDMI as it relates to format selection. Instead
> + * of directly using the "color format" DRM property for bridge chains that end
> + * in HDMI bridges, the bridge chain format selection logic will trust the logic
> + * that set the HDMI output format. For the common HDMI state helper
> + * functionality, this means that %DRM_COLOR_FORMAT_ENUM_AUTO will allow
> + * fallbacks to YCBCr 4:2:0 if the bandwidth requirements would otherwise be too
> + * high but the mode and connector allow it.
> + *
> + * For bridge chains that do not end in an HDMI bridge,
> + * %DRM_COLOR_FORMAT_ENUM_AUTO will be satisfied with the first output format on
> + * the last bridge for which it can find a path back to the first bridge.
> + */
> +
>  /* Protect bridge_list and bridge_lingering_list */
>  static DEFINE_MUTEX(bridge_lock);
>  static LIST_HEAD(bridge_list);
> 

Thanks.
-- 
~Randy

