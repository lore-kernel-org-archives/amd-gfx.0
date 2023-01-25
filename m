Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DE1C54E94
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 20:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63CC010E145;
	Wed, 25 Jan 2023 20:53:23 +0000 (UTC)
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com
 (mailrelay2-1.pub.mailoutpod2-cph3.one.com [46.30.211.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B41C210E168
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 20:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ravnborg.org; s=rsa2;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=/NbmLZPfTUBNuvwpuIq7jzdYXjOyhys3va43pns/wME=;
 b=fXzCVuKRusidZBn0C8DUfgcuqFi/xH4Dq66tyHbKA0oEuRzZuyoIBOiLjsOwSvr+XkS5Aj6/8FjfS
 f1d19b3n2z0KUneSoilCiaNmzUWxDKPyG6eKXAoW0igFvtDQo9SGKXCtGVlpoN0OfqSLgAw+CIbCVN
 csYcffChBpGi6AJIHGSwJinq5tjrmRtv6oc2CdNm9Q7TFsLahoU5Ms05Lebn4W0llb1eVofn1EdPxe
 GpcepYkR9FhzvhXT8jy0QE5+B9n5nSxXE3HPA8K05S/hpAQso901xLBhlv7iXHZHbmXbLK3ua9aUzv
 Z0NFaunagWqq8MfE3TtCNIwsrOjBVtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=ravnborg.org; s=ed2;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=/NbmLZPfTUBNuvwpuIq7jzdYXjOyhys3va43pns/wME=;
 b=H0mcFvUdtrxvOtOWjFbsUaf7rnbOCi8U9iXjFrJBOzDccJr1E5qa1ZOuQ3ZOe3mcbAztOHHM8l8/s
 V3o0dAlBQ==
X-HalOne-ID: 24b509b3-9cf2-11ed-a537-3df7d73157c4
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
 by mailrelay2 (Halon) with ESMTPSA
 id 24b509b3-9cf2-11ed-a537-3df7d73157c4;
 Wed, 25 Jan 2023 20:52:16 +0000 (UTC)
Date: Wed, 25 Jan 2023 21:52:14 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 01/10] drm/client: Test for connectors before sending
 hotplug event
Message-ID: <Y9GWfi4EiCDPa6BJ@ravnborg.org>
References: <20230125200415.14123-1-tzimmermann@suse.de>
 <20230125200415.14123-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125200415.14123-2-tzimmermann@suse.de>
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
Cc: freedreno@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 javierm@redhat.com, mripard@kernel.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, linux-tegra@vger.kernel.org, airlied@gmail.com,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Thomas,

On Wed, Jan 25, 2023 at 09:04:06PM +0100, Thomas Zimmermann wrote:
> Test for connectors in the client code and remove a similar test
> from the generic fbdev emulation. Do nothing if the test fails.
> Not having connectors indicates a driver bug.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/gpu/drm/drm_client.c        | 5 +++++
>  drivers/gpu/drm/drm_fbdev_generic.c | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
> index 262ec64d4397..09ac191c202d 100644
> --- a/drivers/gpu/drm/drm_client.c
> +++ b/drivers/gpu/drm/drm_client.c
> @@ -198,6 +198,11 @@ void drm_client_dev_hotplug(struct drm_device *dev)
>  	if (!drm_core_check_feature(dev, DRIVER_MODESET))
>  		return;
>  
> +	if (!dev->mode_config.num_connector) {
> +		drm_dbg_kms(dev, "No connectors found, will not send hotplug events!\n");
> +		return;
This deserves a more visible logging - if a driver fails here it would
be good to spot it in the normal kernel log.
drm_info or drm_notice?

The original code had this on the debug level, but when moving the log
level could also be updated.

	Sam

> +	}
> +
>  	mutex_lock(&dev->clientlist_mutex);
>  	list_for_each_entry(client, &dev->clientlist, list) {
>  		if (!client->funcs || !client->funcs->hotplug)
> diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
> index 0a4c160e0e58..3d455a2e3fb5 100644
> --- a/drivers/gpu/drm/drm_fbdev_generic.c
> +++ b/drivers/gpu/drm/drm_fbdev_generic.c
> @@ -389,11 +389,6 @@ static int drm_fbdev_client_hotplug(struct drm_client_dev *client)
>  	if (dev->fb_helper)
>  		return drm_fb_helper_hotplug_event(dev->fb_helper);
>  
> -	if (!dev->mode_config.num_connector) {
> -		drm_dbg_kms(dev, "No connectors found, will not create framebuffer!\n");
> -		return 0;
> -	}
> -
>  	drm_fb_helper_prepare(dev, fb_helper, &drm_fb_helper_generic_funcs);
>  
>  	ret = drm_fb_helper_init(dev, fb_helper);
> -- 
> 2.39.0
