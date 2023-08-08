Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E07BC001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 14:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C925510E1C1;
	Tue,  8 Aug 2023 14:59:18 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E5B10E1C3
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 14:59:16 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9923833737eso802200066b.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Aug 2023 07:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691506755; x=1692111555;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PwNOpZkrGlAJ+sZaVmIQkSXcaZP/4s+78wGEDys/wuo=;
 b=GMPhOaEVKFqOZAg7z1IQxbeH9ournhjHVUoNhFn5xSGrmeaPxIoEePuHPAYwz3d8Cd
 Q0quBXj2RY6GqTZ1b1bQ9hJ31+m6sG65vNkeaNgeYYVEdtsBqmiF6g+rRzvW2cM3/kXc
 RVFC1KGehEMjPYNBFTxQ/4clQkBwoUMP35gILK82DzAEQb0PAC1MAZeQzEwE8nDXqd3F
 KExwrbD1hPgbHA+fOR+siSu9TOtWzqGmZspIIXPDRYBtfSOzsH3v1Sj0YQ/bE1NmkDXD
 LoJVj2id+gCWB76/Q+Nd3JwVAcv6alpCl7c3TpYSL3nBLgln01zy/yU9vNZx/cyTkMH9
 eOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691506755; x=1692111555;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PwNOpZkrGlAJ+sZaVmIQkSXcaZP/4s+78wGEDys/wuo=;
 b=F6MmyMi6vc07gMWe123i2YA7i3EEWbWemi+bu6VFedA2i1nqJenGojK+0ron+AuosG
 FK1IYyjGl9kGcM0CPIpaw5lfU7x8mG20KtprDvr7RLalMTKIwOloFFX91rn04fRKDqBS
 XkQwAisfewKj5DhT1QfC1RWiCoTTsfCvkpoIeYvCTX8RuXP0qL9hcwMBmaaYcKvK6o8q
 Yi/H3/G7mQLWhmPIvovd8vJCZXA3dOatG9tSiyOVhjjk96xlnSDCJ2rRqKDvCllmohyM
 iwqr2UvNQQshEmfKs5ovINo5QmWT12tdXZspEcBxdn1N6K0FT8g6SypxDhkSdYNNRXVC
 UsXQ==
X-Gm-Message-State: AOJu0YyDgGpcUBpDQZgLDsdtgCgge7DQ4Z8vrS3noHe8UZ37N0Tfgpyu
 sk5jA2jjjaqkr505HiGc8nA=
X-Google-Smtp-Source: AGHT+IFjIo/XcMc2wrHj6JfHEEXONnqYTY7Ooi7cKPWNPcOsoKtsGgJGhWs7CHhG3o33WZNKcv44Lg==
X-Received: by 2002:a17:906:e:b0:99c:7134:ab6d with SMTP id
 14-20020a170906000e00b0099c7134ab6dmr11160132eja.41.1691506754577; 
 Tue, 08 Aug 2023 07:59:14 -0700 (PDT)
Received: from ?IPV6:2a00:e180:1471:fb00:e090:ae3d:1c51:b452?
 ([2a00:e180:1471:fb00:e090:ae3d:1c51:b452])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a170906688900b0099ce188be7fsm2474741ejr.3.2023.08.08.07.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 07:59:13 -0700 (PDT)
Message-ID: <c6866c85-34ab-7e4d-dbbe-5b21c5b29df2@gmail.com>
Date: Tue, 8 Aug 2023 16:59:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 1/5] drm/amdkfd: ignore crat by default
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230807220545.1320198-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230807220545.1320198-1-alexander.deucher@amd.com>
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

Am 08.08.23 um 00:05 schrieb Alex Deucher:
> We are dropping the IOMMUv2 path, so no need to enable this.
> It's often buggy on consumer platforms anyway.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Bye ATC, it wasn't really nice with you :)

Acked-by: Christian König <christian.koenig@amd.com> for the whole series.

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 49f40d9f16e86..f5a6f562e2a80 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1543,11 +1543,7 @@ static bool kfd_ignore_crat(void)
>   	if (ignore_crat)
>   		return true;
>   
> -#ifndef KFD_SUPPORT_IOMMU_V2
>   	ret = true;
> -#else
> -	ret = false;
> -#endif
>   
>   	return ret;
>   }

