Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A71EC4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 14:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574A960FDA
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 14:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574A960FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B3B96E1A2;
	Mon, 21 Jun 2021 14:54:40 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E45216E1A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 14:54:38 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 p8-20020a7bcc880000b02901dbb595a9f1so181484wma.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 07:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=XLVAZwAxuXNsGaV6lvPX7vIKs+0qO2BfXOSpcxK89hk=;
 b=CeFZUpYWyygSdLxxQ3eB4z2Nk6uk921eYPoXBo/JPjyJbOyoFIWC5KOrJYX4j73pY3
 2iOfXdUrkwhkp58y6/RPMu8y2ZruriZjHFk2+m1BZYRkvu05V3lLx8/GS8Gt0Bz8pRUZ
 kdfSXYYgrKfPrI7nD2Svww6QvgK98Vroo5+tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=XLVAZwAxuXNsGaV6lvPX7vIKs+0qO2BfXOSpcxK89hk=;
 b=uOk4ECljiRJz7bWMZYXIrkxdzeodPSt9eKhin15xkLQ5SJUH2UASzj9IDWqnV1tNSP
 o6jSEbPm2jedBTuOtrGP6FtnHlp+t4v+UCIPw1cJOxAOwiEj9YDjllQT5RHpvQBXM7M3
 HFCJ7VNukAJfPm1SkXnV86cpwuTcdvg+1Jv8WvYKIoSFL+nCIbIbE88TvXA/AjPPxxA7
 iLbfE81XfBzEEQUdRuIGixmb0l2XE8vvKSTvxC6KQZImMrSrnn0ud+BKZeohtioWKIcY
 1JKT6IG9z8vATG+AwuGRsrMC3Ff5/0XrMfRlAT5RNYIzGY5W+QElZryO1DDFHaKo6L64
 HBIA==
X-Gm-Message-State: AOAM532FQoKqORwV7aFWU03ZEtDhxbDvjCIjBKfRUkyDRUK9t1VReFF+
 Ly241NqKhSGEfV3/0guTE+2z0A==
X-Google-Smtp-Source: ABdhPJyQ0JSmH8QndMZrr5AL5YLnvQqlqh8f8Kc50ydxa8bqPvF6adZqTFdw3Y3grNzRd/IgPkjjIA==
X-Received: by 2002:a05:600c:281:: with SMTP id
 1mr25368979wmk.171.1624287277670; 
 Mon, 21 Jun 2021 07:54:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id n4sm4429425wrw.21.2021.06.21.07.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 07:54:37 -0700 (PDT)
Date: Mon, 21 Jun 2021 16:54:35 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/3] drm/nouveau: wait for moving fence after pinning
Message-ID: <YNCoK1qv6CCIy0Rl@phenom.ffwll.local>
References: <20210621130328.11070-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210621130328.11070-1-christian.koenig@amd.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
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
Cc: daniel.vetter@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 21, 2021 at 03:03:26PM +0200, Christian K=F6nig wrote:
> We actually need to wait for the moving fence after pinning
> the BO to make sure that the pin is completed.
> =

> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> CC: stable@kernel.org
> ---
>  drivers/gpu/drm/nouveau/nouveau_prime.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/gpu/drm/nouveau/nouveau_prime.c b/drivers/gpu/drm/no=
uveau/nouveau_prime.c
> index 347488685f74..591738545eba 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_prime.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_prime.c
> @@ -93,7 +93,13 @@ int nouveau_gem_prime_pin(struct drm_gem_object *obj)
>  	if (ret)
>  		return -EINVAL;
>  =

> -	return 0;
> +	if (nvbo->bo.moving) {

Don't we need to hold the dma_resv to read this? We can grab a reference
and then unlock, but I think just unlocked wait can go boom pretty easily
(since we don't hold a reference or lock so someone else can jump in and
free the moving fence).
-Daniel

> +		ret =3D dma_fence_wait(nvbo->bo.moving, true);
> +		if (ret)
> +			nouveau_bo_unpin(nvbo);
> +	}
> +
> +	return ret;
>  }
>  =

>  void nouveau_gem_prime_unpin(struct drm_gem_object *obj)
> -- =

> 2.25.1
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
