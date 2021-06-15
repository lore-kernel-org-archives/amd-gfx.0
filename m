Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3BCC48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 12:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B046145E
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 12:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B046145E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0961489FF6;
	Tue, 15 Jun 2021 12:02:03 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF14489FD3;
 Tue, 15 Jun 2021 12:02:01 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id t7so5534671edd.5;
 Tue, 15 Jun 2021 05:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=74xg67OkPNrW2Sf6CPxy6eTp/ulR0UM1WRVVLNUMsnU=;
 b=I4LcX4TbN0Nk/BRMN3YfqoZGm2V9ZG3YBAdPBZXox0PBCHSKH5PRzigLushvL6+mEC
 6p9QX7Oxj9aTUkKXNk8ioCbZfKASXXiPmoRo7lnz2nxjV5wDoQDaUD0ypae+UAHS6NE5
 xHJ0RRBCAEq8Csqn5QMOJWAQ+EBOom7XURjk0L8P+pfk51Re3HhsoOjJ+8z7MUIZajvb
 spzy+wXHur3icJnFDnSp5iBpnvL/UW0tp0ofbfhfc6UO68b6zRcwkiM8LrrJuGEDGHEy
 r+pYGJCaVtGl48L92kOJZsrauVb+vA36A3jNlbuBzPgNdtKFH0IBSPe7m3RqUTlDXnoJ
 gjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=74xg67OkPNrW2Sf6CPxy6eTp/ulR0UM1WRVVLNUMsnU=;
 b=AWfGJtwfhaBkMnIbdd03eNotXEpx+h4RP8NOZrPetaykBA5zah06WyEpRTmXWYYtWb
 FFAt+H4CMBsHsEhGshOIvgkJ7xK5pgpPLwA2jw2EOWqi9/Pw0UOE1zUjsGSV9vbMjnR5
 ZwxAqazbtYxPD0CRyP0u8GpEWtTb75k2+9zI7AkGR9v+9azpq6yZz+/M+zGyrwMd/YqC
 kP/8e54vC60cReKWoOKqmv7vtApAJBU5Fo/m/wz1+PIYx2PbvJUVgjxh5QxfWWzvLwyv
 oxBo9mu6yKXABGTf2DGdtXakFHQ8Ho76wJfvt/aOxoBa93hFHCl17vUrK+tcYMmLX3yg
 mGIA==
X-Gm-Message-State: AOAM531tim8NKw/5JP+N59k8ACTe8huGJiuHpSjDZbZL0c8vuA2J7Zbh
 MHpvZREoNJ2x2YcupWKqBTb/HBAeACM=
X-Google-Smtp-Source: ABdhPJzySIFiU8i9IsyVB71fD9wU9397xyKaPuwCtIWzRAQO79qZZ73IGTMZVdDEaXyLKHNwI51WPw==
X-Received: by 2002:a05:6402:8d3:: with SMTP id
 d19mr22523821edz.321.1623758520506; 
 Tue, 15 Jun 2021 05:02:00 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:f438:4e93:3853:400c?
 ([2a02:908:1252:fb60:f438:4e93:3853:400c])
 by smtp.gmail.com with ESMTPSA id c19sm11704904edw.10.2021.06.15.05.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jun 2021 05:02:00 -0700 (PDT)
Subject: Re: [RFC PATCH] drm/ttm: Do page counting after populate callback
 succeed
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210615115746.27424-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f70e88b3-f0db-fca8-f05e-f685f1a913ad@gmail.com>
Date: Tue, 15 Jun 2021 14:01:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210615115746.27424-1-xinhui.pan@amd.com>
Content-Language: en-US
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
Cc: daniel@ffwll.ch, christian.koenig@amd.com, dri-devel@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.06.21 um 13:57 schrieb xinhui pan:
> Amdgpu set SG flag in populate callback. So TTM still count pages in SG
> BO.

It's probably better to fix this instead. E.g. why does amdgpu modify 
the SG flag during populate and not during initial creation? That 
doesn't seem to make sense.

Christian.

> One easy way to fix this is lets count pages after populate callback.
>
> We hit one issue that amdgpu alloc many SG BOs, but TTM try to do swap
> again and again even if swapout does not swap SG BOs at all.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/ttm/ttm_tt.c | 32 +++++++++++++-------------------
>   1 file changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> index a1a25410ec74..4fa0a8cd71c0 100644
> --- a/drivers/gpu/drm/ttm/ttm_tt.c
> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> @@ -317,13 +317,6 @@ int ttm_tt_populate(struct ttm_device *bdev,
>   	if (ttm_tt_is_populated(ttm))
>   		return 0;
>   
> -	if (!(ttm->page_flags & TTM_PAGE_FLAG_SG)) {
> -		atomic_long_add(ttm->num_pages, &ttm_pages_allocated);
> -		if (bdev->pool.use_dma32)
> -			atomic_long_add(ttm->num_pages,
> -					&ttm_dma32_pages_allocated);
> -	}
> -
>   	while (atomic_long_read(&ttm_pages_allocated) > ttm_pages_limit ||
>   	       atomic_long_read(&ttm_dma32_pages_allocated) >
>   	       ttm_dma32_pages_limit) {
> @@ -342,6 +335,13 @@ int ttm_tt_populate(struct ttm_device *bdev,
>   	if (ret)
>   		goto error;
>   
> +	if (!(ttm->page_flags & TTM_PAGE_FLAG_SG)) {
> +		atomic_long_add(ttm->num_pages, &ttm_pages_allocated);
> +		if (bdev->pool.use_dma32)
> +			atomic_long_add(ttm->num_pages,
> +					&ttm_dma32_pages_allocated);
> +	}
> +
>   	ttm_tt_add_mapping(bdev, ttm);
>   	ttm->page_flags |= TTM_PAGE_FLAG_PRIV_POPULATED;
>   	if (unlikely(ttm->page_flags & TTM_PAGE_FLAG_SWAPPED)) {
> @@ -355,12 +355,6 @@ int ttm_tt_populate(struct ttm_device *bdev,
>   	return 0;
>   
>   error:
> -	if (!(ttm->page_flags & TTM_PAGE_FLAG_SG)) {
> -		atomic_long_sub(ttm->num_pages, &ttm_pages_allocated);
> -		if (bdev->pool.use_dma32)
> -			atomic_long_sub(ttm->num_pages,
> -					&ttm_dma32_pages_allocated);
> -	}
>   	return ret;
>   }
>   EXPORT_SYMBOL(ttm_tt_populate);
> @@ -384,12 +378,6 @@ void ttm_tt_unpopulate(struct ttm_device *bdev, struct ttm_tt *ttm)
>   	if (!ttm_tt_is_populated(ttm))
>   		return;
>   
> -	ttm_tt_clear_mapping(ttm);
> -	if (bdev->funcs->ttm_tt_unpopulate)
> -		bdev->funcs->ttm_tt_unpopulate(bdev, ttm);
> -	else
> -		ttm_pool_free(&bdev->pool, ttm);
> -
>   	if (!(ttm->page_flags & TTM_PAGE_FLAG_SG)) {
>   		atomic_long_sub(ttm->num_pages, &ttm_pages_allocated);
>   		if (bdev->pool.use_dma32)
> @@ -397,6 +385,12 @@ void ttm_tt_unpopulate(struct ttm_device *bdev, struct ttm_tt *ttm)
>   					&ttm_dma32_pages_allocated);
>   	}
>   
> +	ttm_tt_clear_mapping(ttm);
> +	if (bdev->funcs->ttm_tt_unpopulate)
> +		bdev->funcs->ttm_tt_unpopulate(bdev, ttm);
> +	else
> +		ttm_pool_free(&bdev->pool, ttm);
> +
>   	ttm->page_flags &= ~TTM_PAGE_FLAG_PRIV_POPULATED;
>   }
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
