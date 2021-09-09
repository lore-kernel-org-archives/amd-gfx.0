Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967B9C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 08:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4660061139
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 08:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4660061139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFDEF6E4A2;
	Thu,  9 Sep 2021 08:34:27 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A90246E4A2
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 08:34:25 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id u9so1330468wrg.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Sep 2021 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=2xvZmtCpUSpDvWhhhoz8pQeSgMqbE2DyHPAEjdelCko=;
 b=Jvao0rcCZq7F53y4kgFHofbacK32vnFGJ/0Uw2VAF89wnYwUyQcGYwDITj+o4PQtMU
 bvBO992FD61VzJMXEWvTPP13brk66dOGE+TBpne0c47FKCOgyUeXvuX7reNtxA4DU32P
 ZAUjSREVs5T+l+UzbxD4ShpvJvACGl/n16rC6jHtqLbehKuk+cW+S16Mnlu1W8mFBjLl
 Vim0y8rjAD/Fi6YHw0PGn6hOzKq0Sf2U2J7i2ey9XjdcKbOXP+Ay3hMyWVLdhuVfL26q
 tnr+mVM7N+zS/fUa3aNCSSIFMinD8BYjVbq7CIL+gULxSpEvuyhUYmxM7rry+xVmNXuX
 I8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=2xvZmtCpUSpDvWhhhoz8pQeSgMqbE2DyHPAEjdelCko=;
 b=XAyHJ8XF9FoEGHr2MT4ZB8RqkLTgXwDDadg7UTxLM9r/GNIyaxrA+BreemIoUUW2zP
 GgUwklZik69GSfz8Q8UEKgBeoqf1z8Y/nMg/MFeGEM5n8Osw7V656/3Jqwqt0J0x2RtN
 Ts6yxeoLKXgAueCH7HXJYT5VIlKce0iQLjtzQnFfclzSSDxSMQ56Z/R3vmkdPMPgwer8
 OigiGWrHsDWwasOXVCGMGc2SVQnzM8YRW9hHdLbud9ld+D217cYcErrxvMjorohmw5nz
 YbW6iK+KxnEkV1ujEIq3NQUNWJzlVGAKUgvOUCUV0BLxrfeuImBeLXxOpsPXPHyCjwif
 +39w==
X-Gm-Message-State: AOAM530BUDCzAkDhhtKhQoJeUigQE0t9wImdR49w60D79ROlc9ktASZg
 kLSMXi4A5Id8LEAfgxemCJIIfUZrrVM=
X-Google-Smtp-Source: ABdhPJyXSzCmlkvCieQ9STdLn4mzr3jvZkf2se6pL62HcednF2km80kuytCzZhfEHUb3JGKMr/8FLA==
X-Received: by 2002:adf:b7cd:: with SMTP id t13mr2101229wre.63.1631176464134; 
 Thu, 09 Sep 2021 01:34:24 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7140:364b:3af8:f004?
 ([2a02:908:1252:fb60:7140:364b:3af8:f004])
 by smtp.gmail.com with ESMTPSA id n18sm894349wmc.22.2021.09.09.01.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Sep 2021 01:34:23 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdgpu: alloc IB extra msg from IB pool
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <DM4PR12MB5165E6211939B36FD10BF65C87D59@DM4PR12MB5165.namprd12.prod.outlook.com>
 <33e834d0-b1d7-16ed-4be4-ec6dd485b5a0@amd.com>
 <DM4PR12MB5165F781E6DA18852A01640C87D59@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <646f114d-12f1-6c6a-d12a-39a68fe47386@gmail.com>
Date: Thu, 9 Sep 2021 10:34:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <DM4PR12MB5165F781E6DA18852A01640C87D59@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="------------0DD8ACDA7FBD39DECFC8E9CD"
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

This is a multi-part message in MIME format.
--------------0DD8ACDA7FBD39DECFC8E9CD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, correct but the key point is I want the same handling for old and 
new UVD blocks to be the same.

This makes it more likely that the code keeps working on all hardware 
generations when we change something.

See those old hardware is rare to get these days and I don't want to 
risk any bug report from end users when we didn't tested that well on 
SI/CIK.

Christian.

Am 09.09.21 um 10:11 schrieb Pan, Xinhui:
>
> [AMD Official Use Only]
>
>
> well, If IB test fails because we use gtt domain or
> the above 256MB vram. Then the failure is expected.
> Doesn't IB test exist to detect such issue?
>
> ------------------------------------------------------------------------
> *发件人:* Koenig, Christian <Christian.Koenig@amd.com>
> *发送时间:* 2021年9月9日星期四 15:16
> *收件人:* Pan, Xinhui; amd-gfx@lists.freedesktop.org
> *抄送:* Deucher, Alexander
> *主题:* Re: [PATCH 2/2] drm/amdgpu: alloc IB extra msg from IB pool
>
> Am 09.09.21 um 07:55 schrieb Pan, Xinhui:
> > [AMD Official Use Only]
> >
> > There is one dedicated IB pool for IB test. So lets use it for extra msg
> > too.
> >
> > For UVD on older HW, use one reserved BO at specific range.
> >
> > Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 173 +++++++++++++++---------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |   1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c |  18 +--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  99 ++++++--------
> >   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |  28 ++--
> >   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |  28 ++--
> >   6 files changed, 185 insertions(+), 162 deletions(-)
>
> Please split that up into one patch for UVD, one for VCE and a third for
> VCN.
>
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> > index d451c359606a..733cfc848c6c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> > @@ -299,8 +299,36 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
> >          }
> >
> >          /* from uvd v5.0 HW addressing capacity increased to 64 bits */
> > -       if (!amdgpu_device_ip_block_version_cmp(adev, 
> AMD_IP_BLOCK_TYPE_UVD, 5, 0))
> > +       if (!amdgpu_device_ip_block_version_cmp(adev, 
> AMD_IP_BLOCK_TYPE_UVD, 5, 0)) {
> >                  adev->uvd.address_64_bit = true;
>
> Yeah, that's exactly what I'm trying to avoid.
>
> We should use the BO approach both for old and new UVD blocks, just
> making sure that we place it correctly for the old ones.
>
> This way we have much lower chance of breaking the old stuff.
>
> Thanks,
> Christian.
>
> > +       } else {
> > +               struct amdgpu_bo *bo = NULL;
> > +               void *addr;
> > +
> > +               r = amdgpu_bo_create_reserved(adev, PAGE_SIZE, 
> PAGE_SIZE,
> > + AMDGPU_GEM_DOMAIN_VRAM,
> > +                               &bo, NULL, &addr);
> > +               if (r)
> > +                       return r;
> > +               amdgpu_bo_kunmap(bo);
> > +               amdgpu_bo_unpin(bo);
> > +               r = amdgpu_bo_pin_restricted(bo, AMDGPU_GEM_DOMAIN_VRAM,
> > +                               0, 256 << 20);
> > +               if (r) {
> > +                       amdgpu_bo_unreserve(bo);
> > +                       amdgpu_bo_unref(&bo);
> > +                       return r;
> > +               }
> > +               r = amdgpu_bo_kmap(bo, &addr);
> > +               if (r) {
> > +                       amdgpu_bo_unpin(bo);
> > +                       amdgpu_bo_unreserve(bo);
> > +                       amdgpu_bo_unref(&bo);
> > +                       return r;
> > +               }
> > +               adev->uvd.ib_bo = bo;
> > +               amdgpu_bo_unreserve(bo);
> > +       }
> >
> >          switch (adev->asic_type) {
> >          case CHIP_TONGA:
> > @@ -342,6 +370,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
> >                  for (i = 0; i < AMDGPU_MAX_UVD_ENC_RINGS; ++i)
> > amdgpu_ring_fini(&adev->uvd.inst[j].ring_enc[i]);
> >          }
> > + amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL, NULL);
> >          release_firmware(adev->uvd.fw);
> >
> >          return 0;
> > @@ -1066,7 +1095,7 @@ int amdgpu_uvd_ring_parse_cs(struct 
> amdgpu_cs_parser *parser, uint32_t ib_idx)
> >          return 0;
> >   }
> >
> > -static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct 
> amdgpu_bo *bo,
> > +static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, uint64_t addr,
> >                                 bool direct, struct dma_fence **fence)
> >   {
> >          struct amdgpu_device *adev = ring->adev;
> > @@ -1074,29 +1103,15 @@ static int amdgpu_uvd_send_msg(struct 
> amdgpu_ring *ring, struct amdgpu_bo *bo,
> >          struct amdgpu_job *job;
> >          struct amdgpu_ib *ib;
> >          uint32_t data[4];
> > -       uint64_t addr;
> >          long r;
> >          int i;
> >          unsigned offset_idx = 0;
> >          unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
> >
> > -       amdgpu_bo_kunmap(bo);
> > -       amdgpu_bo_unpin(bo);
> > -
> > -       if (!ring->adev->uvd.address_64_bit) {
> > -               struct ttm_operation_ctx ctx = { true, false };
> > -
> > -               amdgpu_bo_placement_from_domain(bo, 
> AMDGPU_GEM_DOMAIN_VRAM);
> > - amdgpu_uvd_force_into_uvd_segment(bo);
> > -               r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> > -               if (r)
> > -                       goto err;
> > -       }
> > -
> >          r = amdgpu_job_alloc_with_ib(adev, 64, direct ? 
> AMDGPU_IB_POOL_DIRECT :
> > AMDGPU_IB_POOL_DELAYED, &job);
> >          if (r)
> > -               goto err;
> > +               return r;
> >
> >          if (adev->asic_type >= CHIP_VEGA10) {
> >                  offset_idx = 1 + ring->me;
> > @@ -1110,7 +1125,6 @@ static int amdgpu_uvd_send_msg(struct 
> amdgpu_ring *ring, struct amdgpu_bo *bo,
> >          data[3] = PACKET0(offset[offset_idx] + UVD_NO_OP, 0);
> >
> >          ib = &job->ibs[0];
> > -       addr = amdgpu_bo_gpu_offset(bo);
> >          ib->ptr[0] = data[0];
> >          ib->ptr[1] = addr;
> >          ib->ptr[2] = data[1];
> > @@ -1123,33 +1137,13 @@ static int amdgpu_uvd_send_msg(struct 
> amdgpu_ring *ring, struct amdgpu_bo *bo,
> >          }
> >          ib->length_dw = 16;
> >
> > -       if (direct) {
> > -               r = dma_resv_wait_timeout(bo->tbo.base.resv, true, 
> false,
> > - msecs_to_jiffies(10));
> > -               if (r == 0)
> > -                       r = -ETIMEDOUT;
> > -               if (r < 0)
> > -                       goto err_free;
> > -
> > +       if (direct)
> >                  r = amdgpu_job_submit_direct(job, ring, &f);
> > -               if (r)
> > -                       goto err_free;
> > -       } else {
> > -               r = amdgpu_sync_resv(adev, &job->sync, 
> bo->tbo.base.resv,
> > - AMDGPU_SYNC_ALWAYS,
> > - AMDGPU_FENCE_OWNER_UNDEFINED);
> > -               if (r)
> > -                       goto err_free;
> > -
> > +       else
> >                  r = amdgpu_job_submit(job, &adev->uvd.entity,
> > - AMDGPU_FENCE_OWNER_UNDEFINED, &f);
> > -               if (r)
> > -                       goto err_free;
> > -       }
> > -
> > -       amdgpu_bo_fence(bo, f, false);
> > -       amdgpu_bo_unreserve(bo);
> > -       amdgpu_bo_unref(&bo);
> > + AMDGPU_FENCE_OWNER_UNDEFINED, &f);
> > +       if (r)
> > +               goto err_free;
> >
> >          if (fence)
> >                  *fence = dma_fence_get(f);
> > @@ -1159,10 +1153,6 @@ static int amdgpu_uvd_send_msg(struct 
> amdgpu_ring *ring, struct amdgpu_bo *bo,
> >
> >   err_free:
> >          amdgpu_job_free(job);
> > -
> > -err:
> > -       amdgpu_bo_unreserve(bo);
> > -       amdgpu_bo_unref(&bo);
> >          return r;
> >   }
> >
> > @@ -1173,16 +1163,31 @@ int amdgpu_uvd_get_create_msg(struct 
> amdgpu_ring *ring, uint32_t handle,
> >                                struct dma_fence **fence)
> >   {
> >          struct amdgpu_device *adev = ring->adev;
> > -       struct amdgpu_bo *bo = NULL;
> > +       struct amdgpu_bo *bo = adev->uvd.ib_bo;
> > +       struct dma_fence *f = NULL;
> > +       struct amdgpu_ib ib;
> >          uint32_t *msg;
> >          int r, i;
> >
> > -       r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> > - AMDGPU_GEM_DOMAIN_GTT,
> > -                                     &bo, NULL, (void **)&msg);
> > -       if (r)
> > -               return r;
> > -
> > +       if (bo) {
> > +               r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
> > +               if (r)
> > +                       return r;
> > +               r = dma_resv_wait_timeout(bo->tbo.base.resv, true, 
> false,
> > + msecs_to_jiffies(10));
> > +               if (r == 0)
> > +                       r = -ETIMEDOUT;
> > +               if (r < 0)
> > +                       goto err;
> > +               ib.gpu_addr = amdgpu_bo_gpu_offset(bo);
> > +               msg = amdgpu_bo_kptr(bo);
> > +       } else {
> > +               memset(&ib, 0, sizeof(ib));
> > +               r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
> > + AMDGPU_IB_POOL_DIRECT,
> > +                               &ib);
> > +               msg = ib.ptr;
> > +       }
> >          /* stitch together an UVD create msg */
> >          msg[0] = cpu_to_le32(0x00000de4);
> >          msg[1] = cpu_to_le32(0x00000000);
> > @@ -1198,23 +1203,52 @@ int amdgpu_uvd_get_create_msg(struct 
> amdgpu_ring *ring, uint32_t handle,
> >          for (i = 11; i < 1024; ++i)
> >                  msg[i] = cpu_to_le32(0x0);
> >
> > -       return amdgpu_uvd_send_msg(ring, bo, true, fence);
> > +       r = amdgpu_uvd_send_msg(ring, ib.gpu_addr, true, &f);
> > +       if (r)
> > +               goto err;
> > +       if (bo)
> > +               amdgpu_bo_fence(bo, f, false);
> > +       if (fence)
> > +               *fence = dma_fence_get(f);
> > +err:
> > +       if (bo)
> > +               amdgpu_bo_unreserve(bo);
> > +       else
> > +               amdgpu_ib_free(adev, &ib, f);
> > +       dma_fence_put(f);
> > +       return r;
> >   }
> >
> >   int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t 
> handle,
> >                                 bool direct, struct dma_fence **fence)
> >   {
> >          struct amdgpu_device *adev = ring->adev;
> > -       struct amdgpu_bo *bo = NULL;
> > +       struct amdgpu_bo *bo = adev->uvd.ib_bo;
> > +       struct dma_fence *f = NULL;
> > +       struct amdgpu_ib ib;
> >          uint32_t *msg;
> >          int r, i;
> >
> > -       r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> > - AMDGPU_GEM_DOMAIN_GTT,
> > -                                     &bo, NULL, (void **)&msg);
> > -       if (r)
> > -               return r;
> > -
> > +       if (bo) {
> > +               r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
> > +               if (r)
> > +                       return r;
> > +               r = dma_resv_wait_timeout(bo->tbo.base.resv, true, 
> false,
> > + msecs_to_jiffies(10));
> > +               if (r == 0)
> > +                       r = -ETIMEDOUT;
> > +               if (r < 0)
> > +                       goto err;
> > +               ib.gpu_addr = amdgpu_bo_gpu_offset(bo);
> > +               msg = amdgpu_bo_kptr(bo);
> > +       } else {
> > +               memset(&ib, 0, sizeof(ib));
> > +               r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
> > +                               direct ?
> > + AMDGPU_IB_POOL_DIRECT : AMDGPU_IB_POOL_DELAYED,
> > +                               &ib);
> > +               msg = ib.ptr;
> > +       }
> >          /* stitch together an UVD destroy msg */
> >          msg[0] = cpu_to_le32(0x00000de4);
> >          msg[1] = cpu_to_le32(0x00000002);
> > @@ -1223,7 +1257,20 @@ int amdgpu_uvd_get_destroy_msg(struct 
> amdgpu_ring *ring, uint32_t handle,
> >          for (i = 4; i < 1024; ++i)
> >                  msg[i] = cpu_to_le32(0x0);
> >
> > -       return amdgpu_uvd_send_msg(ring, bo, direct, fence);
> > +       r = amdgpu_uvd_send_msg(ring, ib.gpu_addr, true, &f);
> > +       if (r)
> > +               goto err;
> > +       if (bo)
> > +               amdgpu_bo_fence(bo, f, false);
> > +       if (fence)
> > +               *fence = dma_fence_get(f);
> > +err:
> > +       if (bo)
> > +               amdgpu_bo_unreserve(bo);
> > +       else
> > +               amdgpu_ib_free(adev, &ib, f);
> > +       dma_fence_put(f);
> > +       return r;
> >   }
> >
> >   static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> > index edbb8194ee81..76ac9699885d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> > @@ -68,6 +68,7 @@ struct amdgpu_uvd {
> >          /* store image width to adjust nb memory state */
> >          unsigned decode_image_width;
> >          uint32_t                keyselect;
> > +       struct amdgpu_bo        *ib_bo;
> >   };
> >
> >   int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > index e9fdf49d69e8..45d98694db18 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > @@ -82,7 +82,6 @@ MODULE_FIRMWARE(FIRMWARE_VEGA20);
> >
> >   static void amdgpu_vce_idle_work_handler(struct work_struct *work);
> >   static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, 
> uint32_t handle,
> > -                                    struct amdgpu_bo *bo,
> >                                       struct dma_fence **fence);
> >   static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, 
> uint32_t handle,
> >                                        bool direct, struct dma_fence 
> **fence);
> > @@ -441,7 +440,6 @@ void amdgpu_vce_free_handles(struct 
> amdgpu_device *adev, struct drm_file *filp)
> >    * Open up a stream for HW test
> >    */
> >   static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, 
> uint32_t handle,
> > -                                    struct amdgpu_bo *bo,
> >                                       struct dma_fence **fence)
> >   {
> >          const unsigned ib_size_dw = 1024;
> > @@ -451,14 +449,13 @@ static int amdgpu_vce_get_create_msg(struct 
> amdgpu_ring *ring, uint32_t handle,
> >          uint64_t addr;
> >          int i, r;
> >
> > -       r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
> > +       r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4 + 
> PAGE_SIZE,
> > AMDGPU_IB_POOL_DIRECT, &job);
> >          if (r)
> >                  return r;
> >
> >          ib = &job->ibs[0];
> > -
> > -       addr = amdgpu_bo_gpu_offset(bo);
> > +       addr = ib->gpu_addr + ib_size_dw * 4;
> >
> >          /* stitch together an VCE create msg */
> >          ib->length_dw = 0;
> > @@ -1134,20 +1131,13 @@ int amdgpu_vce_ring_test_ring(struct 
> amdgpu_ring *ring)
> >   int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
> >   {
> >          struct dma_fence *fence = NULL;
> > -       struct amdgpu_bo *bo = NULL;
> >          long r;
> >
> >          /* skip vce ring1/2 ib test for now, since it's not reliable */
> >          if (ring != &ring->adev->vce.ring[0])
> >                  return 0;
> >
> > -       r = amdgpu_bo_create_reserved(ring->adev, 512, PAGE_SIZE,
> > - AMDGPU_GEM_DOMAIN_VRAM,
> > -                                     &bo, NULL, NULL);
> > -       if (r)
> > -               return r;
> > -
> > -       r = amdgpu_vce_get_create_msg(ring, 1, bo, NULL);
> > +       r = amdgpu_vce_get_create_msg(ring, 1, NULL);
> >          if (r)
> >                  goto error;
> >
> > @@ -1163,8 +1153,6 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring 
> *ring, long timeout)
> >
> >   error:
> >          dma_fence_put(fence);
> > -       amdgpu_bo_unreserve(bo);
> > -       amdgpu_bo_free_kernel(&bo, NULL, NULL);
> >          return r;
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > index 561296a85b43..b60d5f01fdae 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > @@ -541,15 +541,14 @@ int amdgpu_vcn_dec_sw_ring_test_ring(struct 
> amdgpu_ring *ring)
> >   }
> >
> >   static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
> > -                                  struct amdgpu_bo *bo,
> > -                                  struct dma_fence **fence)
> > +               struct amdgpu_ib *ib_msg,
> > +               struct dma_fence **fence)
> >   {
> >          struct amdgpu_device *adev = ring->adev;
> >          struct dma_fence *f = NULL;
> >          struct amdgpu_job *job;
> >          struct amdgpu_ib *ib;
> > -       uint64_t addr;
> > -       void *msg = NULL;
> > +       uint64_t addr = ib_msg->gpu_addr;
> >          int i, r;
> >
> >          r = amdgpu_job_alloc_with_ib(adev, 64,
> > @@ -558,8 +557,6 @@ static int amdgpu_vcn_dec_send_msg(struct 
> amdgpu_ring *ring,
> >                  goto err;
> >
> >          ib = &job->ibs[0];
> > -       addr = amdgpu_bo_gpu_offset(bo);
> > -       msg = amdgpu_bo_kptr(bo);
> >          ib->ptr[0] = PACKET0(adev->vcn.internal.data0, 0);
> >          ib->ptr[1] = addr;
> >          ib->ptr[2] = PACKET0(adev->vcn.internal.data1, 0);
> > @@ -576,9 +573,7 @@ static int amdgpu_vcn_dec_send_msg(struct 
> amdgpu_ring *ring,
> >          if (r)
> >                  goto err_free;
> >
> > -       amdgpu_bo_fence(bo, f, false);
> > -       amdgpu_bo_unreserve(bo);
> > -       amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
> > +       amdgpu_ib_free(adev, ib_msg, f);
> >
> >          if (fence)
> >                  *fence = dma_fence_get(f);
> > @@ -588,27 +583,26 @@ static int amdgpu_vcn_dec_send_msg(struct 
> amdgpu_ring *ring,
> >
> >   err_free:
> >          amdgpu_job_free(job);
> > -
> >   err:
> > -       amdgpu_bo_unreserve(bo);
> > -       amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
> > +       amdgpu_ib_free(adev, ib_msg, f);
> >          return r;
> >   }
> >
> >   static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, 
> uint32_t handle,
> > -                                        struct amdgpu_bo **bo)
> > +               struct amdgpu_ib *ib)
> >   {
> >          struct amdgpu_device *adev = ring->adev;
> >          uint32_t *msg;
> >          int r, i;
> >
> > -       *bo = NULL;
> > -       r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> > - AMDGPU_GEM_DOMAIN_VRAM,
> > -                                     bo, NULL, (void **)&msg);
> > +       memset(ib, 0, sizeof(*ib));
> > +       r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
> > +                       AMDGPU_IB_POOL_DIRECT,
> > +                       ib);
> >          if (r)
> >                  return r;
> >
> > +       msg = ib->ptr;
> >          msg[0] = cpu_to_le32(0x00000028);
> >          msg[1] = cpu_to_le32(0x00000038);
> >          msg[2] = cpu_to_le32(0x00000001);
> > @@ -630,19 +624,20 @@ static int 
> amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
> >   }
> >
> >   static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring 
> *ring, uint32_t handle,
> > -                                         struct amdgpu_bo **bo)
> > +                                         struct amdgpu_ib *ib)
> >   {
> >          struct amdgpu_device *adev = ring->adev;
> >          uint32_t *msg;
> >          int r, i;
> >
> > -       *bo = NULL;
> > -       r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> > - AMDGPU_GEM_DOMAIN_VRAM,
> > -                                     bo, NULL, (void **)&msg);
> > +       memset(ib, 0, sizeof(*ib));
> > +       r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
> > +                       AMDGPU_IB_POOL_DIRECT,
> > +                       ib);
> >          if (r)
> >                  return r;
> >
> > +       msg = ib->ptr;
> >          msg[0] = cpu_to_le32(0x00000028);
> >          msg[1] = cpu_to_le32(0x00000018);
> >          msg[2] = cpu_to_le32(0x00000000);
> > @@ -658,21 +653,21 @@ static int 
> amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
> >   int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long 
> timeout)
> >   {
> >          struct dma_fence *fence = NULL;
> > -       struct amdgpu_bo *bo;
> > +       struct amdgpu_ib ib;
> >          long r;
> >
> > -       r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
> > +       r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
> >          if (r)
> >                  goto error;
> >
> > -       r = amdgpu_vcn_dec_send_msg(ring, bo, NULL);
> > +       r = amdgpu_vcn_dec_send_msg(ring, &ib, NULL);
> >          if (r)
> >                  goto error;
> > -       r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &bo);
> > +       r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &ib);
> >          if (r)
> >                  goto error;
> >
> > -       r = amdgpu_vcn_dec_send_msg(ring, bo, &fence);
> > +       r = amdgpu_vcn_dec_send_msg(ring, &ib, &fence);
> >          if (r)
> >                  goto error;
> >
> > @@ -688,8 +683,8 @@ int amdgpu_vcn_dec_ring_test_ib(struct 
> amdgpu_ring *ring, long timeout)
> >   }
> >
> >   static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
> > -                                  struct amdgpu_bo *bo,
> > -                                  struct dma_fence **fence)
> > +               struct amdgpu_ib *ib_msg,
> > +               struct dma_fence **fence)
> >   {
> >          struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
> >          const unsigned int ib_size_dw = 64;
> > @@ -697,7 +692,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct 
> amdgpu_ring *ring,
> >          struct dma_fence *f = NULL;
> >          struct amdgpu_job *job;
> >          struct amdgpu_ib *ib;
> > -       uint64_t addr;
> > +       uint64_t addr = ib_msg->gpu_addr;
> >          int i, r;
> >
> >          r = amdgpu_job_alloc_with_ib(adev, ib_size_dw * 4,
> > @@ -706,7 +701,6 @@ static int amdgpu_vcn_dec_sw_send_msg(struct 
> amdgpu_ring *ring,
> >                  goto err;
> >
> >          ib = &job->ibs[0];
> > -       addr = amdgpu_bo_gpu_offset(bo);
> >          ib->length_dw = 0;
> >
> >          ib->ptr[ib->length_dw++] = sizeof(struct 
> amdgpu_vcn_decode_buffer) + 8;
> > @@ -726,9 +720,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct 
> amdgpu_ring *ring,
> >          if (r)
> >                  goto err_free;
> >
> > -       amdgpu_bo_fence(bo, f, false);
> > -       amdgpu_bo_unreserve(bo);
> > -       amdgpu_bo_unref(&bo);
> > +       amdgpu_ib_free(adev, ib_msg, f);
> >
> >          if (fence)
> >                  *fence = dma_fence_get(f);
> > @@ -738,31 +730,29 @@ static int amdgpu_vcn_dec_sw_send_msg(struct 
> amdgpu_ring *ring,
> >
> >   err_free:
> >          amdgpu_job_free(job);
> > -
> >   err:
> > -       amdgpu_bo_unreserve(bo);
> > -       amdgpu_bo_unref(&bo);
> > +       amdgpu_ib_free(adev, ib_msg, f);
> >          return r;
> >   }
> >
> >   int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long 
> timeout)
> >   {
> >          struct dma_fence *fence = NULL;
> > -       struct amdgpu_bo *bo;
> > +       struct amdgpu_ib ib;
> >          long r;
> >
> > -       r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
> > +       r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
> >          if (r)
> >                  goto error;
> >
> > -       r = amdgpu_vcn_dec_sw_send_msg(ring, bo, NULL);
> > +       r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, NULL);
> >          if (r)
> >                  goto error;
> > -       r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &bo);
> > +       r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &ib);
> >          if (r)
> >                  goto error;
> >
> > -       r = amdgpu_vcn_dec_sw_send_msg(ring, bo, &fence);
> > +       r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, &fence);
> >          if (r)
> >                  goto error;
> >
> > @@ -809,7 +799,7 @@ int amdgpu_vcn_enc_ring_test_ring(struct 
> amdgpu_ring *ring)
> >   }
> >
> >   static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, 
> uint32_t handle,
> > -                                        struct amdgpu_bo *bo,
> > +                                        struct amdgpu_ib *ib_msg,
> >                                           struct dma_fence **fence)
> >   {
> >          const unsigned ib_size_dw = 16;
> > @@ -825,7 +815,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct 
> amdgpu_ring *ring, uint32_t hand
> >                  return r;
> >
> >          ib = &job->ibs[0];
> > -       addr = amdgpu_bo_gpu_offset(bo);
> > +       addr = ib_msg->gpu_addr;
> >
> >          ib->length_dw = 0;
> >          ib->ptr[ib->length_dw++] = 0x00000018;
> > @@ -863,7 +853,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct 
> amdgpu_ring *ring, uint32_t hand
> >   }
> >
> >   static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring 
> *ring, uint32_t handle,
> > -                                         struct amdgpu_bo *bo,
> > +                                         struct amdgpu_ib *ib_msg,
> >                                            struct dma_fence **fence)
> >   {
> >          const unsigned ib_size_dw = 16;
> > @@ -879,7 +869,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct 
> amdgpu_ring *ring, uint32_t han
> >                  return r;
> >
> >          ib = &job->ibs[0];
> > -       addr = amdgpu_bo_gpu_offset(bo);
> > +       addr = ib_msg->gpu_addr;
> >
> >          ib->length_dw = 0;
> >          ib->ptr[ib->length_dw++] = 0x00000018;
> > @@ -918,21 +908,23 @@ static int 
> amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
> >
> >   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long 
> timeout)
> >   {
> > +       struct amdgpu_device *adev = ring->adev;
> >          struct dma_fence *fence = NULL;
> > -       struct amdgpu_bo *bo = NULL;
> > +       struct amdgpu_ib ib;
> >          long r;
> >
> > -       r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
> > - AMDGPU_GEM_DOMAIN_VRAM,
> > -                                     &bo, NULL, NULL);
> > +       memset(&ib, 0, sizeof(ib));
> > +       r = amdgpu_ib_get(adev, NULL, 128 << 10,
> > +                       AMDGPU_IB_POOL_DIRECT,
> > +                       &ib);
> >          if (r)
> >                  return r;
> >
> > -       r = amdgpu_vcn_enc_get_create_msg(ring, 1, bo, NULL);
> > +       r = amdgpu_vcn_enc_get_create_msg(ring, 1, &ib, NULL);
> >          if (r)
> >                  goto error;
> >
> > -       r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, bo, &fence);
> > +       r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, &ib, &fence);
> >          if (r)
> >                  goto error;
> >
> > @@ -943,9 +935,8 @@ int amdgpu_vcn_enc_ring_test_ib(struct 
> amdgpu_ring *ring, long timeout)
> >                  r = 0;
> >
> >   error:
> > +       amdgpu_ib_free(adev, &ib, fence);
> >          dma_fence_put(fence);
> > -       amdgpu_bo_unreserve(bo);
> > -       amdgpu_bo_free_kernel(&bo, NULL, NULL);
> >
> >          return r;
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c 
> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > index bc571833632e..98442462135c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > @@ -206,14 +206,14 @@ static int uvd_v6_0_enc_ring_test_ring(struct 
> amdgpu_ring *ring)
> >    * Open up a stream for HW test
> >    */
> >   static int uvd_v6_0_enc_get_create_msg(struct amdgpu_ring *ring, 
> uint32_t handle,
> > -                                      struct amdgpu_bo *bo,
> > +                                      struct amdgpu_ib *ib_msg,
> >                                         struct dma_fence **fence)
> >   {
> >          const unsigned ib_size_dw = 16;
> >          struct amdgpu_job *job;
> >          struct amdgpu_ib *ib;
> >          struct dma_fence *f = NULL;
> > -       uint64_t addr;
> > +       uint64_t addr = ib_msg->gpu_addr;
> >          int i, r;
> >
> >          r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
> > @@ -222,7 +222,6 @@ static int uvd_v6_0_enc_get_create_msg(struct 
> amdgpu_ring *ring, uint32_t handle
> >                  return r;
> >
> >          ib = &job->ibs[0];
> > -       addr = amdgpu_bo_gpu_offset(bo);
> >
> >          ib->length_dw = 0;
> >          ib->ptr[ib->length_dw++] = 0x00000018;
> > @@ -270,14 +269,14 @@ static int uvd_v6_0_enc_get_create_msg(struct 
> amdgpu_ring *ring, uint32_t handle
> >    */
> >   static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
> >                                          uint32_t handle,
> > -                                       struct amdgpu_bo *bo,
> > +                                       struct amdgpu_ib *ib_msg,
> >                                          struct dma_fence **fence)
> >   {
> >          const unsigned ib_size_dw = 16;
> >          struct amdgpu_job *job;
> >          struct amdgpu_ib *ib;
> >          struct dma_fence *f = NULL;
> > -       uint64_t addr;
> > +       uint64_t addr = ib_msg->gpu_addr;
> >          int i, r;
> >
> >          r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
> > @@ -286,7 +285,6 @@ static int uvd_v6_0_enc_get_destroy_msg(struct 
> amdgpu_ring *ring,
> >                  return r;
> >
> >          ib = &job->ibs[0];
> > -       addr = amdgpu_bo_gpu_offset(bo);
> >
> >          ib->length_dw = 0;
> >          ib->ptr[ib->length_dw++] = 0x00000018;
> > @@ -331,21 +329,23 @@ static int uvd_v6_0_enc_get_destroy_msg(struct 
> amdgpu_ring *ring,
> >    */
> >   static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, 
> long timeout)
> >   {
> > +       struct amdgpu_device *adev = ring->adev;
> >          struct dma_fence *fence = NULL;
> > -       struct amdgpu_bo *bo = NULL;
> > +       struct amdgpu_ib ib;
> >          long r;
> >
> > -       r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
> > - AMDGPU_GEM_DOMAIN_VRAM,
> > -                                     &bo, NULL, NULL);
> > +       memset(&ib, 0, sizeof(ib));
> > +       r = amdgpu_ib_get(adev, NULL, 128 << 10,
> > +                       AMDGPU_IB_POOL_DIRECT,
> > +                       &ib);
> >          if (r)
> >                  return r;
> >
> > -       r = uvd_v6_0_enc_get_create_msg(ring, 1, bo, NULL);
> > +       r = uvd_v6_0_enc_get_create_msg(ring, 1, &ib, NULL);
> >          if (r)
> >                  goto error;
> >
> > -       r = uvd_v6_0_enc_get_destroy_msg(ring, 1, bo, &fence);
> > +       r = uvd_v6_0_enc_get_destroy_msg(ring, 1, &ib, &fence);
> >          if (r)
> >                  goto error;
> >
> > @@ -356,10 +356,8 @@ static int uvd_v6_0_enc_ring_test_ib(struct 
> amdgpu_ring *ring, long timeout)
> >                  r = 0;
> >
> >   error:
> > +       amdgpu_ib_free(adev, &ib, fence);
> >          dma_fence_put(fence);
> > -       amdgpu_bo_unpin(bo);
> > -       amdgpu_bo_unreserve(bo);
> > -       amdgpu_bo_unref(&bo);
> >          return r;
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c 
> b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> > index b6e82d75561f..3440ef554f99 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> > @@ -213,14 +213,14 @@ static int uvd_v7_0_enc_ring_test_ring(struct 
> amdgpu_ring *ring)
> >    * Open up a stream for HW test
> >    */
> >   static int uvd_v7_0_enc_get_create_msg(struct amdgpu_ring *ring, 
> uint32_t handle,
> > -                                      struct amdgpu_bo *bo,
> > +                                      struct amdgpu_ib *ib_msg,
> >                                         struct dma_fence **fence)
> >   {
> >          const unsigned ib_size_dw = 16;
> >          struct amdgpu_job *job;
> >          struct amdgpu_ib *ib;
> >          struct dma_fence *f = NULL;
> > -       uint64_t addr;
> > +       uint64_t addr = ib_msg->gpu_addr;
> >          int i, r;
> >
> >          r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
> > @@ -229,7 +229,6 @@ static int uvd_v7_0_enc_get_create_msg(struct 
> amdgpu_ring *ring, uint32_t handle
> >                  return r;
> >
> >          ib = &job->ibs[0];
> > -       addr = amdgpu_bo_gpu_offset(bo);
> >
> >          ib->length_dw = 0;
> >          ib->ptr[ib->length_dw++] = 0x00000018;
> > @@ -276,14 +275,14 @@ static int uvd_v7_0_enc_get_create_msg(struct 
> amdgpu_ring *ring, uint32_t handle
> >    * Close up a stream for HW test or if userspace failed to do so
> >    */
> >   static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, 
> uint32_t handle,
> > -                                       struct amdgpu_bo *bo,
> > +                                       struct amdgpu_ib *ib_msg,
> >                                          struct dma_fence **fence)
> >   {
> >          const unsigned ib_size_dw = 16;
> >          struct amdgpu_job *job;
> >          struct amdgpu_ib *ib;
> >          struct dma_fence *f = NULL;
> > -       uint64_t addr;
> > +       uint64_t addr = ib_msg->gpu_addr;
> >          int i, r;
> >
> >          r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
> > @@ -292,7 +291,6 @@ static int uvd_v7_0_enc_get_destroy_msg(struct 
> amdgpu_ring *ring, uint32_t handl
> >                  return r;
> >
> >          ib = &job->ibs[0];
> > -       addr = amdgpu_bo_gpu_offset(bo);
> >
> >          ib->length_dw = 0;
> >          ib->ptr[ib->length_dw++] = 0x00000018;
> > @@ -337,21 +335,23 @@ static int uvd_v7_0_enc_get_destroy_msg(struct 
> amdgpu_ring *ring, uint32_t handl
> >    */
> >   static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, 
> long timeout)
> >   {
> > +       struct amdgpu_device *adev = ring->adev;
> >          struct dma_fence *fence = NULL;
> > -       struct amdgpu_bo *bo = NULL;
> > +       struct amdgpu_ib ib;
> >          long r;
> >
> > -       r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
> > - AMDGPU_GEM_DOMAIN_VRAM,
> > -                                     &bo, NULL, NULL);
> > +       memset(&ib, 0, sizeof(ib));
> > +       r = amdgpu_ib_get(adev, NULL, 128 << 10,
> > +                       AMDGPU_IB_POOL_DIRECT,
> > +                       &ib);
> >          if (r)
> >                  return r;
> >
> > -       r = uvd_v7_0_enc_get_create_msg(ring, 1, bo, NULL);
> > +       r = uvd_v7_0_enc_get_create_msg(ring, 1, &ib, NULL);
> >          if (r)
> >                  goto error;
> >
> > -       r = uvd_v7_0_enc_get_destroy_msg(ring, 1, bo, &fence);
> > +       r = uvd_v7_0_enc_get_destroy_msg(ring, 1, &ib, &fence);
> >          if (r)
> >                  goto error;
> >
> > @@ -362,10 +362,8 @@ static int uvd_v7_0_enc_ring_test_ib(struct 
> amdgpu_ring *ring, long timeout)
> >                  r = 0;
> >
> >   error:
> > +       amdgpu_ib_free(adev, &ib, fence);
> >          dma_fence_put(fence);
> > -       amdgpu_bo_unpin(bo);
> > -       amdgpu_bo_unreserve(bo);
> > -       amdgpu_bo_unref(&bo);
> >          return r;
> >   }
> >
> > --
> > 2.25.1
> >
>
>


--------------0DD8ACDA7FBD39DECFC8E9CD
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Yes, correct but the key point is I want the same handling for old
    and new UVD blocks to be the same.<br>
    <br>
    This makes it more likely that the code keeps working on all
    hardware generations when we change something.<br>
    <br>
    See those old hardware is rare to get these days and I don't want to
    risk any bug report from end users when we didn't tested that well
    on SI/CIK.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 09.09.21 um 10:11 schrieb Pan,
      Xinhui:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM4PR12MB5165F781E6DA18852A01640C87D59@DM4PR12MB5165.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p
        style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;"
        align="Left">
        [AMD Official Use Only]<br>
      </p>
      <br>
      <div>
        <div dir="auto" style="direction: ltr; margin: 0px; padding:
          0px; font-family: sans-serif; font-size: 11pt; color: black;
          text-align: left;">
          well, If IB test fails because we use gtt domain or</div>
        <div dir="auto" style="direction: ltr; margin: 0px; padding:
          0px; font-family: sans-serif; font-size: 11pt; color: black;
          text-align: left;">
          the above 256MB vram<span style="font-size: 11pt;">. Then the
            failure</span><span style="font-size: 11pt;"> is expected. </span></div>
        <div dir="auto" style="direction: ltr; margin: 0px; padding:
          0px; font-family: sans-serif; font-size: 11pt; color: black;
          text-align: left;">
          <span style="font-size: 11pt;">Doesn't IB test exist to detect
            such issue?</span></div>
        <div id="id-6c97172e-0116-45da-8423-7906d63f733c"
          class="ms-outlook-mobile-reference-message">
          <div style="font-family: sans-serif; font-size: 12pt; color:
            rgb(0, 0, 0);"><br>
          </div>
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg"><strong>发件人:</strong> Koenig,
            Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            <strong>发送时间:</strong> 2021年9月9日星期四 15:16<br>
            <strong>收件人:</strong> Pan, Xinhui;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
            <strong>抄送:</strong> Deucher, Alexander<br>
            <strong>主题:</strong> Re: [PATCH 2/2] drm/amdgpu: alloc IB
            extra msg from IB pool<br>
          </div>
          <br>
          <meta name="Generator" content="Microsoft Exchange Server">
          <!-- converted from text -->
          <style>.EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; }</style><font
            size="2"><span style="font-size:11pt;">
              <div class="PlainText">Am 09.09.21 um 07:55 schrieb Pan,
                Xinhui:<br>
                &gt; [AMD Official Use Only]<br>
                &gt;<br>
                &gt; There is one dedicated IB pool for IB test. So lets
                use it for extra msg<br>
                &gt; too.<br>
                &gt;<br>
                &gt; For UVD on older HW, use one reserved BO at
                specific range.<br>
                &gt;<br>
                &gt; Signed-off-by: xinhui pan
                <a class="moz-txt-link-rfc2396E" href="mailto:xinhui.pan@amd.com">&lt;xinhui.pan@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 173
                +++++++++++++++---------<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |   1 +<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c |  18 +--<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  99
                ++++++--------<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |  28
                ++--<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |  28
                ++--<br>
                &gt;   6 files changed, 185 insertions(+), 162
                deletions(-)<br>
                <br>
                Please split that up into one patch for UVD, one for VCE
                and a third for <br>
                VCN.<br>
                <br>
                &gt;<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c<br>
                &gt; index d451c359606a..733cfc848c6c 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c<br>
                &gt; @@ -299,8 +299,36 @@ int amdgpu_uvd_sw_init(struct
                amdgpu_device *adev)<br>
                &gt;          }<br>
                &gt;<br>
                &gt;          /* from uvd v5.0 HW addressing capacity
                increased to 64 bits */<br>
                &gt; -       if
                (!amdgpu_device_ip_block_version_cmp(adev,
                AMD_IP_BLOCK_TYPE_UVD, 5, 0))<br>
                &gt; +       if
                (!amdgpu_device_ip_block_version_cmp(adev,
                AMD_IP_BLOCK_TYPE_UVD, 5, 0)) {<br>
                &gt;                  adev-&gt;uvd.address_64_bit =
                true;<br>
                <br>
                Yeah, that's exactly what I'm trying to avoid.<br>
                <br>
                We should use the BO approach both for old and new UVD
                blocks, just <br>
                making sure that we place it correctly for the old ones.<br>
                <br>
                This way we have much lower chance of breaking the old
                stuff.<br>
                <br>
                Thanks,<br>
                Christian.<br>
                <br>
                &gt; +       } else {<br>
                &gt; +               struct amdgpu_bo *bo = NULL;<br>
                &gt; +               void *addr;<br>
                &gt; +<br>
                &gt; +               r = amdgpu_bo_create_reserved(adev,
                PAGE_SIZE, PAGE_SIZE,<br>
                &gt; +                              
                AMDGPU_GEM_DOMAIN_VRAM,<br>
                &gt; +                               &amp;bo, NULL,
                &amp;addr);<br>
                &gt; +               if (r)<br>
                &gt; +                       return r;<br>
                &gt; +               amdgpu_bo_kunmap(bo);<br>
                &gt; +               amdgpu_bo_unpin(bo);<br>
                &gt; +               r = amdgpu_bo_pin_restricted(bo,
                AMDGPU_GEM_DOMAIN_VRAM,<br>
                &gt; +                               0, 256 &lt;&lt;
                20);<br>
                &gt; +               if (r) {<br>
                &gt; +                       amdgpu_bo_unreserve(bo);<br>
                &gt; +                       amdgpu_bo_unref(&amp;bo);<br>
                &gt; +                       return r;<br>
                &gt; +               }<br>
                &gt; +               r = amdgpu_bo_kmap(bo, &amp;addr);<br>
                &gt; +               if (r) {<br>
                &gt; +                       amdgpu_bo_unpin(bo);<br>
                &gt; +                       amdgpu_bo_unreserve(bo);<br>
                &gt; +                       amdgpu_bo_unref(&amp;bo);<br>
                &gt; +                       return r;<br>
                &gt; +               }<br>
                &gt; +               adev-&gt;uvd.ib_bo = bo;<br>
                &gt; +               amdgpu_bo_unreserve(bo);<br>
                &gt; +       }<br>
                &gt;<br>
                &gt;          switch (adev-&gt;asic_type) {<br>
                &gt;          case CHIP_TONGA:<br>
                &gt; @@ -342,6 +370,7 @@ int amdgpu_uvd_sw_fini(struct
                amdgpu_device *adev)<br>
                &gt;                  for (i = 0; i &lt;
                AMDGPU_MAX_UVD_ENC_RINGS; ++i)<br>
                &gt;                         
                amdgpu_ring_fini(&amp;adev-&gt;uvd.inst[j].ring_enc[i]);<br>
                &gt;          }<br>
                &gt; +      
                amdgpu_bo_free_kernel(&amp;adev-&gt;uvd.ib_bo, NULL,
                NULL);<br>
                &gt;          release_firmware(adev-&gt;uvd.fw);<br>
                &gt;<br>
                &gt;          return 0;<br>
                &gt; @@ -1066,7 +1095,7 @@ int
                amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser
                *parser, uint32_t ib_idx)<br>
                &gt;          return 0;<br>
                &gt;   }<br>
                &gt;<br>
                &gt; -static int amdgpu_uvd_send_msg(struct amdgpu_ring
                *ring, struct amdgpu_bo *bo,<br>
                &gt; +static int amdgpu_uvd_send_msg(struct amdgpu_ring
                *ring, uint64_t addr,<br>
                &gt;                                 bool direct, struct
                dma_fence **fence)<br>
                &gt;   {<br>
                &gt;          struct amdgpu_device *adev =
                ring-&gt;adev;<br>
                &gt; @@ -1074,29 +1103,15 @@ static int
                amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct
                amdgpu_bo *bo,<br>
                &gt;          struct amdgpu_job *job;<br>
                &gt;          struct amdgpu_ib *ib;<br>
                &gt;          uint32_t data[4];<br>
                &gt; -       uint64_t addr;<br>
                &gt;          long r;<br>
                &gt;          int i;<br>
                &gt;          unsigned offset_idx = 0;<br>
                &gt;          unsigned offset[3] = { UVD_BASE_SI, 0, 0
                };<br>
                &gt;<br>
                &gt; -       amdgpu_bo_kunmap(bo);<br>
                &gt; -       amdgpu_bo_unpin(bo);<br>
                &gt; -<br>
                &gt; -       if (!ring-&gt;adev-&gt;uvd.address_64_bit)
                {<br>
                &gt; -               struct ttm_operation_ctx ctx = {
                true, false };<br>
                &gt; -<br>
                &gt; -               amdgpu_bo_placement_from_domain(bo,
                AMDGPU_GEM_DOMAIN_VRAM);<br>
                &gt; -              
                amdgpu_uvd_force_into_uvd_segment(bo);<br>
                &gt; -               r =
                ttm_bo_validate(&amp;bo-&gt;tbo, &amp;bo-&gt;placement,
                &amp;ctx);<br>
                &gt; -               if (r)<br>
                &gt; -                       goto err;<br>
                &gt; -       }<br>
                &gt; -<br>
                &gt;          r = amdgpu_job_alloc_with_ib(adev, 64,
                direct ? AMDGPU_IB_POOL_DIRECT :<br>
                &gt;                                      
                AMDGPU_IB_POOL_DELAYED, &amp;job);<br>
                &gt;          if (r)<br>
                &gt; -               goto err;<br>
                &gt; +               return r;<br>
                &gt;<br>
                &gt;          if (adev-&gt;asic_type &gt;= CHIP_VEGA10)
                {<br>
                &gt;                  offset_idx = 1 + ring-&gt;me;<br>
                &gt; @@ -1110,7 +1125,6 @@ static int
                amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct
                amdgpu_bo *bo,<br>
                &gt;          data[3] = PACKET0(offset[offset_idx] +
                UVD_NO_OP, 0);<br>
                &gt;<br>
                &gt;          ib = &amp;job-&gt;ibs[0];<br>
                &gt; -       addr = amdgpu_bo_gpu_offset(bo);<br>
                &gt;          ib-&gt;ptr[0] = data[0];<br>
                &gt;          ib-&gt;ptr[1] = addr;<br>
                &gt;          ib-&gt;ptr[2] = data[1];<br>
                &gt; @@ -1123,33 +1137,13 @@ static int
                amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct
                amdgpu_bo *bo,<br>
                &gt;          }<br>
                &gt;          ib-&gt;length_dw = 16;<br>
                &gt;<br>
                &gt; -       if (direct) {<br>
                &gt; -               r =
                dma_resv_wait_timeout(bo-&gt;tbo.base.resv, true, false,<br>
                &gt; -                                        
                msecs_to_jiffies(10));<br>
                &gt; -               if (r == 0)<br>
                &gt; -                       r = -ETIMEDOUT;<br>
                &gt; -               if (r &lt; 0)<br>
                &gt; -                       goto err_free;<br>
                &gt; -<br>
                &gt; +       if (direct)<br>
                &gt;                  r = amdgpu_job_submit_direct(job,
                ring, &amp;f);<br>
                &gt; -               if (r)<br>
                &gt; -                       goto err_free;<br>
                &gt; -       } else {<br>
                &gt; -               r = amdgpu_sync_resv(adev,
                &amp;job-&gt;sync, bo-&gt;tbo.base.resv,<br>
                &gt; -                                   
                AMDGPU_SYNC_ALWAYS,<br>
                &gt; -                                   
                AMDGPU_FENCE_OWNER_UNDEFINED);<br>
                &gt; -               if (r)<br>
                &gt; -                       goto err_free;<br>
                &gt; -<br>
                &gt; +       else<br>
                &gt;                  r = amdgpu_job_submit(job,
                &amp;adev-&gt;uvd.entity,<br>
                &gt; -                                    
                AMDGPU_FENCE_OWNER_UNDEFINED, &amp;f);<br>
                &gt; -               if (r)<br>
                &gt; -                       goto err_free;<br>
                &gt; -       }<br>
                &gt; -<br>
                &gt; -       amdgpu_bo_fence(bo, f, false);<br>
                &gt; -       amdgpu_bo_unreserve(bo);<br>
                &gt; -       amdgpu_bo_unref(&amp;bo);<br>
                &gt; +                              
                AMDGPU_FENCE_OWNER_UNDEFINED, &amp;f);<br>
                &gt; +       if (r)<br>
                &gt; +               goto err_free;<br>
                &gt;<br>
                &gt;          if (fence)<br>
                &gt;                  *fence = dma_fence_get(f);<br>
                &gt; @@ -1159,10 +1153,6 @@ static int
                amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct
                amdgpu_bo *bo,<br>
                &gt;<br>
                &gt;   err_free:<br>
                &gt;          amdgpu_job_free(job);<br>
                &gt; -<br>
                &gt; -err:<br>
                &gt; -       amdgpu_bo_unreserve(bo);<br>
                &gt; -       amdgpu_bo_unref(&amp;bo);<br>
                &gt;          return r;<br>
                &gt;   }<br>
                &gt;<br>
                &gt; @@ -1173,16 +1163,31 @@ int
                amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring,
                uint32_t handle,<br>
                &gt;                                struct dma_fence
                **fence)<br>
                &gt;   {<br>
                &gt;          struct amdgpu_device *adev =
                ring-&gt;adev;<br>
                &gt; -       struct amdgpu_bo *bo = NULL;<br>
                &gt; +       struct amdgpu_bo *bo = adev-&gt;uvd.ib_bo;<br>
                &gt; +       struct dma_fence *f = NULL;<br>
                &gt; +       struct amdgpu_ib ib;<br>
                &gt;          uint32_t *msg;<br>
                &gt;          int r, i;<br>
                &gt;<br>
                &gt; -       r = amdgpu_bo_create_reserved(adev, 1024,
                PAGE_SIZE,<br>
                &gt; -                                    
                AMDGPU_GEM_DOMAIN_GTT,<br>
                &gt; -                                     &amp;bo,
                NULL, (void **)&amp;msg);<br>
                &gt; -       if (r)<br>
                &gt; -               return r;<br>
                &gt; -<br>
                &gt; +       if (bo) {<br>
                &gt; +               r = ttm_bo_reserve(&amp;bo-&gt;tbo,
                true, true, NULL);<br>
                &gt; +               if (r)<br>
                &gt; +                       return r;<br>
                &gt; +               r =
                dma_resv_wait_timeout(bo-&gt;tbo.base.resv, true, false,<br>
                &gt; +                              
                msecs_to_jiffies(10));<br>
                &gt; +               if (r == 0)<br>
                &gt; +                       r = -ETIMEDOUT;<br>
                &gt; +               if (r &lt; 0)<br>
                &gt; +                       goto err;<br>
                &gt; +               ib.gpu_addr =
                amdgpu_bo_gpu_offset(bo);<br>
                &gt; +               msg = amdgpu_bo_kptr(bo);<br>
                &gt; +       } else {<br>
                &gt; +               memset(&amp;ib, 0, sizeof(ib));<br>
                &gt; +               r = amdgpu_ib_get(adev, NULL,
                PAGE_SIZE,<br>
                &gt; +                              
                AMDGPU_IB_POOL_DIRECT,<br>
                &gt; +                               &amp;ib);<br>
                &gt; +               msg = ib.ptr;<br>
                &gt; +       }<br>
                &gt;          /* stitch together an UVD create msg */<br>
                &gt;          msg[0] = cpu_to_le32(0x00000de4);<br>
                &gt;          msg[1] = cpu_to_le32(0x00000000);<br>
                &gt; @@ -1198,23 +1203,52 @@ int
                amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring,
                uint32_t handle,<br>
                &gt;          for (i = 11; i &lt; 1024; ++i)<br>
                &gt;                  msg[i] = cpu_to_le32(0x0);<br>
                &gt;<br>
                &gt; -       return amdgpu_uvd_send_msg(ring, bo, true,
                fence);<br>
                &gt; +       r = amdgpu_uvd_send_msg(ring, ib.gpu_addr,
                true, &amp;f);<br>
                &gt; +       if (r)<br>
                &gt; +               goto err;<br>
                &gt; +       if (bo)<br>
                &gt; +               amdgpu_bo_fence(bo, f, false);<br>
                &gt; +       if (fence)<br>
                &gt; +               *fence = dma_fence_get(f);<br>
                &gt; +err:<br>
                &gt; +       if (bo)<br>
                &gt; +               amdgpu_bo_unreserve(bo);<br>
                &gt; +       else<br>
                &gt; +               amdgpu_ib_free(adev, &amp;ib, f);<br>
                &gt; +       dma_fence_put(f);<br>
                &gt; +       return r;<br>
                &gt;   }<br>
                &gt;<br>
                &gt;   int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring
                *ring, uint32_t handle,<br>
                &gt;                                 bool direct, struct
                dma_fence **fence)<br>
                &gt;   {<br>
                &gt;          struct amdgpu_device *adev =
                ring-&gt;adev;<br>
                &gt; -       struct amdgpu_bo *bo = NULL;<br>
                &gt; +       struct amdgpu_bo *bo = adev-&gt;uvd.ib_bo;<br>
                &gt; +       struct dma_fence *f = NULL;<br>
                &gt; +       struct amdgpu_ib ib;<br>
                &gt;          uint32_t *msg;<br>
                &gt;          int r, i;<br>
                &gt;<br>
                &gt; -       r = amdgpu_bo_create_reserved(adev, 1024,
                PAGE_SIZE,<br>
                &gt; -                                    
                AMDGPU_GEM_DOMAIN_GTT,<br>
                &gt; -                                     &amp;bo,
                NULL, (void **)&amp;msg);<br>
                &gt; -       if (r)<br>
                &gt; -               return r;<br>
                &gt; -<br>
                &gt; +       if (bo) {<br>
                &gt; +               r = ttm_bo_reserve(&amp;bo-&gt;tbo,
                true, true, NULL);<br>
                &gt; +               if (r)<br>
                &gt; +                       return r;<br>
                &gt; +               r =
                dma_resv_wait_timeout(bo-&gt;tbo.base.resv, true, false,<br>
                &gt; +                              
                msecs_to_jiffies(10));<br>
                &gt; +               if (r == 0)<br>
                &gt; +                       r = -ETIMEDOUT;<br>
                &gt; +               if (r &lt; 0)<br>
                &gt; +                       goto err;<br>
                &gt; +               ib.gpu_addr =
                amdgpu_bo_gpu_offset(bo);<br>
                &gt; +               msg = amdgpu_bo_kptr(bo);<br>
                &gt; +       } else {<br>
                &gt; +               memset(&amp;ib, 0, sizeof(ib));<br>
                &gt; +               r = amdgpu_ib_get(adev, NULL,
                PAGE_SIZE,<br>
                &gt; +                               direct ?<br>
                &gt; +                              
                AMDGPU_IB_POOL_DIRECT : AMDGPU_IB_POOL_DELAYED,<br>
                &gt; +                               &amp;ib);<br>
                &gt; +               msg = ib.ptr;<br>
                &gt; +       }<br>
                &gt;          /* stitch together an UVD destroy msg */<br>
                &gt;          msg[0] = cpu_to_le32(0x00000de4);<br>
                &gt;          msg[1] = cpu_to_le32(0x00000002);<br>
                &gt; @@ -1223,7 +1257,20 @@ int
                amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring,
                uint32_t handle,<br>
                &gt;          for (i = 4; i &lt; 1024; ++i)<br>
                &gt;                  msg[i] = cpu_to_le32(0x0);<br>
                &gt;<br>
                &gt; -       return amdgpu_uvd_send_msg(ring, bo,
                direct, fence);<br>
                &gt; +       r = amdgpu_uvd_send_msg(ring, ib.gpu_addr,
                true, &amp;f);<br>
                &gt; +       if (r)<br>
                &gt; +               goto err;<br>
                &gt; +       if (bo)<br>
                &gt; +               amdgpu_bo_fence(bo, f, false);<br>
                &gt; +       if (fence)<br>
                &gt; +               *fence = dma_fence_get(f);<br>
                &gt; +err:<br>
                &gt; +       if (bo)<br>
                &gt; +               amdgpu_bo_unreserve(bo);<br>
                &gt; +       else<br>
                &gt; +               amdgpu_ib_free(adev, &amp;ib, f);<br>
                &gt; +       dma_fence_put(f);<br>
                &gt; +       return r;<br>
                &gt;   }<br>
                &gt;<br>
                &gt;   static void amdgpu_uvd_idle_work_handler(struct
                work_struct *work)<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h<br>
                &gt; index edbb8194ee81..76ac9699885d 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h<br>
                &gt; @@ -68,6 +68,7 @@ struct amdgpu_uvd {<br>
                &gt;          /* store image width to adjust nb memory
                state */<br>
                &gt;          unsigned               
                decode_image_width;<br>
                &gt;          uint32_t                keyselect;<br>
                &gt; +       struct amdgpu_bo        *ib_bo;<br>
                &gt;   };<br>
                &gt;<br>
                &gt;   int amdgpu_uvd_sw_init(struct amdgpu_device
                *adev);<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<br>
                &gt; index e9fdf49d69e8..45d98694db18 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<br>
                &gt; @@ -82,7 +82,6 @@ MODULE_FIRMWARE(FIRMWARE_VEGA20);<br>
                &gt;<br>
                &gt;   static void amdgpu_vce_idle_work_handler(struct
                work_struct *work);<br>
                &gt;   static int amdgpu_vce_get_create_msg(struct
                amdgpu_ring *ring, uint32_t handle,<br>
                &gt; -                                    struct
                amdgpu_bo *bo,<br>
                &gt;                                       struct
                dma_fence **fence);<br>
                &gt;   static int amdgpu_vce_get_destroy_msg(struct
                amdgpu_ring *ring, uint32_t handle,<br>
                &gt;                                        bool direct,
                struct dma_fence **fence);<br>
                &gt; @@ -441,7 +440,6 @@ void
                amdgpu_vce_free_handles(struct amdgpu_device *adev,
                struct drm_file *filp)<br>
                &gt;    * Open up a stream for HW test<br>
                &gt;    */<br>
                &gt;   static int amdgpu_vce_get_create_msg(struct
                amdgpu_ring *ring, uint32_t handle,<br>
                &gt; -                                    struct
                amdgpu_bo *bo,<br>
                &gt;                                       struct
                dma_fence **fence)<br>
                &gt;   {<br>
                &gt;          const unsigned ib_size_dw = 1024;<br>
                &gt; @@ -451,14 +449,13 @@ static int
                amdgpu_vce_get_create_msg(struct amdgpu_ring *ring,
                uint32_t handle,<br>
                &gt;          uint64_t addr;<br>
                &gt;          int i, r;<br>
                &gt;<br>
                &gt; -       r = amdgpu_job_alloc_with_ib(ring-&gt;adev,
                ib_size_dw * 4,<br>
                &gt; +       r = amdgpu_job_alloc_with_ib(ring-&gt;adev,
                ib_size_dw * 4 + PAGE_SIZE,<br>
                &gt;                                      
                AMDGPU_IB_POOL_DIRECT, &amp;job);<br>
                &gt;          if (r)<br>
                &gt;                  return r;<br>
                &gt;<br>
                &gt;          ib = &amp;job-&gt;ibs[0];<br>
                &gt; -<br>
                &gt; -       addr = amdgpu_bo_gpu_offset(bo);<br>
                &gt; +       addr = ib-&gt;gpu_addr + ib_size_dw * 4;<br>
                &gt;<br>
                &gt;          /* stitch together an VCE create msg */<br>
                &gt;          ib-&gt;length_dw = 0;<br>
                &gt; @@ -1134,20 +1131,13 @@ int
                amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)<br>
                &gt;   int amdgpu_vce_ring_test_ib(struct amdgpu_ring
                *ring, long timeout)<br>
                &gt;   {<br>
                &gt;          struct dma_fence *fence = NULL;<br>
                &gt; -       struct amdgpu_bo *bo = NULL;<br>
                &gt;          long r;<br>
                &gt;<br>
                &gt;          /* skip vce ring1/2 ib test for now, since
                it's not reliable */<br>
                &gt;          if (ring !=
                &amp;ring-&gt;adev-&gt;vce.ring[0])<br>
                &gt;                  return 0;<br>
                &gt;<br>
                &gt; -       r =
                amdgpu_bo_create_reserved(ring-&gt;adev, 512, PAGE_SIZE,<br>
                &gt; -                                    
                AMDGPU_GEM_DOMAIN_VRAM,<br>
                &gt; -                                     &amp;bo,
                NULL, NULL);<br>
                &gt; -       if (r)<br>
                &gt; -               return r;<br>
                &gt; -<br>
                &gt; -       r = amdgpu_vce_get_create_msg(ring, 1, bo,
                NULL);<br>
                &gt; +       r = amdgpu_vce_get_create_msg(ring, 1,
                NULL);<br>
                &gt;          if (r)<br>
                &gt;                  goto error;<br>
                &gt;<br>
                &gt; @@ -1163,8 +1153,6 @@ int
                amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long
                timeout)<br>
                &gt;<br>
                &gt;   error:<br>
                &gt;          dma_fence_put(fence);<br>
                &gt; -       amdgpu_bo_unreserve(bo);<br>
                &gt; -       amdgpu_bo_free_kernel(&amp;bo, NULL, NULL);<br>
                &gt;          return r;<br>
                &gt;   }<br>
                &gt;<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
                &gt; index 561296a85b43..b60d5f01fdae 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
                &gt; @@ -541,15 +541,14 @@ int
                amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring
                *ring)<br>
                &gt;   }<br>
                &gt;<br>
                &gt;   static int amdgpu_vcn_dec_send_msg(struct
                amdgpu_ring *ring,<br>
                &gt; -                                  struct amdgpu_bo
                *bo,<br>
                &gt; -                                  struct dma_fence
                **fence)<br>
                &gt; +               struct amdgpu_ib *ib_msg,<br>
                &gt; +               struct dma_fence **fence)<br>
                &gt;   {<br>
                &gt;          struct amdgpu_device *adev =
                ring-&gt;adev;<br>
                &gt;          struct dma_fence *f = NULL;<br>
                &gt;          struct amdgpu_job *job;<br>
                &gt;          struct amdgpu_ib *ib;<br>
                &gt; -       uint64_t addr;<br>
                &gt; -       void *msg = NULL;<br>
                &gt; +       uint64_t addr = ib_msg-&gt;gpu_addr;<br>
                &gt;          int i, r;<br>
                &gt;<br>
                &gt;          r = amdgpu_job_alloc_with_ib(adev, 64,<br>
                &gt; @@ -558,8 +557,6 @@ static int
                amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,<br>
                &gt;                  goto err;<br>
                &gt;<br>
                &gt;          ib = &amp;job-&gt;ibs[0];<br>
                &gt; -       addr = amdgpu_bo_gpu_offset(bo);<br>
                &gt; -       msg = amdgpu_bo_kptr(bo);<br>
                &gt;          ib-&gt;ptr[0] =
                PACKET0(adev-&gt;vcn.internal.data0, 0);<br>
                &gt;          ib-&gt;ptr[1] = addr;<br>
                &gt;          ib-&gt;ptr[2] =
                PACKET0(adev-&gt;vcn.internal.data1, 0);<br>
                &gt; @@ -576,9 +573,7 @@ static int
                amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,<br>
                &gt;          if (r)<br>
                &gt;                  goto err_free;<br>
                &gt;<br>
                &gt; -       amdgpu_bo_fence(bo, f, false);<br>
                &gt; -       amdgpu_bo_unreserve(bo);<br>
                &gt; -       amdgpu_bo_free_kernel(&amp;bo, NULL, (void
                **)&amp;msg);<br>
                &gt; +       amdgpu_ib_free(adev, ib_msg, f);<br>
                &gt;<br>
                &gt;          if (fence)<br>
                &gt;                  *fence = dma_fence_get(f);<br>
                &gt; @@ -588,27 +583,26 @@ static int
                amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,<br>
                &gt;<br>
                &gt;   err_free:<br>
                &gt;          amdgpu_job_free(job);<br>
                &gt; -<br>
                &gt;   err:<br>
                &gt; -       amdgpu_bo_unreserve(bo);<br>
                &gt; -       amdgpu_bo_free_kernel(&amp;bo, NULL, (void
                **)&amp;msg);<br>
                &gt; +       amdgpu_ib_free(adev, ib_msg, f);<br>
                &gt;          return r;<br>
                &gt;   }<br>
                &gt;<br>
                &gt;   static int amdgpu_vcn_dec_get_create_msg(struct
                amdgpu_ring *ring, uint32_t handle,<br>
                &gt; -                                        struct
                amdgpu_bo **bo)<br>
                &gt; +               struct amdgpu_ib *ib)<br>
                &gt;   {<br>
                &gt;          struct amdgpu_device *adev =
                ring-&gt;adev;<br>
                &gt;          uint32_t *msg;<br>
                &gt;          int r, i;<br>
                &gt;<br>
                &gt; -       *bo = NULL;<br>
                &gt; -       r = amdgpu_bo_create_reserved(adev, 1024,
                PAGE_SIZE,<br>
                &gt; -                                    
                AMDGPU_GEM_DOMAIN_VRAM,<br>
                &gt; -                                     bo, NULL,
                (void **)&amp;msg);<br>
                &gt; +       memset(ib, 0, sizeof(*ib));<br>
                &gt; +       r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,<br>
                &gt; +                       AMDGPU_IB_POOL_DIRECT,<br>
                &gt; +                       ib);<br>
                &gt;          if (r)<br>
                &gt;                  return r;<br>
                &gt;<br>
                &gt; +       msg = ib-&gt;ptr;<br>
                &gt;          msg[0] = cpu_to_le32(0x00000028);<br>
                &gt;          msg[1] = cpu_to_le32(0x00000038);<br>
                &gt;          msg[2] = cpu_to_le32(0x00000001);<br>
                &gt; @@ -630,19 +624,20 @@ static int
                amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring,
                uint32_t hand<br>
                &gt;   }<br>
                &gt;<br>
                &gt;   static int amdgpu_vcn_dec_get_destroy_msg(struct
                amdgpu_ring *ring, uint32_t handle,<br>
                &gt; -                                         struct
                amdgpu_bo **bo)<br>
                &gt; +                                         struct
                amdgpu_ib *ib)<br>
                &gt;   {<br>
                &gt;          struct amdgpu_device *adev =
                ring-&gt;adev;<br>
                &gt;          uint32_t *msg;<br>
                &gt;          int r, i;<br>
                &gt;<br>
                &gt; -       *bo = NULL;<br>
                &gt; -       r = amdgpu_bo_create_reserved(adev, 1024,
                PAGE_SIZE,<br>
                &gt; -                                    
                AMDGPU_GEM_DOMAIN_VRAM,<br>
                &gt; -                                     bo, NULL,
                (void **)&amp;msg);<br>
                &gt; +       memset(ib, 0, sizeof(*ib));<br>
                &gt; +       r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,<br>
                &gt; +                       AMDGPU_IB_POOL_DIRECT,<br>
                &gt; +                       ib);<br>
                &gt;          if (r)<br>
                &gt;                  return r;<br>
                &gt;<br>
                &gt; +       msg = ib-&gt;ptr;<br>
                &gt;          msg[0] = cpu_to_le32(0x00000028);<br>
                &gt;          msg[1] = cpu_to_le32(0x00000018);<br>
                &gt;          msg[2] = cpu_to_le32(0x00000000);<br>
                &gt; @@ -658,21 +653,21 @@ static int
                amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring,
                uint32_t han<br>
                &gt;   int amdgpu_vcn_dec_ring_test_ib(struct
                amdgpu_ring *ring, long timeout)<br>
                &gt;   {<br>
                &gt;          struct dma_fence *fence = NULL;<br>
                &gt; -       struct amdgpu_bo *bo;<br>
                &gt; +       struct amdgpu_ib ib;<br>
                &gt;          long r;<br>
                &gt;<br>
                &gt; -       r = amdgpu_vcn_dec_get_create_msg(ring, 1,
                &amp;bo);<br>
                &gt; +       r = amdgpu_vcn_dec_get_create_msg(ring, 1,
                &amp;ib);<br>
                &gt;          if (r)<br>
                &gt;                  goto error;<br>
                &gt;<br>
                &gt; -       r = amdgpu_vcn_dec_send_msg(ring, bo,
                NULL);<br>
                &gt; +       r = amdgpu_vcn_dec_send_msg(ring, &amp;ib,
                NULL);<br>
                &gt;          if (r)<br>
                &gt;                  goto error;<br>
                &gt; -       r = amdgpu_vcn_dec_get_destroy_msg(ring, 1,
                &amp;bo);<br>
                &gt; +       r = amdgpu_vcn_dec_get_destroy_msg(ring, 1,
                &amp;ib);<br>
                &gt;          if (r)<br>
                &gt;                  goto error;<br>
                &gt;<br>
                &gt; -       r = amdgpu_vcn_dec_send_msg(ring, bo,
                &amp;fence);<br>
                &gt; +       r = amdgpu_vcn_dec_send_msg(ring, &amp;ib,
                &amp;fence);<br>
                &gt;          if (r)<br>
                &gt;                  goto error;<br>
                &gt;<br>
                &gt; @@ -688,8 +683,8 @@ int
                amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring,
                long timeout)<br>
                &gt;   }<br>
                &gt;<br>
                &gt;   static int amdgpu_vcn_dec_sw_send_msg(struct
                amdgpu_ring *ring,<br>
                &gt; -                                  struct amdgpu_bo
                *bo,<br>
                &gt; -                                  struct dma_fence
                **fence)<br>
                &gt; +               struct amdgpu_ib *ib_msg,<br>
                &gt; +               struct dma_fence **fence)<br>
                &gt;   {<br>
                &gt;          struct amdgpu_vcn_decode_buffer
                *decode_buffer = NULL;<br>
                &gt;          const unsigned int ib_size_dw = 64;<br>
                &gt; @@ -697,7 +692,7 @@ static int
                amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,<br>
                &gt;          struct dma_fence *f = NULL;<br>
                &gt;          struct amdgpu_job *job;<br>
                &gt;          struct amdgpu_ib *ib;<br>
                &gt; -       uint64_t addr;<br>
                &gt; +       uint64_t addr = ib_msg-&gt;gpu_addr;<br>
                &gt;          int i, r;<br>
                &gt;<br>
                &gt;          r = amdgpu_job_alloc_with_ib(adev,
                ib_size_dw * 4,<br>
                &gt; @@ -706,7 +701,6 @@ static int
                amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,<br>
                &gt;                  goto err;<br>
                &gt;<br>
                &gt;          ib = &amp;job-&gt;ibs[0];<br>
                &gt; -       addr = amdgpu_bo_gpu_offset(bo);<br>
                &gt;          ib-&gt;length_dw = 0;<br>
                &gt;<br>
                &gt;          ib-&gt;ptr[ib-&gt;length_dw++] =
                sizeof(struct amdgpu_vcn_decode_buffer) + 8;<br>
                &gt; @@ -726,9 +720,7 @@ static int
                amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,<br>
                &gt;          if (r)<br>
                &gt;                  goto err_free;<br>
                &gt;<br>
                &gt; -       amdgpu_bo_fence(bo, f, false);<br>
                &gt; -       amdgpu_bo_unreserve(bo);<br>
                &gt; -       amdgpu_bo_unref(&amp;bo);<br>
                &gt; +       amdgpu_ib_free(adev, ib_msg, f);<br>
                &gt;<br>
                &gt;          if (fence)<br>
                &gt;                  *fence = dma_fence_get(f);<br>
                &gt; @@ -738,31 +730,29 @@ static int
                amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,<br>
                &gt;<br>
                &gt;   err_free:<br>
                &gt;          amdgpu_job_free(job);<br>
                &gt; -<br>
                &gt;   err:<br>
                &gt; -       amdgpu_bo_unreserve(bo);<br>
                &gt; -       amdgpu_bo_unref(&amp;bo);<br>
                &gt; +       amdgpu_ib_free(adev, ib_msg, f);<br>
                &gt;          return r;<br>
                &gt;   }<br>
                &gt;<br>
                &gt;   int amdgpu_vcn_dec_sw_ring_test_ib(struct
                amdgpu_ring *ring, long timeout)<br>
                &gt;   {<br>
                &gt;          struct dma_fence *fence = NULL;<br>
                &gt; -       struct amdgpu_bo *bo;<br>
                &gt; +       struct amdgpu_ib ib;<br>
                &gt;          long r;<br>
                &gt;<br>
                &gt; -       r = amdgpu_vcn_dec_get_create_msg(ring, 1,
                &amp;bo);<br>
                &gt; +       r = amdgpu_vcn_dec_get_create_msg(ring, 1,
                &amp;ib);<br>
                &gt;          if (r)<br>
                &gt;                  goto error;<br>
                &gt;<br>
                &gt; -       r = amdgpu_vcn_dec_sw_send_msg(ring, bo,
                NULL);<br>
                &gt; +       r = amdgpu_vcn_dec_sw_send_msg(ring,
                &amp;ib, NULL);<br>
                &gt;          if (r)<br>
                &gt;                  goto error;<br>
                &gt; -       r = amdgpu_vcn_dec_get_destroy_msg(ring, 1,
                &amp;bo);<br>
                &gt; +       r = amdgpu_vcn_dec_get_destroy_msg(ring, 1,
                &amp;ib);<br>
                &gt;          if (r)<br>
                &gt;                  goto error;<br>
                &gt;<br>
                &gt; -       r = amdgpu_vcn_dec_sw_send_msg(ring, bo,
                &amp;fence);<br>
                &gt; +       r = amdgpu_vcn_dec_sw_send_msg(ring,
                &amp;ib, &amp;fence);<br>
                &gt;          if (r)<br>
                &gt;                  goto error;<br>
                &gt;<br>
                &gt; @@ -809,7 +799,7 @@ int
                amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring)<br>
                &gt;   }<br>
                &gt;<br>
                &gt;   static int amdgpu_vcn_enc_get_create_msg(struct
                amdgpu_ring *ring, uint32_t handle,<br>
                &gt; -                                        struct
                amdgpu_bo *bo,<br>
                &gt; +                                        struct
                amdgpu_ib *ib_msg,<br>
                &gt;                                           struct
                dma_fence **fence)<br>
                &gt;   {<br>
                &gt;          const unsigned ib_size_dw = 16;<br>
                &gt; @@ -825,7 +815,7 @@ static int
                amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring,
                uint32_t hand<br>
                &gt;                  return r;<br>
                &gt;<br>
                &gt;          ib = &amp;job-&gt;ibs[0];<br>
                &gt; -       addr = amdgpu_bo_gpu_offset(bo);<br>
                &gt; +       addr = ib_msg-&gt;gpu_addr;<br>
                &gt;<br>
                &gt;          ib-&gt;length_dw = 0;<br>
                &gt;          ib-&gt;ptr[ib-&gt;length_dw++] =
                0x00000018;<br>
                &gt; @@ -863,7 +853,7 @@ static int
                amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring,
                uint32_t hand<br>
                &gt;   }<br>
                &gt;<br>
                &gt;   static int amdgpu_vcn_enc_get_destroy_msg(struct
                amdgpu_ring *ring, uint32_t handle,<br>
                &gt; -                                         struct
                amdgpu_bo *bo,<br>
                &gt; +                                         struct
                amdgpu_ib *ib_msg,<br>
                &gt;                                            struct
                dma_fence **fence)<br>
                &gt;   {<br>
                &gt;          const unsigned ib_size_dw = 16;<br>
                &gt; @@ -879,7 +869,7 @@ static int
                amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring,
                uint32_t han<br>
                &gt;                  return r;<br>
                &gt;<br>
                &gt;          ib = &amp;job-&gt;ibs[0];<br>
                &gt; -       addr = amdgpu_bo_gpu_offset(bo);<br>
                &gt; +       addr = ib_msg-&gt;gpu_addr;<br>
                &gt;<br>
                &gt;          ib-&gt;length_dw = 0;<br>
                &gt;          ib-&gt;ptr[ib-&gt;length_dw++] =
                0x00000018;<br>
                &gt; @@ -918,21 +908,23 @@ static int
                amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring,
                uint32_t han<br>
                &gt;<br>
                &gt;   int amdgpu_vcn_enc_ring_test_ib(struct
                amdgpu_ring *ring, long timeout)<br>
                &gt;   {<br>
                &gt; +       struct amdgpu_device *adev = ring-&gt;adev;<br>
                &gt;          struct dma_fence *fence = NULL;<br>
                &gt; -       struct amdgpu_bo *bo = NULL;<br>
                &gt; +       struct amdgpu_ib ib;<br>
                &gt;          long r;<br>
                &gt;<br>
                &gt; -       r =
                amdgpu_bo_create_reserved(ring-&gt;adev, 128 * 1024,
                PAGE_SIZE,<br>
                &gt; -                                    
                AMDGPU_GEM_DOMAIN_VRAM,<br>
                &gt; -                                     &amp;bo,
                NULL, NULL);<br>
                &gt; +       memset(&amp;ib, 0, sizeof(ib));<br>
                &gt; +       r = amdgpu_ib_get(adev, NULL, 128 &lt;&lt;
                10,<br>
                &gt; +                       AMDGPU_IB_POOL_DIRECT,<br>
                &gt; +                       &amp;ib);<br>
                &gt;          if (r)<br>
                &gt;                  return r;<br>
                &gt;<br>
                &gt; -       r = amdgpu_vcn_enc_get_create_msg(ring, 1,
                bo, NULL);<br>
                &gt; +       r = amdgpu_vcn_enc_get_create_msg(ring, 1,
                &amp;ib, NULL);<br>
                &gt;          if (r)<br>
                &gt;                  goto error;<br>
                &gt;<br>
                &gt; -       r = amdgpu_vcn_enc_get_destroy_msg(ring, 1,
                bo, &amp;fence);<br>
                &gt; +       r = amdgpu_vcn_enc_get_destroy_msg(ring, 1,
                &amp;ib, &amp;fence);<br>
                &gt;          if (r)<br>
                &gt;                  goto error;<br>
                &gt;<br>
                &gt; @@ -943,9 +935,8 @@ int
                amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring,
                long timeout)<br>
                &gt;                  r = 0;<br>
                &gt;<br>
                &gt;   error:<br>
                &gt; +       amdgpu_ib_free(adev, &amp;ib, fence);<br>
                &gt;          dma_fence_put(fence);<br>
                &gt; -       amdgpu_bo_unreserve(bo);<br>
                &gt; -       amdgpu_bo_free_kernel(&amp;bo, NULL, NULL);<br>
                &gt;<br>
                &gt;          return r;<br>
                &gt;   }<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
                b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
                &gt; index bc571833632e..98442462135c 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
                &gt; @@ -206,14 +206,14 @@ static int
                uvd_v6_0_enc_ring_test_ring(struct amdgpu_ring *ring)<br>
                &gt;    * Open up a stream for HW test<br>
                &gt;    */<br>
                &gt;   static int uvd_v6_0_enc_get_create_msg(struct
                amdgpu_ring *ring, uint32_t handle,<br>
                &gt; -                                      struct
                amdgpu_bo *bo,<br>
                &gt; +                                      struct
                amdgpu_ib *ib_msg,<br>
                &gt;                                         struct
                dma_fence **fence)<br>
                &gt;   {<br>
                &gt;          const unsigned ib_size_dw = 16;<br>
                &gt;          struct amdgpu_job *job;<br>
                &gt;          struct amdgpu_ib *ib;<br>
                &gt;          struct dma_fence *f = NULL;<br>
                &gt; -       uint64_t addr;<br>
                &gt; +       uint64_t addr = ib_msg-&gt;gpu_addr;<br>
                &gt;          int i, r;<br>
                &gt;<br>
                &gt;          r =
                amdgpu_job_alloc_with_ib(ring-&gt;adev, ib_size_dw * 4,<br>
                &gt; @@ -222,7 +222,6 @@ static int
                uvd_v6_0_enc_get_create_msg(struct amdgpu_ring *ring,
                uint32_t handle<br>
                &gt;                  return r;<br>
                &gt;<br>
                &gt;          ib = &amp;job-&gt;ibs[0];<br>
                &gt; -       addr = amdgpu_bo_gpu_offset(bo);<br>
                &gt;<br>
                &gt;          ib-&gt;length_dw = 0;<br>
                &gt;          ib-&gt;ptr[ib-&gt;length_dw++] =
                0x00000018;<br>
                &gt; @@ -270,14 +269,14 @@ static int
                uvd_v6_0_enc_get_create_msg(struct amdgpu_ring *ring,
                uint32_t handle<br>
                &gt;    */<br>
                &gt;   static int uvd_v6_0_enc_get_destroy_msg(struct
                amdgpu_ring *ring,<br>
                &gt;                                          uint32_t
                handle,<br>
                &gt; -                                       struct
                amdgpu_bo *bo,<br>
                &gt; +                                       struct
                amdgpu_ib *ib_msg,<br>
                &gt;                                          struct
                dma_fence **fence)<br>
                &gt;   {<br>
                &gt;          const unsigned ib_size_dw = 16;<br>
                &gt;          struct amdgpu_job *job;<br>
                &gt;          struct amdgpu_ib *ib;<br>
                &gt;          struct dma_fence *f = NULL;<br>
                &gt; -       uint64_t addr;<br>
                &gt; +       uint64_t addr = ib_msg-&gt;gpu_addr;<br>
                &gt;          int i, r;<br>
                &gt;<br>
                &gt;          r =
                amdgpu_job_alloc_with_ib(ring-&gt;adev, ib_size_dw * 4,<br>
                &gt; @@ -286,7 +285,6 @@ static int
                uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,<br>
                &gt;                  return r;<br>
                &gt;<br>
                &gt;          ib = &amp;job-&gt;ibs[0];<br>
                &gt; -       addr = amdgpu_bo_gpu_offset(bo);<br>
                &gt;<br>
                &gt;          ib-&gt;length_dw = 0;<br>
                &gt;          ib-&gt;ptr[ib-&gt;length_dw++] =
                0x00000018;<br>
                &gt; @@ -331,21 +329,23 @@ static int
                uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,<br>
                &gt;    */<br>
                &gt;   static int uvd_v6_0_enc_ring_test_ib(struct
                amdgpu_ring *ring, long timeout)<br>
                &gt;   {<br>
                &gt; +       struct amdgpu_device *adev = ring-&gt;adev;<br>
                &gt;          struct dma_fence *fence = NULL;<br>
                &gt; -       struct amdgpu_bo *bo = NULL;<br>
                &gt; +       struct amdgpu_ib ib;<br>
                &gt;          long r;<br>
                &gt;<br>
                &gt; -       r =
                amdgpu_bo_create_reserved(ring-&gt;adev, 128 * 1024,
                PAGE_SIZE,<br>
                &gt; -                                    
                AMDGPU_GEM_DOMAIN_VRAM,<br>
                &gt; -                                     &amp;bo,
                NULL, NULL);<br>
                &gt; +       memset(&amp;ib, 0, sizeof(ib));<br>
                &gt; +       r = amdgpu_ib_get(adev, NULL, 128 &lt;&lt;
                10,<br>
                &gt; +                       AMDGPU_IB_POOL_DIRECT,<br>
                &gt; +                       &amp;ib);<br>
                &gt;          if (r)<br>
                &gt;                  return r;<br>
                &gt;<br>
                &gt; -       r = uvd_v6_0_enc_get_create_msg(ring, 1,
                bo, NULL);<br>
                &gt; +       r = uvd_v6_0_enc_get_create_msg(ring, 1,
                &amp;ib, NULL);<br>
                &gt;          if (r)<br>
                &gt;                  goto error;<br>
                &gt;<br>
                &gt; -       r = uvd_v6_0_enc_get_destroy_msg(ring, 1,
                bo, &amp;fence);<br>
                &gt; +       r = uvd_v6_0_enc_get_destroy_msg(ring, 1,
                &amp;ib, &amp;fence);<br>
                &gt;          if (r)<br>
                &gt;                  goto error;<br>
                &gt;<br>
                &gt; @@ -356,10 +356,8 @@ static int
                uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long
                timeout)<br>
                &gt;                  r = 0;<br>
                &gt;<br>
                &gt;   error:<br>
                &gt; +       amdgpu_ib_free(adev, &amp;ib, fence);<br>
                &gt;          dma_fence_put(fence);<br>
                &gt; -       amdgpu_bo_unpin(bo);<br>
                &gt; -       amdgpu_bo_unreserve(bo);<br>
                &gt; -       amdgpu_bo_unref(&amp;bo);<br>
                &gt;          return r;<br>
                &gt;   }<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
                b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
                &gt; index b6e82d75561f..3440ef554f99 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
                &gt; @@ -213,14 +213,14 @@ static int
                uvd_v7_0_enc_ring_test_ring(struct amdgpu_ring *ring)<br>
                &gt;    * Open up a stream for HW test<br>
                &gt;    */<br>
                &gt;   static int uvd_v7_0_enc_get_create_msg(struct
                amdgpu_ring *ring, uint32_t handle,<br>
                &gt; -                                      struct
                amdgpu_bo *bo,<br>
                &gt; +                                      struct
                amdgpu_ib *ib_msg,<br>
                &gt;                                         struct
                dma_fence **fence)<br>
                &gt;   {<br>
                &gt;          const unsigned ib_size_dw = 16;<br>
                &gt;          struct amdgpu_job *job;<br>
                &gt;          struct amdgpu_ib *ib;<br>
                &gt;          struct dma_fence *f = NULL;<br>
                &gt; -       uint64_t addr;<br>
                &gt; +       uint64_t addr = ib_msg-&gt;gpu_addr;<br>
                &gt;          int i, r;<br>
                &gt;<br>
                &gt;          r =
                amdgpu_job_alloc_with_ib(ring-&gt;adev, ib_size_dw * 4,<br>
                &gt; @@ -229,7 +229,6 @@ static int
                uvd_v7_0_enc_get_create_msg(struct amdgpu_ring *ring,
                uint32_t handle<br>
                &gt;                  return r;<br>
                &gt;<br>
                &gt;          ib = &amp;job-&gt;ibs[0];<br>
                &gt; -       addr = amdgpu_bo_gpu_offset(bo);<br>
                &gt;<br>
                &gt;          ib-&gt;length_dw = 0;<br>
                &gt;          ib-&gt;ptr[ib-&gt;length_dw++] =
                0x00000018;<br>
                &gt; @@ -276,14 +275,14 @@ static int
                uvd_v7_0_enc_get_create_msg(struct amdgpu_ring *ring,
                uint32_t handle<br>
                &gt;    * Close up a stream for HW test or if userspace
                failed to do so<br>
                &gt;    */<br>
                &gt;   static int uvd_v7_0_enc_get_destroy_msg(struct
                amdgpu_ring *ring, uint32_t handle,<br>
                &gt; -                                       struct
                amdgpu_bo *bo,<br>
                &gt; +                                       struct
                amdgpu_ib *ib_msg,<br>
                &gt;                                          struct
                dma_fence **fence)<br>
                &gt;   {<br>
                &gt;          const unsigned ib_size_dw = 16;<br>
                &gt;          struct amdgpu_job *job;<br>
                &gt;          struct amdgpu_ib *ib;<br>
                &gt;          struct dma_fence *f = NULL;<br>
                &gt; -       uint64_t addr;<br>
                &gt; +       uint64_t addr = ib_msg-&gt;gpu_addr;<br>
                &gt;          int i, r;<br>
                &gt;<br>
                &gt;          r =
                amdgpu_job_alloc_with_ib(ring-&gt;adev, ib_size_dw * 4,<br>
                &gt; @@ -292,7 +291,6 @@ static int
                uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
                uint32_t handl<br>
                &gt;                  return r;<br>
                &gt;<br>
                &gt;          ib = &amp;job-&gt;ibs[0];<br>
                &gt; -       addr = amdgpu_bo_gpu_offset(bo);<br>
                &gt;<br>
                &gt;          ib-&gt;length_dw = 0;<br>
                &gt;          ib-&gt;ptr[ib-&gt;length_dw++] =
                0x00000018;<br>
                &gt; @@ -337,21 +335,23 @@ static int
                uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
                uint32_t handl<br>
                &gt;    */<br>
                &gt;   static int uvd_v7_0_enc_ring_test_ib(struct
                amdgpu_ring *ring, long timeout)<br>
                &gt;   {<br>
                &gt; +       struct amdgpu_device *adev = ring-&gt;adev;<br>
                &gt;          struct dma_fence *fence = NULL;<br>
                &gt; -       struct amdgpu_bo *bo = NULL;<br>
                &gt; +       struct amdgpu_ib ib;<br>
                &gt;          long r;<br>
                &gt;<br>
                &gt; -       r =
                amdgpu_bo_create_reserved(ring-&gt;adev, 128 * 1024,
                PAGE_SIZE,<br>
                &gt; -                                    
                AMDGPU_GEM_DOMAIN_VRAM,<br>
                &gt; -                                     &amp;bo,
                NULL, NULL);<br>
                &gt; +       memset(&amp;ib, 0, sizeof(ib));<br>
                &gt; +       r = amdgpu_ib_get(adev, NULL, 128 &lt;&lt;
                10,<br>
                &gt; +                       AMDGPU_IB_POOL_DIRECT,<br>
                &gt; +                       &amp;ib);<br>
                &gt;          if (r)<br>
                &gt;                  return r;<br>
                &gt;<br>
                &gt; -       r = uvd_v7_0_enc_get_create_msg(ring, 1,
                bo, NULL);<br>
                &gt; +       r = uvd_v7_0_enc_get_create_msg(ring, 1,
                &amp;ib, NULL);<br>
                &gt;          if (r)<br>
                &gt;                  goto error;<br>
                &gt;<br>
                &gt; -       r = uvd_v7_0_enc_get_destroy_msg(ring, 1,
                bo, &amp;fence);<br>
                &gt; +       r = uvd_v7_0_enc_get_destroy_msg(ring, 1,
                &amp;ib, &amp;fence);<br>
                &gt;          if (r)<br>
                &gt;                  goto error;<br>
                &gt;<br>
                &gt; @@ -362,10 +362,8 @@ static int
                uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long
                timeout)<br>
                &gt;                  r = 0;<br>
                &gt;<br>
                &gt;   error:<br>
                &gt; +       amdgpu_ib_free(adev, &amp;ib, fence);<br>
                &gt;          dma_fence_put(fence);<br>
                &gt; -       amdgpu_bo_unpin(bo);<br>
                &gt; -       amdgpu_bo_unreserve(bo);<br>
                &gt; -       amdgpu_bo_unref(&amp;bo);<br>
                &gt;          return r;<br>
                &gt;   }<br>
                &gt;<br>
                &gt; --<br>
                &gt; 2.25.1<br>
                &gt;<br>
                <br>
              </div>
            </span></font><br>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------0DD8ACDA7FBD39DECFC8E9CD--
