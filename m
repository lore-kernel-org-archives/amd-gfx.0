Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23714C35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 15:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC28D10E530;
	Wed, 19 Mar 2025 15:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jegeeiMp";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F70E10E530
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 15:27:55 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3996af42857so617193f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 08:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742398074; x=1743002874; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YsGShsxAJ38pcyKpIa4pQjrsufR5W8WPDoFH+AcXJbU=;
 b=jegeeiMpz4dUcQRNVKKN0jnvYUiwame2DdRY9vmPIC+oKKppj53FSiKxue0X8nfTwj
 gZC0QTWEhOSaaRzTqMannF8gFS8XR9cytQm+l0Oi2iNEDXUsMmq+2veyogKL40clEigV
 lu6+5lZDGyCpRU8G4RIjXOrFfmK7oPJy9cGORJIFJMLe1Vjgb+61Sc9kV22EivaKsrfX
 ac+/9uuDEX45zFWnqHaOhs8i0adUywiCBl/oCwOu42aUh5ERZUYbzxudo2OQ/4roiwlQ
 Yb5vpRfIMqdwzI2krYwz2pUDPCjAqV5zpGCi/hzEVULoK1NojE0sdqu/8ofCfm399+eU
 kkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742398074; x=1743002874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YsGShsxAJ38pcyKpIa4pQjrsufR5W8WPDoFH+AcXJbU=;
 b=ObgDe7X+3TkHHfYQj/DSLf1+g1+x3wza8Tv5HfBDF+J8zC4fRfOH3/3W38G9RJm5vS
 JlwapkJrr2fLWL34zGXAdG23KQXyOxG0gO3v+vEsyHAIdb+7lVPt3sogkagSbs0AKTG9
 Gh5mJsndaToSxo4S/p3AW1yMzIOeMcIPjuKh1BKUV02Ul2ttp2QommnhgHeEKJ1/rhYh
 z8Mx0jERUloQywFoYfuRNoEbXJ5BVWY4dpuYd/Y7ZYqRI2wn3hpBbg1GrZx4yONQmawQ
 sZmPjOxXX++ff2yWbmViOgu9165Bu1A/IXj8QmguwbmoKg98rD1HMgohAHNupNIAMDar
 n3FA==
X-Gm-Message-State: AOJu0Ywix6sjzT0GFGpB0KfOXE0cNH+Aju5cz72giLzsqlOIH+aofvZw
 XExbV/P3XGSVJIDCREMsvufVo4CvKsRtPYRtYSgThRfOsmQ+Il7Y
X-Gm-Gg: ASbGncvmsxW30F9LylQ3I8n3V9QEQuANKxbTkyxBUKp6NKhWnSi1cnIDCR1IHJCVWbA
 RBBuNWaiVV4Y7qZtlKZ8xqjx1oDU6/LHMomVcO3shjoNkjKkCbSgKF9Y2/SkFlVnj7kEJCzi6DO
 RmQkum3vOw4yuhY7YJSww2GJV6VJYdSeu94dk9CmHswF8F6HG19cSPg+csBBN1aod7RwtLYtjGL
 Hxbve85F5NIIapSgXt8yLGbkuHbA8vF2qSY1wVKlkP1G6jYdgij1kYJ1KCEfu4hFdnmD0eS9nSV
 0iSn9zPP9kENPPCR/ojqeOqk+T5ofqBN55uSNSoQwEivGYEcIE53b/Yh0mBZg7hghl13hRLH7w=
 =
X-Google-Smtp-Source: AGHT+IETTNHEAyMRR1oT7HMZOb17xQQH0SsHvJ68bVaqQUpFkuI621nUfLbuRBqwbWwMBsCAkg4tYA==
X-Received: by 2002:a5d:648b:0:b0:391:865:5a93 with SMTP id
 ffacd0b85a97d-39973c6d44fmr2750184f8f.22.1742398072841; 
 Wed, 19 Mar 2025 08:27:52 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df344dsm21910948f8f.10.2025.03.19.08.27.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 08:27:52 -0700 (PDT)
Message-ID: <22ddb205-2e38-4b9f-9272-61a76f9e56ee@gmail.com>
Date: Wed, 19 Mar 2025 16:27:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: remove is_mes_queue flag
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250312175657.187396-1-alexander.deucher@amd.com>
 <CADnq5_Oj4s9QWjgGJBFkfwRsjKt=erAYrBBvK5pxEQXZCVenvA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_Oj4s9QWjgGJBFkfwRsjKt=erAYrBBvK5pxEQXZCVenvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Sorry missed that one, Acked-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

Am 18.03.25 um 14:15 schrieb Alex Deucher:
> Ping?
>
> On Wed, Mar 12, 2025 at 1:57 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>> This was leftover from MES bring up when we had MES
>> user queues in the kernel.  It's no longer used so
>> remove it.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   |   4 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 112 ++++++---------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  14 --
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  22 +--
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |   2 +-
>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  84 +++---------
>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 143 ++++---------------
>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  67 ++-------
>>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |   4 -
>>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   |   4 -
>>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   |   4 -
>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 166 +++++++----------------
>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  83 ++++--------
>>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  83 ++++--------
>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 164 +++++++---------------
>>  15 files changed, 259 insertions(+), 697 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> index eac96a3d8c6c3..6efa0c5717dcf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> @@ -163,12 +163,12 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>                 init_shadow = false;
>>         }
>>
>> -       if (!ring->sched.ready && !ring->is_mes_queue) {
>> +       if (!ring->sched.ready) {
>>                 dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n", ring->name);
>>                 return -EINVAL;
>>         }
>>
>> -       if (vm && !job->vmid && !ring->is_mes_queue) {
>> +       if (vm && !job->vmid) {
>>                 dev_err(adev->dev, "VM IB without ID\n");
>>                 return -EINVAL;
>>         }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index d55c8b7fdb596..ba8f2785865af 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -187,14 +187,10 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
>>  }
>>
>>  #define amdgpu_ring_get_gpu_addr(ring, offset)                         \
>> -       (ring->is_mes_queue ?                                           \
>> -        (ring->mes_ctx->meta_data_gpu_addr + offset) :                 \
>> -        (ring->adev->wb.gpu_addr + offset * 4))
>> +        (ring->adev->wb.gpu_addr + offset * 4)
>>
>>  #define amdgpu_ring_get_cpu_addr(ring, offset)                         \
>> -       (ring->is_mes_queue ?                                           \
>> -        (void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset) : \
>> -        (&ring->adev->wb.wb[offset]))
>> +        (&ring->adev->wb.wb[offset])
>>
>>  /**
>>   * amdgpu_ring_init - init driver ring struct.
>> @@ -243,57 +239,42 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>>                 ring->sched_score = sched_score;
>>                 ring->vmid_wait = dma_fence_get_stub();
>>
>> -               if (!ring->is_mes_queue) {
>> -                       ring->idx = adev->num_rings++;
>> -                       adev->rings[ring->idx] = ring;
>> -               }
>> +               ring->idx = adev->num_rings++;
>> +               adev->rings[ring->idx] = ring;
>>
>>                 r = amdgpu_fence_driver_init_ring(ring);
>>                 if (r)
>>                         return r;
>>         }
>>
>> -       if (ring->is_mes_queue) {
>> -               ring->rptr_offs = amdgpu_mes_ctx_get_offs(ring,
>> -                               AMDGPU_MES_CTX_RPTR_OFFS);
>> -               ring->wptr_offs = amdgpu_mes_ctx_get_offs(ring,
>> -                               AMDGPU_MES_CTX_WPTR_OFFS);
>> -               ring->fence_offs = amdgpu_mes_ctx_get_offs(ring,
>> -                               AMDGPU_MES_CTX_FENCE_OFFS);
>> -               ring->trail_fence_offs = amdgpu_mes_ctx_get_offs(ring,
>> -                               AMDGPU_MES_CTX_TRAIL_FENCE_OFFS);
>> -               ring->cond_exe_offs = amdgpu_mes_ctx_get_offs(ring,
>> -                               AMDGPU_MES_CTX_COND_EXE_OFFS);
>> -       } else {
>> -               r = amdgpu_device_wb_get(adev, &ring->rptr_offs);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%d) ring rptr_offs wb alloc failed\n", r);
>> -                       return r;
>> -               }
>> +       r = amdgpu_device_wb_get(adev, &ring->rptr_offs);
>> +       if (r) {
>> +               dev_err(adev->dev, "(%d) ring rptr_offs wb alloc failed\n", r);
>> +               return r;
>> +       }
>>
>> -               r = amdgpu_device_wb_get(adev, &ring->wptr_offs);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%d) ring wptr_offs wb alloc failed\n", r);
>> -                       return r;
>> -               }
>> +       r = amdgpu_device_wb_get(adev, &ring->wptr_offs);
>> +       if (r) {
>> +               dev_err(adev->dev, "(%d) ring wptr_offs wb alloc failed\n", r);
>> +               return r;
>> +       }
>>
>> -               r = amdgpu_device_wb_get(adev, &ring->fence_offs);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%d) ring fence_offs wb alloc failed\n", r);
>> -                       return r;
>> -               }
>> +       r = amdgpu_device_wb_get(adev, &ring->fence_offs);
>> +       if (r) {
>> +               dev_err(adev->dev, "(%d) ring fence_offs wb alloc failed\n", r);
>> +               return r;
>> +       }
>>
>> -               r = amdgpu_device_wb_get(adev, &ring->trail_fence_offs);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%d) ring trail_fence_offs wb alloc failed\n", r);
>> -                       return r;
>> -               }
>> +       r = amdgpu_device_wb_get(adev, &ring->trail_fence_offs);
>> +       if (r) {
>> +               dev_err(adev->dev, "(%d) ring trail_fence_offs wb alloc failed\n", r);
>> +               return r;
>> +       }
>>
>> -               r = amdgpu_device_wb_get(adev, &ring->cond_exe_offs);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%d) ring cond_exec_polling wb alloc failed\n", r);
>> -                       return r;
>> -               }
>> +       r = amdgpu_device_wb_get(adev, &ring->cond_exe_offs);
>> +       if (r) {
>> +               dev_err(adev->dev, "(%d) ring cond_exec_polling wb alloc failed\n", r);
>> +               return r;
>>         }
>>
>>         ring->fence_gpu_addr =
>> @@ -353,18 +334,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>>         ring->cached_rptr = 0;
>>
>>         /* Allocate ring buffer */
>> -       if (ring->is_mes_queue) {
>> -               int offset = 0;
>> -
>> -               BUG_ON(ring->ring_size > PAGE_SIZE*4);
>> -
>> -               offset = amdgpu_mes_ctx_get_offs(ring,
>> -                                        AMDGPU_MES_CTX_RING_OFFS);
>> -               ring->gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               ring->ring = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -               amdgpu_ring_clear_ring(ring);
>> -
>> -       } else if (ring->ring_obj == NULL) {
>> +       if (ring->ring_obj == NULL) {
>>                 r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw, PAGE_SIZE,
>>                                             AMDGPU_GEM_DOMAIN_GTT,
>>                                             &ring->ring_obj,
>> @@ -401,32 +371,26 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>>  {
>>
>>         /* Not to finish a ring which is not initialized */
>> -       if (!(ring->adev) ||
>> -           (!ring->is_mes_queue && !(ring->adev->rings[ring->idx])))
>> +       if (!(ring->adev) || !(ring->adev->rings[ring->idx]))
>>                 return;
>>
>>         ring->sched.ready = false;
>>
>> -       if (!ring->is_mes_queue) {
>> -               amdgpu_device_wb_free(ring->adev, ring->rptr_offs);
>> -               amdgpu_device_wb_free(ring->adev, ring->wptr_offs);
>> +       amdgpu_device_wb_free(ring->adev, ring->rptr_offs);
>> +       amdgpu_device_wb_free(ring->adev, ring->wptr_offs);
>>
>> -               amdgpu_device_wb_free(ring->adev, ring->cond_exe_offs);
>> -               amdgpu_device_wb_free(ring->adev, ring->fence_offs);
>> +       amdgpu_device_wb_free(ring->adev, ring->cond_exe_offs);
>> +       amdgpu_device_wb_free(ring->adev, ring->fence_offs);
>>
>> -               amdgpu_bo_free_kernel(&ring->ring_obj,
>> -                                     &ring->gpu_addr,
>> -                                     (void **)&ring->ring);
>> -       } else {
>> -               kfree(ring->fence_drv.fences);
>> -       }
>> +       amdgpu_bo_free_kernel(&ring->ring_obj,
>> +                             &ring->gpu_addr,
>> +                             (void **)&ring->ring);
>>
>>         dma_fence_put(ring->vmid_wait);
>>         ring->vmid_wait = NULL;
>>         ring->me = 0;
>>
>> -       if (!ring->is_mes_queue)
>> -               ring->adev->rings[ring->idx] = NULL;
>> +       ring->adev->rings[ring->idx] = NULL;
>>  }
>>
>>  /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index d93d3047553b3..bea3747f9550b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -306,11 +306,6 @@ struct amdgpu_ring {
>>         unsigned                num_hw_submission;
>>         atomic_t                *sched_score;
>>
>> -       /* used for mes */
>> -       bool                    is_mes_queue;
>> -       uint32_t                hw_queue_id;
>> -       struct amdgpu_mes_ctx_data *mes_ctx;
>> -
>>         bool            is_sw_ring;
>>         unsigned int    entry_index;
>>         /* store the cached rptr to restore after reset */
>> @@ -440,15 +435,6 @@ static inline void amdgpu_ring_patch_cond_exec(struct amdgpu_ring *ring,
>>         ring->ring[offset] = cur - offset;
>>  }
>>
>> -#define amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset)                 \
>> -       (ring->is_mes_queue && ring->mes_ctx ?                          \
>> -        (ring->mes_ctx->meta_data_gpu_addr + offset) : 0)
>> -
>> -#define amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset)                 \
>> -       (ring->is_mes_queue && ring->mes_ctx ?                          \
>> -        (void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset) : \
>> -        NULL)
>> -
>>  int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
>>
>>  void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> index 3a4cef8960185..03c4c012a1508 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> @@ -76,22 +76,14 @@ uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
>>         if (amdgpu_sriov_vf(adev) || vmid == 0 || !adev->gfx.mcbp)
>>                 return 0;
>>
>> -       if (ring->is_mes_queue) {
>> -               uint32_t offset = 0;
>> +       r = amdgpu_sdma_get_index_from_ring(ring, &index);
>>
>> -               offset = offsetof(struct amdgpu_mes_ctx_meta_data,
>> -                                 sdma[ring->idx].sdma_meta_data);
>> -               csa_mc_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -       } else {
>> -               r = amdgpu_sdma_get_index_from_ring(ring, &index);
>> -
>> -               if (r || index > 31)
>> -                       csa_mc_addr = 0;
>> -               else
>> -                       csa_mc_addr = amdgpu_csa_vaddr(adev) +
>> -                               AMDGPU_CSA_SDMA_OFFSET +
>> -                               index * AMDGPU_CSA_SDMA_SIZE;
>> -       }
>> +       if (r || index > 31)
>> +               csa_mc_addr = 0;
>> +       else
>> +               csa_mc_addr = amdgpu_csa_vaddr(adev) +
>> +                       AMDGPU_CSA_SDMA_OFFSET +
>> +                       index * AMDGPU_CSA_SDMA_SIZE;
>>
>>         return csa_mc_addr;
>>  }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index ef4fe2df8398c..ea18484d1d7a7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -702,7 +702,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>         if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
>>                 adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmid);
>>
>> -       if (!ring->is_mes_queue && ring->funcs->emit_gds_switch &&
>> +       if (ring->funcs->emit_gds_switch &&
>>             gds_switch_needed) {
>>                 amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>>                                             job->gds_size, job->gws_base,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 2cf663d25881d..719c4aa90a0e0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -582,33 +582,18 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>
>>         memset(&ib, 0, sizeof(ib));
>>
>> -       if (ring->is_mes_queue) {
>> -               uint32_t padding, offset;
>> -
>> -               offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
>> -               padding = amdgpu_mes_ctx_get_offs(ring,
>> -                                                 AMDGPU_MES_CTX_PADDING_OFFS);
>> -
>> -               ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               ib.ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -
>> -               gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, padding);
>> -               cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, padding);
>> -               *cpu_ptr = cpu_to_le32(0xCAFEDEAD);
>> -       } else {
>> -               r = amdgpu_device_wb_get(adev, &index);
>> -               if (r)
>> -                       return r;
>> +       r = amdgpu_device_wb_get(adev, &index);
>> +       if (r)
>> +               return r;
>>
>> -               gpu_addr = adev->wb.gpu_addr + (index * 4);
>> -               adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
>> -               cpu_ptr = &adev->wb.wb[index];
>> +       gpu_addr = adev->wb.gpu_addr + (index * 4);
>> +       adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
>> +       cpu_ptr = &adev->wb.wb[index];
>>
>> -               r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
>> -               if (r) {
>> -                       DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
>> -                       goto err1;
>> -               }
>> +       r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
>> +       if (r) {
>> +               DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
>> +               goto err1;
>>         }
>>
>>         ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
>> @@ -635,12 +620,10 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>         else
>>                 r = -EINVAL;
>>  err2:
>> -       if (!ring->is_mes_queue)
>> -               amdgpu_ib_free(&ib, NULL);
>> +       amdgpu_ib_free(&ib, NULL);
>>         dma_fence_put(f);
>>  err1:
>> -       if (!ring->is_mes_queue)
>> -               amdgpu_device_wb_free(adev, index);
>> +       amdgpu_device_wb_free(adev, index);
>>         return r;
>>  }
>>
>> @@ -5760,10 +5743,6 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>>                                     (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
>>         }
>>
>> -       if (ring->is_mes_queue)
>> -               /* inherit vmid from mqd */
>> -               control |= 0x400000;
>> -
>>         amdgpu_ring_write(ring, header);
>>         BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
>>         amdgpu_ring_write(ring,
>> @@ -5783,10 +5762,6 @@ static void gfx_v11_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
>>         unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>>         u32 control = INDIRECT_BUFFER_VALID | ib->length_dw | (vmid << 24);
>>
>> -       if (ring->is_mes_queue)
>> -               /* inherit vmid from mqd */
>> -               control |= 0x40000000;
>> -
>>         /* Currently, there is a high possibility to get wave ID mismatch
>>          * between ME and GDS, leading to a hw deadlock, because ME generates
>>          * different wave IDs than the GDS expects. This situation happens
>> @@ -5844,8 +5819,7 @@ static void gfx_v11_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>>         amdgpu_ring_write(ring, upper_32_bits(addr));
>>         amdgpu_ring_write(ring, lower_32_bits(seq));
>>         amdgpu_ring_write(ring, upper_32_bits(seq));
>> -       amdgpu_ring_write(ring, ring->is_mes_queue ?
>> -                        (ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG) : 0);
>> +       amdgpu_ring_write(ring, 0);
>>  }
>>
>>  static void gfx_v11_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
>> @@ -5873,10 +5847,7 @@ static void gfx_v11_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
>>  static void gfx_v11_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
>>                                          unsigned vmid, uint64_t pd_addr)
>>  {
>> -       if (ring->is_mes_queue)
>> -               gfx_v11_0_ring_invalidate_tlbs(ring, 0, 0, false, 0);
>> -       else
>> -               amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
>> +       amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
>>
>>         /* compute doesn't have PFP */
>>         if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
>> @@ -6105,28 +6076,13 @@ static void gfx_v11_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
>>         void *de_payload_cpu_addr;
>>         int cnt;
>>
>> -       if (ring->is_mes_queue) {
>> -               offset = offsetof(struct amdgpu_mes_ctx_meta_data,
>> -                                 gfx[0].gfx_meta_data) +
>> -                       offsetof(struct v10_gfx_meta_data, de_payload);
>> -               de_payload_gpu_addr =
>> -                       amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               de_payload_cpu_addr =
>> -                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -
>> -               offset = offsetof(struct amdgpu_mes_ctx_meta_data,
>> -                                 gfx[0].gds_backup) +
>> -                       offsetof(struct v10_gfx_meta_data, de_payload);
>> -               gds_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -       } else {
>> -               offset = offsetof(struct v10_gfx_meta_data, de_payload);
>> -               de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
>> -               de_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
>> +       offset = offsetof(struct v10_gfx_meta_data, de_payload);
>> +       de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
>> +       de_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
>>
>> -               gds_addr = ALIGN(amdgpu_csa_vaddr(ring->adev) +
>> -                                AMDGPU_CSA_SIZE - adev->gds.gds_size,
>> -                                PAGE_SIZE);
>> -       }
>> +       gds_addr = ALIGN(amdgpu_csa_vaddr(ring->adev) +
>> +                        AMDGPU_CSA_SIZE - adev->gds.gds_size,
>> +                        PAGE_SIZE);
>>
>>         de_payload.gds_backup_addrlo = lower_32_bits(gds_addr);
>>         de_payload.gds_backup_addrhi = upper_32_bits(gds_addr);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index 60d8630a05c82..9db2becab68fe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -477,33 +477,18 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>
>>         memset(&ib, 0, sizeof(ib));
>>
>> -       if (ring->is_mes_queue) {
>> -               uint32_t padding, offset;
>> -
>> -               offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
>> -               padding = amdgpu_mes_ctx_get_offs(ring,
>> -                                                 AMDGPU_MES_CTX_PADDING_OFFS);
>> -
>> -               ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               ib.ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -
>> -               gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, padding);
>> -               cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, padding);
>> -               *cpu_ptr = cpu_to_le32(0xCAFEDEAD);
>> -       } else {
>> -               r = amdgpu_device_wb_get(adev, &index);
>> -               if (r)
>> -                       return r;
>> +       r = amdgpu_device_wb_get(adev, &index);
>> +       if (r)
>> +               return r;
>>
>> -               gpu_addr = adev->wb.gpu_addr + (index * 4);
>> -               adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
>> -               cpu_ptr = &adev->wb.wb[index];
>> +       gpu_addr = adev->wb.gpu_addr + (index * 4);
>> +       adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
>> +       cpu_ptr = &adev->wb.wb[index];
>>
>> -               r = amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
>> -               if (r) {
>> -                       dev_err(adev->dev, "amdgpu: failed to get ib (%ld).\n", r);
>> -                       goto err1;
>> -               }
>> +       r = amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
>> +       if (r) {
>> +               dev_err(adev->dev, "amdgpu: failed to get ib (%ld).\n", r);
>> +               goto err1;
>>         }
>>
>>         ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
>> @@ -530,12 +515,10 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>         else
>>                 r = -EINVAL;
>>  err2:
>> -       if (!ring->is_mes_queue)
>> -               amdgpu_ib_free(&ib, NULL);
>> +       amdgpu_ib_free(&ib, NULL);
>>         dma_fence_put(f);
>>  err1:
>> -       if (!ring->is_mes_queue)
>> -               amdgpu_device_wb_free(adev, index);
>> +       amdgpu_device_wb_free(adev, index);
>>         return r;
>>  }
>>
>> @@ -4283,45 +4266,17 @@ static u64 gfx_v12_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
>>  static void gfx_v12_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
>>  {
>>         struct amdgpu_device *adev = ring->adev;
>> -       uint32_t *wptr_saved;
>> -       uint32_t *is_queue_unmap;
>> -       uint64_t aggregated_db_index;
>> -       uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_GFX].mqd_size;
>> -       uint64_t wptr_tmp;
>> -
>> -       if (ring->is_mes_queue) {
>> -               wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
>> -               is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
>> -                                             sizeof(uint32_t));
>> -               aggregated_db_index =
>> -                       amdgpu_mes_get_aggregated_doorbell_index(adev,
>> -                                                                ring->hw_prio);
>> -
>> -               wptr_tmp = ring->wptr & ring->buf_mask;
>> -               atomic64_set((atomic64_t *)ring->wptr_cpu_addr, wptr_tmp);
>> -               *wptr_saved = wptr_tmp;
>> -               /* assume doorbell always being used by mes mapped queue */
>> -               if (*is_queue_unmap) {
>> -                       WDOORBELL64(aggregated_db_index, wptr_tmp);
>> -                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
>> -               } else {
>> -                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
>>
>> -                       if (*is_queue_unmap)
>> -                               WDOORBELL64(aggregated_db_index, wptr_tmp);
>> -               }
>> +       if (ring->use_doorbell) {
>> +               /* XXX check if swapping is necessary on BE */
>> +               atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
>> +                            ring->wptr);
>> +               WDOORBELL64(ring->doorbell_index, ring->wptr);
>>         } else {
>> -               if (ring->use_doorbell) {
>> -                       /* XXX check if swapping is necessary on BE */
>> -                       atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
>> -                                    ring->wptr);
>> -                       WDOORBELL64(ring->doorbell_index, ring->wptr);
>> -               } else {
>> -                       WREG32_SOC15(GC, 0, regCP_RB0_WPTR,
>> -                                    lower_32_bits(ring->wptr));
>> -                       WREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI,
>> -                                    upper_32_bits(ring->wptr));
>> -               }
>> +               WREG32_SOC15(GC, 0, regCP_RB0_WPTR,
>> +                            lower_32_bits(ring->wptr));
>> +               WREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI,
>> +                            upper_32_bits(ring->wptr));
>>         }
>>  }
>>
>> @@ -4346,42 +4301,14 @@ static u64 gfx_v12_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
>>  static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>>  {
>>         struct amdgpu_device *adev = ring->adev;
>> -       uint32_t *wptr_saved;
>> -       uint32_t *is_queue_unmap;
>> -       uint64_t aggregated_db_index;
>> -       uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size;
>> -       uint64_t wptr_tmp;
>> -
>> -       if (ring->is_mes_queue) {
>> -               wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
>> -               is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
>> -                                             sizeof(uint32_t));
>> -               aggregated_db_index =
>> -                       amdgpu_mes_get_aggregated_doorbell_index(adev,
>> -                                                                ring->hw_prio);
>> -
>> -               wptr_tmp = ring->wptr & ring->buf_mask;
>> -               atomic64_set((atomic64_t *)ring->wptr_cpu_addr, wptr_tmp);
>> -               *wptr_saved = wptr_tmp;
>> -               /* assume doorbell always used by mes mapped queue */
>> -               if (*is_queue_unmap) {
>> -                       WDOORBELL64(aggregated_db_index, wptr_tmp);
>> -                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
>> -               } else {
>> -                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
>>
>> -                       if (*is_queue_unmap)
>> -                               WDOORBELL64(aggregated_db_index, wptr_tmp);
>> -               }
>> +       /* XXX check if swapping is necessary on BE */
>> +       if (ring->use_doorbell) {
>> +               atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
>> +                            ring->wptr);
>> +               WDOORBELL64(ring->doorbell_index, ring->wptr);
>>         } else {
>> -               /* XXX check if swapping is necessary on BE */
>> -               if (ring->use_doorbell) {
>> -                       atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
>> -                                    ring->wptr);
>> -                       WDOORBELL64(ring->doorbell_index, ring->wptr);
>> -               } else {
>> -                       BUG(); /* only DOORBELL method supported on gfx12 now */
>> -               }
>> +               BUG(); /* only DOORBELL method supported on gfx12 now */
>>         }
>>  }
>>
>> @@ -4428,10 +4355,6 @@ static void gfx_v12_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>>
>>         control |= ib->length_dw | (vmid << 24);
>>
>> -       if (ring->is_mes_queue)
>> -               /* inherit vmid from mqd */
>> -               control |= 0x400000;
>> -
>>         amdgpu_ring_write(ring, header);
>>         BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
>>         amdgpu_ring_write(ring,
>> @@ -4451,10 +4374,6 @@ static void gfx_v12_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
>>         unsigned vmid = AMDGPU_JOB_GET_VMID(job);
>>         u32 control = INDIRECT_BUFFER_VALID | ib->length_dw | (vmid << 24);
>>
>> -       if (ring->is_mes_queue)
>> -               /* inherit vmid from mqd */
>> -               control |= 0x40000000;
>> -
>>         amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
>>         BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
>>         amdgpu_ring_write(ring,
>> @@ -4494,8 +4413,7 @@ static void gfx_v12_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>>         amdgpu_ring_write(ring, upper_32_bits(addr));
>>         amdgpu_ring_write(ring, lower_32_bits(seq));
>>         amdgpu_ring_write(ring, upper_32_bits(seq));
>> -       amdgpu_ring_write(ring, ring->is_mes_queue ?
>> -                        (ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG) : 0);
>> +       amdgpu_ring_write(ring, 0);
>>  }
>>
>>  static void gfx_v12_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
>> @@ -4523,10 +4441,7 @@ static void gfx_v12_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
>>  static void gfx_v12_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
>>                                          unsigned vmid, uint64_t pd_addr)
>>  {
>> -       if (ring->is_mes_queue)
>> -               gfx_v12_0_ring_invalidate_tlbs(ring, 0, 0, false, 0);
>> -       else
>> -               amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
>> +       amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
>>
>>         /* compute doesn't have PFP */
>>         if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 734f2dd986290..f4dfa1418b740 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -5472,16 +5472,8 @@ static void gfx_v9_0_ring_patch_ce_meta(struct amdgpu_ring *ring,
>>
>>         payload_size = sizeof(struct v9_ce_ib_state);
>>
>> -       if (ring->is_mes_queue) {
>> -               payload_offset = offsetof(struct amdgpu_mes_ctx_meta_data,
>> -                                         gfx[0].gfx_meta_data) +
>> -                       offsetof(struct v9_gfx_meta_data, ce_payload);
>> -               ce_payload_cpu_addr =
>> -                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, payload_offset);
>> -       } else {
>> -               payload_offset = offsetof(struct v9_gfx_meta_data, ce_payload);
>> -               ce_payload_cpu_addr = adev->virt.csa_cpu_addr + payload_offset;
>> -       }
>> +       payload_offset = offsetof(struct v9_gfx_meta_data, ce_payload);
>> +       ce_payload_cpu_addr = adev->virt.csa_cpu_addr + payload_offset;
>>
>>         if (offset + (payload_size >> 2) <= ring->buf_mask + 1) {
>>                 memcpy((void *)&ring->ring[offset], ce_payload_cpu_addr, payload_size);
>> @@ -5504,16 +5496,8 @@ static void gfx_v9_0_ring_patch_de_meta(struct amdgpu_ring *ring,
>>
>>         payload_size = sizeof(struct v9_de_ib_state);
>>
>> -       if (ring->is_mes_queue) {
>> -               payload_offset = offsetof(struct amdgpu_mes_ctx_meta_data,
>> -                                         gfx[0].gfx_meta_data) +
>> -                       offsetof(struct v9_gfx_meta_data, de_payload);
>> -               de_payload_cpu_addr =
>> -                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, payload_offset);
>> -       } else {
>> -               payload_offset = offsetof(struct v9_gfx_meta_data, de_payload);
>> -               de_payload_cpu_addr = adev->virt.csa_cpu_addr + payload_offset;
>> -       }
>> +       payload_offset = offsetof(struct v9_gfx_meta_data, de_payload);
>> +       de_payload_cpu_addr = adev->virt.csa_cpu_addr + payload_offset;
>>
>>         ((struct v9_de_ib_state *)de_payload_cpu_addr)->ib_completion_status =
>>                 IB_COMPLETION_STATUS_PREEMPTED;
>> @@ -5703,19 +5687,9 @@ static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
>>
>>         cnt = (sizeof(ce_payload) >> 2) + 4 - 2;
>>
>> -       if (ring->is_mes_queue) {
>> -               offset = offsetof(struct amdgpu_mes_ctx_meta_data,
>> -                                 gfx[0].gfx_meta_data) +
>> -                       offsetof(struct v9_gfx_meta_data, ce_payload);
>> -               ce_payload_gpu_addr =
>> -                       amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               ce_payload_cpu_addr =
>> -                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -       } else {
>> -               offset = offsetof(struct v9_gfx_meta_data, ce_payload);
>> -               ce_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
>> -               ce_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
>> -       }
>> +       offset = offsetof(struct v9_gfx_meta_data, ce_payload);
>> +       ce_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
>> +       ce_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
>>
>>         amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
>>         amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(2) |
>> @@ -5801,28 +5775,13 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume, bo
>>         void *de_payload_cpu_addr;
>>         int cnt;
>>
>> -       if (ring->is_mes_queue) {
>> -               offset = offsetof(struct amdgpu_mes_ctx_meta_data,
>> -                                 gfx[0].gfx_meta_data) +
>> -                       offsetof(struct v9_gfx_meta_data, de_payload);
>> -               de_payload_gpu_addr =
>> -                       amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               de_payload_cpu_addr =
>> -                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -
>> -               offset = offsetof(struct amdgpu_mes_ctx_meta_data,
>> -                                 gfx[0].gds_backup) +
>> -                       offsetof(struct v9_gfx_meta_data, de_payload);
>> -               gds_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -       } else {
>> -               offset = offsetof(struct v9_gfx_meta_data, de_payload);
>> -               de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
>> -               de_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
>> +       offset = offsetof(struct v9_gfx_meta_data, de_payload);
>> +       de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
>> +       de_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
>>
>> -               gds_addr = ALIGN(amdgpu_csa_vaddr(ring->adev) +
>> -                                AMDGPU_CSA_SIZE - adev->gds.gds_size,
>> -                                PAGE_SIZE);
>> -       }
>> +       gds_addr = ALIGN(amdgpu_csa_vaddr(ring->adev) +
>> +                        AMDGPU_CSA_SIZE - adev->gds.gds_size,
>> +                        PAGE_SIZE);
>>
>>         if (usegds) {
>>                 de_payload.gds_backup_addrlo = lower_32_bits(gds_addr);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index 95d894a231fcf..8ae4c031162bc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -428,10 +428,6 @@ static void gmc_v10_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int
>>         struct amdgpu_device *adev = ring->adev;
>>         uint32_t reg;
>>
>> -       /* MES fw manages IH_VMID_x_LUT updating */
>> -       if (ring->is_mes_queue)
>> -               return;
>> -
>>         if (ring->vm_hub == AMDGPU_GFXHUB(0))
>>                 reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_VMID_0_LUT) + vmid;
>>         else
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> index ad099f136f84e..5c91d4445418c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> @@ -393,10 +393,6 @@ static void gmc_v11_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int
>>         struct amdgpu_device *adev = ring->adev;
>>         uint32_t reg;
>>
>> -       /* MES fw manages IH_VMID_x_LUT updating */
>> -       if (ring->is_mes_queue)
>> -               return;
>> -
>>         if (ring->vm_hub == AMDGPU_GFXHUB(0))
>>                 reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid;
>>         else
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> index bf8d01da88154..0a1946c824118 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> @@ -413,10 +413,6 @@ static void gmc_v12_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid
>>         struct amdgpu_device *adev = ring->adev;
>>         uint32_t reg;
>>
>> -       /* MES fw manages IH_VMID_x_LUT updating */
>> -       if (ring->is_mes_queue)
>> -               return;
>> -
>>         if (ring->vm_hub == AMDGPU_GFXHUB(0))
>>                 reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid;
>>         else
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> index 44a401870509f..712392671a3cf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> @@ -369,67 +369,36 @@ static uint64_t sdma_v5_0_ring_get_wptr(struct amdgpu_ring *ring)
>>  static void sdma_v5_0_ring_set_wptr(struct amdgpu_ring *ring)
>>  {
>>         struct amdgpu_device *adev = ring->adev;
>> -       uint32_t *wptr_saved;
>> -       uint32_t *is_queue_unmap;
>> -       uint64_t aggregated_db_index;
>> -       uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_DMA].mqd_size;
>>
>>         DRM_DEBUG("Setting write pointer\n");
>> -       if (ring->is_mes_queue) {
>> -               wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
>> -               is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
>> -                                             sizeof(uint32_t));
>> -               aggregated_db_index =
>> -                       amdgpu_mes_get_aggregated_doorbell_index(adev,
>> -                       AMDGPU_MES_PRIORITY_LEVEL_NORMAL);
>> -
>> +       if (ring->use_doorbell) {
>> +               DRM_DEBUG("Using doorbell -- "
>> +                         "wptr_offs == 0x%08x "
>> +                         "lower_32_bits(ring->wptr) << 2 == 0x%08x "
>> +                         "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
>> +                         ring->wptr_offs,
>> +                         lower_32_bits(ring->wptr << 2),
>> +                         upper_32_bits(ring->wptr << 2));
>> +               /* XXX check if swapping is necessary on BE */
>>                 atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
>>                              ring->wptr << 2);
>> -               *wptr_saved = ring->wptr << 2;
>> -               if (*is_queue_unmap) {
>> -                       WDOORBELL64(aggregated_db_index, ring->wptr << 2);
>> -                       DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
>> -                                       ring->doorbell_index, ring->wptr << 2);
>> -                       WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
>> -               } else {
>> -                       DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
>> -                                       ring->doorbell_index, ring->wptr << 2);
>> -                       WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
>> -
>> -                       if (*is_queue_unmap)
>> -                               WDOORBELL64(aggregated_db_index,
>> -                                           ring->wptr << 2);
>> -               }
>> +               DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
>> +                         ring->doorbell_index, ring->wptr << 2);
>> +               WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
>>         } else {
>> -               if (ring->use_doorbell) {
>> -                       DRM_DEBUG("Using doorbell -- "
>> -                                 "wptr_offs == 0x%08x "
>> -                                 "lower_32_bits(ring->wptr) << 2 == 0x%08x "
>> -                                 "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
>> -                                 ring->wptr_offs,
>> -                                 lower_32_bits(ring->wptr << 2),
>> -                                 upper_32_bits(ring->wptr << 2));
>> -                       /* XXX check if swapping is necessary on BE */
>> -                       atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
>> -                                    ring->wptr << 2);
>> -                       DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
>> -                                 ring->doorbell_index, ring->wptr << 2);
>> -                       WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
>> -               } else {
>> -                       DRM_DEBUG("Not using doorbell -- "
>> -                                 "mmSDMA%i_GFX_RB_WPTR == 0x%08x "
>> -                                 "mmSDMA%i_GFX_RB_WPTR_HI == 0x%08x\n",
>> -                                 ring->me,
>> -                                 lower_32_bits(ring->wptr << 2),
>> -                                 ring->me,
>> -                                 upper_32_bits(ring->wptr << 2));
>> -                       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev,
>> -                                            ring->me, mmSDMA0_GFX_RB_WPTR),
>> -                                       lower_32_bits(ring->wptr << 2));
>> -                       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev,
>> -                                            ring->me, mmSDMA0_GFX_RB_WPTR_HI),
>> -                                       upper_32_bits(ring->wptr << 2));
>> -               }
>> +               DRM_DEBUG("Not using doorbell -- "
>> +                         "mmSDMA%i_GFX_RB_WPTR == 0x%08x "
>> +                         "mmSDMA%i_GFX_RB_WPTR_HI == 0x%08x\n",
>> +                         ring->me,
>> +                         lower_32_bits(ring->wptr << 2),
>> +                         ring->me,
>> +                         upper_32_bits(ring->wptr << 2));
>> +               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev,
>> +                                                            ring->me, mmSDMA0_GFX_RB_WPTR),
>> +                               lower_32_bits(ring->wptr << 2));
>> +               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev,
>> +                                                            ring->me, mmSDMA0_GFX_RB_WPTR_HI),
>> +                               upper_32_bits(ring->wptr << 2));
>>         }
>>  }
>>
>> @@ -575,11 +544,9 @@ static void sdma_v5_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
>>         }
>>
>>         if (flags & AMDGPU_FENCE_FLAG_INT) {
>> -               uint32_t ctx = ring->is_mes_queue ?
>> -                       (ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG) : 0;
>>                 /* generate an interrupt */
>>                 amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_TRAP));
>> -               amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(ctx));
>> +               amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(0));
>>         }
>>  }
>>
>> @@ -1046,33 +1013,22 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
>>         int r;
>>         u32 tmp;
>>         u64 gpu_addr;
>> -       volatile uint32_t *cpu_ptr = NULL;
>>
>>         tmp = 0xCAFEDEAD;
>>
>> -       if (ring->is_mes_queue) {
>> -               uint32_t offset = 0;
>> -               offset = amdgpu_mes_ctx_get_offs(ring,
>> -                                        AMDGPU_MES_CTX_PADDING_OFFS);
>> -               gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -               *cpu_ptr = tmp;
>> -       } else {
>> -               r = amdgpu_device_wb_get(adev, &index);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
>> -                       return r;
>> -               }
>> -
>> -               gpu_addr = adev->wb.gpu_addr + (index * 4);
>> -               adev->wb.wb[index] = cpu_to_le32(tmp);
>> +       r = amdgpu_device_wb_get(adev, &index);
>> +       if (r) {
>> +               dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
>> +               return r;
>>         }
>>
>> +       gpu_addr = adev->wb.gpu_addr + (index * 4);
>> +       adev->wb.wb[index] = cpu_to_le32(tmp);
>> +
>>         r = amdgpu_ring_alloc(ring, 20);
>>         if (r) {
>>                 DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
>> -               if (!ring->is_mes_queue)
>> -                       amdgpu_device_wb_free(adev, index);
>> +               amdgpu_device_wb_free(adev, index);
>>                 return r;
>>         }
>>
>> @@ -1085,10 +1041,7 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
>>         amdgpu_ring_commit(ring);
>>
>>         for (i = 0; i < adev->usec_timeout; i++) {
>> -               if (ring->is_mes_queue)
>> -                       tmp = le32_to_cpu(*cpu_ptr);
>> -               else
>> -                       tmp = le32_to_cpu(adev->wb.wb[index]);
>> +               tmp = le32_to_cpu(adev->wb.wb[index]);
>>                 if (tmp == 0xDEADBEEF)
>>                         break;
>>                 if (amdgpu_emu_mode == 1)
>> @@ -1100,8 +1053,7 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
>>         if (i >= adev->usec_timeout)
>>                 r = -ETIMEDOUT;
>>
>> -       if (!ring->is_mes_queue)
>> -               amdgpu_device_wb_free(adev, index);
>> +       amdgpu_device_wb_free(adev, index);
>>
>>         return r;
>>  }
>> @@ -1124,38 +1076,24 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>         long r;
>>         u32 tmp = 0;
>>         u64 gpu_addr;
>> -       volatile uint32_t *cpu_ptr = NULL;
>>
>>         tmp = 0xCAFEDEAD;
>>         memset(&ib, 0, sizeof(ib));
>>
>> -       if (ring->is_mes_queue) {
>> -               uint32_t offset = 0;
>> -               offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
>> -               ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               ib.ptr = (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -
>> -               offset = amdgpu_mes_ctx_get_offs(ring,
>> -                                        AMDGPU_MES_CTX_PADDING_OFFS);
>> -               gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -               *cpu_ptr = tmp;
>> -       } else {
>> -               r = amdgpu_device_wb_get(adev, &index);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
>> -                       return r;
>> -               }
>> +       r = amdgpu_device_wb_get(adev, &index);
>> +       if (r) {
>> +               dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
>> +               return r;
>> +       }
>>
>> -               gpu_addr = adev->wb.gpu_addr + (index * 4);
>> -               adev->wb.wb[index] = cpu_to_le32(tmp);
>> +       gpu_addr = adev->wb.gpu_addr + (index * 4);
>> +       adev->wb.wb[index] = cpu_to_le32(tmp);
>>
>> -               r = amdgpu_ib_get(adev, NULL, 256,
>> -                                       AMDGPU_IB_POOL_DIRECT, &ib);
>> -               if (r) {
>> -                       DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
>> -                       goto err0;
>> -               }
>> +       r = amdgpu_ib_get(adev, NULL, 256,
>> +                         AMDGPU_IB_POOL_DIRECT, &ib);
>> +       if (r) {
>> +               DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
>> +               goto err0;
>>         }
>>
>>         ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
>> @@ -1183,10 +1121,7 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>                 goto err1;
>>         }
>>
>> -       if (ring->is_mes_queue)
>> -               tmp = le32_to_cpu(*cpu_ptr);
>> -       else
>> -               tmp = le32_to_cpu(adev->wb.wb[index]);
>> +       tmp = le32_to_cpu(adev->wb.wb[index]);
>>
>>         if (tmp == 0xDEADBEEF)
>>                 r = 0;
>> @@ -1197,8 +1132,7 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>         amdgpu_ib_free(&ib, NULL);
>>         dma_fence_put(f);
>>  err0:
>> -       if (!ring->is_mes_queue)
>> -               amdgpu_device_wb_free(adev, index);
>> +       amdgpu_device_wb_free(adev, index);
>>         return r;
>>  }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> index cb2a3e5592855..2c0bf2fc6d380 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> @@ -394,11 +394,9 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
>>         }
>>
>>         if ((flags & AMDGPU_FENCE_FLAG_INT)) {
>> -               uint32_t ctx = ring->is_mes_queue ?
>> -                       (ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG) : 0;
>>                 /* generate an interrupt */
>>                 amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_TRAP));
>> -               amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(ctx));
>> +               amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(0));
>>         }
>>  }
>>
>> @@ -903,33 +901,22 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
>>         int r;
>>         u32 tmp;
>>         u64 gpu_addr;
>> -       volatile uint32_t *cpu_ptr = NULL;
>>
>>         tmp = 0xCAFEDEAD;
>>
>> -       if (ring->is_mes_queue) {
>> -               uint32_t offset = 0;
>> -               offset = amdgpu_mes_ctx_get_offs(ring,
>> -                                        AMDGPU_MES_CTX_PADDING_OFFS);
>> -               gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -               *cpu_ptr = tmp;
>> -       } else {
>> -               r = amdgpu_device_wb_get(adev, &index);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
>> -                       return r;
>> -               }
>> -
>> -               gpu_addr = adev->wb.gpu_addr + (index * 4);
>> -               adev->wb.wb[index] = cpu_to_le32(tmp);
>> +       r = amdgpu_device_wb_get(adev, &index);
>> +       if (r) {
>> +               dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
>> +               return r;
>>         }
>>
>> +       gpu_addr = adev->wb.gpu_addr + (index * 4);
>> +       adev->wb.wb[index] = cpu_to_le32(tmp);
>> +
>>         r = amdgpu_ring_alloc(ring, 20);
>>         if (r) {
>>                 DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
>> -               if (!ring->is_mes_queue)
>> -                       amdgpu_device_wb_free(adev, index);
>> +               amdgpu_device_wb_free(adev, index);
>>                 return r;
>>         }
>>
>> @@ -942,10 +929,7 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
>>         amdgpu_ring_commit(ring);
>>
>>         for (i = 0; i < adev->usec_timeout; i++) {
>> -               if (ring->is_mes_queue)
>> -                       tmp = le32_to_cpu(*cpu_ptr);
>> -               else
>> -                       tmp = le32_to_cpu(adev->wb.wb[index]);
>> +               tmp = le32_to_cpu(adev->wb.wb[index]);
>>                 if (tmp == 0xDEADBEEF)
>>                         break;
>>                 if (amdgpu_emu_mode == 1)
>> @@ -957,8 +941,7 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
>>         if (i >= adev->usec_timeout)
>>                 r = -ETIMEDOUT;
>>
>> -       if (!ring->is_mes_queue)
>> -               amdgpu_device_wb_free(adev, index);
>> +       amdgpu_device_wb_free(adev, index);
>>
>>         return r;
>>  }
>> @@ -981,37 +964,23 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>         long r;
>>         u32 tmp = 0;
>>         u64 gpu_addr;
>> -       volatile uint32_t *cpu_ptr = NULL;
>>
>>         tmp = 0xCAFEDEAD;
>>         memset(&ib, 0, sizeof(ib));
>>
>> -       if (ring->is_mes_queue) {
>> -               uint32_t offset = 0;
>> -               offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
>> -               ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               ib.ptr = (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -
>> -               offset = amdgpu_mes_ctx_get_offs(ring,
>> -                                        AMDGPU_MES_CTX_PADDING_OFFS);
>> -               gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -               *cpu_ptr = tmp;
>> -       } else {
>> -               r = amdgpu_device_wb_get(adev, &index);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
>> -                       return r;
>> -               }
>> +       r = amdgpu_device_wb_get(adev, &index);
>> +       if (r) {
>> +               dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
>> +               return r;
>> +       }
>>
>> -               gpu_addr = adev->wb.gpu_addr + (index * 4);
>> -               adev->wb.wb[index] = cpu_to_le32(tmp);
>> +       gpu_addr = adev->wb.gpu_addr + (index * 4);
>> +       adev->wb.wb[index] = cpu_to_le32(tmp);
>>
>> -               r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
>> -               if (r) {
>> -                       DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
>> -                       goto err0;
>> -               }
>> +       r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
>> +       if (r) {
>> +               DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
>> +               goto err0;
>>         }
>>
>>         ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
>> @@ -1039,10 +1008,7 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>                 goto err1;
>>         }
>>
>> -       if (ring->is_mes_queue)
>> -               tmp = le32_to_cpu(*cpu_ptr);
>> -       else
>> -               tmp = le32_to_cpu(adev->wb.wb[index]);
>> +       tmp = le32_to_cpu(adev->wb.wb[index]);
>>
>>         if (tmp == 0xDEADBEEF)
>>                 r = 0;
>> @@ -1053,8 +1019,7 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>         amdgpu_ib_free(&ib, NULL);
>>         dma_fence_put(f);
>>  err0:
>> -       if (!ring->is_mes_queue)
>> -               amdgpu_device_wb_free(adev, index);
>> +       amdgpu_device_wb_free(adev, index);
>>         return r;
>>  }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> index f1a02ce844e0f..d0f7874730f06 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> @@ -377,11 +377,9 @@ static void sdma_v6_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
>>         }
>>
>>         if (flags & AMDGPU_FENCE_FLAG_INT) {
>> -               uint32_t ctx = ring->is_mes_queue ?
>> -                       (ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG) : 0;
>>                 /* generate an interrupt */
>>                 amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_TRAP));
>> -               amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(ctx));
>> +               amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(0));
>>         }
>>  }
>>
>> @@ -921,33 +919,22 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
>>         int r;
>>         u32 tmp;
>>         u64 gpu_addr;
>> -       volatile uint32_t *cpu_ptr = NULL;
>>
>>         tmp = 0xCAFEDEAD;
>>
>> -       if (ring->is_mes_queue) {
>> -               uint32_t offset = 0;
>> -               offset = amdgpu_mes_ctx_get_offs(ring,
>> -                                        AMDGPU_MES_CTX_PADDING_OFFS);
>> -               gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -               *cpu_ptr = tmp;
>> -       } else {
>> -               r = amdgpu_device_wb_get(adev, &index);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
>> -                       return r;
>> -               }
>> -
>> -               gpu_addr = adev->wb.gpu_addr + (index * 4);
>> -               adev->wb.wb[index] = cpu_to_le32(tmp);
>> +       r = amdgpu_device_wb_get(adev, &index);
>> +       if (r) {
>> +               dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
>> +               return r;
>>         }
>>
>> +       gpu_addr = adev->wb.gpu_addr + (index * 4);
>> +       adev->wb.wb[index] = cpu_to_le32(tmp);
>> +
>>         r = amdgpu_ring_alloc(ring, 5);
>>         if (r) {
>>                 DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
>> -               if (!ring->is_mes_queue)
>> -                       amdgpu_device_wb_free(adev, index);
>> +               amdgpu_device_wb_free(adev, index);
>>                 return r;
>>         }
>>
>> @@ -960,10 +947,7 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
>>         amdgpu_ring_commit(ring);
>>
>>         for (i = 0; i < adev->usec_timeout; i++) {
>> -               if (ring->is_mes_queue)
>> -                       tmp = le32_to_cpu(*cpu_ptr);
>> -               else
>> -                       tmp = le32_to_cpu(adev->wb.wb[index]);
>> +               tmp = le32_to_cpu(adev->wb.wb[index]);
>>                 if (tmp == 0xDEADBEEF)
>>                         break;
>>                 if (amdgpu_emu_mode == 1)
>> @@ -975,8 +959,7 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
>>         if (i >= adev->usec_timeout)
>>                 r = -ETIMEDOUT;
>>
>> -       if (!ring->is_mes_queue)
>> -               amdgpu_device_wb_free(adev, index);
>> +       amdgpu_device_wb_free(adev, index);
>>
>>         return r;
>>  }
>> @@ -999,37 +982,23 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>         long r;
>>         u32 tmp = 0;
>>         u64 gpu_addr;
>> -       volatile uint32_t *cpu_ptr = NULL;
>>
>>         tmp = 0xCAFEDEAD;
>>         memset(&ib, 0, sizeof(ib));
>>
>> -       if (ring->is_mes_queue) {
>> -               uint32_t offset = 0;
>> -               offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
>> -               ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               ib.ptr = (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -
>> -               offset = amdgpu_mes_ctx_get_offs(ring,
>> -                                        AMDGPU_MES_CTX_PADDING_OFFS);
>> -               gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -               *cpu_ptr = tmp;
>> -       } else {
>> -               r = amdgpu_device_wb_get(adev, &index);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
>> -                       return r;
>> -               }
>> +       r = amdgpu_device_wb_get(adev, &index);
>> +       if (r) {
>> +               dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
>> +               return r;
>> +       }
>>
>> -               gpu_addr = adev->wb.gpu_addr + (index * 4);
>> -               adev->wb.wb[index] = cpu_to_le32(tmp);
>> +       gpu_addr = adev->wb.gpu_addr + (index * 4);
>> +       adev->wb.wb[index] = cpu_to_le32(tmp);
>>
>> -               r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
>> -               if (r) {
>> -                       DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
>> -                       goto err0;
>> -               }
>> +       r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
>> +       if (r) {
>> +               DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
>> +               goto err0;
>>         }
>>
>>         ib.ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
>> @@ -1057,10 +1026,7 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>                 goto err1;
>>         }
>>
>> -       if (ring->is_mes_queue)
>> -               tmp = le32_to_cpu(*cpu_ptr);
>> -       else
>> -               tmp = le32_to_cpu(adev->wb.wb[index]);
>> +       tmp = le32_to_cpu(adev->wb.wb[index]);
>>
>>         if (tmp == 0xDEADBEEF)
>>                 r = 0;
>> @@ -1071,8 +1037,7 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>         amdgpu_ib_free(&ib, NULL);
>>         dma_fence_put(f);
>>  err0:
>> -       if (!ring->is_mes_queue)
>> -               amdgpu_device_wb_free(adev, index);
>> +       amdgpu_device_wb_free(adev, index);
>>         return r;
>>  }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> index f10de8e2fcae2..7a788da2ef5d7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> @@ -205,66 +205,39 @@ static uint64_t sdma_v7_0_ring_get_wptr(struct amdgpu_ring *ring)
>>  static void sdma_v7_0_ring_set_wptr(struct amdgpu_ring *ring)
>>  {
>>         struct amdgpu_device *adev = ring->adev;
>> -       uint32_t *wptr_saved;
>> -       uint32_t *is_queue_unmap;
>> -       uint64_t aggregated_db_index;
>> -       uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_DMA].mqd_size;
>>
>>         DRM_DEBUG("Setting write pointer\n");
>>
>> -       if (ring->is_mes_queue) {
>> -               wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
>> -               is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
>> -                                             sizeof(uint32_t));
>> -               aggregated_db_index =
>> -                       amdgpu_mes_get_aggregated_doorbell_index(adev,
>> -                                                        ring->hw_prio);
>> -
>> +       if (ring->use_doorbell) {
>> +               DRM_DEBUG("Using doorbell -- "
>> +                         "wptr_offs == 0x%08x "
>> +                         "lower_32_bits(ring->wptr) << 2 == 0x%08x "
>> +                         "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
>> +                         ring->wptr_offs,
>> +                         lower_32_bits(ring->wptr << 2),
>> +                         upper_32_bits(ring->wptr << 2));
>> +               /* XXX check if swapping is necessary on BE */
>>                 atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
>>                              ring->wptr << 2);
>> -               *wptr_saved = ring->wptr << 2;
>> -               if (*is_queue_unmap) {
>> -                       WDOORBELL64(aggregated_db_index, ring->wptr << 2);
>> -                       DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
>> -                                       ring->doorbell_index, ring->wptr << 2);
>> -                       WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
>> -               } else {
>> -                       DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
>> -                                       ring->doorbell_index, ring->wptr << 2);
>> -                       WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
>> -               }
>> +               DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
>> +                         ring->doorbell_index, ring->wptr << 2);
>> +               WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
>>         } else {
>> -               if (ring->use_doorbell) {
>> -                       DRM_DEBUG("Using doorbell -- "
>> -                                 "wptr_offs == 0x%08x "
>> -                                 "lower_32_bits(ring->wptr) << 2 == 0x%08x "
>> -                                 "upper_32_bits(ring->wptr) << 2 == 0x%08x\n",
>> -                                 ring->wptr_offs,
>> -                                 lower_32_bits(ring->wptr << 2),
>> -                                 upper_32_bits(ring->wptr << 2));
>> -                       /* XXX check if swapping is necessary on BE */
>> -                       atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
>> -                                    ring->wptr << 2);
>> -                       DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
>> -                                 ring->doorbell_index, ring->wptr << 2);
>> -                       WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
>> -               } else {
>> -                       DRM_DEBUG("Not using doorbell -- "
>> -                                 "regSDMA%i_GFX_RB_WPTR == 0x%08x "
>> -                                 "regSDMA%i_GFX_RB_WPTR_HI == 0x%08x\n",
>> -                                 ring->me,
>> -                                 lower_32_bits(ring->wptr << 2),
>> -                                 ring->me,
>> -                                 upper_32_bits(ring->wptr << 2));
>> -                       WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev,
>> -                                                                    ring->me,
>> -                                                                    regSDMA0_QUEUE0_RB_WPTR),
>> -                                       lower_32_bits(ring->wptr << 2));
>> -                       WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev,
>> -                                                                    ring->me,
>> -                                                                    regSDMA0_QUEUE0_RB_WPTR_HI),
>> -                                       upper_32_bits(ring->wptr << 2));
>> -               }
>> +               DRM_DEBUG("Not using doorbell -- "
>> +                         "regSDMA%i_GFX_RB_WPTR == 0x%08x "
>> +                         "regSDMA%i_GFX_RB_WPTR_HI == 0x%08x\n",
>> +                         ring->me,
>> +                         lower_32_bits(ring->wptr << 2),
>> +                         ring->me,
>> +                         upper_32_bits(ring->wptr << 2));
>> +               WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev,
>> +                                                            ring->me,
>> +                                                            regSDMA0_QUEUE0_RB_WPTR),
>> +                               lower_32_bits(ring->wptr << 2));
>> +               WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev,
>> +                                                            ring->me,
>> +                                                            regSDMA0_QUEUE0_RB_WPTR_HI),
>> +                               upper_32_bits(ring->wptr << 2));
>>         }
>>  }
>>
>> @@ -408,11 +381,9 @@ static void sdma_v7_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
>>         }
>>
>>         if (flags & AMDGPU_FENCE_FLAG_INT) {
>> -               uint32_t ctx = ring->is_mes_queue ?
>> -                       (ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG) : 0;
>>                 /* generate an interrupt */
>>                 amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_TRAP));
>> -               amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(ctx));
>> +               amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(0));
>>         }
>>  }
>>
>> @@ -965,33 +936,22 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
>>         int r;
>>         u32 tmp;
>>         u64 gpu_addr;
>> -       volatile uint32_t *cpu_ptr = NULL;
>>
>>         tmp = 0xCAFEDEAD;
>>
>> -       if (ring->is_mes_queue) {
>> -               uint32_t offset = 0;
>> -               offset = amdgpu_mes_ctx_get_offs(ring,
>> -                                        AMDGPU_MES_CTX_PADDING_OFFS);
>> -               gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -               *cpu_ptr = tmp;
>> -       } else {
>> -               r = amdgpu_device_wb_get(adev, &index);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
>> -                       return r;
>> -               }
>> -
>> -               gpu_addr = adev->wb.gpu_addr + (index * 4);
>> -               adev->wb.wb[index] = cpu_to_le32(tmp);
>> +       r = amdgpu_device_wb_get(adev, &index);
>> +       if (r) {
>> +               dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
>> +               return r;
>>         }
>>
>> +       gpu_addr = adev->wb.gpu_addr + (index * 4);
>> +       adev->wb.wb[index] = cpu_to_le32(tmp);
>> +
>>         r = amdgpu_ring_alloc(ring, 5);
>>         if (r) {
>>                 DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
>> -               if (!ring->is_mes_queue)
>> -                       amdgpu_device_wb_free(adev, index);
>> +               amdgpu_device_wb_free(adev, index);
>>                 return r;
>>         }
>>
>> @@ -1004,10 +964,7 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
>>         amdgpu_ring_commit(ring);
>>
>>         for (i = 0; i < adev->usec_timeout; i++) {
>> -               if (ring->is_mes_queue)
>> -                       tmp = le32_to_cpu(*cpu_ptr);
>> -               else
>> -                       tmp = le32_to_cpu(adev->wb.wb[index]);
>> +               tmp = le32_to_cpu(adev->wb.wb[index]);
>>                 if (tmp == 0xDEADBEEF)
>>                         break;
>>                 if (amdgpu_emu_mode == 1)
>> @@ -1019,8 +976,7 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
>>         if (i >= adev->usec_timeout)
>>                 r = -ETIMEDOUT;
>>
>> -       if (!ring->is_mes_queue)
>> -               amdgpu_device_wb_free(adev, index);
>> +       amdgpu_device_wb_free(adev, index);
>>
>>         return r;
>>  }
>> @@ -1043,37 +999,23 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>         long r;
>>         u32 tmp = 0;
>>         u64 gpu_addr;
>> -       volatile uint32_t *cpu_ptr = NULL;
>>
>>         tmp = 0xCAFEDEAD;
>>         memset(&ib, 0, sizeof(ib));
>>
>> -       if (ring->is_mes_queue) {
>> -               uint32_t offset = 0;
>> -               offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
>> -               ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               ib.ptr = (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -
>> -               offset = amdgpu_mes_ctx_get_offs(ring,
>> -                                        AMDGPU_MES_CTX_PADDING_OFFS);
>> -               gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>> -               cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
>> -               *cpu_ptr = tmp;
>> -       } else {
>> -               r = amdgpu_device_wb_get(adev, &index);
>> -               if (r) {
>> -                       dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
>> -                       return r;
>> -               }
>> +       r = amdgpu_device_wb_get(adev, &index);
>> +       if (r) {
>> +               dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
>> +               return r;
>> +       }
>>
>> -               gpu_addr = adev->wb.gpu_addr + (index * 4);
>> -               adev->wb.wb[index] = cpu_to_le32(tmp);
>> +       gpu_addr = adev->wb.gpu_addr + (index * 4);
>> +       adev->wb.wb[index] = cpu_to_le32(tmp);
>>
>> -               r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
>> -               if (r) {
>> -                       DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
>> -                       goto err0;
>> -               }
>> +       r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
>> +       if (r) {
>> +               DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
>> +               goto err0;
>>         }
>>
>>         ib.ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
>> @@ -1101,10 +1043,7 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>                 goto err1;
>>         }
>>
>> -       if (ring->is_mes_queue)
>> -               tmp = le32_to_cpu(*cpu_ptr);
>> -       else
>> -               tmp = le32_to_cpu(adev->wb.wb[index]);
>> +       tmp = le32_to_cpu(adev->wb.wb[index]);
>>
>>         if (tmp == 0xDEADBEEF)
>>                 r = 0;
>> @@ -1115,8 +1054,7 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>>         amdgpu_ib_free(&ib, NULL);
>>         dma_fence_put(f);
>>  err0:
>> -       if (!ring->is_mes_queue)
>> -               amdgpu_device_wb_free(adev, index);
>> +       amdgpu_device_wb_free(adev, index);
>>         return r;
>>  }
>>
>> --
>> 2.48.1
>>

