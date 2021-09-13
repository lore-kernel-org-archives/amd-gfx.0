Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD07CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853DB60EFF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 853DB60EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 246036E0F5;
	Mon, 13 Sep 2021 06:52:56 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 160E76E0F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 06:52:55 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id u16so12907909wrn.5
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Sep 2021 23:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=23nPOFybBWVQUscqYZXQhg6YhYJDfdFqPmsKkRujwww=;
 b=HA7icvYD96j+SHh3w/E+z14ks2j/uQs/ReIYbvjdNC9qHh6BDHljan7TsvzrGhx5lT
 yxtqmUiEJDVGyTsCzyuxitnCPXmC4RXAiXNbnnSglP8g+Rh1EyOtNu/mc0VKTriEIMJE
 Qvk/Lh3aIsuf5Sgk9/+rVTw/CsTd4xPmT+2jB/DniglGSXHN4eY4L8td+kcjYxKmYbjA
 HrnKq5krTxSG1siGMbOJiWAZpGHu+s6GKmDxolWCuHkJB93imiuYAj8D6z1GH3BENJl2
 w7FnER0lC7gS+FE5UXBD0RtH/4pa4bQeutdXVzHSKojFZ+WcauLflXdffe0Y5KebURgK
 1Mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=23nPOFybBWVQUscqYZXQhg6YhYJDfdFqPmsKkRujwww=;
 b=KGtgzOV/mGRfKUeN37sWhXvJ9uY/LNIraxBZNDgZmiQ8Y4q6Nh2+3ThK0Kkw5hGmnn
 kEGGt502AxFk5vNIR7+aISA8BTTofeenblLDZDVjQ78B0k2afX9V7a8XBPkHUfRLyF/F
 9rIXDKgCQrGCuPRJtHi4SswjeXzxmKKFx/hcJ03AGD+c7DwMv9yDOHMV6NVG/1WQLEDw
 07Vc2xh2xVU1vSKejKRo9fr7DsLMwtZxEXM+Sbv5pryAttBUd0aD1npFM6ENHDYzEgEq
 AKqMtRNtW1Gzqk/hAZCn0hhmw2Bxwbhik0tjFbdxZXRfVp66Aa00vk6IAG+yM4TYg+VM
 U75Q==
X-Gm-Message-State: AOAM532WN1O58ZoTInYEk+j3LhyCnw0uH9pC6h09lmE6soGJtTCcG0vR
 eHNlen0Kyy683zqtPI8kn3s=
X-Google-Smtp-Source: ABdhPJwkTAO2PddVPTgNBlCDS6cXSd7F00Z18J43nXGL/D7UOHRWafhskM/Pd0jfeBHYP9jz7WPIXg==
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr10667849wrv.41.1631515973564; 
 Sun, 12 Sep 2021 23:52:53 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id u13sm6382991wrt.41.2021.09.12.23.52.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Sep 2021 23:52:53 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYzIDEvM10gZHJtL2FtZGdwdTogVVZE?=
 =?UTF-8?Q?_avoid_memory_allocation_during_IB_test?=
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210911013421.5213-1-xinhui.pan@amd.com>
 <50096f9f-5113-8303-b1e8-32faa10a0ddd@amd.com>
 <DM4PR12MB5165E4220CADA57AFBE4429587D99@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5fbd3a2d-8198-48b6-7a3d-253e2aadb2ca@gmail.com>
Date: Mon, 13 Sep 2021 08:52:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <DM4PR12MB5165E4220CADA57AFBE4429587D99@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
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

Ah, missed the local variable in amdgpu_uvd_create_msg_bo_helper(). 
Please add a comment on that.

Apart from that looks good to me.

Regards,
Christian.

Am 13.09.21 um 08:51 schrieb Pan, Xinhui:
> [AMD Official Use Only]
>
> 1) Of cource I can drop the bo resv lock as long as we fix the race of IB test. will do it in v4
>
> 2) amdgpu_uvd_create_msg_bo_helper always use a local variable *bo = NULL passed to bo_create. and assiged it to **bo_ptr on success. Of cource, I will make code easier to understand.
>
> ________________________________________
> 发件人: Koenig, Christian <Christian.Koenig@amd.com>
> 发送时间: 2021年9月13日 14:31
> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
> 抄送: Deucher, Alexander
> 主题: Re: [PATCH v3 1/3] drm/amdgpu: UVD avoid memory allocation during IB test
>
> Am 11.09.21 um 03:34 schrieb xinhui pan:
>> move BO allocation in sw_init.
>>
>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>> ---
>> change from v2:
>> use reservation trylock for direct IB test.
>> change from v1:
>> only use pre-allocated BO for direct IB submission.
>> and take its reservation lock to avoid any potential race.
>> better safe than sorry.
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 104 +++++++++++++++++-------
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |   1 +
>>    drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |   8 +-
>>    drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |   8 +-
>>    4 files changed, 79 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> index d451c359606a..a4b3dd6b38c6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> @@ -134,6 +134,51 @@ MODULE_FIRMWARE(FIRMWARE_VEGA12);
>>    MODULE_FIRMWARE(FIRMWARE_VEGA20);
>>
>>    static void amdgpu_uvd_idle_work_handler(struct work_struct *work);
>> +static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo);
>> +
>> +static int amdgpu_uvd_create_msg_bo_helper(struct amdgpu_device *adev,
>> +                                        uint32_t size,
>> +                                        struct amdgpu_bo **bo_ptr)
>> +{
>> +     struct ttm_operation_ctx ctx = { true, false };
>> +     struct amdgpu_bo *bo = NULL;
>> +     void *addr;
>> +     int r;
>> +
>> +     r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
>> +                                   AMDGPU_GEM_DOMAIN_GTT,
>> +                                   &bo, NULL, &addr);
>> +     if (r)
>> +             return r;
>> +
>> +     if (adev->uvd.address_64_bit) {
>> +             *bo_ptr = bo;
>> +             return 0;
>> +     }
>> +
>> +     amdgpu_bo_kunmap(bo);
>> +     amdgpu_bo_unpin(bo);
>> +     amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
>> +     amdgpu_uvd_force_into_uvd_segment(bo);
>> +     r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>> +     if (r)
>> +             goto err;
>> +     r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_VRAM);
>> +     if (r)
>> +             goto err_pin;
>> +     r = amdgpu_bo_kmap(bo, &addr);
>> +     if (r)
>> +             goto err_kmap;
>> +     *bo_ptr = bo;
>> +     return 0;
>> +err_kmap:
>> +     amdgpu_bo_unpin(bo);
>> +err_pin:
>> +err:
>> +     amdgpu_bo_unreserve(bo);
>> +     amdgpu_bo_unref(&bo);
>> +     return r;
>> +}
>>
>>    int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>    {
>> @@ -302,6 +347,11 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>        if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
>>                adev->uvd.address_64_bit = true;
>>
>> +     r = amdgpu_uvd_create_msg_bo_helper(adev, 128 << 10, &adev->uvd.ib_bo);
>> +     if (r)
>> +             return r;
>> +     amdgpu_bo_unreserve(adev->uvd.ib_bo);
>> +
>>        switch (adev->asic_type) {
>>        case CHIP_TONGA:
>>                adev->uvd.use_ctx_buf = adev->uvd.fw_version >= FW_1_65_10;
>> @@ -324,6 +374,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>
>>    int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>>    {
>> +     void *addr = amdgpu_bo_kptr(adev->uvd.ib_bo);
>>        int i, j;
>>
>>        drm_sched_entity_destroy(&adev->uvd.entity);
>> @@ -342,6 +393,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>>                for (i = 0; i < AMDGPU_MAX_UVD_ENC_RINGS; ++i)
>>                        amdgpu_ring_fini(&adev->uvd.inst[j].ring_enc[i]);
>>        }
>> +     amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL, &addr);
>>        release_firmware(adev->uvd.fw);
>>
>>        return 0;
>> @@ -1080,23 +1132,10 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>        unsigned offset_idx = 0;
>>        unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
>>
>> -     amdgpu_bo_kunmap(bo);
>> -     amdgpu_bo_unpin(bo);
>> -
>> -     if (!ring->adev->uvd.address_64_bit) {
>> -             struct ttm_operation_ctx ctx = { true, false };
>> -
>> -             amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
>> -             amdgpu_uvd_force_into_uvd_segment(bo);
>> -             r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>> -             if (r)
>> -                     goto err;
>> -     }
>> -
>>        r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
>>                                     AMDGPU_IB_POOL_DELAYED, &job);
>>        if (r)
>> -             goto err;
>> +             return r;
>>
>>        if (adev->asic_type >= CHIP_VEGA10) {
>>                offset_idx = 1 + ring->me;
>> @@ -1148,8 +1187,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>        }
>>
>>        amdgpu_bo_fence(bo, f, false);
>> -     amdgpu_bo_unreserve(bo);
>> -     amdgpu_bo_unref(&bo);
>>
>>        if (fence)
>>                *fence = dma_fence_get(f);
>> @@ -1159,10 +1196,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>>
>>    err_free:
>>        amdgpu_job_free(job);
>> -
>> -err:
>> -     amdgpu_bo_unreserve(bo);
>> -     amdgpu_bo_unref(&bo);
>>        return r;
>>    }
>>
>> @@ -1173,16 +1206,16 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>>                              struct dma_fence **fence)
>>    {
>>        struct amdgpu_device *adev = ring->adev;
>> -     struct amdgpu_bo *bo = NULL;
>> +     struct amdgpu_bo *bo = adev->uvd.ib_bo;
>>        uint32_t *msg;
>>        int r, i;
>>
>> -     r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
>> -                                   AMDGPU_GEM_DOMAIN_GTT,
>> -                                   &bo, NULL, (void **)&msg);
>> +     /* Direct IB submission should be exclusive. */
>> +     r = WARN_ON_ONCE(ttm_bo_reserve(&bo->tbo, true, true, NULL));
> Please just completely drop taking the reservation for direct
> submission. I don't want lockdep to complain about that.
>
>>        if (r)
>>                return r;
>>
>> +     msg = amdgpu_bo_kptr(bo);
>>        /* stitch together an UVD create msg */
>>        msg[0] = cpu_to_le32(0x00000de4);
>>        msg[1] = cpu_to_le32(0x00000000);
>> @@ -1198,23 +1231,28 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>>        for (i = 11; i < 1024; ++i)
>>                msg[i] = cpu_to_le32(0x0);
>>
>> -     return amdgpu_uvd_send_msg(ring, bo, true, fence);
>> +     r = amdgpu_uvd_send_msg(ring, bo, true, fence);
>> +
>> +     amdgpu_bo_unreserve(bo);
>> +     return r;
>>    }
>>
>>    int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>>                               bool direct, struct dma_fence **fence)
>>    {
>>        struct amdgpu_device *adev = ring->adev;
>> -     struct amdgpu_bo *bo = NULL;
>> +     struct amdgpu_bo *bo = adev->uvd.ib_bo;
> That won't work. To make the allocation work bo must be NULL when
> amdgpu_uvd_create_msg_bo_helper() is called.
>
> Probably best to add an "*bo = NULL" to amdgpu_uvd_create_msg_bo_helper().
>
> Regards,
> Christian.
>
>>        uint32_t *msg;
>>        int r, i;
>>
>> -     r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
>> -                                   AMDGPU_GEM_DOMAIN_GTT,
>> -                                   &bo, NULL, (void **)&msg);
>> +     if (direct)
>> +             r = WARN_ON_ONCE(ttm_bo_reserve(&bo->tbo, true, true, NULL));
>> +     else
>> +             r = amdgpu_uvd_create_msg_bo_helper(adev, 4096, &bo);
>>        if (r)
>>                return r;
>>
>> +     msg = amdgpu_bo_kptr(bo);
>>        /* stitch together an UVD destroy msg */
>>        msg[0] = cpu_to_le32(0x00000de4);
>>        msg[1] = cpu_to_le32(0x00000002);
>> @@ -1223,7 +1261,13 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>>        for (i = 4; i < 1024; ++i)
>>                msg[i] = cpu_to_le32(0x0);
>>
>> -     return amdgpu_uvd_send_msg(ring, bo, direct, fence);
>> +     r = amdgpu_uvd_send_msg(ring, bo, direct, fence);
>> +
>> +     amdgpu_bo_unreserve(bo);
>> +     if (!direct)
>> +             amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
>> +
>> +     return r;
>>    }
>>
>>    static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>> index edbb8194ee81..76ac9699885d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
>> @@ -68,6 +68,7 @@ struct amdgpu_uvd {
>>        /* store image width to adjust nb memory state */
>>        unsigned                decode_image_width;
>>        uint32_t                keyselect;
>> +     struct amdgpu_bo        *ib_bo;
>>    };
>>
>>    int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> index bc571833632e..dd92d96dd5a2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
>> @@ -332,12 +332,10 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
>>    static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>    {
>>        struct dma_fence *fence = NULL;
>> -     struct amdgpu_bo *bo = NULL;
>> +     struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
>>        long r;
>>
>> -     r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
>> -                                   AMDGPU_GEM_DOMAIN_VRAM,
>> -                                   &bo, NULL, NULL);
>> +     r = WARN_ON_ONCE(ttm_bo_reserve(&bo->tbo, true, true, NULL));
>>        if (r)
>>                return r;
>>
>> @@ -357,9 +355,7 @@ static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>
>>    error:
>>        dma_fence_put(fence);
>> -     amdgpu_bo_unpin(bo);
>>        amdgpu_bo_unreserve(bo);
>> -     amdgpu_bo_unref(&bo);
>>        return r;
>>    }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> index b6e82d75561f..271122cf2237 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>> @@ -338,12 +338,10 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handl
>>    static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>    {
>>        struct dma_fence *fence = NULL;
>> -     struct amdgpu_bo *bo = NULL;
>> +     struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
>>        long r;
>>
>> -     r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
>> -                                   AMDGPU_GEM_DOMAIN_VRAM,
>> -                                   &bo, NULL, NULL);
>> +     r = WARN_ON_ONCE(ttm_bo_reserve(&bo->tbo, true, true, NULL));
>>        if (r)
>>                return r;
>>
>> @@ -363,9 +361,7 @@ static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>
>>    error:
>>        dma_fence_put(fence);
>> -     amdgpu_bo_unpin(bo);
>>        amdgpu_bo_unreserve(bo);
>> -     amdgpu_bo_unref(&bo);
>>        return r;
>>    }
>>

