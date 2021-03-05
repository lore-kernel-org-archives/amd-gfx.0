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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA7AC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DBEA6508F
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBEA6508F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52ADE6EBFB;
	Fri,  5 Mar 2021 15:15:29 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A446EBA5
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 15:15:28 +0000 (UTC)
Received: by mail-qt1-x82f.google.com with SMTP id v3so1954990qtw.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Mar 2021 07:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ucGo17w438JESE8skT+tg//rMiOyQ0iSQ5Tg91sLa6M=;
 b=VlfNJK5Xz5sXZgYloo3Aih4orgToEzX1vT0CCBatL8cGCYWwW9fRoXU0yoafxbhSE/
 ffswGvjYRXXpj0xzPNHxfswFAb+dP1vvy1tRGTiC1Spb83B/u19zLxbzgYfGW/K3ThTk
 7c/9EjTBtJ0FbChln4ruPiWnvpM4wFzaCTcSNM5k16tvaVX95YlTPzdCt24Ks2N8E8lb
 DA2NJTPgyGOw8DAO5hq8YnY/K07UmykFpZCo+QA0Ft2XdQXJhW334CtB21Um7JHLAdyP
 b88a29FHGOX7uLt6QDbWrseD2qJhYyCEwvBjz+AzMSHKJOERcN2UVOwqMiBEtPUk0ZYr
 neXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ucGo17w438JESE8skT+tg//rMiOyQ0iSQ5Tg91sLa6M=;
 b=SLO2H+qNiUOYi14PUeRzfSkXrl9PDdffrFskDg9h5z024ecw0Erh1jC8nRiobyHWd1
 yB1LXVKEHb3gcfvii1uxHQmdd3HPTSOg9gaKqK8X/1UG9G4/KOxLFygh32AxllPMYaL8
 9E4ct5CllouTzXTTUArKSH8o6ksRb5phXAWhgOvWrq8TXmFIMe0UV+Rf27Qe4tUXRpp/
 0/jZx5m30GnjjwxwDfUTSlKo3qqBYMzp1OA/xD/VzBsvZppN+gkhuC2CuysnDx7QzKiZ
 q0CNIJLFtVf6owH1FIaIY0AcweXy55djdNDenBDTYoEXRE4az/dXqmYKrJUHvdl8gKHu
 43Eg==
X-Gm-Message-State: AOAM531JUCZIMTlB7QKrwnk+ALpb3erPq0gGNpuU9Vo8D1lO5annsNRn
 kyIWNCRbV5lXtjQUxyw9nlX08ubLwi8cqw==
X-Google-Smtp-Source: ABdhPJxQv57QlrbeeSCUpBerGtKfEnE3A2I6Sn7lM4L7y08bu5z5oZ9F8qLRUP87/zxBiMOitrQoIQ==
X-Received: by 2002:ac8:68b:: with SMTP id f11mr8979303qth.373.1614957327817; 
 Fri, 05 Mar 2021 07:15:27 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:ee4e:e545:33e0:7359?
 ([2a02:908:1252:fb60:ee4e:e545:33e0:7359])
 by smtp.gmail.com with ESMTPSA id e132sm1975418qkb.15.2021.03.05.07.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 07:15:27 -0800 (PST)
Subject: Re: [PATCH 1/5] drm/amdgpu: allow variable BO struct creation
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210305150617.20144-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fad3377e-3eb0-a4ad-8526-42a638f2ab20@gmail.com>
Date: Fri, 5 Mar 2021 16:15:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305150617.20144-1-nirmoy.das@amd.com>
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



Am 05.03.21 um 16:06 schrieb Nirmoy Das:
> Allow allocating BO structures with different structure size
> than struct amdgpu_bo.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>   2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 0bd22ed1dacf..1ff8c3570c82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -551,8 +551,12 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
>   
>   	acc_size = ttm_bo_dma_acc_size(&adev->mman.bdev, size,
>   				       sizeof(struct amdgpu_bo));
> +	if (bp->bo_ptr_size < sizeof(struct amdgpu_bo)) {
> +		DRM_ERROR("can't create BO with size < struct amdgpu_bo\n");
> +		return -EINVAL;
> +	}

Please make this a BUG_ON instead. When this is wrong we corrupt kernel 
memory.

Christian.

>   
> -	bo = kzalloc(sizeof(struct amdgpu_bo), GFP_KERNEL);
> +	bo = kzalloc(bp->bo_ptr_size, GFP_KERNEL);
>   	if (bo == NULL)
>   		return -ENOMEM;
>   	drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
> @@ -642,6 +646,7 @@ static int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
>   		AMDGPU_GEM_CREATE_SHADOW;
>   	bp.type = ttm_bo_type_kernel;
>   	bp.resv = bo->tbo.base.resv;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>   
>   	r = amdgpu_bo_do_create(adev, &bp, &bo->shadow);
>   	if (!r) {
> @@ -676,6 +681,9 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	int r;
>   
>   	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
> +	if (bp->bo_ptr_size < sizeof(struct amdgpu_bo))
> +		bp->bo_ptr_size = sizeof(struct amdgpu_bo);
> +
>   	r = amdgpu_bo_do_create(adev, bp, bo_ptr);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 8cd96c9330dd..848dc0a017dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -40,6 +40,7 @@
>   struct amdgpu_bo_param {
>   	unsigned long			size;
>   	int				byte_align;
> +	u32				bo_ptr_size;
>   	u32				domain;
>   	u32				preferred_domain;
>   	u64				flags;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
