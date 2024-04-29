Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E546C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 11:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5F6010E8CA;
	Mon, 29 Apr 2024 11:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eKoI2PUx";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AA8010E8CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 11:06:18 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-41b79451153so22016075e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 04:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714388776; x=1714993576; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lUT9vzVslcPYqsYAv1syc/iNp92bbNkDdxKljLDbQ0Q=;
 b=eKoI2PUxMVh6WGn8qUmTqSpy+hVx1k1hq88AKZv8aMWuiIdzsaXUllCyIR1GEjRGDN
 SN+qlDNKXvdE4uFiIoKsHnPn9MQLYeglrjlzlyTT5sBWHMKSio9O37WS+EijuftVge19
 VoY3oX1Py28BAKxbzInTJWd8e29uPzoEhWiHJTMoZkA5WudD0WSrfLgFnm1Mn4CK1Dko
 DS5yz02+LQnLWCT/VkxFwAW195XFQaLXpflu0d7QhIFAPcmplup0XvJL90WVzn89Z9pi
 PovnWJl7xTGLktZE5B67kmhFub8O1CC9jc5PAdHdbF/tSmpk+IVt2H930q1jaa4XESd4
 FcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714388776; x=1714993576;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lUT9vzVslcPYqsYAv1syc/iNp92bbNkDdxKljLDbQ0Q=;
 b=Qqdu9LOM5dZAx/C0+8tHE/KuOwgyCi5+oV8ihY+1PRaFz4ranCDLnsHfOw2wPLaWxK
 /3gWCuzTIjweV+d9+0SBqLNNrEyjg7U4EbLJtyw9S+wM5DCTIemKFUNmfEZwwZ63CrlA
 dmp4yLsmRTTKuFPqHnxz2wutfMvdqwAmAIR5nU7YqCtlH7929v394NXeQmshUIMQ2pCC
 u+DUphKamDOKN8mjP/vdzrkStFSDEjMyfLX+X6TBGs8aK1Wob0Ktdvgm9w9xGaI+xJem
 JIf1j85K6b0DOYziCJohY6FTz5O7QIi+lCUpp8Shfsub/b3cnurRcJU0vjNck4ZWVroO
 GA4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbJ7ZLDz25+a1unkh9spj/KV6bE5xKefrAIGVLJVBYJ/DSw8N3ZzPRQ6CAFmdrnH6hKx+VCWzaAG1FXzEeg3VnBhAxVWX6alP4lqGV5w==
X-Gm-Message-State: AOJu0YzxYpoR1h4aOUz0BxggqfFLAHJiTiZ3lHT7Eq6MZKUdngTuCoXn
 G9CmLG0z0GlObaEUoJZefV+CawA9Qpqxp2d9Ttjv9PKIBbmspKY6
X-Google-Smtp-Source: AGHT+IE5oFzC7TwCEMITXgtavOrMlUvCN+p47y2lJp9kuwP51lUnMOSVIBoGkAh3yCG6QaCO+sgdxQ==
X-Received: by 2002:a05:600c:4449:b0:41a:fa9a:d86b with SMTP id
 v9-20020a05600c444900b0041afa9ad86bmr7483424wmn.11.1714388776318; 
 Mon, 29 Apr 2024 04:06:16 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a05600c34d200b0041b083e16e2sm19141160wmq.2.2024.04.29.04.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 04:06:15 -0700 (PDT)
Message-ID: <c66a5f9a-99df-43ea-b2c7-94db01957951@gmail.com>
Date: Mon, 29 Apr 2024 13:06:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix pinned GART area accounting and
 fdinfo reporting
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20240426164355.1563-1-tursulin@igalia.com>
 <20240426164355.1563-4-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240426164355.1563-4-tursulin@igalia.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.04.24 um 18:43 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> When commit b453e42a6e8b ("drm/amdgpu: Add new placement for preemptible
> SG BOs") added a new TTM region it missed to notice the conceptual
> imbalance in GART pin size accounting as done in amdgpu_bo_pin/unpin.
>
> That imbalance leads to such objects getting accounted against the
> resource, but are not un-accounted when unpinned.
>
> Fix by extending the accounting criteria in amdgpu_bo_unpin.
>
> What also aappears needs fixing is not reporting their size from the
> amdgpu_bo_get_memory, which is used to implement fdinfo stats, so they are
> not mixed with the regular userspace created and driver owned objects.
>
> And also amdgpu_bo_print_info for debugfs reporting.
>
> Note that the patch depends on the previous one which broke down the
> relevant checks from the domain based to placement based.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: b453e42a6e8b ("drm/amdgpu: Add new placement for preemptible SG BOs")
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index fb984669fc3a..5a2bbc793953 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1032,7 +1032,8 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>   		atomic64_sub(amdgpu_bo_size(bo), &adev->vram_pin_size);
>   		atomic64_sub(amdgpu_vram_mgr_bo_visible_size(bo),
>   			     &adev->visible_pin_size);
> -	} else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
> +	} else if (bo->tbo.resource->mem_type == TTM_PL_TT ||
> +		   bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT) {

Good catch, but please separate that one from the other changes since we 
probably want to backport it.

>   		atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>   	}
>   
> @@ -1298,7 +1299,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>   			stats->vram_shared += size;
>   		break;
>   	case TTM_PL_TT:
> -	case AMDGPU_PL_PREEMPT:
>   		stats->gtt += size;
>   		if (shared)
>   			stats->gtt_shared += size;
> @@ -1599,7 +1599,6 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
>   				placement = "VRAM";
>   			break;
>   		case TTM_PL_TT:
> -		case AMDGPU_PL_PREEMPT:

Yeah, that makes sense as well. But we need a case for AMDGPU_PL_PREEMPT 
here as well then.

Regards,
Christian.

>   			placement = "GTT";
>   			break;
>   		case TTM_PL_SYSTEM:

