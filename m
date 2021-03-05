Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA32C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B7365085
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B7365085
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 906106EB3E;
	Fri,  5 Mar 2021 15:13:22 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4896EB3E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 15:13:21 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id 2so1963128qtw.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Mar 2021 07:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ahJxcpnu1MpaRoDD9vu6aSxQjWtxlJ5AgVzbREw5TVY=;
 b=Jnx6TsBpfbt9/Kr983pmtd1y0z5+x4yRou+oFZqPdQVa9Tm33x1p783LUzPXmhAnyG
 FD4pvGPpfz3qHWWKTqsnaTbrvD17Sj8IWGR3RdVIiY2+mDZnzkOgWMOxZTzmpHylW3mQ
 p/gYJRxu4BHCHZSbfT/4oB93r0XV62o66OkDrA9oOgXSrsZntKpKFxWbon0I3KtU/w0e
 fr3qyCHBbjDieCPZme8zurPrT31VNAumcq7cyttcke64ETz4J1l03xfHQKTpCrynGJAD
 uWeRE9YQqSqq5zzy+zANwgCiweVX5WbO9StpVrsG8uU8CTTsDoGtTCQ7mgzdN98lIAWO
 SI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ahJxcpnu1MpaRoDD9vu6aSxQjWtxlJ5AgVzbREw5TVY=;
 b=fbpLzkbZCu/ParZLPMIWwPwEboIzENsCRutifdEZ6U0z6N9ymX48Z9zXMqfNXUXxkp
 M0UCChMepgUMbjr1DEvHT2+CzOTUHcFoxguaq5Bk16JeJQ0BoQQsJUWGF1lFe7kSyuk6
 To0O8YgjzzPo49FbgldSaLCQ5zAhsOX9EpFYp2a3icj3xVyJjGnKBgptdfs9DTMptKbt
 on1/K5KY5axB5noQPyF8up/SxqA9PcJMjoDdJd7Y5NmMrpcvyvk1W6QxHR1IdEXsJ1Ut
 irE0nPQCbUGVtImK2/Lb8fr3AUXcLcWTFHy8Lqt0UE7KtzCnsaDfembiuL3hnmXWGm+A
 TkMA==
X-Gm-Message-State: AOAM531CsNgqyHDIBBy23pKC3Q3NljIaAYH2UfjNRNUYmKWKScRGQPM0
 NBRn4wAF7Tpdns/ze/zFOBkNHw8kyCswsQ==
X-Google-Smtp-Source: ABdhPJyXxtiLYVSBf37KIxDxfaBP1x29/UtY/yBS2Gyv0rQWR5ApSnBl4hr2lJ8OCDPG63xZob5Pjw==
X-Received: by 2002:ac8:5709:: with SMTP id 9mr9397441qtw.8.1614957201038;
 Fri, 05 Mar 2021 07:13:21 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:ee4e:e545:33e0:7359?
 ([2a02:908:1252:fb60:ee4e:e545:33e0:7359])
 by smtp.gmail.com with ESMTPSA id k4sm2040619qte.59.2021.03.05.07.13.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 07:13:20 -0800 (PST)
Subject: Re: [PATCH 4/5] drm/amdgpu: use tiling_flags of struct amdgpu_bo_user
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210305143532.5936-1-nirmoy.das@amd.com>
 <20210305143532.5936-4-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <42997172-c13f-4f75-ca24-20bd7bb13243@gmail.com>
Date: Fri, 5 Mar 2021 16:13:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305143532.5936-4-nirmoy.das@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 05.03.21 um 15:35 schrieb Nirmoy Das:
> This flag is only needed for BOs created by amdgpu_gem_object_create(),
> so we can remove tiling_flags from the base class.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 +++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 -
>   2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 355d01ebce51..2e5cf46251af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1174,12 +1174,19 @@ int amdgpu_bo_fbdev_mmap(struct amdgpu_bo *bo,
>   int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	struct amdgpu_bo_user *ubo;
> +
> +	if (bo->tbo.type != ttm_bo_type_device) {
> +		DRM_ERROR("can not set tiling_flags for a non-amdgpu_bo_user type BO\n");
> +		return -EINVAL;
> +	}

I would just replace this with a WARN_ON or even BUG_ON since we should 
never ever make kernel BOs accessible to users space.

But what could be is that this is used with an imported SG table BO, so 
you need to make this check bo->tbo.type == ttm_bo_type_kernel.

Christian.

>   
>   	if (adev->family <= AMDGPU_FAMILY_CZ &&
>   	    AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT) > 6)
>   		return -EINVAL;
>   
> -	bo->tiling_flags = tiling_flags;
> +	ubo = container_of((bo), struct amdgpu_bo_user, bo);
> +	ubo->tiling_flags = tiling_flags;
>   	return 0;
>   }
>   
> @@ -1193,10 +1200,18 @@ int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags)
>    */
>   void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
>   {
> +	struct amdgpu_bo_user *ubo;
> +
> +	if (bo->tbo.type != ttm_bo_type_device) {
> +		DRM_ERROR("can not get tiling_flags for a non-amdgpu_bo_user type BO\n");
> +		return;
> +	}
> +
>   	dma_resv_assert_held(bo->tbo.base.resv);
> +	ubo = container_of((bo), struct amdgpu_bo_user, bo);
>   
>   	if (tiling_flags)
> -		*tiling_flags = bo->tiling_flags;
> +		*tiling_flags = ubo->tiling_flags;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index cbb881afe6da..6cc38b71f7ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -91,7 +91,6 @@ struct amdgpu_bo {
>   	struct ttm_bo_kmap_obj		kmap;
>   	u64				flags;
>   	unsigned			pin_count;
> -	u64				tiling_flags;
>   	u64				metadata_flags;
>   	void				*metadata;
>   	u32				metadata_size;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
