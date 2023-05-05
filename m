Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC5FC77B75
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 08:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F8310E598;
	Fri,  5 May 2023 08:11:02 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CA7810E598
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 08:11:00 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-956ff2399c9so255554366b.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 May 2023 01:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683274259; x=1685866259;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gnxp5iBU/3iR+6ORSZ9KVphOqADi4ujwfzj0fyUI8gY=;
 b=U9fvUxO/me2fcxAE4IYqVQlgZNIYfIcXtJ26wq6MG514VlKj5GoG8ntC1ccLjkVGaR
 aUb82gB84+WT/pdKR2t5eflugmcf4yK0eosVafRvJLSzd/VPE7szSpHfTdFJOorqwqI+
 DKSiqf+xz57/wLrnONPgl06liFkg0DTrdTVJM6YiSF7s97IDL+xpBwNfyDjecO21cQWo
 fmXsBzywXAbr04a0z2jnD1fltWC+poKPld8/+KEuafOr9iKY+XMwtRj7ZD/PBrRqzWLo
 IA8MppipILjGgXSUkhcHvNUTyUHGdmTBmpi++gGBkGH3J43tHGMITvNJddVDceohUM/S
 FCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683274259; x=1685866259;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gnxp5iBU/3iR+6ORSZ9KVphOqADi4ujwfzj0fyUI8gY=;
 b=G9l2k/WbIlMzsj32eNOtG5CmjYkA4ZoT7667lkBZk8rkqxb/SmecHY/vMXSZEbf6Zc
 /YHrAQHEuU2EWE++jddI0IPyzCl1UmXxgxkdO9a9rD8Kdy6AOE/v2trRNEBuDhfMv4Va
 JWXMN9Ze06B+qI70GkUUK2S37BqaZDZvR2VPg0M2h1x1r+tfF7ED5e74dlURotby8yWq
 mVEnHn6wo9N6WQ7o+2GrjtqPUYC2q5lHla9NnA/EZ8MzBwtvwHzqrHYIi4rwMeACxvoZ
 Jc0OfM1Nfth+116AaEVgCcQHs5lPdjHgxpEBIPNNEmOd5fHqA4vG3OTaGRTjohdbsrbY
 X4AA==
X-Gm-Message-State: AC+VfDw77Gv9nYxd3br2Xoos0v+MwQ9AWR8sj3XQ5TGmiSaphVNt+f4K
 uTT7yqxSvoUSZS6eI4MsacM=
X-Google-Smtp-Source: ACHHUZ7VZBZAqud53Ltb/jHhtpg20cFvYPYhPVhaM/Nm7QEfvA+W587pWzM48thei6cBdm2mMfqABQ==
X-Received: by 2002:a17:907:2ce3:b0:94f:2d38:896b with SMTP id
 hz3-20020a1709072ce300b0094f2d38896bmr412935ejc.53.1683274258579; 
 Fri, 05 May 2023 01:10:58 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:e2f8:820b:7a40:97ca?
 ([2a02:908:1256:79a0:e2f8:820b:7a40:97ca])
 by smtp.gmail.com with ESMTPSA id
 og6-20020a1709071dc600b00965e839f56bsm303745ejc.182.2023.05.05.01.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 May 2023 01:10:57 -0700 (PDT)
Message-ID: <8f895857-9597-6cdf-5c4a-2fb4abd252c3@gmail.com>
Date: Fri, 5 May 2023 10:10:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] drm/amdgpu: adjust vmhub flush tlb iteration to fit
 the new GFXHUB/MMHUB layout
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230504155023.1415369-1-yifan1.zhang@amd.com>
 <20230504155023.1415369-2-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230504155023.1415369-2-yifan1.zhang@amd.com>
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
Cc: Alexander.Deucher@amd.com, le.ma@amd.com, christian.koenig@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 04.05.23 um 17:50 schrieb Yifan Zhang:
> tlb flush has to be changed for the new mmhub layout
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 16 ++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   | 10 +++++++---
>   2 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index 01cb89ffbd56..2383db399c95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -160,6 +160,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>   	/* Starting from VEGA10, system bit must be 0 to mean invalid. */
>   	uint64_t flags = 0;
>   	int idx;
> +	struct amdgpu_vmhub *hub;

Please always define variables as local as possible. E.g. in this case 
not in the function but rather in the loop.

Apart from that it's good practice to keep defines like i, r, idx etc.. 
last. Some upstream maintainer even enforce reverse xmas tree ordering.

Regards,
Christian.


>   
>   	if (!adev->gart.ptr)
>   		return;
> @@ -182,8 +183,11 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>   	}
>   	mb();
>   	amdgpu_device_flush_hdp(adev, NULL);
> -	for (i = 0; i < adev->num_vmhubs; i++)
> -		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
> +	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
> +		hub = &adev->vmhub[i];
> +		if (hub->vmhub_funcs)
> +			amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
> +	}
>   
>   	drm_dev_exit(idx);
>   }
> @@ -258,14 +262,18 @@ void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>   void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
>   {
>   	int i;
> +	struct amdgpu_vmhub *hub;
>   
>   	if (!adev->gart.ptr)
>   		return;
>   
>   	mb();
>   	amdgpu_device_flush_hdp(adev, NULL);
> -	for (i = 0; i < adev->num_vmhubs; i++)
> -		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
> +	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
> +		hub = &adev->vmhub[i];
> +		if (hub->vmhub_funcs)
> +			amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
> +	}
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 90cf79f8ddde..3ee7f5e067fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -331,6 +331,7 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   	bool ret;
>   	struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> +	struct amdgpu_vmhub *hub;
>   
>   	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
>   		spin_lock(&adev->gfx.kiq[0].ring_lock);
> @@ -362,9 +363,12 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   				&queried_pasid);
>   		if (ret	&& queried_pasid == pasid) {
>   			if (all_hub) {
> -				for (i = 0; i < adev->num_vmhubs; i++)
> -					gmc_v11_0_flush_gpu_tlb(adev, vmid,
> -							i, flush_type);
> +				for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
> +					hub = &adev->vmhub[i];
> +					if (hub->vmhub_funcs)
> +						gmc_v11_0_flush_gpu_tlb(adev, vmid,
> +								i, flush_type);
> +				}
>   			} else {
>   				gmc_v11_0_flush_gpu_tlb(adev, vmid,
>   						AMDGPU_GFXHUB(0), flush_type);

