Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C69C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 06:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14EBD6105A
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 06:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14EBD6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 959386E10F;
	Wed,  8 Sep 2021 06:23:42 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A0B36E10F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 06:23:42 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id q11so1457660wrr.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Sep 2021 23:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=j6soTc3IrQgcbvv3inYN0aOGt/S29eB/F1vye/TcwfQ=;
 b=dCOhOkFkjKt25xMDKjNxmtNPPq3+YO/3DKHgai75+6KDQfqfgnPKY2dNoeagT+zqoy
 R0MQFpg96yAzsVqzo9bQSMeYyvwvVXK1Xu/u4W6KNaRoQ4oCajlmEtUOBN7YD5cr9DSl
 Iyvm8h5AeLDbNwnmCPZhUx+Bkp4ovoOEiF8O5nh7S7PFLsoNnxV4FEB4cinjEfkO5n1S
 en+RSqCGaI/d237bdLkFMgjX8x50jZdFcTq01NKQZJOtFkeEXegWLYMZqllS58ppS6dY
 F8j+UK34mj5Ob1hCsGCzY4oaDqutX/Ucbs8/bRY53/AFx+mCvVP3Om+q330bNOIW058O
 GV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=j6soTc3IrQgcbvv3inYN0aOGt/S29eB/F1vye/TcwfQ=;
 b=r40R4UU1MI74VBFyPP9dK/2ALEr21gUY9FDP07sRhY0Xjpb3F+/aBrwCbVevestbWO
 POLPo2C4mJlOmXRZ5jovzOoD1X/CV71si57bWC9zKkCMV1XEOwUOD/VsNCXojMAjSSTn
 vtxTkmoMxyK06X6QtrvpBS/Xu1FwdhKN617EfS+w/rQkpAtfCTYysaP6FjtIsu5qcYCG
 Uo61jEqOyox1NZics2rQDca1NfrzWyakkLTUYQHAvvYR/wluSJGp8GVHSy1H0gH74zY9
 IrSjjArj007FvGdKLtvNvSJBHTSTbwxOkjYRZ9+LEG2WvQMe8QKLLocmV/GCPoEtfSK7
 YrIA==
X-Gm-Message-State: AOAM531SCKIy0REsBTwX4RY6xIuvdpb2Ia2dWP8i42Jkanh3eLj2HHlK
 XHa2t/91VZx8Bt7YVQ/gKs4=
X-Google-Smtp-Source: ABdhPJxmjKHw1w4FB7gzOpU7T4FR9gFiRlJLOAPHl4RFrqqsE9Fo5Obc3OrMxB/09nfBOwshNr0EYQ==
X-Received: by 2002:a5d:4285:: with SMTP id k5mr2073797wrq.131.1631082220631; 
 Tue, 07 Sep 2021 23:23:40 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:58f0:1f28:e3d8:5e7b?
 ([2a02:908:1252:fb60:58f0:1f28:e3d8:5e7b])
 by smtp.gmail.com with ESMTPSA id j14sm29333wrp.21.2021.09.07.23.23.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Sep 2021 23:23:40 -0700 (PDT)
Subject: Re: [RFC PATCH v3] drm/amdgpu: alloc uvd msg from IB pool
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210907122617.5303-1-xinhui.pan@amd.com>
 <da7895bf-f2d9-e35c-3f93-e4e48f364511@amd.com>
 <923A021C-0559-4EC7-88F2-7ABF2BA6A66E@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c3f0e3a8-8433-bef9-e613-c4f53e857fff@gmail.com>
Date: Wed, 8 Sep 2021 08:23:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <923A021C-0559-4EC7-88F2-7ABF2BA6A66E@amd.com>
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

Am 08.09.21 um 03:25 schrieb Pan, Xinhui:
>> 2021年9月7日 20:37，Koenig, Christian <Christian.Koenig@amd.com> 写道：
>>
>> Am 07.09.21 um 14:26 schrieb xinhui pan:
>>> There is one dedicated IB pool for IB test. So lets use it for uvd msg
>>> too.
>>>
>>> For some older HW, use one reserved BO at specific range.
>>>
>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 173 +++++++++++++++---------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |   2 +
>>>   2 files changed, 112 insertions(+), 63 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> index d451c359606a..b741ab7b2468 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> @@ -299,8 +299,35 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>>   	}
>>>     	/* from uvd v5.0 HW addressing capacity increased to 64 bits */
>>> -	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
>>> +	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0)) {
>>>   		adev->uvd.address_64_bit = true;
>>> +	} else {
>>> +		struct amdgpu_bo *bo = NULL;
>>> +
>>> +		r = amdgpu_bo_create_reserved(adev, PAGE_SIZE, PAGE_SIZE,
>>> +				AMDGPU_GEM_DOMAIN_VRAM,
>>> +				&bo, NULL, &adev->uvd.ib_bo_cpu_addr);
>>> +		if (r)
>>> +			return r;
>>> +		amdgpu_bo_kunmap(bo);
>>> +		amdgpu_bo_unpin(bo);
>>> +		r = amdgpu_bo_pin_restricted(bo, AMDGPU_GEM_DOMAIN_VRAM,
>>> +				0, 256 << 20);
>>> +		if (r) {
>>> +			amdgpu_bo_unreserve(bo);
>>> +			amdgpu_bo_unref(&bo);
>>> +			return r;
>>> +		}
>>> +		r = amdgpu_bo_kmap(bo, &adev->uvd.ib_bo_cpu_addr);
>>> +		if (r) {
>>> +			amdgpu_bo_unpin(bo);
>>> +			amdgpu_bo_unreserve(bo);
>>> +			amdgpu_bo_unref(&bo);
>>> +			return r;
>>> +		}
>>> +		adev->uvd.ib_bo = bo;
>>> +		amdgpu_bo_unreserve(bo);
>> Can we have the same handling for both cases please? E.g. always allocate a single BO in SW init and place it appropriately.
> One single BO is not good. validating BO into GTT or VRAM still cause memory allocation.
> I will have a try to use two BOs.

Well you should pin the buffer during allocation while loading the 
driver. After that we should not see any migration at all.

> More aggressively,  I will let vc/vcn/uvd IB test share the same two BOs.

VCE/UVD and VCN are mutual exclusive, you either have one or the other 
in the hardware.

So you can just have one BO for each and only whatever is present in the 
hardware is actually allocated.

>> And I think we need some kind of lock to prevent concurrent use of the BO.
> It takes reservation lock.

That is a really bad idea. The reservation lock can (in theory) depend 
on the reset as well, so you end up in a circle dependency and potential 
deadlock again.

Thanks a lot that you take a look into this, it's on my TODO list for 
years to fix that up.

Christian.

>
>> Christian.
>>
>>> +	}
>>>     	switch (adev->asic_type) {
>>>   	case CHIP_TONGA:
>>> @@ -342,6 +369,8 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>>>   		for (i = 0; i < AMDGPU_MAX_UVD_ENC_RINGS; ++i)
>>>   			amdgpu_ring_fini(&adev->uvd.inst[j].ring_enc[i]);
>>>   	}
>>> +	amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL,
>>> +			(void **)&adev->uvd.ib_bo_cpu_addr);
>>>   	release_firmware(adev->uvd.fw);
>>>     	return 0;
>>> @@ -1066,7 +1095,7 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser, uint32_t ib_idx)
>>>   	return 0;
>>>   }
>>>   -static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>> +static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, uint64_t addr,
>>>   			       bool direct, struct dma_fence **fence)
>>>   {
>>>   	struct amdgpu_device *adev = ring->adev;
>>> @@ -1074,29 +1103,15 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>>   	struct amdgpu_job *job;
>>>   	struct amdgpu_ib *ib;
>>>   	uint32_t data[4];
>>> -	uint64_t addr;
>>>   	long r;
>>>   	int i;
>>>   	unsigned offset_idx = 0;
>>>   	unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
>>>   -	amdgpu_bo_kunmap(bo);
>>> -	amdgpu_bo_unpin(bo);
>>> -
>>> -	if (!ring->adev->uvd.address_64_bit) {
>>> -		struct ttm_operation_ctx ctx = { true, false };
>>> -
>>> -		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
>>> -		amdgpu_uvd_force_into_uvd_segment(bo);
>>> -		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>> -		if (r)
>>> -			goto err;
>>> -	}
>>> -
>>>   	r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
>>>   				     AMDGPU_IB_POOL_DELAYED, &job);
>>>   	if (r)
>>> -		goto err;
>>> +		return r;
>>>     	if (adev->asic_type >= CHIP_VEGA10) {
>>>   		offset_idx = 1 + ring->me;
>>> @@ -1110,7 +1125,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>>   	data[3] = PACKET0(offset[offset_idx] + UVD_NO_OP, 0);
>>>     	ib = &job->ibs[0];
>>> -	addr = amdgpu_bo_gpu_offset(bo);
>>>   	ib->ptr[0] = data[0];
>>>   	ib->ptr[1] = addr;
>>>   	ib->ptr[2] = data[1];
>>> @@ -1123,33 +1137,13 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>>   	}
>>>   	ib->length_dw = 16;
>>>   -	if (direct) {
>>> -		r = dma_resv_wait_timeout(bo->tbo.base.resv, true, false,
>>> -					  msecs_to_jiffies(10));
>>> -		if (r == 0)
>>> -			r = -ETIMEDOUT;
>>> -		if (r < 0)
>>> -			goto err_free;
>>> -
>>> +	if (direct)
>>>   		r = amdgpu_job_submit_direct(job, ring, &f);
>>> -		if (r)
>>> -			goto err_free;
>>> -	} else {
>>> -		r = amdgpu_sync_resv(adev, &job->sync, bo->tbo.base.resv,
>>> -				     AMDGPU_SYNC_ALWAYS,
>>> -				     AMDGPU_FENCE_OWNER_UNDEFINED);
>>> -		if (r)
>>> -			goto err_free;
>>> -
>>> +	else
>>>   		r = amdgpu_job_submit(job, &adev->uvd.entity,
>>> -				      AMDGPU_FENCE_OWNER_UNDEFINED, &f);
>>> -		if (r)
>>> -			goto err_free;
>>> -	}
>>> -
>>> -	amdgpu_bo_fence(bo, f, false);
>>> -	amdgpu_bo_unreserve(bo);
>>> -	amdgpu_bo_unref(&bo);
>>> +				AMDGPU_FENCE_OWNER_UNDEFINED, &f);
>>> +	if (r)
>>> +		goto err_free;
>>>     	if (fence)
>>>   		*fence = dma_fence_get(f);
>>> @@ -1159,10 +1153,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>>     err_free:
>>>   	amdgpu_job_free(job);
>>> -
>>> -err:
>>> -	amdgpu_bo_unreserve(bo);
>>> -	amdgpu_bo_unref(&bo);
>>>   	return r;
>>>   }
>>>   @@ -1173,16 +1163,31 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>>>   			      struct dma_fence **fence)
>>>   {
>>>   	struct amdgpu_device *adev = ring->adev;
>>> -	struct amdgpu_bo *bo = NULL;
>>> +	struct amdgpu_bo *bo = adev->uvd.ib_bo;
>>> +	struct dma_fence *f = NULL;
>>> +	struct amdgpu_ib ib;
>>>   	uint32_t *msg;
>>>   	int r, i;
>>>   -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
>>> -				      AMDGPU_GEM_DOMAIN_GTT,
>>> -				      &bo, NULL, (void **)&msg);
>>> -	if (r)
>>> -		return r;
>>> -
>>> +	if (bo) {
>>> +		r = amdgpu_bo_reserve(bo, true);
>>> +		if (r)
>>> +			return r;
>>> +		r = dma_resv_wait_timeout(bo->tbo.base.resv, true, false,
>>> +				msecs_to_jiffies(10));
>>> +		if (r == 0)
>>> +			r = -ETIMEDOUT;
>>> +		if (r < 0)
>>> +			goto err;
>>> +		ib.gpu_addr = amdgpu_bo_gpu_offset(bo);
>>> +		msg = adev->uvd.ib_bo_cpu_addr;
>>> +	} else {
>>> +		memset(&msg, 0, sizeof(msg));
>>> +		r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
>>> +				AMDGPU_IB_POOL_DIRECT,
>>> +				&ib);
>>> +		msg = ib.ptr;
>>> +	}
>>>   	/* stitch together an UVD create msg */
>>>   	msg[0] = cpu_to_le32(0x00000de4);
>>>   	msg[1] = cpu_to_le32(0x00000000);
>>> @@ -1198,23 +1203,52 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>>>   	for (i = 11; i < 1024; ++i)
>>>   		msg[i] = cpu_to_le32(0x0);
>>>   -	return amdgpu_uvd_send_msg(ring, bo, true, fence);
>>> +	r = amdgpu_uvd_send_msg(ring, ib.gpu_addr, true, &f);
>>> +	if (r)
>>> +		goto err;
>>> +	if (bo)
>>> +		amdgpu_bo_fence(bo, f, false);
>>> +	else
>>> +		amdgpu_ib_free(adev, &ib, f);
>>> +	if (fence)
>>> +		*fence = dma_fence_get(f);
>>> +	dma_fence_put(f);
>>> +err:
>>> +	if (bo)
>>> +		amdgpu_bo_unreserve(bo);
>>> +	return r;
>>>   }
>>>     int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>>>   			       bool direct, struct dma_fence **fence)
>>>   {
>>>   	struct amdgpu_device *adev = ring->adev;
>>> -	struct amdgpu_bo *bo = NULL;
>>> +	struct amdgpu_bo *bo = adev->uvd.ib_bo;
>>> +	struct dma_fence *f = NULL;
>>> +	struct amdgpu_ib ib;
>>>   	uint32_t *msg;
>>>   	int r, i;
>>>   -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
>>> -				      AMDGPU_GEM_DOMAIN_GTT,
>>> -				      &bo, NULL, (void **)&msg);
>>> -	if (r)
>>> -		return r;
>>> -
>>> +	if (bo) {
>>> +		r = amdgpu_bo_reserve(bo, true);
>>> +		if (r)
>>> +			return r;
>>> +		r = dma_resv_wait_timeout(bo->tbo.base.resv, true, false,
>>> +				msecs_to_jiffies(10));
>>> +		if (r == 0)
>>> +			r = -ETIMEDOUT;
>>> +		if (r < 0)
>>> +			goto err;
>>> +		ib.gpu_addr = amdgpu_bo_gpu_offset(bo);
>>> +		msg = adev->uvd.ib_bo_cpu_addr;
>>> +	} else {
>>> +		memset(&msg, 0, sizeof(msg));
>>> +		r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
>>> +				direct ?
>>> +				AMDGPU_IB_POOL_DIRECT : AMDGPU_IB_POOL_DELAYED,
>>> +				&ib);
>>> +		msg = ib.ptr;
>>> +	}
>>>   	/* stitch together an UVD destroy msg */
>>>   	msg[0] = cpu_to_le32(0x00000de4);
>>>   	msg[1] = cpu_to_le32(0x00000002);
>>> @@ -1223,7 +1257,20 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>>>   	for (i = 4; i < 1024; ++i)
>>>   		msg[i] = cpu_to_le32(0x0);
>>>   -	return amdgpu_uvd_send_msg(ring, bo, direct, fence);
>>> +	r = amdgpu_uvd_send_msg(ring, ib.gpu_addr, true, &f);
>>> +	if (r)
>>> +		goto err;
>>> +	if (bo)
>>> +		amdgpu_bo_fence(bo, f, false);
>>> +	else
>>> +		amdgpu_ib_free(adev, &ib, f);
>>> +	if (fence)
>>> +		*fence = dma_fence_get(f);
>>> +	dma_fence_put(f);
>>> +err:
>>> +	if (bo)
>>> +		amdgpu_bo_unreserve(bo);
>>> +	return r;
>>>   }
>>>     static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>>> index edbb8194ee81..3ff49daf558c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>>> @@ -68,6 +68,8 @@ struct amdgpu_uvd {
>>>   	/* store image width to adjust nb memory state */
>>>   	unsigned		decode_image_width;
>>>   	uint32_t                keyselect;
>>> +	struct amdgpu_bo	*ib_bo;
>>> +	void			*ib_bo_cpu_addr;
>>>   };
>>>     int amdgpu_uvd_sw_init(struct amdgpu_device *adev);

