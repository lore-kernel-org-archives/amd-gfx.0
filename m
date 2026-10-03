Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3A1CA5FDD
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2026 10:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17C9710E92F;
	Sat,  3 Oct 2026 10:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UReXiafg";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F28EE10E92B
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 10:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791023458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x3OlQPuKLle/RWQyCvYbmxpN1t4vBLUkyyPtEqihZM4=;
 b=UReXiafghX64kpKGImsxTTKlDlI3P7ZvzxZc//n7Evfe82nc3yPdUOTGKjX2HrfCxdDlAW
 oXW2JwwrQ6I6QCCAr4ECDY9kicU8bmXgEJ2AinnMFWINqE+6WP3CHIMc0Oju3ZvFc472x9
 vaHydr8BpNTpO9Zf8p4vO1HTU1ktw6U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-i_o116hDPx-B7uIKzyrsXg-1; Sat, 03 Oct 2026 06:30:57 -0400
X-MC-Unique: i_o116hDPx-B7uIKzyrsXg-1
X-Mimecast-MFC-AGG-ID: i_o116hDPx-B7uIKzyrsXg_1791023456
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e6862e924so4887375e9.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 03 Oct 2026 03:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791023456; x=1791628256;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x3OlQPuKLle/RWQyCvYbmxpN1t4vBLUkyyPtEqihZM4=;
 b=V6/60DB89JQ9XAae0bcDjk7hCGsRSR3HILL49eTQHxK7gs9EJNZnvg0NdsXYzlLDWp
 l6YPtS/1sGkRDjy7GyxMZrt4t1u+TV6tEzma5E+hJqHVKiRRPB5Pypc5vip0S2CG4kiP
 LiJzavq49FYpLtnfcbTYuf+nshq8/1JH/9qOLs95/f4GmndPcXar6byocYn20KC9Z/cU
 ucBZmqb19Nas/dXiLofsgK7GBQD1ff+e54/5zoXkjBtDpWQPQMV0ktU2hBgIfQSHfpue
 230mPDH8aEVrD4Jyd9Gqdyp8WDkpoVbWwjh5ko4aoq+tJhyduO+EetsbmgGxzbv01mbt
 9XGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6W3veeduMxaV5tQYXhwpEeMQEVXXBIWvzcZabE7PeCzIHqBfljVOS/9Nmqrawu18iTZ8zSaxh@lists.freedesktop.org
X-Gm-Message-State: AFuF++lW2dY67X2qkxRTZUg3UJqIukLY/ad6LcQHZNE+KmBEhkTtEvoq
 1IW5mBD7TK15QGyibQiTH6F70LDPa0rWJU23tzikRRAGlgiAKhblNh3rxTQRG1+AYUJu7w/bX+q
 e0H8B8AWPYZbep5++YH2Q+IjxO7hu/nEY+hkzOdAnAN7+aRGr9u0Agb09LO0ldV6C6n8=
X-Gm-Gg: AYBFou3iL7RIci+QBn95+uzzl4FTgHcjec9MjwjNZ+hWC43031kxgVESe/aOf6Ds27a
 7bSi9z4yjuFKDq8TvMj8zBbI+++ecy5JZwRJJ4xdkpPPHczzDiuXJgPHzKIBBnvAktiM3e8nHsH
 mBDM+2AJ6Ojm49oaPzMxRYyF70tEDZbUtn4O6LMCnh9ZrRvTyYrhlzBghDlddfzeFzjMEIrUgvN
 XopTsvJkp3TKa+QcKCVgWQzr6JNBfT9VDr1CeFzaiI2C6tDVGIjqPJF9OPD1rTnCxpxntQDhGPa
 D+aWQYRxIvGYfi+X05P7otUnkAWn7YcSCmYkckXwkhKDvikVACITm0VG2OG91YX01lxIcwfnKHX
 TpoZT9ZVYx6DApj0Whu0vOeSEjO/PJtqLE+ue5fnl/THkT2ALfm3dqFQ6rjwCNR+0/Q==
X-Received: by 2002:a05:600c:3115:b0:49f:cac3:c68a with SMTP id
 5b1f17b1804b1-4a168105ddfmr30255995e9.31.1791023456048; 
 Sat, 03 Oct 2026 03:30:56 -0700 (PDT)
X-Received: by 2002:a05:600c:3115:b0:49f:cac3:c68a with SMTP id
 5b1f17b1804b1-4a168105ddfmr30255685e9.31.1791023455648; 
 Sat, 03 Oct 2026 03:30:55 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03ff20831sm97747375e9.4.2026.10.03.03.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 03:30:55 -0700 (PDT)
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
Subject: Re: [PATCH v9 21/21] drm/solomon: add SSD130x connector luminance
 support
In-Reply-To: <20261002190030.211356-22-mario.limonciello@amd.com>
References: <20261002190030.211356-1-mario.limonciello@amd.com>
 <20261002190030.211356-22-mario.limonciello@amd.com>
Date: Sat, 03 Oct 2026 12:30:53 +0200
Message-ID: <xlv1zewv5b4y.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eKUrKes4IpbXv5gyr7HNWcei4peVdRtli82lvPZol4g_1791023456
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

Hello Mario,

> Expose SSD130x contrast through the connector LUMINANCE property when
> DRM_LUMINANCE is enabled. Program contrast directly and retain the
> backlight class interface otherwise.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

[...]

>  struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
>  {
>  	struct ssd130x_device *ssd130x;
> +#ifndef CONFIG_DRM_LUMINANCE
>  	struct backlight_device *bl;
> +#endif

[...]

> +#ifndef CONFIG_DRM_LUMINANCE
>  	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ssd130x,
>  					    &ssd130xfb_bl_ops[ssd130x->device_info->family_id],
>  					    NULL);
> @@ -2258,6 +2298,7 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
>  	bl->props.brightness = ssd130x->contrast;
>  	bl->props.max_brightness = MAX_CONTRAST;
>  	ssd130x->bl_dev = bl;
> +#endif

I think that IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE) makes more sense?

Other than that, the patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

