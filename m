Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327C4C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 14:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD7A64F11
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 14:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD7A64F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F1C6EA82;
	Fri,  5 Mar 2021 14:37:51 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 752566EA82
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 14:37:50 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id s15so1867357qtq.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Mar 2021 06:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=OK8mw5xPLZnPYFhUbVyVzmHt0cU+aJk0F+nBWYA5YB8=;
 b=j0HsDznGpSibAqnZfuGR5PZDzfNfWJSsum66qwBIkUYY5jRxmp7GjCvuh79UCltKlJ
 XZbyl5yAkLC52nTkod3EIarqwKNrf3gTB0YbvdRvr4LPmFhGi06KtmLqzu8A/rb9ljSV
 g71/JbIxuJKnT5EBiIz2SspEwt35UIEsn1pqsHXMeT1Vu9/KQrvxA66c0IJbclrl+fu6
 ju+58QMjYJQyDP5ECWLkVXOEKt71pNHhYnmcKt9FD95rxqpqdxlcLqnSSKyMNIkiMhIw
 qm49KwmMQDxJFT+9kThnFv+r0ooCzHlYWwejckq09MJSCsn2/80SBhOx/OEB5rpwVhnH
 wO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=OK8mw5xPLZnPYFhUbVyVzmHt0cU+aJk0F+nBWYA5YB8=;
 b=hkkSbaNPhDMGIK8V4fbogc9l6ZkujvcXkgiLAF8rDV0gEzoZGphMR5OshTu0Sz7ub6
 nCrBOrpbXaGFDLEJZVR8zSENSInBrpaxKZarDSIsC8ktpQ5ac2f2LVGNwNSLFxRsd4WO
 28+Y51NU3GxLv+19xQAA2CqPNLDe+7vXeUqiB5FT/L2vjf/g4hg7bzAzoW4Nrd1dkHQX
 k1tSzRGDVkYQ5QABKHE/6E8YMBqpYPn2BImYxwWyqO4PEYBbVFodqFgW9lPFBgvZDYvT
 QlNakCAQt1KdR5UvBgNEmEGe/Ekh4asqFvXkiniyodPApQVsTBYsvZ9+tDNQ1LWfYqES
 N7iA==
X-Gm-Message-State: AOAM532jjGx3fNDx9xFJoWpOBAGN15KGHYb7X1EgCKRR4WNq5/7E7jvV
 NdknyItks59mQMg8sFIep2QMw4/dKeVsug==
X-Google-Smtp-Source: ABdhPJzZORqqES3E7KfXpUtZJUsjjApJjKxj162QUV3Q2vEntJuEsT5rpPk/R3s8sThsluDmsKnBIQ==
X-Received: by 2002:ac8:76c5:: with SMTP id q5mr7769589qtr.376.1614955069698; 
 Fri, 05 Mar 2021 06:37:49 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:ee4e:e545:33e0:7359?
 ([2a02:908:1252:fb60:ee4e:e545:33e0:7359])
 by smtp.gmail.com with ESMTPSA id m190sm1839950qkc.66.2021.03.05.06.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 06:37:49 -0800 (PST)
Subject: Re: [PATCH 1/5] drm/amdgpu: allow variable BO struct creation
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210305143532.5936-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <015f2823-e03f-1cc0-6b9f-4c6109225863@gmail.com>
Date: Fri, 5 Mar 2021 15:37:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305143532.5936-1-nirmoy.das@amd.com>
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
> Allow allocating BO structures with different structure size
> than struct amdgpu_bo.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 0bd22ed1dacf..745393472564 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -551,6 +551,8 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
>   
>   	acc_size = ttm_bo_dma_acc_size(&adev->mman.bdev, size,
>   				       sizeof(struct amdgpu_bo));
> +	if (bp->bo_ptr_size < sizeof(struct amdgpu_bo))
> +		bp->bo_ptr_size = sizeof(struct amdgpu_bo);

You should probably rather fix up all callers and make sure that the 
parameter structure is correctly filled in.

Christian.

>   
>   	bo = kzalloc(sizeof(struct amdgpu_bo), GFP_KERNEL);
>   	if (bo == NULL)
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
