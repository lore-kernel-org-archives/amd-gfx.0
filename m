Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F43C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 09:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6315914B04F;
	Thu,  7 Jul 2022 09:54:18 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB7CD14B03D
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 09:54:16 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id ay25so649369wmb.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Jul 2022 02:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=VQO0TVLIYJkevyjKopZZJvqxIDs83EK6u247lS3rklA=;
 b=pnMRUsxQfUtCAZW7JJdz71Zxgmpj+oVjvh0UxNSqZv14I1H30wS8VbwZjWOuU7iGVB
 AiTiJ7HnPgZ1tMhAhqBYKnVGJCwGhWeNT4aKO5SBAPKLhIKcYs47DDKAX7Fvf9QftsJW
 X2RGkdDHmVJTMiv54SqZBwAl4bjoY+Me0zO6MUiGqF626Rvfkw6Il1Jsg+jxuXIzIQhG
 v42u+GiTHbB6NvkdJB/2wBsnZFY1asrezomFGO3QnOMquLXHncgFFHgGmiZQ2Wdy662A
 az6ZiKzM9Go/q9VEumVqHQfiv2HOKTCzzoXTvTC3HEyTKLBhhukVhA44ojtm2PeNMa1p
 2zmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=VQO0TVLIYJkevyjKopZZJvqxIDs83EK6u247lS3rklA=;
 b=6okbFj7EnIYU3MxrJA88/11iM9ccXx381nhGP6jaKdAFo6IrGPaFIBIlkM5R9gmK73
 7G3bwOnTBVpOFZbv4iMYTqI4icNWt8VD3uICclbP4J+9aN0hns5ZqQUBCtR+VOmV7cOo
 8RnFYw6a6SVhn2FQeepohTJyvr/BmDaPxUrRcv+LoOhO54wTHncaIz81QJxcDaNb1c+I
 TsqWLjjUIVk5EookgGftZWbxpawCu1/CsVbsgBPpledDo+rAntoiMm5YiY5/GmTD+A1W
 3dEjn1O9JjQWdMhA7W2ilJu1PNlp0hco5uXsrxwQ1/IoUEX7IeUhF5YCYGw4AoOJi+N5
 73Xg==
X-Gm-Message-State: AJIora9BKRNfOcPdSrg1akdoLq4EoNlfgWVrfUr2wFG3VG6vRfUIZvrt
 POzj4HJdRzPHGhi7o5pf6aiWgP1/9Zc=
X-Google-Smtp-Source: AGRyM1tYxadWsnipftMqOsyu055/vjRuQzuBpTKe0HtQavM+jwC+LG6GfNkTxg67gDfEaz1NE/G5Wg==
X-Received: by 2002:a05:600c:3494:b0:3a0:37f0:86ad with SMTP id
 a20-20020a05600c349400b003a037f086admr3552212wmq.65.1657187655390; 
 Thu, 07 Jul 2022 02:54:15 -0700 (PDT)
Received: from [192.168.178.21] (p57b0bd9f.dip0.t-ipconnect.de.
 [87.176.189.159]) by smtp.gmail.com with ESMTPSA id
 l26-20020a1ced1a000000b003a03ae64f57sm7722180wmh.8.2022.07.07.02.54.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Jul 2022 02:54:14 -0700 (PDT)
Message-ID: <92f468dc-2fad-5135-4aeb-c8ce2a680c69@gmail.com>
Date: Thu, 7 Jul 2022 11:54:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Fix a NULL pointer of fence
Content-Language: en-US
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220707095053.6755-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220707095053.6755-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.07.22 um 11:50 schrieb xinhui pan:
> Fence is accessed by dma_resv_add_fence() now.
> Use amdgpu_amdkfd_remove_eviction_fence instead.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 0036c9e405af..1e25c400ce4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1558,10 +1558,10 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>   
>   	if (!process_info)
>   		return;
> -
>   	/* Release eviction fence from PD */
>   	amdgpu_bo_reserve(pd, false);
> -	amdgpu_bo_fence(pd, NULL, false);
> +	amdgpu_amdkfd_remove_eviction_fence(pd,
> +					process_info->eviction_fence);

Good catch as well, but Felix needs to take a look at this.

Regards,
Christian.

>   	amdgpu_bo_unreserve(pd);
>   
>   	/* Update process info */

