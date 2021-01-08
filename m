Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA8CC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 14:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7FB235FC
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 14:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7FB235FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C46126E157;
	Fri,  8 Jan 2021 14:31:54 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D760B6E157
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 14:31:53 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id t30so9243016wrb.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 06:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=pk13RAN8QYm3ZK5u00KzYGfzHly+W+u9hQh9WRL/cUo=;
 b=aHHnDQtnpy8xc5ZkVj5zzFxyB6rcShULcb2Dbxkql3jNEYBKsZu/f7YS0tBS9JWyhh
 pnxSHcXIE5Aj5OvXhddAJNmPi7FsQXs2TnyU6hhqiW+GZj5Tbt5+N2ys5V+80X1uxr/j
 a93syYmZVRagYMyQio6zDD6VD4ziehj1eD4JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=pk13RAN8QYm3ZK5u00KzYGfzHly+W+u9hQh9WRL/cUo=;
 b=KUBoc6zsy9LAz2zQDuaAfdmhhXmUKjx07yrMaHY8ZPcC8euF6UzY6+2b6brrs2cCqg
 XJ1ElHG38Sahx82Dsvvaj+CHo3EzewW17beIVX1Rh3o0eqKoiHlC1Zyq9jKqmIqPDlvR
 ZgVf3CKlOyj9bLj1meEri1zjiStKuds6K5NO5Jv5IHBl3bHCtGI4HtOVP+YfeZ80DZKY
 1DcKEpQOFMefOV0GlvkvtX95k7VlGmgeARQJSWKmi6m3dJBj9WLnevAijFJkNKp2Kcpt
 biOjhTWJjzPuYor9/ISzDvXnJ9eo1EHv3D6bCCPMW3juVElFlRq+uEj9uOZZVadtL8dD
 5+Bg==
X-Gm-Message-State: AOAM531TjiR7swSdv7IYudfzdpUBMzHg9EwnVlFcg4nXxwhI3NA+zFr1
 Xbtfz4vXBtqGXbMrDGpj9G1wJA==
X-Google-Smtp-Source: ABdhPJzgc/HwPMkBHBJq9+EXE+pFmPdfFV1mtMH2JrMjdv1ZPKrmRiJ4ang/ReSQDJNrip7sar5slw==
X-Received: by 2002:adf:c5d3:: with SMTP id v19mr3890380wrg.365.1610116312438; 
 Fri, 08 Jan 2021 06:31:52 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id n16sm13551046wrj.26.2021.01.08.06.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 06:31:51 -0800 (PST)
Date: Fri, 8 Jan 2021 15:31:49 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: christian.koenig@amd.com
Subject: Re: [PATCH 1/2] drm/radeon: stop re-init the TTM page pool
Message-ID: <X/hs1Rvm57zGPU8y@phenom.ffwll.local>
References: <20210105182309.1362-1-christian.koenig@amd.com>
 <X/dN/YFtnVAIllds@phenom.ffwll.local>
 <ffa9d7f2-fe68-fb6a-8422-82b8949dbe1e@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ffa9d7f2-fe68-fb6a-8422-82b8949dbe1e@gmail.com>
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
Cc: dri-devel@lists.freedesktop.org, ray.huang@amd.com, bp@alien8.de,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 07, 2021 at 09:08:29PM +0100, Christian K=F6nig wrote:
> Am 07.01.21 um 19:07 schrieb Daniel Vetter:
> > On Tue, Jan 05, 2021 at 07:23:08PM +0100, Christian K=F6nig wrote:
> > > Drivers are not supposed to init the page pool directly any more.
> > > =

> > > Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> > Please include reported-by credits and link to the bug reports on
> > lore.kernel.org when merging this. Also I guess this should have a Fixe=
s:
> > line?
> =

> I'm not aware of a bug report, but the reported-by/Fixes lines are indeed
> missing.

This one here:

https://lore.kernel.org/dri-devel/20201231104020.GA4504@zn.tnic/

Or did I get confused, and the above is yet another bug?

> BTW: Any idea why dim add-link doesn't work?

Hm we occasionally have fun with email parsing (it's hard) and especially
python changes in how encodings are handled differently between python2
and python3. If you have a specific example I can try and take a look why
it doesn't work.
-Daniel

> > And maybe some words on how/why stuff blows up.
> =

> Just a typo. I've forgot to remove two lines in radeon while rebasing and
> still had the symbols exported so never noticed this.
> =

> Christian.
> =

> > -Daniel
> > =

> > > ---
> > >   drivers/gpu/drm/radeon/radeon_ttm.c | 3 ---
> > >   1 file changed, 3 deletions(-)
> > > =

> > > diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/ra=
deon/radeon_ttm.c
> > > index d4328ff57757..35b715f82ed8 100644
> > > --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> > > +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> > > @@ -729,9 +729,6 @@ int radeon_ttm_init(struct radeon_device *rdev)
> > >   	}
> > >   	rdev->mman.initialized =3D true;
> > > -	ttm_pool_init(&rdev->mman.bdev.pool, rdev->dev, rdev->need_swiotlb,
> > > -		      dma_addressing_limited(&rdev->pdev->dev));
> > > -
> > >   	r =3D radeon_ttm_init_vram(rdev);
> > >   	if (r) {
> > >   		DRM_ERROR("Failed initializing VRAM heap.\n");
> > > -- =

> > > 2.25.1
> > > =

> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
