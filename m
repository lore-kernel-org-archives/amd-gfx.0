Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A0ECA5FE8
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2026 11:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B590510E895;
	Sat,  3 Oct 2026 11:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="KtLAu2Fu";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E7110E876
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 11:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791026579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n6DEk79+AjGFUJq3XsqFxT4woiJPH49kvRHU0q9Llf8=;
 b=KtLAu2Fu83rLHUTKWcTdBny9/bsAiAuLMZ2h7qlNP1g0WLz0bZ2zDbm5EXrWD3lmxMjzOm
 4LhxsK1P/fGGrf+Qt1o03vD51BC7SMzpr0M49KdvTDdKg8Hhx7N5kkxGpjuQanJgTx3FfD
 Guv4NIpvOWd58EMX81UpnHXJN5NyxNM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-04yaemLgOzSfGWWg4P51vA-1; Sat, 03 Oct 2026 07:22:57 -0400
X-MC-Unique: 04yaemLgOzSfGWWg4P51vA-1
X-Mimecast-MFC-AGG-ID: 04yaemLgOzSfGWWg4P51vA_1791026576
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-486f9d150c3so192534f8f.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 03 Oct 2026 04:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791026576; x=1791631376;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n6DEk79+AjGFUJq3XsqFxT4woiJPH49kvRHU0q9Llf8=;
 b=ETYYk2eQW0kHZodZbxntfvc5o7UTjlYMTpdNI0ATBfLdPDFMuqPYwg6gyyBJvPFqPT
 yFrsT/vOx/Rm/LPw3QvBUUWucPPoqOaXDcAl4x6mQeGkKWRTFj/0MWT9OpCsT/7VxbIz
 D+JkM9UDJDMpBeTdCdHk1FaeSNV51p+n0mcwUJ+1KAq6NqKi5Lus7xGOCipsE8M/nGbe
 2/LLakqO5BoNhMqZk5VtC5SZOHVw358DzydYDyPaEkxWNCtN1pntwWUrpYEI3eswfH2O
 SGxBxG7hQ8SZxKvKkaBXuN9P/0MilLQ/aVcPVD2PCPQP75gUB9EbYZPLLf0b4c1rfJQI
 eNgw==
X-Forwarded-Encrypted: i=1;
 AKwUvByAU3PQwxwCWRe14I1VPdYUlPcI4LZtrgGyzXVuRXVLjEoR2ad3Qybv7iY5CLl3b3rW+nFKJxkg@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIIK7CILf70qxDJQ1hxuNRakxKCq7l8OiNrvCnZFwGEavnmXOfD
 xRXh86Af/wt6e9DBs0e+6Z6WMTHm49bNQgV/PBm6LWX2kn3nOXIIpYj/pR9pHlMlVlUi/WN0eFn
 1Z8hb4V0hRv3RjOho73NzgoPnS7geegZswrYszVgG6J3A6G5agr3FZCabL+kD/00e8Nk=
X-Gm-Gg: AYBFou1rrTLRfKdxOUTl7mEYdSYM6ONx5aVUwrPviM9YMnEPq+j32JTu8kkNumL68WC
 WdmY9ifcKzztciXRBb78qLK5wF4gUWVjPqB4Y+ZfeJIOJP8m99uhEVJIlAFzR+DURxGePFs/WT7
 VVRrOkSKGp7wUNfPh2748ho1loDF+LpTzaXencjQIXjbOQ/NEn6eXhn6x5OqW0zPYpdgJXoplco
 20uj3Dv5Rq+GFDa1LwvjO7W10tiNc+Az1JoSyWCcnE4uW+VtWvOSv/PJXsB1kb0tn1xz4qco4B6
 iNmcBhiOvLtDeRAHu4iZiPUcVqAn6Yrp2LYJLzaRnRUyND3P+gneMMecqc8tGZwF3Y+VISfM5AZ
 jUYhbwTYfUAgSMOD0dDdVbEaTf+H4iAiB0mzdifNY0dv+Me8jM5TCQsv5ucO5TGUwCg==
X-Received: by 2002:a05:6000:18aa:b0:48b:1b1:af12 with SMTP id
 ffacd0b85a97d-48b127623bamr8872513f8f.56.1791026576007; 
 Sat, 03 Oct 2026 04:22:56 -0700 (PDT)
X-Received: by 2002:a05:6000:18aa:b0:48b:1b1:af12 with SMTP id
 ffacd0b85a97d-48b127623bamr8872483f8f.56.1791026575557; 
 Sat, 03 Oct 2026 04:22:55 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b383065a4sm11069220f8f.44.2026.10.03.04.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 04:22:53 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: Re: [PATCH v9 09/21] drm/tiny: migrate panel-mipi-dbi to connector
 luminance
In-Reply-To: <20261002190030.211356-10-mario.limonciello@amd.com>
References: <20261002190030.211356-1-mario.limonciello@amd.com>
 <20261002190030.211356-10-mario.limonciello@amd.com>
Date: Sat, 03 Oct 2026 13:22:51 +0200
Message-ID: <xlv1h5j3gh9w.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9A4ih5_4uRNNtuDgVLgF3r59MOAWnar1q2mRhVe-R-o_1791026576
X-Mimecast-Originator: redhat.com
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

Mario Limonciello <mario.limonciello@amd.com> writes:

> Attach the connector LUMINANCE property for MIPI DBI compatible panels
> and retain the legacy backlight class interface only when DRM_LUMINANCE is
> disabled.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/tiny/Kconfig          | 2 +-
>  drivers/gpu/drm/tiny/panel-mipi-dbi.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
> index f0e72d4b6a470..e61a429538bc0 100644
> --- a/drivers/gpu/drm/tiny/Kconfig
> +++ b/drivers/gpu/drm/tiny/Kconfig
> @@ -73,7 +73,7 @@ config DRM_PANEL_MIPI_DBI
>  	select DRM_KMS_HELPER
>  	select DRM_GEM_DMA_HELPER
>  	select DRM_MIPI_DBI
> -	select BACKLIGHT_CLASS_DEVICE
> +	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
>  	select VIDEOMODE_HELPERS
>  	help
>  	  Say Y here if you want to enable support for MIPI DBI compatible
> diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> index 60cd65cae41d8..730f1b219fdec 100644
> --- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> +++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> @@ -485,6 +485,9 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  	drm_connector_helper_add(connector, &panel_mipi_dbi_connector_helper_funcs);
> +	ret = drm_mipi_dbi_connector_attach_luminance_property(connector);
> +	if (ret)
> +		return ret;
>

I don't see how this could work...

The drm_mipi_dbi_connector_attach_luminance_property() helper only attaches a
LUMINANCE property to the connector if DRM_LUMINANCE is enabled and backlight
is not NULL.

But if DRM_LUMINANCE is enabled, then backlight will always be NULL given that
the drivers/gpu/drm/tiny/panel-mipi-dbi.c driver does:

        dbidev->backlight = devm_of_find_backlight(dev);

and devm_of_find_backlight() is just a stub that unconditionally return NULL if
BACKLIGHT_CLASS_DEVICE is disabled:

https://elixir.bootlin.com/linux/v7.3-rc5/source/include/linux/backlight.h#L441

I don't think we will be able to add support for the LUMINANCE property to MIPI
DBI drivers unless the drivers DT binding are changed. Or maybe what this shows
is that a backlight backend is really needed.

I would leave these drivers out for now and then later figure out how to make
them work without breaking the backlight sysfs interface.

Maybe what can be done is to add a new CONFIG_BACKLIGHT_SYSFS Kconfig symbol,
that defaults to y but allows the sysfs interface to be disabled. That way,
you could still have CONFIG_BACKLIGHT_CLASS_DEVICE enabled but prevent the
uAPI breakage.

Then in this MIPI DBI drivers you could do:

select DRM_LUMINANCE if !CONFIG_BACKLIGHT_SYSFS, or something like that.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

