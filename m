Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240C8C00140
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Aug 2022 16:06:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0D18F743;
	Wed, 10 Aug 2022 16:06:38 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C064C90B54
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 16:06:27 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id z2so19736547edc.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=c8vFkOY1i9NCEYtTa9S6YKJBZGwwpT53y4s3dkVxSyo=;
 b=FAF/dHai8WsbZMQo7x9Xq3OJ94HbuvFBAKsZ9SibILi/XWDv5ADkVT9L3zl/M/TcQ4
 x5owTjFnQESYdvcRbvOaOYD5sj06t6oFY+mH7zfUW6QYJkD0c0ECf9PnYFuFszkJxVt1
 YqcF3BEq9TPLr+jXkV08KvwqpVBoXEsAXofPEVikyrQEqTKdjPgfJgDqswkcYJATeWLb
 JiOkN2kCTSp9QJbzj5mzSGjHGVhCbo0wYe0+3KKHMKmh2BAhG6jxip5IpCwrxtk7DgiN
 SvwB4e2XFmWy1+hfg6QlowATc6yFiJcNqvqdXSljLWGqqDJbOeyL++sdCiH9JJF7ATLd
 7tEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=c8vFkOY1i9NCEYtTa9S6YKJBZGwwpT53y4s3dkVxSyo=;
 b=Wvg1pGmM1yGnmbiU+gx7M9PCS4msJzJCcwJHXo3lTS0PyuxpZuDzzVgXXRFCPL0asA
 /HQrMq9bNo+mNrWZmZ7+vWSOn6bRiu6QUZbuv0NE2IoqrtCXY/tqHTn/n6Dt+xp9IpyQ
 /BqNk5qZnhg3RukDS7Q+C+uQwLyTvMIwR/Gyn22lWLRVGDXFXmGovdY8IRmw4ntMrR/3
 GVZzo+yrras2Fw1Q/pP5ghWXtzBqw5jn+uPKlHa20AZMYgYk9PDpDt3zrZHuctXkOfQ2
 YzGYFVJjjoFSdGV/+sutZKUOCfT+NM34gr2ReVaOxWlzLyvkPfznf3Ds1wzwzMzAmMo1
 y54A==
X-Gm-Message-State: ACgBeo1vMa2eLMiOxARuMWopOGd3qNlHZIMBvJqHILpacMX2k4MqsskO
 D2212nKoMREUlX5nQMteJSOYs4HMgbM=
X-Google-Smtp-Source: AA6agR6slq54ii8sZodClodOsIjrqmrlZvRcVxl/3pAB3kaAyaMKgmbE155/tZtTZamyhzoBnDyDQA==
X-Received: by 2002:a05:6402:2386:b0:43d:a74:cd44 with SMTP id
 j6-20020a056402238600b0043d0a74cd44mr26656166eda.280.1660147585637; 
 Wed, 10 Aug 2022 09:06:25 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:2eb9:26a5:fc9e:fdfc?
 ([2a02:908:1256:79a0:2eb9:26a5:fc9e:fdfc])
 by smtp.gmail.com with ESMTPSA id
 w21-20020a170906131500b0072ab06bf296sm2433063ejb.23.2022.08.10.09.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Aug 2022 09:06:25 -0700 (PDT)
Message-ID: <eea939c0-7cd9-b9ac-5d6d-a3ba3eed8ced@gmail.com>
Date: Wed, 10 Aug 2022 18:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu: modify mcbp implement for gfx9(v2)
Content-Language: en-US
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220809091448.958375-1-jiadong.zhu@amd.com>
 <DS7PR12MB633394912926A7E531FB5D81F4629@DS7PR12MB6333.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DS7PR12MB633394912926A7E531FB5D81F4629@DS7PR12MB6333.namprd12.prod.outlook.com>
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, Jiadong,

first of all your patches have major style issues. Please use the 
checkpatch.pl script before sending those out.

Apart from that as discussed on our call on Monday MCBP is not something 
we will implement on Linux. So we will probably remove the existing 
debugfs test sooner or later.

Regards,
Christian.

Am 09.08.22 um 11:21 schrieb Zhu, Jiadong:
> [AMD Official Use Only - General]
>
> Hi,
>
> This patch is to correct the mcbp package for gfx9, which is the basic function used for debugfs.
> There are no logic about when to trigger mcbp.
> Shall we get this reviewed?
>
> Thanks,
> Jiadong
>
> -----Original Message-----
> From: Zhu, Jiadong <Jiadong.Zhu@amd.com>
> Sent: Tuesday, August 9, 2022 5:15 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, Aaron <Aaron.Liu@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: modify mcbp implement for gfx9(v2)
>
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>
> 1. Use unmap_queue package to trigger preemption on gfx9
>     Add trailing fence to track the preemption done.
> 2. Modify emit_ce_meta emit_de_meta functions
>     for the resumed ibs.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 159 ++++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/soc15d.h      |   2 +
>   3 files changed, 141 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 82c178a9033a..ca626f0ad7b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -59,6 +59,7 @@ enum amdgpu_ring_priority_level {
>   #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
>   #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
>   #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
> +#define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)
>
>   #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 5332899642dc..0b7cb4cf13c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -751,7 +751,7 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);  static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
>                                  struct amdgpu_cu_info *cu_info);
>   static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev); -static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
> +static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool
> +resume);
>   static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);  static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
>                                            void *ras_error_status);
> @@ -824,9 +824,10 @@ static void gfx_v9_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
>                          PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbell_index));
>
>          if (action == PREEMPT_QUEUES_NO_UNMAP) {
> -               amdgpu_ring_write(kiq_ring, lower_32_bits(gpu_addr));
> -               amdgpu_ring_write(kiq_ring, upper_32_bits(gpu_addr));
> -               amdgpu_ring_write(kiq_ring, seq);
> +               amdgpu_ring_write(kiq_ring, lower_32_bits(ring->wptr & ring->buf_mask));
> +               amdgpu_ring_write(kiq_ring, 0);
> +               amdgpu_ring_write(kiq_ring, 0);
> +
>          } else {
>                  amdgpu_ring_write(kiq_ring, 0);
>                  amdgpu_ring_write(kiq_ring, 0);
> @@ -5446,11 +5447,15 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>
>          control |= ib->length_dw | (vmid << 24);
>
> -       if (amdgpu_sriov_vf(ring->adev) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
> +       if ((amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp) && (ib->flags &
> +AMDGPU_IB_FLAG_PREEMPT)) {
>                  control |= INDIRECT_BUFFER_PRE_ENB(1);
>
> +               if (flags & AMDGPU_IB_PREEMPTED)
> +                       control |= INDIRECT_BUFFER_PRE_RESUME(1);
> +
>                  if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)
> -                       gfx_v9_0_ring_emit_de_meta(ring);
> +                       gfx_v9_0_ring_emit_de_meta(ring,
> +                                (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ?
> +true : false);
>          }
>
>          amdgpu_ring_write(ring, header);
> @@ -5505,6 +5510,7 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>          bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
>          bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
>          bool writeback = flags & AMDGPU_FENCE_FLAG_TC_WB_ONLY;
> +       bool exec = flags & AMDGPU_FENCE_FLAG_EXEC;
>
>          /* RELEASE_MEM - flush caches, send int */
>          amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6)); @@ -5515,6 +5521,7 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>                                                 EOP_TC_WB_ACTION_EN |
>                                                 EOP_TC_MD_ACTION_EN)) |
>                                   EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
> +                                (exec ? EOP_EXEC : 0x0) |
>                                   EVENT_INDEX(5)));
>          amdgpu_ring_write(ring, DATA_SEL(write64bit ? 2 : 1) | INT_SEL(int_sel ? 2 : 0));
>
> @@ -5620,33 +5627,135 @@ static void gfx_v9_ring_emit_sb(struct amdgpu_ring *ring)
>          amdgpu_ring_write(ring, 0);
>   }
>
> -static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring)
> +static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool
> +resume)
>   {
> +       struct amdgpu_device *adev = ring->adev;
>          struct v9_ce_ib_state ce_payload = {0};
> -       uint64_t csa_addr;
> +       uint64_t offset, ce_payload_gpu_addr;
> +       void *ce_payload_cpu_addr;
>          int cnt;
>
>          cnt = (sizeof(ce_payload) >> 2) + 4 - 2;
> -       csa_addr = amdgpu_csa_vaddr(ring->adev);
> +
> +       if (ring->is_mes_queue) {
> +               offset = offsetof(struct amdgpu_mes_ctx_meta_data,
> +                                 gfx[0].gfx_meta_data) +
> +                       offsetof(struct v9_gfx_meta_data, ce_payload);
> +               ce_payload_gpu_addr =
> +                       amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +               ce_payload_cpu_addr =
> +                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +       } else {
> +               offset = offsetof(struct v9_gfx_meta_data, ce_payload);
> +               ce_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
> +               ce_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
> +       }
>
>          amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
>          amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(2) |
>                                   WRITE_DATA_DST_SEL(8) |
>                                   WR_CONFIRM) |
>                                   WRITE_DATA_CACHE_POLICY(0));
> -       amdgpu_ring_write(ring, lower_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, ce_payload)));
> -       amdgpu_ring_write(ring, upper_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, ce_payload)));
> -       amdgpu_ring_write_multiple(ring, (void *)&ce_payload, sizeof(ce_payload) >> 2);
> +       amdgpu_ring_write(ring, lower_32_bits(ce_payload_gpu_addr));
> +       amdgpu_ring_write(ring, upper_32_bits(ce_payload_gpu_addr));
> +
> +       if (resume)
> +               amdgpu_ring_write_multiple(ring, ce_payload_cpu_addr,
> +                                          sizeof(ce_payload) >> 2);
> +       else
> +               amdgpu_ring_write_multiple(ring, (void *)&ce_payload,
> +                                          sizeof(ce_payload) >> 2);
> +}
> +
> +static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring) {
> +       int i, r = 0;
> +       struct amdgpu_device *adev = ring->adev;
> +       struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> +       struct amdgpu_ring *kiq_ring = &kiq->ring;
> +       unsigned long flags;
> +
> +       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> +               return -EINVAL;
> +
> +       spin_lock_irqsave(&kiq->ring_lock, flags);
> +
> +       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> +               spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +               return -ENOMEM;
> +       }
> +
> +       /* assert preemption condition */
> +       amdgpu_ring_set_preempt_cond_exec(ring, false);
> +
> +       ring->trail_seq += 1;
> +       amdgpu_ring_alloc(ring, 13);
> +       gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> +                                 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC);
> +       /*reset the CP_VMID_PREEMPT after trailing fence*/
> +       amdgpu_ring_emit_wreg(ring,
> +                                 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),
> +                                 0x0);
> +
> +       /* assert IB preemption, emit the trailing fence */
> +       kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
> +                                  ring->trail_fence_gpu_addr,
> +                                  ring->trail_seq);
> +
> +       amdgpu_ring_commit(kiq_ring);
> +       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +
> +       /* poll the trailing fence */
> +       for (i = 0; i < adev->usec_timeout; i++) {
> +               if (ring->trail_seq ==
> +                   le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> +                       break;
> +               udelay(1);
> +       }
> +
> +       if (i >= adev->usec_timeout) {
> +               r = -EINVAL;
> +               DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> +       }
> +
> +       amdgpu_ring_commit(ring);
> +
> +       /* deassert preemption condition */
> +       amdgpu_ring_set_preempt_cond_exec(ring, true);
> +       return r;
>   }
>
> -static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
> +static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool
> +resume)
>   {
> +       struct amdgpu_device *adev = ring->adev;
>          struct v9_de_ib_state de_payload = {0};
> -       uint64_t csa_addr, gds_addr;
> +       uint64_t offset, gds_addr, de_payload_gpu_addr;
> +       void *de_payload_cpu_addr;
>          int cnt;
>
> -       csa_addr = amdgpu_csa_vaddr(ring->adev);
> -       gds_addr = csa_addr + 4096;
> +       if (ring->is_mes_queue) {
> +               offset = offsetof(struct amdgpu_mes_ctx_meta_data,
> +                                 gfx[0].gfx_meta_data) +
> +                       offsetof(struct v9_gfx_meta_data, de_payload);
> +               de_payload_gpu_addr =
> +                       amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +               de_payload_cpu_addr =
> +                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +
> +               offset = offsetof(struct amdgpu_mes_ctx_meta_data,
> +                                 gfx[0].gds_backup) +
> +                       offsetof(struct v9_gfx_meta_data, de_payload);
> +               gds_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +       } else {
> +               offset = offsetof(struct v9_gfx_meta_data, de_payload);
> +               de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
> +               de_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
> +
> +               gds_addr = ALIGN(amdgpu_csa_vaddr(ring->adev) +
> +                                AMDGPU_CSA_SIZE - adev->gds.gds_size,
> +                                PAGE_SIZE);
> +       }
> +
>          de_payload.gds_backup_addrlo = lower_32_bits(gds_addr);
>          de_payload.gds_backup_addrhi = upper_32_bits(gds_addr);
>
> @@ -5656,9 +5765,15 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
>                                   WRITE_DATA_DST_SEL(8) |
>                                   WR_CONFIRM) |
>                                   WRITE_DATA_CACHE_POLICY(0));
> -       amdgpu_ring_write(ring, lower_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, de_payload)));
> -       amdgpu_ring_write(ring, upper_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, de_payload)));
> -       amdgpu_ring_write_multiple(ring, (void *)&de_payload, sizeof(de_payload) >> 2);
> +       amdgpu_ring_write(ring, lower_32_bits(de_payload_gpu_addr));
> +       amdgpu_ring_write(ring, upper_32_bits(de_payload_gpu_addr));
> +
> +       if (resume)
> +               amdgpu_ring_write_multiple(ring, de_payload_cpu_addr,
> +                                          sizeof(de_payload) >> 2);
> +       else
> +               amdgpu_ring_write_multiple(ring, (void *)&de_payload,
> +                                          sizeof(de_payload) >> 2);
>   }
>
>   static void gfx_v9_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start, @@ -5674,8 +5789,9 @@ static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)  {
>          uint32_t dw2 = 0;
>
> -       if (amdgpu_sriov_vf(ring->adev))
> -               gfx_v9_0_ring_emit_ce_meta(ring);
> +       if (amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp)
> +               gfx_v9_0_ring_emit_ce_meta(ring,
> +                                   (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ?
> +true : false);
>
>          dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
>          if (flags & AMDGPU_HAVE_CTX_SWITCH) {
> @@ -7024,6 +7140,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>          .emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
>          .init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
>          .patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
> +       .preempt_ib = gfx_v9_0_ring_preempt_ib,
>          .emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
>          .emit_wreg = gfx_v9_0_ring_emit_wreg,
>          .emit_reg_wait = gfx_v9_0_ring_emit_reg_wait, diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> index 799925d22fc8..614e9f8467fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> @@ -162,6 +162,7 @@
>                   * 2 - Bypass
>                   */
>   #define     INDIRECT_BUFFER_PRE_ENB(x)          ((x) << 21)
> +#define     INDIRECT_BUFFER_PRE_RESUME(x)           ((x) << 30)
>   #define        PACKET3_COPY_DATA                               0x40
>   #define        PACKET3_PFP_SYNC_ME                             0x42
>   #define        PACKET3_COND_WRITE                              0x45
> @@ -184,6 +185,7 @@
>   #define                EOP_TC_ACTION_EN                        (1 << 17) /* L2 */
>   #define                EOP_TC_NC_ACTION_EN                     (1 << 19)
>   #define                EOP_TC_MD_ACTION_EN                     (1 << 21) /* L2 metadata */
> +#define                EOP_EXEC                                        (1 << 28) /* For Trailing Fence */
>
>   #define                DATA_SEL(x)                             ((x) << 29)
>                  /* 0 - discard
> --
> 2.25.1
>

