Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEF2CD3429
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 11:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A931310E44F;
	Tue,  3 Sep 2024 11:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Jv1iQGsD";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 510C910E08E
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 11:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725361739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5KNCsJ15HkUgltOPMm708gH3cAto2XwAuJxZwET5MHs=;
 b=Jv1iQGsDscG4vY8v3IFxvipGXQOyKUxFNWFIKt/GK4B+KQgs/WCoMPZuTgYrEWCnNbKI7j
 tO7q4BYEnp4KtyTmRrrNUF6ve6V2vC8T4eyFHZ4vtg7uNW3Uv9nkcZXw5rJPfSA8NlxMi4
 GYb58T03oEvyJhaNW9uNTaNJYP75cNE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-dXMc1_A7OgyOYbUlo4tgHQ-1; Tue, 03 Sep 2024 07:08:58 -0400
X-MC-Unique: dXMc1_A7OgyOYbUlo4tgHQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42bb2899d57so47724035e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Sep 2024 04:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725361737; x=1725966537;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5KNCsJ15HkUgltOPMm708gH3cAto2XwAuJxZwET5MHs=;
 b=QW12mcbarX3UU4oEwXDa6pONCvXry9MeG6x7VORapfWEVPbZLFehZYsrZpo1tktHoL
 ZtML5OAiC+idj+B3Aj8da+PNYCasTxE65HVnxDmWxLO1yczG4QjlNXWyZJipbQdSbBvG
 2qD8S4/28WtUOPuAtpEXuRCwbE6nv1hm8ZKBxO+SPj6UWmBP8kRRjP3NgBe9MlHoHb2v
 eMkCwFJP+8EcUoa1gFjk8nKQpiw1LeWHWkhwLS76DgEZgGNy+C7OpimwBd4gGxJk9+mu
 lU+Zdw4xmNOOSdnF0bcWbe31n6h1rMBO4gDWwR9THXoHO5E0yBGv54v9HTjT96Y5gw3A
 v3fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNd8wVIMSkl822TtN/fSAdPJNdugEvcUZYK0AmmPChHz2aM4nWvZbXvZy9+zyIzcWkJlv7Re+X@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLDuJsPFuIaVF0wAjp0B7cpuzSa/rSBeZOvdc67MMs4pPcMr+K
 eFvpZoGyFLn7IV+99vOvWf85X6bE2cpUsG0/ISZIKclyv6iD+WccziuZeXr44btap8jhYXsacE7
 2WrK2zAMxGI9hOQnjaI9kUvp30msdMLUivWCqREXWLDkWhNGy9SOmUGHtWdbej6k=
X-Received: by 2002:a05:600c:6592:b0:426:61ef:ec36 with SMTP id
 5b1f17b1804b1-42c82f13bb8mr49158835e9.0.1725361736880; 
 Tue, 03 Sep 2024 04:08:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/LIzZrmcj69ybDsKA77dubjSmW4Tpk5zW1Gf9bYbxoUzrG0GhAgYYbYf75Z9LDiQ3xPDERQ==
X-Received: by 2002:a05:600c:6592:b0:426:61ef:ec36 with SMTP id
 5b1f17b1804b1-42c82f13bb8mr49158605e9.0.1725361736297; 
 Tue, 03 Sep 2024 04:08:56 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bbc36bd88sm139398275e9.24.2024.09.03.04.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 04:08:56 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 05/81] drm/fbdev-dma: Support struct
 drm_driver.fbdev_probe
In-Reply-To: <20240830084456.77630-6-tzimmermann@suse.de>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-6-tzimmermann@suse.de>
Date: Tue, 03 Sep 2024 13:08:55 +0200
Message-ID: <87h6axgfjs.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Rework fbdev probing to support fbdev_probe in struct drm_driver
> and reimplement the old fb_probe callback on top of it. Provide an
> initializer macro for struct drm_driver that sets the callback
> according to the kernel configuration.
>
> This change allows the common fbdev client to run on top of DMA-
> based DRM drivers.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_fbdev_dma.c | 60 ++++++++++++++++++++-------------
>  include/drm/drm_fbdev_dma.h     | 12 +++++++
>  2 files changed, 48 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
> index 7ef5a48c8029..aeccf7f7a522 100644
> --- a/drivers/gpu/drm/drm_fbdev_dma.c
> +++ b/drivers/gpu/drm/drm_fbdev_dma.c
> @@ -86,6 +86,40 @@ static const struct fb_ops drm_fbdev_dma_fb_ops = {
>  
>  static int drm_fbdev_dma_helper_fb_probe(struct drm_fb_helper *fb_helper,
>  					 struct drm_fb_helper_surface_size *sizes)
> +{

static inline for this wrapper maybe ?

> +	return drm_fbdev_dma_driver_fbdev_probe(fb_helper, sizes);
> +}
> +

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

