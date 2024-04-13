Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6403C4345F
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Apr 2024 22:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E59C10F07E;
	Sat, 13 Apr 2024 22:41:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="htVrCY4e";
	dkim-atps=neutral
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com
 [209.85.166.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 477BE10F07E
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Apr 2024 22:41:53 +0000 (UTC)
Received: by mail-io1-f47.google.com with SMTP id
 ca18e2360f4ac-7d5e27eca85so87950639f.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Apr 2024 15:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713048112; x=1713652912; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pnDAWyubBVFIK8EVLs5+Ftyt3Akbv+MmXUrxx6ZyqY=;
 b=htVrCY4ecPcOZ0MCozLfslVVpncp73QgOoy9W/xb03NEhTx79x7I2uQD0aboldNL6V
 mSp/oCUcCi+tU3mSJJrLPMOsB6VYuw036pmZ7lOnfeGw/3eFAGe8DKFOWNnTo7YiyXHk
 +noHJU9BNg1iX0/slRoeDEJiEpW6grOYzmGF87rS4zRy3BqmAFYzT7U+dPe3kRT5bN9o
 C1LvYUfjOuy5rPOqiKF9WiP4IZP2O4Bel8Pe6xd2tPBH4DrcFXt6WP3GOL844eyHikd4
 UlpFUvx5yqngHLpJbqbDlgoVrrusK2reCm8yEUcNH6KU9RtpBpPJJg+kVlfkW/Y9Lo/7
 yhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713048112; x=1713652912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3pnDAWyubBVFIK8EVLs5+Ftyt3Akbv+MmXUrxx6ZyqY=;
 b=SUbzMzM7O2Umvgp+YgctJrxsaDkaHedFqmDuDeF12P34W+CsfEeCwpOx6Ybm0tcORa
 Aa5MjeMP8WZTIWGlRs990Qc77psEuPPr19Vyn7ZqQgLPzcqduEloCY1rKtlLS+pPUoS1
 CqxNPkO1aPt9nVsECWSEZzRN2eBW7ra8/0Zxli/jy5X8ixOU61WfXEGhbIQ5B5nJJocA
 lLxiCWAdY6ByKASCZZMRDdapZHwipDTgbH3mgaeiJLndpUT6nQO0cqBosd3s3ac1sKp+
 jg6XBLZqpJVBL1Yh+5M2gqyc8ucLQjbe8oXxlZhISsi0OoUUX9duF9BFHRX2W1CBC3Ny
 n4LA==
X-Gm-Message-State: AOJu0Yzca1oxXcpGJG0msbSfX6daTIUG4NxS/6+ra3tFbVEDO705bDTQ
 oNZOH+7bkRxY8V2wMO2yzAe4jggRvRXt18Ty9UJCg/SFfzXfE7CeWnClhBo7ZyyfYZU/k4MoVX+
 1W7geUJS/cjLMz9Rek7rQsoZZawo=
X-Google-Smtp-Source: AGHT+IG4/1MbBt6tHJ5IOWnBwzZ/fq/fuRwfFnH9wk1tNsFRgoBzc5yU+4y1utFXhjc+q02afdTwhWBEzNPVWuyufnM=
X-Received: by 2002:a05:6602:378a:b0:7d0:2c19:76ba with SMTP id
 be10-20020a056602378a00b007d02c1976bamr8171701iob.17.1713048111969; Sat, 13
 Apr 2024 15:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240412120037.78562-1-Frank.Min@amd.com>
 <DM8PR12MB54626DE19C749CB7F2468047E9042@DM8PR12MB5462.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB54626DE19C749CB7F2468047E9042@DM8PR12MB5462.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 13 Apr 2024 18:41:39 -0400
Message-ID: <CADnq5_O5=xXs6dgo7VqjAt+gy_z-3ZsHYO9maNRNAw-uw9CWdg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: replace tmz flag into buffer flag
To: "Min, Frank" <Frank.Min@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Gao,
 Likun" <Likun.Gao@amd.com>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>
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

On Fri, Apr 12, 2024 at 8:17=E2=80=AFAM Min, Frank <Frank.Min@amd.com> wrot=
e:
>
> [AMD Official Use Only - General]
>
> From: Frank Min <Frank.Min@amd.com>
>
> Replace tmz flag into buffer flag to make it easier to understand and ext=
end
>
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> Signed-off-by: Frank Min <Frank.Min@amd.com>

Before you push this to amd-staging-drm-next, can you squash in the
si_dma.c fix and update the kerneldoc above each function to reflect
the new parameter?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 18 +++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |  2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |  2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |  2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  5 +++--
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  4 ++--
>  15 files changed, 36 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_benchmark.c
> index edc6377ec5ff..199693369c7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> @@ -39,7 +39,7 @@ static int amdgpu_benchmark_do_move(struct amdgpu_devic=
e *adev, unsigned size,
>         for (i =3D 0; i < n; i++) {
>                 struct amdgpu_ring *ring =3D adev->mman.buffer_funcs_ring=
;
>                 r =3D amdgpu_copy_buffer(ring, saddr, daddr, size, NULL, =
&fence,
> -                                      false, false, false);
> +                                      false, false, 0);
>                 if (r)
>                         goto exit_do_move;
>                 r =3D dma_fence_wait(fence, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 38742ff0ff49..abb1505c82ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -791,7 +791,7 @@ int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow=
, struct dma_fence **fence)
>
>         return amdgpu_copy_buffer(ring, shadow_addr, parent_addr,
>                                   amdgpu_bo_size(shadow), NULL, fence,
> -                                 true, false, false);
> +                                 true, false, 0);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.h
> index a22c6446817b..b5bde6652838 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -136,7 +136,7 @@ struct amdgpu_buffer_funcs {
>                                  uint64_t dst_offset,
>                                  /* number of byte to transfer */
>                                  uint32_t byte_count,
> -                                bool tmz);
> +                                uint32_t copy_flags);
>
>         /* maximum bytes in a single operation */
>         uint32_t        fill_max_bytes;
> @@ -154,7 +154,7 @@ struct amdgpu_buffer_funcs {
>                                  uint32_t byte_count);
>  };
>
> -#define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffe=
r_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
> +#define amdgpu_emit_copy_buffer(adev, ib, s, d, b, f)
> +(adev)->mman.buffer_funcs->emit_copy_buffer((ib), (s), (d), (b), (f))
>  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_f=
uncs->emit_fill_buffer((ib), (s), (d), (b))
>
>  struct amdgpu_sdma_instance *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index f0fffbf2bdd5..d58ab879e125 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -267,7 +267,7 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_ob=
ject *bo,
>         dst_addr =3D amdgpu_bo_gpu_offset(adev->gart.bo);
>         dst_addr +=3D window * AMDGPU_GTT_MAX_TRANSFER_SIZE * 8;
>         amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr,
> -                               dst_addr, num_bytes, false);
> +                               dst_addr, num_bytes, 0);
>
>         amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>         WARN_ON(job->ibs[0].length_dw > num_dw); @@ -327,6 +327,8 @@ int =
amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>         struct dma_fence *fence =3D NULL;
>         int r =3D 0;
>
> +       uint32_t copy_flags =3D 0;
> +
>         if (!adev->mman.buffer_funcs_enabled) {
>                 DRM_ERROR("Trying to move memory with ring turned off.\n"=
);
>                 return -EINVAL;
> @@ -354,8 +356,11 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device =
*adev,
>                 if (r)
>                         goto error;
>
> -               r =3D amdgpu_copy_buffer(ring, from, to, cur_size,
> -                                      resv, &next, false, true, tmz);
> +               if (tmz)
> +                       copy_flags |=3D AMDGPU_COPY_FLAGS_TMZ;
> +
> +               r =3D amdgpu_copy_buffer(ring, from, to, cur_size, resv,
> +                                      &next, false, true, copy_flags);
>                 if (r)
>                         goto error;
>
> @@ -1782,7 +1787,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm=
_buffer_object *bo,
>                 swap(src_addr, dst_addr);
>
>         amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr,
> -                               PAGE_SIZE, false);
> +                               PAGE_SIZE, 0);
>
>         amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
>         WARN_ON(job->ibs[0].length_dw > num_dw); @@ -2596,7 +2601,7 @@ in=
t amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
>                        uint64_t dst_offset, uint32_t byte_count,
>                        struct dma_resv *resv,
>                        struct dma_fence **fence, bool direct_submit,
> -                      bool vm_needs_flush, bool tmz)
> +                      bool vm_needs_flush, uint32_t copy_flags)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         unsigned int num_loops, num_dw;
> @@ -2622,8 +2627,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, ui=
nt64_t src_offset,
>                 uint32_t cur_size_in_bytes =3D min(byte_count, max_bytes)=
;
>
>                 amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_offset,
> -                                       dst_offset, cur_size_in_bytes, tm=
z);
> -
> +                                       dst_offset, cur_size_in_bytes, co=
py_flags);
>                 src_offset +=3D cur_size_in_bytes;
>                 dst_offset +=3D cur_size_in_bytes;
>                 byte_count -=3D cur_size_in_bytes;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.h
> index fe37697a76b9..22cdbb52ba4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -121,6 +121,8 @@ struct amdgpu_copy_mem {
>         unsigned long                   offset;
>  };
>
> +#define AMDGPU_COPY_FLAGS_TMZ          (1 << 0)
> +
>  int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size); =
 void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev);  int amdgpu_preempt_=
mgr_init(struct amdgpu_device *adev); @@ -158,7 +160,7 @@ int amdgpu_copy_b=
uffer(struct amdgpu_ring *ring, uint64_t src_offset,
>                        uint64_t dst_offset, uint32_t byte_count,
>                        struct dma_resv *resv,
>                        struct dma_fence **fence, bool direct_submit,
> -                      bool vm_needs_flush, bool tmz);
> +                      bool vm_needs_flush, uint32_t copy_flags);
>  int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>                                const struct amdgpu_copy_mem *src,
>                                const struct amdgpu_copy_mem *dst, diff --=
git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/ci=
k_sdma.c
> index ee5dce6f6043..ab1f112a0cbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -1305,7 +1305,7 @@ static void cik_sdma_emit_copy_buffer(struct amdgpu=
_ib *ib,
>                                       uint64_t src_offset,
>                                       uint64_t dst_offset,
>                                       uint32_t byte_count,
> -                                     bool tmz)
> +                                     uint32_t copy_flags)
>  {
>         ib->ptr[ib->length_dw++] =3D SDMA_PACKET(SDMA_OPCODE_COPY, SDMA_C=
OPY_SUB_OPCODE_LINEAR, 0);
>         ib->ptr[ib->length_dw++] =3D byte_count; diff --git a/drivers/gpu=
/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> index 7ffaaaf1fcdd..93e933915e86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -1191,7 +1191,7 @@ static void sdma_v2_4_emit_copy_buffer(struct amdgp=
u_ib *ib,
>                                        uint64_t src_offset,
>                                        uint64_t dst_offset,
>                                        uint32_t byte_count,
> -                                      bool tmz)
> +                                      uint32_t copy_flags)
>  {
>         ib->ptr[ib->length_dw++] =3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |
>                 SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v3_0.c
> index c5ea32687eb5..45ccd12bd857 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1631,7 +1631,7 @@ static void sdma_v3_0_emit_copy_buffer(struct amdgp=
u_ib *ib,
>                                        uint64_t src_offset,
>                                        uint64_t dst_offset,
>                                        uint32_t byte_count,
> -                                      bool tmz)
> +                                      uint32_t copy_flags)
>  {
>         ib->ptr[ib->length_dw++] =3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |
>                 SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_0.c
> index 7ae5f134f09b..90b936545dc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2468,11 +2468,11 @@ static void sdma_v4_0_emit_copy_buffer(struct amd=
gpu_ib *ib,
>                                        uint64_t src_offset,
>                                        uint64_t dst_offset,
>                                        uint32_t byte_count,
> -                                      bool tmz)
> +                                      uint32_t copy_flags)
>  {
>         ib->ptr[ib->length_dw++] =3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |
>                 SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) |
> -               SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);
> +               SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY=
_FLAGS_TMZ)
> +? 1 : 0);
>         ib->ptr[ib->length_dw++] =3D byte_count - 1;
>         ib->ptr[ib->length_dw++] =3D 0; /* src/dst endian swap */
>         ib->ptr[ib->length_dw++] =3D lower_32_bits(src_offset); diff --gi=
t a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/s=
dma_v4_4_2.c
> index fec5a3d1c4bc..7d1d65dca627 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1981,11 +1981,11 @@ static void sdma_v4_4_2_emit_copy_buffer(struct a=
mdgpu_ib *ib,
>                                        uint64_t src_offset,
>                                        uint64_t dst_offset,
>                                        uint32_t byte_count,
> -                                      bool tmz)
> +                                      uint32_t copy_flags)
>  {
>         ib->ptr[ib->length_dw++] =3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |
>                 SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) |
> -               SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);
> +               SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY=
_FLAGS_TMZ)
> +? 1 : 0);
>         ib->ptr[ib->length_dw++] =3D byte_count - 1;
>         ib->ptr[ib->length_dw++] =3D 0; /* src/dst endian swap */
>         ib->ptr[ib->length_dw++] =3D lower_32_bits(src_offset); diff --gi=
t a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdm=
a_v5_0.c
> index c1ff5eda8961..6a669613d028 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1836,11 +1836,11 @@ static void sdma_v5_0_emit_copy_buffer(struct amd=
gpu_ib *ib,
>                                        uint64_t src_offset,
>                                        uint64_t dst_offset,
>                                        uint32_t byte_count,
> -                                      bool tmz)
> +                                      uint32_t copy_flags)
>  {
>         ib->ptr[ib->length_dw++] =3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |
>                 SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) |
> -               SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);
> +               SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY=
_FLAGS_TMZ)
> +? 1 : 0);
>         ib->ptr[ib->length_dw++] =3D byte_count - 1;
>         ib->ptr[ib->length_dw++] =3D 0; /* src/dst endian swap */
>         ib->ptr[ib->length_dw++] =3D lower_32_bits(src_offset); diff --gi=
t a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdm=
a_v5_2.c
> index c441a20a41a3..aa0901135f30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1778,11 +1778,11 @@ static void sdma_v5_2_emit_copy_buffer(struct amd=
gpu_ib *ib,
>                                        uint64_t src_offset,
>                                        uint64_t dst_offset,
>                                        uint32_t byte_count,
> -                                      bool tmz)
> +                                      uint32_t copy_flags)
>  {
>         ib->ptr[ib->length_dw++] =3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |
>                 SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) |
> -               SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);
> +               SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY=
_FLAGS_TMZ)
> +? 1 : 0);
>         ib->ptr[ib->length_dw++] =3D byte_count - 1;
>         ib->ptr[ib->length_dw++] =3D 0; /* src/dst endian swap */
>         ib->ptr[ib->length_dw++] =3D lower_32_bits(src_offset); diff --gi=
t a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdm=
a_v6_0.c
> index f423cc6cc9d2..8a3889a20c60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1604,11 +1604,11 @@ static void sdma_v6_0_emit_copy_buffer(struct amd=
gpu_ib *ib,
>                                        uint64_t src_offset,
>                                        uint64_t dst_offset,
>                                        uint32_t byte_count,
> -                                      bool tmz)
> +                                      uint32_t copy_flags)
>  {
>         ib->ptr[ib->length_dw++] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_=
OP_COPY) |
>                 SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR=
) |
> -               SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);
> +               SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY=
_FLAGS_TMZ)
> +? 1 : 0);
>         ib->ptr[ib->length_dw++] =3D byte_count - 1;
>         ib->ptr[ib->length_dw++] =3D 0; /* src/dst endian swap */
>         ib->ptr[ib->length_dw++] =3D lower_32_bits(src_offset); diff --gi=
t a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdm=
a_v7_0.c
> index 33f1a549e7b5..0245b0374f65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1606,11 +1606,12 @@ static void sdma_v7_0_emit_copy_buffer(struct amd=
gpu_ib *ib,
>                                        uint64_t src_offset,
>                                        uint64_t dst_offset,
>                                        uint32_t byte_count,
> -                                      bool tmz)
> +                                      uint32_t copy_flags)
>  {
>         ib->ptr[ib->length_dw++] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_=
OP_COPY) |
>                 SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR=
) |
> -               SDMA_PKT_COPY_LINEAR_HEADER_TMZ(tmz ? 1 : 0);
> +               SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY=
_FLAGS_TMZ)
> +? 1 : 0);
> +
>         ib->ptr[ib->length_dw++] =3D byte_count - 1;
>         ib->ptr[ib->length_dw++] =3D 0; /* src/dst endian swap */
>         ib->ptr[ib->length_dw++] =3D lower_32_bits(src_offset); diff --gi=
t a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/k=
fd_migrate.c
> index 0ed275dd6ecf..c96e10b5b86f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -77,7 +77,7 @@ svm_migrate_gart_map(struct amdgpu_ring *ring, uint64_t=
 npages,
>
>         dst_addr =3D amdgpu_bo_gpu_offset(adev->gart.bo);
>         amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr,
> -                               dst_addr, num_bytes, false);
> +                               dst_addr, num_bytes, 0);
>
>         amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>         WARN_ON(job->ibs[0].length_dw > num_dw); @@ -153,7 +153,7 @@ svm_=
migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
>                 }
>
>                 r =3D amdgpu_copy_buffer(ring, gart_s, gart_d, size * PAG=
E_SIZE,
> -                                      NULL, &next, false, true, false);
> +                                      NULL, &next, false, true, 0);
>                 if (r) {
>                         dev_err(adev->dev, "fail %d to copy memory\n", r)=
;
>                         goto out_unlock;
> --
> 2.34.1
>
