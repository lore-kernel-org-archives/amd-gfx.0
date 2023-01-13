Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B02C67871
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 15:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE68E10E198;
	Fri, 13 Jan 2023 15:28:36 +0000 (UTC)
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com
 (mailrelay6-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:405::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE57E10E198
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 15:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ravnborg.org; s=rsa2;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=e8hzZHTdOaUXHevlKXZ3IT0ts6bvp7PdrlX7lQ0YIh4=;
 b=rsdQX1vUTt7C5uZ1dnwUQCIR497urrZ1wGmOJOBcQ+1isLc3puCFhp/AdvUHwASFBHMwY0nCYi8wq
 LngHlFI0dSdGYKrp1JpRCDMjc3GkI5GCWtmxfwqoWdpJRIFakt18ROrn4taVEzsWAekqjT43HPOPqi
 MixtxBZNy8BvU/n3uNa+u4OSTclF5i/rQ36p6M1WeUIPcgI+0JDclU/jDDG8FkOFEakQ30sMlgpTZB
 VluQKswjxJBv9K1O59jFch3MJxpW3DAXYAwyn6/ubZ6UZm7zGq4Y4iE6DC84n/ROfH5/rtlOUcx11R
 VsGGQRCPL1+iMstUbIV/Jg6e4Oo9XPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=ravnborg.org; s=ed2;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=e8hzZHTdOaUXHevlKXZ3IT0ts6bvp7PdrlX7lQ0YIh4=;
 b=0OcP8BL1SYnQM6RmYxWEKWocIbKRz39fejWquqZmXYzsbjUrdXzNSgJ0oCkMepODXsv7DKpOKFxuS
 EN1BqJhCw==
X-HalOne-ID: b02dc733-9354-11ed-b0c0-cde5ad41a1dd
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
 by mailrelay6 (Halon) with ESMTPSA
 id b02dc733-9354-11ed-b0c0-cde5ad41a1dd;
 Fri, 13 Jan 2023 15:12:28 +0000 (UTC)
Date: Fri, 13 Jan 2023 16:12:27 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 05/10] drm/panel: Do not include <linux/fb.h>
Message-ID: <Y8F021QdBYD9IEvD@ravnborg.org>
References: <20230111130206.29974-1-tzimmermann@suse.de>
 <20230111130206.29974-6-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111130206.29974-6-tzimmermann@suse.de>
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
Cc: f.fainelli@gmail.com, amd-gfx@lists.freedesktop.org, liviu.dudau@arm.com,
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, thierry.reding@gmail.com, james.qian.wang@arm.com,
 patrik.r.jakobsson@gmail.com, daniel@ffwll.ch, alexander.deucher@amd.com,
 bcm-kernel-feedback-list@broadcom.com, airlied@gmail.com,
 christian.koenig@amd.com, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 11, 2023 at 02:02:01PM +0100, Thomas Zimmermann wrote:
> Remove unnecessary include statements for <linux/fb.h>. No functional
> changes. Include <linux/of.h> where the driver got the header file via
> <linux/fb.h>.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/panel/panel-ilitek-ili9881c.c         | 1 -
>  drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 1 -
>  drivers/gpu/drm/panel/panel-ronbo-rb070d30.c          | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> index cbb68caa36f2..1ec696adf9de 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> @@ -7,7 +7,6 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
> -#include <linux/fb.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> index 79f852465a84..35d568da342f 100644
> --- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> +++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> @@ -43,7 +43,6 @@
>  
>  #include <linux/delay.h>
>  #include <linux/err.h>
> -#include <linux/fb.h>
>  #include <linux/i2c.h>
>  #include <linux/media-bus-format.h>
>  #include <linux/module.h>
> diff --git a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> index 866d1bf5530e..2ef5ea5eaeeb 100644
> --- a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> +++ b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> @@ -11,7 +11,6 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
> -#include <linux/fb.h>
>  #include <linux/kernel.h>
>  #include <linux/media-bus-format.h>
>  #include <linux/module.h>
> -- 
> 2.39.0
