Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EFCC352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 15:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B4D20656
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 15:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eGIZMXSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B4D20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB4FA6EE98;
	Tue, 11 Feb 2020 15:44:32 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 093D26EE99
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 15:44:32 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id y17so12949341wrh.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 07:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=mrqvVZsVn7mKog9esm7coIiEbXaaJCC1Rfcqj+IiqOM=;
 b=eGIZMXSMMBGZESPC3d5T1L7ViUEpL2IcB9tW7HBQnsr6eo0QpjlO+Q4kFb/sZmLX1L
 6RVlHr5dRNvcDQrVwbmF8zwgXdLLVaeDc0+1yKDirD8N54Ju8PP/tuKbbODgz+DzF/en
 l5pe3fLB4cOn4MNkgbSTKlbRdLBqf0YtOLRts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mrqvVZsVn7mKog9esm7coIiEbXaaJCC1Rfcqj+IiqOM=;
 b=GFxUyxKc0iKEdr51rCyiH9sBuvhyk21qW3A/NMiYepOnqa09kZ9mD4If1RK8GCpIqB
 79RRtvZJ/MfJQ1PedfvOxJxipdDOskObv+29eZON5BpmBf85wXd0wZHQplGXbLsTYOCx
 jibqdyJOETbcz+pc4xDnFz9+lFyFbJVrNLyGZiNCulqhsnWKs8ON3vxih9ew4GSsaSiW
 7uSKOcnIQLeJfHrija0bvlFjmNmZGLtob4qAVdj3cqe6Ey8V3MMESVWPCOLG/vbiYKbs
 kyfwmp5EL8hCqUvr3Uk4x0CQFyg24SwivU+LSyeQZXprWkO1v6s13PvEd1FA1cWdlIFX
 HO+Q==
X-Gm-Message-State: APjAAAU2Pop2FwzpejGNzFcdjLedRUp6QavOSAqWQldbSHLZm+94NVKp
 XRm9uhLk1z4P442mXhk2TxbN0g==
X-Google-Smtp-Source: APXvYqwdMQB0ue7ACvsZYPC15pFoiUgzd/eTdfxdfCsnGlHwMqTG8gjUl279cbMLPm15eMg4GGpe3Q==
X-Received: by 2002:adf:fa86:: with SMTP id h6mr8940823wrr.418.1581435870743; 
 Tue, 11 Feb 2020 07:44:30 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id 25sm4089987wmi.32.2020.02.11.07.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 07:44:29 -0800 (PST)
Date: Tue, 11 Feb 2020 16:44:27 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/ttm: replace dma_resv object on deleted BOs v3
Message-ID: <20200211154427.GJ2363188@phenom.ffwll.local>
References: <20200211154326.83858-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200211154326.83858-1-christian.koenig@amd.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
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
Cc: dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 11, 2020 at 04:43:26PM +0100, Christian K=F6nig wrote:
> When non-imported BOs are resurrected for delayed delete we replace
> the dma_resv object to allow for easy reclaiming of the resources.
> =

> v2: move that to ttm_bo_individualize_resv
> v3: add a comment to explain what's going on
> =

> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> Reviewed-by: xinhui pan <xinhui.pan@amd.com>
> ---
>  drivers/gpu/drm/ttm/ttm_bo.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index bfc42a9e4fb4..8174603d390f 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -393,6 +393,18 @@ static int ttm_bo_individualize_resv(struct ttm_buff=
er_object *bo)
>  =

>  	r =3D dma_resv_copy_fences(&bo->base._resv, bo->base.resv);
>  	dma_resv_unlock(&bo->base._resv);
> +	if (r)
> +		return r;
> +
> +	if (bo->type !=3D ttm_bo_type_sg) {
> +		/* This works because the BO is about to be destroyed and nobody
> +		 * reference it any more. The only tricky case is the trylock on
> +		 * the resv object while holding the lru_lock.
> +		 */

I'm foolish enough to believe this is correct :-)

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +		spin_lock(&ttm_bo_glob.lru_lock);
> +		bo->base.resv =3D &bo->base._resv;
> +		spin_unlock(&ttm_bo_glob.lru_lock);
> +	}
>  =

>  	return r;
>  }
> @@ -724,7 +736,7 @@ static bool ttm_bo_evict_swapout_allowable(struct ttm=
_buffer_object *bo,
>  =

>  	if (bo->base.resv =3D=3D ctx->resv) {
>  		dma_resv_assert_held(bo->base.resv);
> -		if (ctx->flags & TTM_OPT_FLAG_ALLOW_RES_EVICT || bo->deleted)
> +		if (ctx->flags & TTM_OPT_FLAG_ALLOW_RES_EVICT)
>  			ret =3D true;
>  		*locked =3D false;
>  		if (busy)
> -- =

> 2.17.1
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
