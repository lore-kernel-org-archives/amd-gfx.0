Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F818C46467
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jan 2023 16:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC5DB10E2BA;
	Wed, 11 Jan 2023 16:10:54 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96DA210E2BA;
 Wed, 11 Jan 2023 16:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673453452; x=1704989452;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Qdwk/ULwe80LyvZKMxiSPgYKLRGtK5OMkqcEIHSWzXU=;
 b=kVBZpHIz+Oo+3qeKt7IIj/X03gXTZLLNC8/9bDT9kcQZJOY6UhU1WVXY
 pJiHAqJ3YreV5ghmdRiBKwuHGpqnGPMHDb1nqew6WmZcIy0WNZMinfUTE
 7uJ32f4M07DliR9G6SKarAFQcty1hbgivAh9kR8+zcFHPu8wyLxvr5ONt
 luHA8DXWYDKRJ9QyFo6LAooDQUIcPoCbgWza0hKzBtYngk16HWQguj+QP
 slfZ/V2yh5T4A0Fbx9PYoN+rnWgTYamKTXWmDL1OHkXfmr1Q6PFSTZ1L8
 2p5IeVM1okO5PXfJ3ZAJRRqXE2xOH5w7UVmFgHkHlHURDt72NNHC+HIDq g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="387921292"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; d="scan'208";a="387921292"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2023 08:08:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="720770547"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; d="scan'208";a="720770547"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.55])
 by fmsmga008.fm.intel.com with SMTP; 11 Jan 2023 08:08:43 -0800
Received: by stinkbox (sSMTP sendmail emulation);
 Wed, 11 Jan 2023 18:08:42 +0200
Date: Wed, 11 Jan 2023 18:08:42 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 02/10] drm: Include <linux/of.h> where needed
Message-ID: <Y77fCmivLygHyuZ+@intel.com>
References: <20230111130206.29974-1-tzimmermann@suse.de>
 <20230111130206.29974-3-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230111130206.29974-3-tzimmermann@suse.de>
X-Patchwork-Hint: comment
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
Cc: f.fainelli@gmail.com, amd-gfx@lists.freedesktop.org, sam@ravnborg.org,
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, thierry.reding@gmail.com, james.qian.wang@arm.com,
 patrik.r.jakobsson@gmail.com, daniel@ffwll.ch, alexander.deucher@amd.com,
 bcm-kernel-feedback-list@broadcom.com, liviu.dudau@arm.com, airlied@gmail.com,
 christian.koenig@amd.com, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 11, 2023 at 02:01:58PM +0100, Thomas Zimmermann wrote:
> Include <linux/of.h> in source files that need it. Some of DRM's
> source code gets OF header via drm_crtc_helper.h and <linux/fb.h>,
> which can leed to unnecessary recompilation.
> 
> In drm_modes.c, add a comment on the reason for still including
> <linux/fb.h>. The header file is required to get KHZ2PICOS(). The
> macro is part of the UAPI headers, so it cannot be moved to a less
> prominent location.

I never liked that KHZ2PICOS() thing in there. Maybe we should
just nuke it and see if anyone notices?

> 
> v2:
> 	* include <linux/of.h> in komeda_drv.c (kernel test robot)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 1 +
>  drivers/gpu/drm/drm_modes.c                     | 5 +++--
>  drivers/gpu/drm/panel/panel-ronbo-rb070d30.c    | 1 +
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> index 3f4e719eebd8..28f76e07dd95 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> @@ -6,6 +6,7 @@
>   */
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/component.h>
>  #include <linux/pm_runtime.h>
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index be030f4a5311..40d482a01178 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -31,10 +31,11 @@
>   */
>  
>  #include <linux/ctype.h>
> +#include <linux/export.h>
> +#include <linux/fb.h> /* for KHZ2PICOS() */
>  #include <linux/list.h>
>  #include <linux/list_sort.h>
> -#include <linux/export.h>
> -#include <linux/fb.h>
> +#include <linux/of.h>
>  
>  #include <video/of_display_timing.h>
>  #include <video/of_videomode.h>
> diff --git a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> index a8a98c91b13c..866d1bf5530e 100644
> --- a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> +++ b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> @@ -15,6 +15,7 @@
>  #include <linux/kernel.h>
>  #include <linux/media-bus-format.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  
>  #include <linux/gpio/consumer.h>
>  #include <linux/regulator/consumer.h>
> -- 
> 2.39.0

-- 
Ville Syrjälä
Intel
