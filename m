Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C47C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 18:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 727DC23370
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 18:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727DC23370
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA4DC6E4B1;
	Thu,  7 Jan 2021 18:08:02 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1FE36E48C
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 18:08:01 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id d13so6488164wrc.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Jan 2021 10:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=wGoiidMHz8t7Nlo+6hdGgFlQcakaOeGgVDEu54EY9eM=;
 b=V3RtjHiVZTwHt4CEaP5BHMPrH6OrnSQ2+Tl56mXX1FLH2e5yooKoc9HswJjkCqOZA9
 7CaSjZImUCFzlWOVmZXELZnmyHrKZKXcjNWCBC/US1f7q4l8g+XJIjjA0xmpzHScGW9f
 qvVEYeBVJVJPev0hOEoZX2M/SFnBsRcQ3djhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=wGoiidMHz8t7Nlo+6hdGgFlQcakaOeGgVDEu54EY9eM=;
 b=me+VOtd7tfTPma/ZeA0DovWeT5WdlpmDaNiqgwjmUAXM0dg5RPv6HbRJFcl0QKxH4K
 rE37muSima/wbsTCOJzxHGvp4w5d/3sWP/0gO9HS01YG7qiTN+zegU1PbPd3YnpAmhWp
 F4a7+ZKtNdAqVtkeJ20/btfqmKFahlagb11SHOvEcNbIPQ79zMQSF5EkHRyDuJDYW43L
 YfE86d8ZPysW2yHzeiEzNDrHlvNngleWeeHtVsPYBVzdZ9uaTHiZfT0oLLbU/mv73PuX
 5HH4Eqkv0sGHpOFw6yhv8D+Dh8mNf71b1+8lEJ/R6UxnPq+rWz0c0R41uzwV389JXR4B
 KOZw==
X-Gm-Message-State: AOAM530FoRfTevPvT9ormncn0cLCynBDHNE8jby11zcIcggqHIFtZx18
 SOsL8HX6UJQOollWhhN4JYpvXg==
X-Google-Smtp-Source: ABdhPJxLTRPnSqHS0bPohlc6/QsONxqhxq7SrtoJGd6k+648J1Spgwjtch68KAGbLtapxkkhGrnAjw==
X-Received: by 2002:adf:94c7:: with SMTP id 65mr9835120wrr.423.1610042880415; 
 Thu, 07 Jan 2021 10:08:00 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id v11sm9332372wrt.25.2021.01.07.10.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Jan 2021 10:07:59 -0800 (PST)
Date: Thu, 7 Jan 2021 19:07:57 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/2] drm/radeon: stop re-init the TTM page pool
Message-ID: <X/dN/YFtnVAIllds@phenom.ffwll.local>
References: <20210105182309.1362-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210105182309.1362-1-christian.koenig@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: ray.huang@amd.com, bp@alien8.de, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 05, 2021 at 07:23:08PM +0100, Christian K=F6nig wrote:
> Drivers are not supposed to init the page pool directly any more.
> =

> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>

Please include reported-by credits and link to the bug reports on
lore.kernel.org when merging this. Also I guess this should have a Fixes:
line?

And maybe some words on how/why stuff blows up.
-Daniel

> ---
>  drivers/gpu/drm/radeon/radeon_ttm.c | 3 ---
>  1 file changed, 3 deletions(-)
> =

> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon=
/radeon_ttm.c
> index d4328ff57757..35b715f82ed8 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -729,9 +729,6 @@ int radeon_ttm_init(struct radeon_device *rdev)
>  	}
>  	rdev->mman.initialized =3D true;
>  =

> -	ttm_pool_init(&rdev->mman.bdev.pool, rdev->dev, rdev->need_swiotlb,
> -		      dma_addressing_limited(&rdev->pdev->dev));
> -
>  	r =3D radeon_ttm_init_vram(rdev);
>  	if (r) {
>  		DRM_ERROR("Failed initializing VRAM heap.\n");
> -- =

> 2.25.1
> =

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
