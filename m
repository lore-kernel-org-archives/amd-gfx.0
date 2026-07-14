Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE6EC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 13:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B13D210E6E0;
	Tue, 14 Jul 2026 13:45:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q6fqZ7tt";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAD3510E6E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 13:45:55 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-ca53979f8e8so364323a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 06:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784036755; cv=none;
 d=google.com; s=arc-20260327;
 b=o7UwwN4na1kzHHy8IVZgnmk9XX1e05FyvkWgiX+R7J68ILQX/LsCUlZpy4dBfeRlSH
 N+jqy+pTiCzovTaiLr8JRvqrPKZ/U3V44gp8h/dI6ZYmp7AKOGk4EuC58AsvBp1kfbAr
 +ZIVvTdtIKz29UG6+7q8gQkUqDtV4m5H3YLHGDtr1XdOj9hkRhvE6ue+/B92CkvOHcU5
 T543u7X99DFwxR4xjgSO14l9E2TZIKrQfX0qZC2gqYd/FNpB8l6KIORZRp5jfe2767Iu
 KUUAx8OzJTK8zW+xbtQ3Tc9qSSvg5rYNCHa/yESVSXEH6jXKOLmthicXBDeaRv6fyNML
 YgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aSMHHYo3ITRKqAK/KX2Ni8l6jAF4QtVR1V66V9EvS3k=;
 fh=3UpdRJRiefQjFV6OXglAkOJ8EQ8O/QcuE50I7fBjQr4=;
 b=SfS3IlXssuRUj0CIwpGNEBLiObp33SnEbinoKEhhCpvn5hJYBz3jopObg1LxzdCZVu
 w+jhOTB4JDnDnJiueO42P29o61HIoBHL2Zyq8NG/Sj4iaGXLq9psCBa02Yg1makYIwV+
 FRq6ht8oTDzvOgQo/HNfFLvGfdJiPhjrtRjdSwHWmB4IzHgwRb9loTomn/3WOeq/vJyi
 tsYMqynyeeIJ5LsQVSUjoqWEdv1lvACviYQKbHF206LHLPvp7jItMSMIidB7a6x9Tbh2
 Nw2IHJ9wrG/Xo298/3tE+wknzY/g6jmL5y77yHi5zwg3YTtG5urvwSxYmf5nTQ5QlMEt
 Bt2g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784036755; x=1784641555; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aSMHHYo3ITRKqAK/KX2Ni8l6jAF4QtVR1V66V9EvS3k=;
 b=q6fqZ7ttIndNgeos+0S8IO3QsVh4Hg6TzqRCnzCYCJI0DlEgtRq6dO9kqJsvVrLZVF
 YZlrCCubI7gofGcfm///8sVTEyFmpyja4TK59Q/c2obEUIzllN9SYNdWBdGpbGuyBbZY
 SX1S9w4CbodLo040j+u5xt6vkFEEXx813dpab3LEArWf39Ggd86O+wnsTlLS99FsCcMq
 ogJbuSEvyJKwiCRL8Gr75O2VyHjqyKxafcL1sPRR0a/9gYfHiMh6WtsPDb2Mf6CIujga
 1VohmZWZeL391mszYRbYx95RruhZk5xyg0bMmhI8Uwaj+Y1kX3kwO+VdSSt4ca/S0KOf
 FVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784036755; x=1784641555;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aSMHHYo3ITRKqAK/KX2Ni8l6jAF4QtVR1V66V9EvS3k=;
 b=S3ApYi8gZc3pYh0N1qWwfB9rxrs8d10XkTixlhYgIoAhwLwglkuPX3x4ur7GqtUael
 q6j8R1ONhXCFSxupslQL9hHy9B+cwi7rE/855lL7aSbVBdsBNiUehYjJql8la217STrb
 yTmQGRmj/6AdorkysdOtgoUXmpm3U/ld1PpEeT7S2YggYfdoqYAjCsM5ucCI+wTcGfku
 Sjnq1kZFRCaZy04EmRGcSIoKvvRyHZARq87MTZM1Pe0RJI+ROrC3KvmdwRuNsA4j0FQr
 SwMLBUPuI4iVTyNoKyEtalYddHTD9rYlWm2riUCUzl91sxpieGUy3wdY0Kok41wOC0UV
 xJ8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDR5wrhSQM5j55mZxNaX30UmpFuowz9Jwh/c0OhVTut4kJVlAB/sDWAyGSf2hhVSdzAOqf4Nqy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMWWc5V4uRDBUfsgOFIhGMopbZEMP0mojUp2vL19NdBmrII5jh
 TbgZU3YsZBK0n3hlAqrYMAgFTFzWID+n4KP7hAUFfq1Vgw/CrGsOqGzo+4tq0zKfP2B2msfgyDP
 DK7Lk/gTNKRt/S/vP1Njj5aWSeMamk8Q=
X-Gm-Gg: AfdE7cmIyQPUTe96Q6ChBAjdewj69nO78NSNzbUX4s/f3k7kSZgAGC3bai2CqVhRexu
 /lSsjGwR03JhbG2Y+EC5SOAjaoIqgdBEyT7S9GzrSIKGesCOlF8gND89Fh9gKRu426MiBtqp/wI
 RCxpm6djnP+0Sj7Gk3bv5gXM8XjeM59yvhRA1euqdukPuaj4DDc/uyx8En16E61ybMFktKz3Y82
 /6hht0/1wpcZY8GykSE8ZgAIwBeI7bo1SUVh3Wnq6UDtGloCgRGBz1CATeUQG8kklp8dJxyTDE9
 5KlmxetA1dn503PLwSzSQSRZTzSh0A0+Q3z+Pwj8dN8HZdtcd6+qfOppWYU=
X-Received: by 2002:a17:902:c40f:b0:2c9:d298:6c0a with SMTP id
 d9443c01a7336-2ce9e59ee7cmr121662595ad.2.1784036755299; Tue, 14 Jul 2026
 06:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260713182732.630947-1-alexander.deucher@amd.com>
 <20260713182732.630947-10-alexander.deucher@amd.com>
 <6ebc660e-f3a6-470e-b8ec-3aa64b08f597@amd.com>
In-Reply-To: <6ebc660e-f3a6-470e-b8ec-3aa64b08f597@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2026 09:45:41 -0400
X-Gm-Features: AUfX_mz9bAs3Td5I9dMkrILDrZ-pS8P35CnWAGiK_75gRXyt6F_kTqWIdNoJ6vY
Message-ID: <CADnq5_OUBDg6kDkFAfodG6SA0HZ-=9hUHO69iygoffqr6RchDg@mail.gmail.com>
Subject: Re: [PATCH 10/14] drm/amdgpu: add core helper to do TLB invalidation
 via SDMA
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jul 14, 2026 at 5:41=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 7/13/26 20:27, Alex Deucher wrote:
> > Adds a new helper to do TLB invalidation using SDMA.
>
> We already have that. See function amdgpu_gmc_flush_gpu_tlb().

This is a helper for the gmc IP components to replace their gmc
specific callbacks that are used internally by
amdgpu_gmc_flush_gpu_tlb().  See the last 3 patches in the series.
This cleans up a lot of duplicated code in gmc10/11/12 and also
replaces the use of MES for tlb invalidation with SDMA.

Alex

>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 36 +++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  2 ++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 42 +++++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  6 ++++
> >  4 files changed, 86 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gmc.c
> > index 3f0b1b7a557b9..5c1237a30b865 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -928,6 +928,42 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgp=
u_device *adev,
> >       dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0, =
reg1);
> >  }
> >
> > +int amdgpu_gmc_flush_gpu_tlb_helper(struct amdgpu_device *adev, uint32=
_t vmid,
> > +                                 uint32_t vmhub, uint32_t flush_type)
> > +{
> > +     struct dma_fence *fence;
> > +     /* Use register 17 for GART */
> > +     u32 inst, eng =3D 17;
> > +     int r;
> > +
> > +     if (AMDGPU_IS_GFXHUB(vmhub) && !adev->gfx.is_poweron)
> > +             return 0;
> > +
> > +     if (vmhub >=3D AMDGPU_MMHUB0(0))
> > +             inst =3D 0;
> > +     else
> > +             inst =3D vmhub;
> > +
> > +     /* flush hdp cache */
> > +     amdgpu_device_flush_hdp(adev, NULL);
> > +
> > +     mutex_lock(&adev->mman.default_entity.lock);
> > +     r =3D amdgpu_ttm_tlb_inv(adev, vmid, vmhub, eng, flush_type, inst=
,
> > +                            &adev->mman.default_entity,
> > +                            NULL, &fence);
> > +     if (r)
> > +             goto exit;
> > +     r =3D dma_fence_wait(fence, false);
> > +     dma_fence_put(fence);
> > +     if (r)
> > +             goto exit;
> > +
> > +exit:
> > +     mutex_unlock(&adev->mman.default_entity.lock);
> > +
> > +     return r;
> > +}
> > +
> >  /**
> >   * amdgpu_gmc_tmz_set -- check and set if a device supports TMZ
> >   * @adev: amdgpu_device pointer
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gmc.h
> > index 3ca187f5ade85..0135be1418a91 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > @@ -450,6 +450,8 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu=
_device *adev,
> >                                     uint32_t reg0, uint32_t reg1,
> >                                     uint32_t ref, uint32_t mask,
> >                                     uint32_t xcc_inst);
> > +int amdgpu_gmc_flush_gpu_tlb_helper(struct amdgpu_device *adev, uint32=
_t vmid,
> > +                                 uint32_t vmhub, uint32_t flush_type);
> >
> >  extern void amdgpu_gmc_tmz_set(struct amdgpu_device *adev);
> >  extern void amdgpu_gmc_noretry_set(struct amdgpu_device *adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 74ada995bd8e5..03e74b7ca0003 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -2513,6 +2513,48 @@ int amdgpu_copy_buffer(struct amdgpu_device *ade=
v,
> >       return r;
> >  }
> >
> > +int amdgpu_ttm_tlb_inv(struct amdgpu_device *adev,
> > +                    unsigned int vmid, u32 vmhub, u32 eng,
> > +                    u32 flush_type, u32 xcc_inst,
> > +                    struct amdgpu_ttm_buffer_entity *entity,
> > +                    struct dma_resv *resv,
> > +                    struct dma_fence **fence)
> > +{
> > +     struct amdgpu_ring *ring;
> > +     struct amdgpu_job *job;
> > +     int r, num_dw;
> > +
> > +     if (!adev->mman.buffer_funcs_enabled)
> > +             return -EINVAL;
> > +
> > +     ring =3D to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
> > +
> > +     if (!ring->sched.ready) {
> > +             dev_err(adev->dev,
> > +                     "Trying to inv tlbs with ring turned off.\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     num_dw =3D ALIGN(adev->mman.buffer_funcs->tlb_inv_num_dw, 8);
> > +     r =3D amdgpu_ttm_prepare_job(adev, entity, num_dw,
> > +                                resv, false, &job,
> > +                                AMDGPU_KERNEL_JOB_ID_VM_UPDATE);
> > +     if (r)
> > +             goto error_free;
> > +
> > +     amdgpu_emit_tlb_inv(adev, &job->ibs[0], vmid, vmhub, eng,
> > +                         flush_type, xcc_inst);
> > +
> > +     *fence =3D amdgpu_ttm_job_submit(adev, entity, job, num_dw);
> > +
> > +     return 0;
> > +
> > +error_free:
> > +     amdgpu_job_free(job);
> > +     dev_err(adev->dev, "Error scheduling IBs (%d)\n", r);
> > +     return r;
> > +}
> > +
> >  static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
> >                              struct amdgpu_ttm_buffer_entity *entity,
> >                              uint32_t src_data,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.h
> > index ff9e2e3466099..f6a69c5a5ee86 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> > @@ -195,6 +195,12 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
> >                      struct dma_resv *resv,
> >                      struct dma_fence **fence,
> >                      bool vm_needs_flush, uint32_t copy_flags);
> > +int amdgpu_ttm_tlb_inv(struct amdgpu_device *adev,
> > +                    unsigned int vmid, u32 vmhub, u32 eng,
> > +                    u32 flush_type, u32 xcc_inst,
> > +                    struct amdgpu_ttm_buffer_entity *entity,
> > +                    struct dma_resv *resv,
> > +                    struct dma_fence **fence);
> >  int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
> >                           struct amdgpu_bo *bo,
> >                           struct dma_resv *resv,
>
