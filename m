Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332D4C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 07:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E01296109D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 07:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E01296109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F59689D42;
	Tue,  7 Sep 2021 07:32:47 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54FCD89D42
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 07:32:46 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id n5so12949941wro.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Sep 2021 00:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=bmfS4Crv/13HTCIIR+CneDWc5NMF4LzoLkpj9qWeynk=;
 b=YrkvKonv+b4ZwW/sNxCIaPgtX/GabeBAdVxSRP4AR4Ma2WGxwjJiUM3wur0KJ5ckAE
 OI8JlduOLGgGoYqc4up5sYeR3eTTxFl96WGkPX3SRq1UsnH6tYDyNqN8jW06k3SlDMuk
 LlbRW8sd5dyVBTS3rpkDCg86eC/Y5SrP9CqhRLp53cBQuWBkDVTJjH/Bd5TPmfXSqp6P
 zuCp1Xg5sRB46e030tZ9qqnMrLiWQefYlIXla5AkJGzuc1q5e4phjes656xdmS6IcBaz
 3sYckkkDXO6w+FIMtijUUgfxN8asLJ3aH+KBGYGZ/7HogezfQkHZRvYiqNG4A1W1X3aA
 bPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=bmfS4Crv/13HTCIIR+CneDWc5NMF4LzoLkpj9qWeynk=;
 b=Rj04lliH0z+ULx4dvQbvcyA0HVOx8G2wL17jQOHNJjTgUvONY75fd5zgsO+vXlhA5E
 VGDzgMNngD+A6zsIc584W8zwdRugbPDuiD7GeqKd4w8t/UC0CtQt5FWvMSG5XLZUpsQQ
 qqGv974vv8AkwI83J5Q3MbPVLf3p/Zm54Yecv2vQbLvwyE4obL1KxLG63E1tuzLQxdgg
 aSYpQtAAPzVdvz0Vv0wuGimK6DpgeENple1sHQPhWFmwARzjjJqvSk3Rv9HQEFd+v8nM
 bJlAaO2R1gLJATv8Coko0sRPcI+OGP/7GC28FPWZWNCcFJ7vDovLGi7kFh69jt+sEV05
 yUjQ==
X-Gm-Message-State: AOAM5311EYWyD2VSCexUhcWLw6goLc4HKLYhXps8cQMgEq3XQHV2lZY9
 rG50wq6dq6y2l50JkYbhoUW7Qefrn1qi0J9+
X-Google-Smtp-Source: ABdhPJyWXbfpXF5vXqhM08p3zTQVw8lD93f4gKvEjeBkjnV3TLKsu4kiKNfiSnk/w5qW2IMBDvlaNQ==
X-Received: by 2002:a05:6000:1287:: with SMTP id
 f7mr2586790wrx.221.1630999964822; 
 Tue, 07 Sep 2021 00:32:44 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id p9sm10290203wrg.14.2021.09.07.00.32.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Sep 2021 00:32:44 -0700 (PDT)
Subject: Re: [RFC PATCH] drm/amdgpu: alloc uvd msg from IB pool
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
References: <20210907072211.3538-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7af6a5df-eb76-5d04-8f33-42e53644975a@gmail.com>
Date: Tue, 7 Sep 2021 09:32:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907072211.3538-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 07.09.21 um 09:22 schrieb xinhui pan:
> There is one dedicated IB pool for IB test. So lets use it for uvd msg
> too.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 223 +++++++++++++-----------
>   1 file changed, 126 insertions(+), 97 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index d451c359606a..29fbe976a300 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1066,37 +1066,65 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser, uint32_t ib_idx)
>   	return 0;
>   }
>   
> -static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
> -			       bool direct, struct dma_fence **fence)
> +typedef void (*uvd_msg_cb) (struct amdgpu_ring *ring, uint32_t handle,
> +		struct amdgpu_ib *ib, uint32_t *msg, uint64_t msg_gpu_addr);

Please no typedef here, try to avoid the callback altogether if possible.

Apart from that this doesn't handle older UVD hardware correctly, we 
still allocate BOs in VRAM for that as well.

Christian.

> +
> +static void amdgpu_uvd_get_create_msg_cb(struct amdgpu_ring *ring, uint32_t handle,
> +		struct amdgpu_ib *ib, uint32_t *msg, uint64_t addr)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	struct dma_fence *f = NULL;
> -	struct amdgpu_job *job;
> -	struct amdgpu_ib *ib;
>   	uint32_t data[4];
> -	uint64_t addr;
> -	long r;
> +	unsigned int offset_idx = 0;
> +	unsigned int offset[3] = { UVD_BASE_SI, 0, 0 };
>   	int i;
> -	unsigned offset_idx = 0;
> -	unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
>   
> -	amdgpu_bo_kunmap(bo);
> -	amdgpu_bo_unpin(bo);
> +	if (adev->asic_type >= CHIP_VEGA10) {
> +		offset_idx = 1 + ring->me;
> +		offset[1] = adev->reg_offset[UVD_HWIP][0][1];
> +		offset[2] = adev->reg_offset[UVD_HWIP][1][1];
> +	}
>   
> -	if (!ring->adev->uvd.address_64_bit) {
> -		struct ttm_operation_ctx ctx = { true, false };
> +	data[0] = PACKET0(offset[offset_idx] + UVD_GPCOM_VCPU_DATA0, 0);
> +	data[1] = PACKET0(offset[offset_idx] + UVD_GPCOM_VCPU_DATA1, 0);
> +	data[2] = PACKET0(offset[offset_idx] + UVD_GPCOM_VCPU_CMD, 0);
> +	data[3] = PACKET0(offset[offset_idx] + UVD_NO_OP, 0);
>   
> -		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> -		amdgpu_uvd_force_into_uvd_segment(bo);
> -		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -		if (r)
> -			goto err;
> +	ib->ptr[0] = data[0];
> +	ib->ptr[1] = addr;
> +	ib->ptr[2] = data[1];
> +	ib->ptr[3] = addr >> 32;
> +	ib->ptr[4] = data[2];
> +	ib->ptr[5] = 0;
> +	for (i = 6; i < 16; i += 2) {
> +		ib->ptr[i] = data[3];
> +		ib->ptr[i+1] = 0;
>   	}
> +	ib->length_dw = 16;
>   
> -	r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
> -				     AMDGPU_IB_POOL_DELAYED, &job);
> -	if (r)
> -		goto err;
> +	/* stitch together an UVD create msg */
> +	msg[0] = cpu_to_le32(0x00000de4);
> +	msg[1] = cpu_to_le32(0x00000000);
> +	msg[2] = cpu_to_le32(handle);
> +	msg[3] = cpu_to_le32(0x00000000);
> +	msg[4] = cpu_to_le32(0x00000000);
> +	msg[5] = cpu_to_le32(0x00000000);
> +	msg[6] = cpu_to_le32(0x00000000);
> +	msg[7] = cpu_to_le32(0x00000780);
> +	msg[8] = cpu_to_le32(0x00000440);
> +	msg[9] = cpu_to_le32(0x00000000);
> +	msg[10] = cpu_to_le32(0x01b37000);
> +	for (i = 11; i < 1024; ++i)
> +		msg[i] = cpu_to_le32(0x0);
> +}
> +
> +static void amdgpu_uvd_get_destroy_msg_cb(struct amdgpu_ring *ring, uint32_t handle,
> +		struct amdgpu_ib *ib, uint32_t *msg, uint64_t addr)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	uint32_t data[4];
> +	unsigned int offset_idx = 0;
> +	unsigned int offset[3] = { UVD_BASE_SI, 0, 0 };
> +	int i;
>   
>   	if (adev->asic_type >= CHIP_VEGA10) {
>   		offset_idx = 1 + ring->me;
> @@ -1109,8 +1137,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	data[2] = PACKET0(offset[offset_idx] + UVD_GPCOM_VCPU_CMD, 0);
>   	data[3] = PACKET0(offset[offset_idx] + UVD_NO_OP, 0);
>   
> -	ib = &job->ibs[0];
> -	addr = amdgpu_bo_gpu_offset(bo);
>   	ib->ptr[0] = data[0];
>   	ib->ptr[1] = addr;
>   	ib->ptr[2] = data[1];
> @@ -1123,46 +1149,92 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	}
>   	ib->length_dw = 16;
>   
> -	if (direct) {
> +	/* stitch together an UVD destroy msg */
> +	msg[0] = cpu_to_le32(0x00000de4);
> +	msg[1] = cpu_to_le32(0x00000002);
> +	msg[2] = cpu_to_le32(handle);
> +	msg[3] = cpu_to_le32(0x00000000);
> +	for (i = 4; i < 1024; ++i)
> +		msg[i] = cpu_to_le32(0x0);
> +}
> +
> +static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, bool direct,
> +		uvd_msg_cb cb, uint32_t handle, uint32_t ib_size,
> +		uint32_t msg_size, struct dma_fence **fence)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct dma_fence *f = NULL;
> +	struct amdgpu_job *job;
> +	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_ib msg;
> +	int r;
> +
> +	if (!ring->adev->uvd.address_64_bit) {
> +		struct ttm_operation_ctx ctx = { true, false };
> +
> +		r = amdgpu_bo_create_reserved(adev, msg_size, PAGE_SIZE,
> +				AMDGPU_GEM_DOMAIN_VRAM,
> +				&bo, NULL, (void **)&msg.ptr);
> +		if (r)
> +			return r;
> +		amdgpu_bo_kunmap(bo);
> +		amdgpu_bo_unpin(bo);
> +		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> +		amdgpu_uvd_force_into_uvd_segment(bo);
> +		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +		if (r)
> +			goto error;
>   		r = dma_resv_wait_timeout(bo->tbo.base.resv, true, false,
> -					  msecs_to_jiffies(10));
> +				msecs_to_jiffies(10));
>   		if (r == 0)
>   			r = -ETIMEDOUT;
>   		if (r < 0)
> -			goto err_free;
> -
> -		r = amdgpu_job_submit_direct(job, ring, &f);
> -		if (r)
> -			goto err_free;
> +			goto error;
>   	} else {
> -		r = amdgpu_sync_resv(adev, &job->sync, bo->tbo.base.resv,
> -				     AMDGPU_SYNC_ALWAYS,
> -				     AMDGPU_FENCE_OWNER_UNDEFINED);
> +		memset(&msg, 0, sizeof(msg));
> +		r = amdgpu_ib_get(adev, NULL, PAGE_ALIGN(msg_size),
> +				direct ?
> +				AMDGPU_IB_POOL_DIRECT : AMDGPU_IB_POOL_DELAYED,
> +				&msg);
>   		if (r)
> -			goto err_free;
> +			goto error;
> +	}
>   
> +	r = amdgpu_job_alloc_with_ib(adev, ib_size,
> +			direct ? AMDGPU_IB_POOL_DIRECT : AMDGPU_IB_POOL_DELAYED,
> +			&job);
> +	if (r)
> +		goto error;
> +
> +	cb(ring, handle, &(job->ibs[0]), msg.ptr,
> +			bo ? amdgpu_bo_gpu_offset(bo) : msg.gpu_addr);
> +
> +	if (direct)
> +		r = amdgpu_job_submit_direct(job, ring, &f);
> +	else
>   		r = amdgpu_job_submit(job, &adev->uvd.entity,
>   				      AMDGPU_FENCE_OWNER_UNDEFINED, &f);
> -		if (r)
> -			goto err_free;
> +	if (r) {
> +		amdgpu_job_free(job);
> +		goto error;
>   	}
>   
> -	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	if (bo)
> +		amdgpu_bo_fence(bo, f, false);
> +	else
> +		amdgpu_ib_free(adev, &msg, f);
>   
>   	if (fence)
>   		*fence = dma_fence_get(f);
>   	dma_fence_put(f);
> -
> -	return 0;
> -
> -err_free:
> -	amdgpu_job_free(job);
> -
> -err:
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +error:
> +	if (bo) {
> +		amdgpu_bo_unreserve(bo);
> +		amdgpu_bo_unref(&bo);
> +	} else {
> +		if (r)
> +			amdgpu_ib_free(adev, &msg, NULL);
> +	}
>   	return r;
>   }
>   
> @@ -1172,58 +1244,15 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>   			      struct dma_fence **fence)
>   {
> -	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_bo *bo = NULL;
> -	uint32_t *msg;
> -	int r, i;
> -
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_GTT,
> -				      &bo, NULL, (void **)&msg);
> -	if (r)
> -		return r;
> -
> -	/* stitch together an UVD create msg */
> -	msg[0] = cpu_to_le32(0x00000de4);
> -	msg[1] = cpu_to_le32(0x00000000);
> -	msg[2] = cpu_to_le32(handle);
> -	msg[3] = cpu_to_le32(0x00000000);
> -	msg[4] = cpu_to_le32(0x00000000);
> -	msg[5] = cpu_to_le32(0x00000000);
> -	msg[6] = cpu_to_le32(0x00000000);
> -	msg[7] = cpu_to_le32(0x00000780);
> -	msg[8] = cpu_to_le32(0x00000440);
> -	msg[9] = cpu_to_le32(0x00000000);
> -	msg[10] = cpu_to_le32(0x01b37000);
> -	for (i = 11; i < 1024; ++i)
> -		msg[i] = cpu_to_le32(0x0);
> -
> -	return amdgpu_uvd_send_msg(ring, bo, true, fence);
> +	return amdgpu_uvd_send_msg(ring, true, amdgpu_uvd_get_create_msg_cb,
> +			handle, 64, PAGE_SIZE, fence);
>   }
>   
>   int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
> -			       bool direct, struct dma_fence **fence)
> +			      bool direct, struct dma_fence **fence)
>   {
> -	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_bo *bo = NULL;
> -	uint32_t *msg;
> -	int r, i;
> -
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_GTT,
> -				      &bo, NULL, (void **)&msg);
> -	if (r)
> -		return r;
> -
> -	/* stitch together an UVD destroy msg */
> -	msg[0] = cpu_to_le32(0x00000de4);
> -	msg[1] = cpu_to_le32(0x00000002);
> -	msg[2] = cpu_to_le32(handle);
> -	msg[3] = cpu_to_le32(0x00000000);
> -	for (i = 4; i < 1024; ++i)
> -		msg[i] = cpu_to_le32(0x0);
> -
> -	return amdgpu_uvd_send_msg(ring, bo, direct, fence);
> +	return amdgpu_uvd_send_msg(ring, direct, amdgpu_uvd_get_destroy_msg_cb,
> +			handle, 64, PAGE_SIZE, fence);
>   }
>   
>   static void amdgpu_uvd_idle_work_handler(struct work_struct *work)

