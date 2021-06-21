Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9721EC4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 14:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D176115A
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 14:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D176115A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E38496E1B4;
	Mon, 21 Jun 2021 14:57:03 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9C0A6E1A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 14:57:02 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id j2so9482951wrs.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 07:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=g68Ws2VnmzGyW1cBPGZ/o0J8y6ARMnbbGRWOqQlEJxs=;
 b=X2IDfkIxbJ0s9+Q1ArBqGcjp3kz+7gAVl0w13GT6k6EA6jg2uckMyzEBwTy1Y3EZR9
 Hj+NfiAGxH5x1ae41S2f/2DgkOcdDg0UqD2GlPW8FOFXD9qSRGucEO0P07x4xT9T1pZC
 iJhOT9X29snbBR4l3KFCBLIpYh9YVRF8dVMCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=g68Ws2VnmzGyW1cBPGZ/o0J8y6ARMnbbGRWOqQlEJxs=;
 b=j49ATYOr7DcZpv+nSNQVuQRD77Ke2lm64FV7h+M6ScF7DzbD5Sc0uTXaRhDHSyODwZ
 esZSlxEPTwyc7cCp5RJ07xezgxWDhw0px50NfTCYRYuBvTcIGVinoDtFH3c+IWDVSxbL
 n2oRlN/hB8Y2Tx0nciSBbP2zoGpRxMGzMM1iVJyneYZUnFmN//dXzoAED3FTU2KA4uEi
 pa0jWxnyFGImvT8ppvqpMCV5KjjWEri3xTMm6iO/nj+da0dEntPhDUFeqsIjjz/3tzFm
 B5mELDtXtcKHYZ+vup130Dss4k7B2GSUz/tnyhuSSsc7AAvu/6O+p4zMWZcq0wlhuMqb
 jDYw==
X-Gm-Message-State: AOAM533fouB1FVsNtIDlHlozfdUK+Y8ch0MmPGkdhsY1N93yjK+6GF3X
 nFhADanBnmjO6KtPOVyS0UzBrVYA5b7NsQ==
X-Google-Smtp-Source: ABdhPJwrnsvpBjyEgrZBds+k7kVQd87VKPDVal9OWYtORo8ETKQeuXpXpFPGVmSN6e3iRAghKh8gFg==
X-Received: by 2002:a05:6000:1203:: with SMTP id
 e3mr28555873wrx.107.1624287421564; 
 Mon, 21 Jun 2021 07:57:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id k5sm17931075wmk.11.2021.06.21.07.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 07:57:01 -0700 (PDT)
Date: Mon, 21 Jun 2021 16:56:59 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: wait for moving fence after pinning
Message-ID: <YNCouxCGTBCq6hl+@phenom.ffwll.local>
References: <20210621130328.11070-1-christian.koenig@amd.com>
 <20210621130328.11070-3-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210621130328.11070-3-christian.koenig@amd.com>
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

On Mon, Jun 21, 2021 at 03:03:28PM +0200, Christian K=F6nig wrote:
> We actually need to wait for the moving fence after pinning
> the BO to make sure that the pin is completed.
> =

> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> CC: stable@kernel.org
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_dma_buf.c
> index baa980a477d9..37ec59365080 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -214,9 +214,21 @@ static int amdgpu_dma_buf_pin(struct dma_buf_attachm=
ent *attach)
>  {
>  	struct drm_gem_object *obj =3D attach->dmabuf->priv;
>  	struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
> +	int r;
>  =

>  	/* pin buffer into GTT */
> -	return amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
> +	r =3D amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
> +	if (r)
> +		return r;
> +
> +	if (bo->tbo.moving) {

dma-buf.c guarantees we have the reservation here, so we're fine.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +		r =3D dma_fence_wait(bo->tbo.moving, true);
> +		if (r) {
> +			amdgpu_bo_unpin(bo);
> +			return r;
> +		}
> +	}
> +	return 0;
>  }
>  =

>  /**
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
