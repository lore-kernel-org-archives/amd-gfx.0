Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8801C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 15:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FBFF6113D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 15:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FBFF6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 197886EB37;
	Tue, 19 Oct 2021 15:54:33 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A5996EB37
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 15:54:31 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 n40-20020a05600c3ba800b0030da2439b21so3566571wms.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=YQ6cnDmasmTHJhPpC/NlH+gmjY9gt/qM6QGDz1K/rlo=;
 b=Yyu/GP+81Tiag4fVW+wghITZ8EShE01JOPqsOR6MNLoJ71PBVY5duKhEeYJR3mK6aD
 eo7y5phxkZCmpDAbMd83vy0ako/3LS/rhMeyC5Q25izYq0HoQX5S4qsBPB1pHofkaoHY
 OKhAyMGQTi2hPIopLm3ADcoqmvdHBNN756vdrsyzDsJcI1ilwUD3HI+m78sI/8xsB6BG
 Bqc8F18BmvfTOMIxXff6BcsnFBt5zU1KU4FXSJeGDKbqyEUPUBNC88knsngEc5vWc2DO
 S9usBNNZdp0ap6BhjYdBIm0FFgMDkPZHDZFW4w78v3a93VYEJUxXgT2tDrukWVqNGfjh
 5D2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=YQ6cnDmasmTHJhPpC/NlH+gmjY9gt/qM6QGDz1K/rlo=;
 b=qhHkz9WtBocBS7lBs7aOJBqgnDLYh4vlQiSBSyzu1FYn+HS67IRh+4TeY4RJPpuKb/
 LVQbXk1/EhM/rbXdfD+phQLtUopI3lCh8S1ADs4/8ggnc6n4PgBMO5b29m5nrQSRRxGH
 8ktmasl+IfkKfzS8pL/QIke04bOAbpBPvn58WsgCVo+/yTT7BQOJaIeTRLDgFeYevBHD
 bw/HwigzKMQg5YYcGAJfYWhszTwy5OQVQvF8ukBRZUv3ODQEf9wrTld+CCF3abavNL/0
 eF57D92jiOg5s6zcF5jQlrQaaRbWAH9lLh7tuIZJHpHjQdiO0EKe+DtZF317Lin0SF+C
 bbbA==
X-Gm-Message-State: AOAM530NuLg8SnTv+6qild/QD4KVzQyufRY8ZC5RftoFNmsQ0G3Y0iQ9
 +f5jULNiU8LnvO3Z9TrgOkw=
X-Google-Smtp-Source: ABdhPJyY19fLzTQtu+SbsYRhSbRcfczY4qdMQr6uTuAatVOoNiRVOyOZzsSttq5cOXd/6AymQVz6zQ==
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr45178536wrr.409.1634658870231; 
 Tue, 19 Oct 2021 08:54:30 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:4fc4:fae2:bc41:a808?
 ([2a02:908:1252:fb60:4fc4:fae2:bc41:a808])
 by smtp.gmail.com with ESMTPSA id w5sm15344060wra.87.2021.10.19.08.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Oct 2021 08:54:29 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: recover gart table at resume
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org,
 "Christian.Koenig@amd.com" <Christian.Koenig@amd.com>
References: <20211019132200.10352-1-nirmoy.das@amd.com>
 <28201f2b-e524-4192-bafc-29c5871fbb16@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0865a77f-7a84-61c1-4375-f9b180616311@gmail.com>
Date: Tue, 19 Oct 2021 17:54:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <28201f2b-e524-4192-bafc-29c5871fbb16@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.10.21 um 17:41 schrieb Andrey Grodzovsky:
>
> On 2021-10-19 9:22 a.m., Nirmoy Das wrote:
>> Get rid off pin/unpin and evict and swap back gart
>> page table which should make things less likely to break.
>
> +Christian
>
> Could you guys also clarify what exactly are the stability issues this 
> fixes ?

When we evict the GART table during suspend it is theoretically possible 
that we run into an OOM situation.

But since the OOM killer and the buffer move functions are already 
disable that is basically not gracefully handle able.

When we just keep the GART pinned all the time and restore it's content 
during resume from the metadata we should be able to avoid any memory 
allocation for the move.

Christian.

>
> Andrey
>
>
>>
>> Also remove 2nd call to amdgpu_device_evict_resources()
>> as we don't need it.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 -----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 16 ++++++++++++----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 17 +++++++++++++----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 16 ++++++++++++----
>>   4 files changed, 37 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 41ce86244144..22ff229ab981 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3941,11 +3941,6 @@ int amdgpu_device_suspend(struct drm_device 
>> *dev, bool fbcon)
>>       amdgpu_fence_driver_hw_fini(adev);
>>         amdgpu_device_ip_suspend_phase2(adev);
>> -    /* This second call to evict device resources is to evict
>> -     * the gart page table using the CPU.
>> -     */
>> -    amdgpu_device_evict_resources(adev);
>> -
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index 3ec5ff5a6dbe..18e3f3c5aae6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -992,9 +992,16 @@ static int gmc_v10_0_gart_enable(struct 
>> amdgpu_device *adev)
>>           return -EINVAL;
>>       }
>>   -    r = amdgpu_gart_table_vram_pin(adev);
>> -    if (r)
>> -        return r;
>> +    if (!adev->in_suspend) {
>> +        r = amdgpu_gart_table_vram_pin(adev);
>> +        if (r)
>> +            return r;
>> +    } else {
>> +        r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
>> +                                TTM_PL_TT));
>> +        if (r)
>> +            return r;
>> +    }
>>         r = adev->gfxhub.funcs->gart_enable(adev);
>>       if (r)
>> @@ -1062,7 +1069,8 @@ static void gmc_v10_0_gart_disable(struct 
>> amdgpu_device *adev)
>>   {
>>       adev->gfxhub.funcs->gart_disable(adev);
>>       adev->mmhub.funcs->gart_disable(adev);
>> -    amdgpu_gart_table_vram_unpin(adev);
>> +    if (!adev->in_suspend)
>> +        amdgpu_gart_table_vram_unpin(adev);
>>   }
>>     static int gmc_v10_0_hw_fini(void *handle)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> index 492ebed2915b..0ef50ad3d7d5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> @@ -837,9 +837,17 @@ static int gmc_v8_0_gart_enable(struct 
>> amdgpu_device *adev)
>>           dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>           return -EINVAL;
>>       }
>> -    r = amdgpu_gart_table_vram_pin(adev);
>> -    if (r)
>> -        return r;
>> +
>> +    if (!adev->in_suspend) {
>> +        r = amdgpu_gart_table_vram_pin(adev);
>> +        if (r)
>> +            return r;
>> +    } else {
>> +        r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
>> +                                TTM_PL_TT));
>> +        if (r)
>> +            return r;
>> +    }
>>         table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>   @@ -992,7 +1000,8 @@ static void gmc_v8_0_gart_disable(struct 
>> amdgpu_device *adev)
>>       tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>>       WREG32(mmVM_L2_CNTL, tmp);
>>       WREG32(mmVM_L2_CNTL2, 0);
>> -    amdgpu_gart_table_vram_unpin(adev);
>> +    if (!adev->in_suspend)
>> +        amdgpu_gart_table_vram_unpin(adev);
>>   }
>>     /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index cb82404df534..1bbcefd53974 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1714,9 +1714,16 @@ static int gmc_v9_0_gart_enable(struct 
>> amdgpu_device *adev)
>>           return -EINVAL;
>>       }
>>   -    r = amdgpu_gart_table_vram_pin(adev);
>> -    if (r)
>> -        return r;
>> +    if (!adev->in_suspend) {
>> +        r = amdgpu_gart_table_vram_pin(adev);
>> +        if (r)
>> +            return r;
>> +    } else {
>> +        r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
>> +                                TTM_PL_TT));
>> +        if (r)
>> +            return r;
>> +    }
>>         r = adev->gfxhub.funcs->gart_enable(adev);
>>       if (r)
>> @@ -1793,7 +1800,8 @@ static void gmc_v9_0_gart_disable(struct 
>> amdgpu_device *adev)
>>   {
>>       adev->gfxhub.funcs->gart_disable(adev);
>>       adev->mmhub.funcs->gart_disable(adev);
>> -    amdgpu_gart_table_vram_unpin(adev);
>> +    if (!adev->in_suspend)
>> +        amdgpu_gart_table_vram_unpin(adev);
>>   }
>>     static int gmc_v9_0_hw_fini(void *handle)

