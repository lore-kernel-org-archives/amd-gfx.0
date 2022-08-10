Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E623C00140
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Aug 2022 16:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D8A14B1D0;
	Wed, 10 Aug 2022 16:51:44 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30BB214AE13
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 16:51:37 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id k26so28783000ejx.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=fXbCy9rHvZVgM+p3VOlHYad9cpzN6zg2P8UrX5OIFFc=;
 b=CAMS3hmpRcptOI8wWHCDgANGOmk5hppXTYO6bplECSCu8Q31P5Utw5ZtbjB4IfttYt
 z8HYfB0373QsAQ52EDc06BflvRxYjpRlzXUXpSPKKTnTnSHZH1vNRYKyZuR9HaMjZiQ/
 5Bdjyed4TX8H+fZIcuRege+xm2V3ivz0SG8/CGFFOyMmTkC64dcFd6IPPgS5TR95D9rt
 CTD8z2hZjLi+OxDEwqbfDiPgwveVx/PszPOexbKNW3j7BxF4RRNOkeni+Heoz10srgJ+
 07/eY+07hZZPHUtglmprAQilJcw7A71yFTrBPxK3FyDCJ9LSwJ0nKJISMNnQJWuXL7cZ
 8BOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=fXbCy9rHvZVgM+p3VOlHYad9cpzN6zg2P8UrX5OIFFc=;
 b=jkcRI/qL06LFeBYMLOm9oEZ0tZcLRUBP0MecC/OKATc6fyE3+F2yOhluPTO1v/p49T
 1DzsiaVrGSue8nbmEZ1JF5DpiYLWk1TLKnpaFTrhmDHsJvU2EFoRlF7FPZakZwcTzYGj
 WjNRL4MkfblEbu9rnmjz8omG6RxIjwK5lIcTKHlzFwvDcqk7gkNCpfB1TdhQiu5D7Ojh
 SW6TaUWJILeX96MoHBQqroeITXPXYCmkk9BMINMhALtQiT6eriOwRfVXBvR9X/BFMRAD
 RPox4E/Zv5qXjNjp1ZY4tVfbzk7XbDk+Cc5Ws+WcO7lBYZqL1D45XNRqInjr6W9UhbXb
 ugjA==
X-Gm-Message-State: ACgBeo35LzcsFqRPL3nafzOhV1qTe5uYM/NTo7T2PSHqIKpR7gL3SV0F
 Nb84u14Jl0lk8j9ABTmSOrg=
X-Google-Smtp-Source: AA6agR7GJh+8qabu4EQH6qsfk0Tq4Sfnx1ijAbgSfPKbLm5E4mxa+4CDPA3AJFfKP8lqwOm2Wkj7ow==
X-Received: by 2002:a17:907:3ea8:b0:730:9756:7c81 with SMTP id
 hs40-20020a1709073ea800b0073097567c81mr21515778ejc.726.1660150296198; 
 Wed, 10 Aug 2022 09:51:36 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:792d:ce01:420a:664a?
 ([2a02:908:1256:79a0:792d:ce01:420a:664a])
 by smtp.gmail.com with ESMTPSA id
 n6-20020aa7c786000000b0043a554818afsm7917083eds.42.2022.08.10.09.51.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Aug 2022 09:51:35 -0700 (PDT)
Message-ID: <572bd280-09ef-4026-c812-b91b9fe4b7e0@gmail.com>
Date: Wed, 10 Aug 2022 18:51:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Patch V2] drm/amdgpu: Increase tlb flush timeout for sriov
Content-Language: en-US
To: Dusica Milinkovic <Dusica.Milinkovic@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220810085004.107210-1-Dusica.Milinkovic@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220810085004.107210-1-Dusica.Milinkovic@amd.com>
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



Am 10.08.22 um 10:50 schrieb Dusica Milinkovic:
> [Why]
> During multi-vf executing benchmark (Luxmark) observed kiq error timeout.
> It happenes because all of VFs do the tlb invalidation at the same time.
> Although each VF has the invalidate register set, from hardware side
> the invalidate requests are queue to execute.
>
> [How]
> In case of 12 VF increase timeout on 12*100ms
>
> Signed-off-by: Dusica Milinkovic <Dusica.Milinkovic@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 6 +++++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 6 +++++-
>   2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 9ae8cdaa033e..5743975efea5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -419,6 +419,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   	uint32_t seq;
>   	uint16_t queried_pasid;
>   	bool ret;
> +	uint32_t sriov_usec_timeout = 1200000;  /* wait for 12 * 100ms for SRIOV */

Please put that as a define into some header and never ever write 
comments at the same line after a define.



>   	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   
> @@ -437,7 +438,10 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   
>   		amdgpu_ring_commit(ring);
>   		spin_unlock(&adev->gfx.kiq.ring_lock);
> -		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
> +		if (amdgpu_sriov_vf(adev))
> +			r = amdgpu_fence_wait_polling(ring, seq, sriov_usec_timeout);
> +		else
> +			r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);

Don't duplicate the whole call, just change the parameter.

Regards,
Christian.

>   		if (r < 1) {
>   			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
>   			return -ETIME;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index ab89d91975ab..bab26982b3f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -896,6 +896,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   	uint32_t seq;
>   	uint16_t queried_pasid;
>   	bool ret;
> +	uint32_t sriov_usec_timeout = 1200000;  /* wait for 12 * 100ms for SRIOV */
>   	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   
> @@ -935,7 +936,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   
>   		amdgpu_ring_commit(ring);
>   		spin_unlock(&adev->gfx.kiq.ring_lock);
> -		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
> +		if (amdgpu_sriov_vf(adev))
> +			r = amdgpu_fence_wait_polling(ring, seq, sriov_usec_timeout);
> +		else
> +			r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
>   		if (r < 1) {
>   			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
>   			up_read(&adev->reset_domain->sem);

