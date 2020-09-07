Return-Path: <SRS0=05a7=CQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752D0C43461
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 07:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBA4206B8
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 07:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Euxtu+tr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBA4206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268E86E118;
	Mon,  7 Sep 2020 07:14:11 +0000 (UTC)
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF736E0FA
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2020 07:14:09 +0000 (UTC)
Received: by mail-oo1-xc41.google.com with SMTP id r10so1619615oor.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2020 00:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KVfAGFVhhH+3gKxWPx4EEt2i/99FDkLx011kDtsMF+I=;
 b=Euxtu+trgjabIp7kfpqLzFQS+dE83z6NFR5B38p25hCsIskYQhJEXI8aDOFmjb9/rb
 ajdQe4bmbBxWioDNhCAVb/QZqh3F00karTYzM2FazYTVvrVMLOroBXd2TBPPFA8thdy7
 kAmoBHvDcK9wIivmZv2bC4v0rV5TvwkjuxeM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KVfAGFVhhH+3gKxWPx4EEt2i/99FDkLx011kDtsMF+I=;
 b=kFh4784EUyCO5MwF0YjqXGaxl0MeS8M+uEJJy4qo2xDGwRWDzs7AOwI6j2H9HVvmsv
 i9iyWq5X3PKz3vtX8bvdvC9kE8cztOT7rPGlOfB7OtV2PEpu/NTvPrSv/hTtZXhpo+4H
 3Ph5g4fli7qHJEZkaZ8sBkYREbSNJjzN6DU6K4vdGTLMu3Fej1MUhK9okMIrE41+AE+Z
 Za+Jv0vwOziTej6wHGGtblNi7W4XhBcu2vz5GhjXAZh1p6k1DiY7IUUWGCIdFrD3EaNw
 W6vMf29MMxdJjw0MvE0nhL8a2k4EjQBhS/GROyGftf+Se2lZYHzzq3KYhoUVxnnOe+ZR
 Eh1g==
X-Gm-Message-State: AOAM530hRqQ4PZOqoiuZW6Vab8xPH8RvDqlKXApqxWzvnUX7MlBpxF9j
 DNpw72zj8Id+/6gjxcKwTOvl006eaXbe6s2bv2WSng==
X-Google-Smtp-Source: ABdhPJyDsSLWPXy8R9Ce8HIpecD+QM6t0+0yQYpXyChVzKDiPvzj0GbvH4ZECIfVS8TxI8k421NQRVJ+suYIajAm3/8=
X-Received: by 2002:a4a:e98e:: with SMTP id s14mr13829467ood.28.1599462848946; 
 Mon, 07 Sep 2020 00:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200818092017.26290-1-kraxel@redhat.com>
 <20200818092017.26290-2-kraxel@redhat.com>
 <20200901074043.GT2352366@phenom.ffwll.local>
 <20200907063901.atwjdxz7iqyra22h@sirius.home.kraxel.org>
In-Reply-To: <20200907063901.atwjdxz7iqyra22h@sirius.home.kraxel.org>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 7 Sep 2020 09:13:58 +0200
Message-ID: <CAKMK7uFixrbxVoaF4-1hXvQcPySaaYRooQ=LKoivPALH-UCgbw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm: allow limiting the scatter list size.
To: Gerd Hoffmann <kraxel@redhat.com>
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
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 David Airlie <airlied@linux.ie>,
 "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS"
 <nouveau@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>,
 Sandy Huang <hjc@rock-chips.com>, Thierry Reding <thierry.reding@gmail.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 Ben Skeggs <bskeggs@redhat.com>, Russell King <linux+etnaviv@armlinux.org.uk>,
 "moderated list:DRM DRIVERS FOR XEN" <xen-devel@lists.xenproject.org>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 "moderated list:DRM DRIVERS FOR VIVANTE GPU IP"
 <etnaviv@lists.freedesktop.org>, Maxime Ripard <mripard@kernel.org>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 "open list:DRM DRIVERS FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>,
 Sean Paul <sean@poorly.run>, "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 7, 2020 at 8:39 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > > +   /**
> > > +    * @max_segment:
> > > +    *
> > > +    * Max size for scatter list segments.  When unset the default
> > > +    * (SCATTERLIST_MAX_SEGMENT) is used.
> > > +    */
> > > +   size_t max_segment;
> >
> > Is there no better place for this then "at the bottom"? drm_device is a
> > huge structure, piling stuff up randomly doesn't make it better :-)
>
> Moved next to the other gem fields for now (v3 posted).
>
> > I think ideally we'd have a gem substruct like we have on the modeset side
> > at least.
>
> Phew, that'll be quite some churn in the tree.  And there aren't that many
> gem-related fields in struct drm_device.
>
> So you are looking for something like below (header changes only)?

Hm yeah it's a lot less than I thought. And yes I think that would be neat.
-Daniel

>
> take care,
>   Gerd
>
> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> index c455ef404ca6..950167ede98a 100644
> --- a/include/drm/drm_device.h
> +++ b/include/drm/drm_device.h
> @@ -299,22 +299,8 @@ struct drm_device {
>         /** @mode_config: Current mode config */
>         struct drm_mode_config mode_config;
>
> -       /** @object_name_lock: GEM information */
> -       struct mutex object_name_lock;
> -
> -       /** @object_name_idr: GEM information */
> -       struct idr object_name_idr;
> -
> -       /** @vma_offset_manager: GEM information */
> -       struct drm_vma_offset_manager *vma_offset_manager;
> -
> -       /**
> -        * @max_segment:
> -        *
> -        * Max size for scatter list segments for GEM objects.  When
> -        * unset the default (SCATTERLIST_MAX_SEGMENT) is used.
> -        */
> -       size_t max_segment;
> +       /** @gem_config: Current GEM config */
> +       struct drm_gem_config gem_config;
>
>         /** @vram_mm: VRAM MM memory manager */
>         struct drm_vram_mm *vram_mm;
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 337a48321705..74129fb29fb8 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -39,6 +39,25 @@
>
>  #include <drm/drm_vma_manager.h>
>
> +struct drm_gem_config {
> +       /** @object_name_lock: GEM information */
> +       struct mutex object_name_lock;
> +
> +       /** @object_name_idr: GEM information */
> +       struct idr object_name_idr;
> +
> +       /** @vma_offset_manager: GEM information */
> +       struct drm_vma_offset_manager *vma_offset_manager;
> +
> +       /**
> +        * @max_segment:
> +        *
> +        * Max size for scatter list segments for GEM objects.  When
> +        * unset the default (SCATTERLIST_MAX_SEGMENT) is used.
> +        */
> +       size_t max_segment;
> +};
> +
>  struct drm_gem_object;
>
>  /**
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
