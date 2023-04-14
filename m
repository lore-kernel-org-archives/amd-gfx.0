Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D43C77B72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 11:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4374710E16C;
	Fri, 14 Apr 2023 11:26:14 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B0B210E16C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 11:26:12 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 l10-20020a05600c1d0a00b003f04bd3691eso20607477wms.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 04:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681471570; x=1684063570;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vrvyRh+C6WLhjgCiIMj8qeHMXW4W4xbl9Bqr5eOi0VY=;
 b=RI+U5BkRWlaDdh/mqizkFmwceK5p3xI+UwxNf8rjUM9vVxUqS7Le55ryT/mZecIqPC
 q+woO94Dt4zp4pHLGsn94kmljZZ8bBRPeOQ5OlmTQ7uOw52EnQqOT+XH+6A6xjU8N/rC
 boISrVvwYV/gZkfg7bh3G65x5R8iohixx4aNvh9JJYOQP+gH6qeRtL5jC29VBNEHoUcB
 j4oMcQKvD42yTr22C6Av6GbTkOGVvMdCMAoPf4Wf/XD2bedGpx+Z6oUrEnc3/NY2L1XU
 gr1fOW4M1kxKnXeWjTAlNixrkR8x9voKvQmNKQne8Nx8byxKlMdGFKvzplqKblFT2RRn
 gzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681471570; x=1684063570;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vrvyRh+C6WLhjgCiIMj8qeHMXW4W4xbl9Bqr5eOi0VY=;
 b=hTlkeybs62MP2KA/8aB9RFU3qq9fdGFV4pFgrbbUwKLXjuwC1qYBfaiZNKS5RhkDMX
 6I7s9sDfd7gSNqIiACRA/Nm6vEaPk0IYj95OcJe17MW47+ACnrlPhmrmEGjK6d5Du54h
 Gx/6hKBIc6YWU0go6oURSfn74k5fNBTvq9P9E5Y8NveYtTxKGTRev+z0glBcNh0DrQJu
 3VaByoRXzDnQF9Tr82PHmCzLIhhPlUDGlZxgBSYA2+5W3l0sJKyEcSRpguuAkDdQncRz
 3Y/oFF31mD5iUY3ysmrnSYKOKNleS01Rv8QFsUe6lSSoS6FeBS0awrknuC6ckDMXc7Cr
 +ecQ==
X-Gm-Message-State: AAQBX9eISZ+ijj9SjdNYacMMLUPXT4DJJ3HHJrrvKdv1cW+smlI+lDN8
 17nzM4tIzDzRjT0NoQCG7g4=
X-Google-Smtp-Source: AKy350YrOruKYfl9IENSFS5iOKC69aNcTe5HrS3yf68cABzyiSf2y+6uc6TVJzEEKerk/FN8ov/rUA==
X-Received: by 2002:a7b:c4da:0:b0:3ea:f73e:9d8a with SMTP id
 g26-20020a7bc4da000000b003eaf73e9d8amr4363745wmk.30.1681471570265; 
 Fri, 14 Apr 2023 04:26:10 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:5357:4cbc:25bd:5ed5?
 ([2a02:908:1256:79a0:5357:4cbc:25bd:5ed5])
 by smtp.gmail.com with ESMTPSA id
 f20-20020a1c6a14000000b003eae73f0fc1sm4107076wmc.18.2023.04.14.04.26.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Apr 2023 04:26:09 -0700 (PDT)
Message-ID: <3e744248-8359-9f8c-753a-0b01c688fbc2@gmail.com>
Date: Fri, 14 Apr 2023 13:26:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/3] drm/amdgpu: Increase GFX6 graphics ring size.
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20230413142253.414333-1-bas@basnieuwenhuizen.nl>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230413142253.414333-1-bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, maraeo@gmail.com,
 timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.04.23 um 16:22 schrieb Bas Nieuwenhuizen:
> To ensure it supports 192 IBs per submission, so we can keep a
> simplified IB limit in the follow up patch without having to
> look at IP or GPU version.
>
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

I've took the time and double checked the docs and the maximum size of 
the ring buffer on GFX6 is indeed only 1MiB.

So even with this change sched_hw_submission can still go as high as 512 
without problems (the default is 2 or 4 IIRC).

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index c41219e23151..d9ce4d1c50e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -3073,7 +3073,7 @@ static int gfx_v6_0_sw_init(void *handle)
>   		ring = &adev->gfx.gfx_ring[i];
>   		ring->ring_obj = NULL;
>   		sprintf(ring->name, "gfx");
> -		r = amdgpu_ring_init(adev, ring, 1024,
> +		r = amdgpu_ring_init(adev, ring, 2048,
>   				     &adev->gfx.eop_irq,
>   				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
>   				     AMDGPU_RING_PRIO_DEFAULT, NULL);

