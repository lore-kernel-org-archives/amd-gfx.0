Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D542C46467
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jan 2023 13:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A14D710E14B;
	Wed, 11 Jan 2023 13:15:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 860E910E138
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 13:15:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D04013D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 05:16:12 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 06BD83F71A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 05:15:29 -0800 (PST)
Date: Wed, 11 Jan 2023 13:15:16 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 02/10] drm: Include <linux/of.h> where needed
Message-ID: <Y762ZNgVnDi4UJ1G@e110455-lin.cambridge.arm.com>
References: <20230111130206.29974-1-tzimmermann@suse.de>
 <20230111130206.29974-3-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230111130206.29974-3-tzimmermann@suse.de>
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
 bcm-kernel-feedback-list@broadcom.com, airlied@gmail.com,
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

For komeda: Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

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
