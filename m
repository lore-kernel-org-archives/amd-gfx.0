Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB5BC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 09:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 934A610E484;
	Thu,  8 Dec 2022 09:30:17 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC9610E484
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 09:30:11 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id e13so1290952edj.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Dec 2022 01:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WTi4MEUIM6bEcstxggbjh2PPZJNpHMzpWLGx4ZBzasQ=;
 b=Jr6E5I+sScvEyFvkmJQ6ZklhaKXYAcJwwCSNsNp3hk2V4AVjvYZqJN2vGMJsbbWvX6
 uNGYqvWbTGKh9r6/kJphDhleRJWc0o4ChbaayrAQuR+SWeSVjFs8X2TEdI6KCo3+iUVK
 mlz68SPzKS+8+1H3agMu1ygfFZUjgTrlSvRQFUGvXg8a9vDyIBAbQXUsZN2YIP9rEKQQ
 FjpMsVp8GDJ3+RgmyySWlVxGI3BrioqwfHmWRF9uebSSgtl62uhlngEPGQRx3xhuW3p+
 l7D5wxxTz78ljbB0YwEH6mNMgC66HKUwS074ZLdgbMF9e3yB9Kc/5LrLLdJhNBZNStT1
 iCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WTi4MEUIM6bEcstxggbjh2PPZJNpHMzpWLGx4ZBzasQ=;
 b=f7TjYLTz1urmLTCO/TZ7bSLf/PN7OUKx/FEoZ9fX2Sz0hm2sQVWPw30e2f6i9gKLA4
 d7WLOmf0skpZK6uxWllVOZyYycexptDQoBZ5fL4kZaYnmEdAvC7+P7sKzqqmZwxJKZd3
 3KtMSlkuXQ79d/u5i15nllBK4gj9CM8Bi+IOoAnA8gUYZir7dWblPwwcAxINYMoThACL
 oO/35pEYOH4wRVfi+RmrVu8d8+CanR3eQ0OMTwkAe9bCga1sk4gJpb+MNctzVyA2L/iO
 NHtf6NU0KxeYp4lxmrNeH+rrFjm3CQICI5JkcMaP/kxqaKWH9GuoswjJ1PLscWK3NhIP
 ROmg==
X-Gm-Message-State: ANoB5plcfTt1LPHfIZbW6I46BjwJeEfXpXRORUdpAgb+8tLTLJH2uc6J
 R9Q6Sumcr+xbwLdSnfUPbXQ=
X-Google-Smtp-Source: AA0mqf4FFybo+2J36zSCsVmLyq/jfNbgqGT3VdmRF24e/HighIETBA4GUbTxjqdi7cDTrdiOxC1ucg==
X-Received: by 2002:aa7:c9cd:0:b0:461:891a:8162 with SMTP id
 i13-20020aa7c9cd000000b00461891a8162mr81838273edt.398.1670491809905; 
 Thu, 08 Dec 2022 01:30:09 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:172d:b6f5:d270:8dd2?
 ([2a02:908:1256:79a0:172d:b6f5:d270:8dd2])
 by smtp.gmail.com with ESMTPSA id
 a19-20020aa7cf13000000b00463c475684csm3188546edy.73.2022.12.08.01.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Dec 2022 01:30:09 -0800 (PST)
Message-ID: <9d88a136-bd7e-3af2-acc7-c19521556a2d@gmail.com>
Date: Thu, 8 Dec 2022 10:30:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: Add an extra evict_resource call during
 device_suspend.
Content-Language: en-US
To: Shikang Fan <shikang.fan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221208092545.4792-1-shikang.fan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221208092545.4792-1-shikang.fan@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.12.22 um 10:25 schrieb Shikang Fan:
> - evict_resource is taking too long causing sriov full access mode timeout.
>    So, add an extra evict_resource in the beginning as an early evict.
> - Move the original evict_resource after ip_suspend2.
>
> Signed-off-by: Shikang Fan <shikang.fan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 818fa72c670d..8b7db87cffd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4111,6 +4111,10 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   
>   	adev->in_suspend = true;
>   
> +	r = amdgpu_device_evict_resources(adev);
> +	if (r)
> +		return r;
> +
>   	if (amdgpu_sriov_vf(adev)) {
>   		amdgpu_virt_fini_data_exchange(adev);
>   		r = amdgpu_virt_request_full_gpu(adev, false);
> @@ -4135,14 +4139,14 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   	if (!adev->in_s0ix)
>   		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>   
> -	r = amdgpu_device_evict_resources(adev);
> -	if (r)
> -		return r;
> -
>   	amdgpu_fence_driver_hw_fini(adev);
>   
>   	amdgpu_device_ip_suspend_phase2(adev);
>   
> +	r = amdgpu_device_evict_resources(adev);
> +	if (r)
> +		return r;
> +

As noted internally please keep this evict resources call where it was.

It makes sense to evict the BOs which were previously pinned by display 
with the SDMA engine.

Only the final eviction of BOs for fw etc.. should be done with the CPU.

I suggest to also add a comment to each call explaining why we need it.

Regards,
Christian.

>   	if (amdgpu_sriov_vf(adev))
>   		amdgpu_virt_release_full_gpu(adev, false);
>   

