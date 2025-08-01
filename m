Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C464C87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 15:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3269310E8C7;
	Fri,  1 Aug 2025 15:34:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lWdVRKN1";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B57A10E8C3
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 15:34:35 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-31ec291f442so306007a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Aug 2025 08:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754062475; x=1754667275; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CeCZMDVp8e+7lH6bck8SyLH1Dul/E2dUTY1f71y8hTs=;
 b=lWdVRKN1OzC4grE1b/ahmCij4FxZ26QrIrdVc3GnXPJ7YLY3JMNAyp8ky6mrPqzpSE
 Bf8Yaa+hgpKEShwGqlCup7n3HenGWMR9BNiO4Wf2KF7hFyYwKUwtsCntp8P0LleXx/Pa
 sG91cxmSQvbeLNMsx6NW/yF75heQl4OUf8fhkGp2Ag4fcKBZ3uahPcOXjjG0zRZyK8l6
 Q4HBLsIdbbCo3caKuy29PkzPqCozES5ko8fGHTSRqjxS2gDx/3spwnooHCoaXATDtPxT
 4SaL2yfcVcpb8a82h6ZXumbg4iCDfIWJ+cbuVCvb4AtDsrfvDWVbiWQjtxb2CK2Zzizq
 SmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754062475; x=1754667275;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CeCZMDVp8e+7lH6bck8SyLH1Dul/E2dUTY1f71y8hTs=;
 b=ps13C9mWV8NaKXl3pCyCfHRyHnnlu88u5+MfyBoI0FeI+uNHpSbqKItUhzZs1gDrAh
 ow/TN+P2YoqTvMcXr8YPAHnjGkbRfTTvZ6GZkAyPHibfPx0/YxbYfQsr96o3GEYoi4AC
 aHQcLZRLgxN4cFh7gnZDQXrCSaTFp5NkFG6fWoPCKxR46HFVYv7TWGeCLqTWxk5hg34W
 H1ufNLf2wRySPcv75BokY2K4/NbjMtqZcHauUtrQyBT0RUaRDIGJPjW1JGqMdZdAk9kc
 h5g8AAMsEPDbFkyv3JpjPfXw5XlKiE+ZDvEHxCqHXzuE1G0kuLyaAr25dBqE3lTNn4WS
 KouA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUufWXus1wvnzYgw/s7k2eqZBIUPlNc+FNbNHk4PaGxQq5RLOaWYEMi3ILn+4AfktufbHAl4p9g@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwuH8qqQFxKKYuJx+YBO4H/GU/tEPdUovkUDJ8FmUrwuL+bDD6W
 01Je8YFSNmpK8HMZVZ0qdfkmBs1INKkrh/7kJ5Tu3RW9IG2fjItJBJRjlDPyCTpTyqClAIIt5Nf
 XpH6Nuh0xElVt1AVrBRJ+X2QUCWTDte7eNg==
X-Gm-Gg: ASbGncsBPq6JX2Oz3E/WWA1Oi6Hn7u5ozY0ePTfXiprB1nhA2VUMavRDg6NlQMKmv+C
 gywXrJdkwWYfRZ54J122+YBhnyk6N/JREdd2nYJvMQRPXJANxjAw5dOHlekffBY5jFtqT/Hme2x
 6YJ3eOD3C+8ngQOKqQq0S91N0weKyM+GccuIMQ0Lf776Vl11WcFxwVCfMz6g6NlUrlXgrnXTFN7
 IRxoQBw
X-Google-Smtp-Source: AGHT+IHLc0NnM/0SHaCCWwGMfdGnXz4+QMJle8QcG6K48VSDq6yoBzZyKWCpcj9tj42yi+dxZ+la4z6igeD8s8d8Hok=
X-Received: by 2002:a17:90b:1c10:b0:312:e9d:4001 with SMTP id
 98e67ed59e1d1-321162d2568mr98791a91.8.1754062474284; Fri, 01 Aug 2025
 08:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250604122827.2191-1-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20250604122827.2191-1-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 1 Aug 2025 11:34:22 -0400
X-Gm-Features: Ac12FXye-qi7op1cLuXb1bqoHIMcPNZQPi4hG3Kywalo3-0a0r2NIkUavnexzAo
Message-ID: <CADnq5_P3Z=0dpPJa2ZqD+3AN4TdRQhS04sTD1D8ZLuChcDP1bg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdgpu: give each kernel job a unique id
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 amd-gfx@lists.freedesktop.org
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

On Wed, Jun 4, 2025 at 8:46=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> Userspace jobs have drm_file.client_id as a unique identifier
> as job's owners. For kernel jobs, we can allocate arbitrary
> values - the risk of overlap with userspace ids is small (given
> that it's a u64 value).
> In the unlikely case the overlap happens, it'll only impact
> trace events.
>
> Since this ID is traced in the gpu_scheduler trace events, this
> allows to determine the source of each job sent to the hardware.
>
> To make grepping easier, the IDs are defined as they will appear
> in the trace output.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

After reviewing this thread, I don't see any functional impact for
these debug values if they did happen to overlap with values coming
from read UMD clients.  At worst the tracing tools might get confused,
but I think that would be easy to fix.  Seems reasonable to land this.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     | 19 +++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c    |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 28 +++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  8 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  6 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  |  4 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  4 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 12 +++++----
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |  6 +++--
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c       |  6 +++--
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  3 ++-
>  19 files changed, 84 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index cf2df7790077..adc151183e83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1461,7 +1461,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct=
 amdgpu_ring *ring)
>         owner =3D (void *)(unsigned long)atomic_inc_return(&counter);
>
>         r =3D amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
> -                                    64, 0, &job);
> +                                    64, 0, &job,
> +                                    AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER)=
;
>         if (r)
>                 goto err;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index ecb74ccf1d90..66e762c1e43c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -674,7 +674,7 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *a=
dev, uint32_t vmid,
>         r =3D amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.high_pr,
>                                      AMDGPU_FENCE_OWNER_UNDEFINED,
>                                      16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
> -                                    &job);
> +                                    &job, AMDGPU_KERNEL_JOB_ID_FLUSH_GPU=
_TLB);
>         if (r)
>                 goto error_alloc;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 75262ce8db27..9fd5387a0cd4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -230,11 +230,12 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>  int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
>                              struct drm_sched_entity *entity, void *owner=
,
>                              size_t size, enum amdgpu_ib_pool_type pool_t=
ype,
> -                            struct amdgpu_job **job)
> +                            struct amdgpu_job **job, u64 k_job_id)
>  {
>         int r;
>
> -       r =3D amdgpu_job_alloc(adev, NULL, entity, owner, 1, job, 0);
> +       r =3D amdgpu_job_alloc(adev, NULL, entity, owner, 1, job,
> +                            k_job_id);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.h
> index 5a8bc6342222..6108a6f9dba7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -44,6 +44,22 @@
>  struct amdgpu_fence;
>  enum amdgpu_ib_pool_type;
>
> +/* Internal kernel job ids. (decreasing values, starting from U64_MAX). =
*/
> +#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE              (1844674407370955161=
5ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES         (1844674407370955161=
4ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE        (1844674407370955161=
3ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR            (1844674407370955161=
2ULL)
> +#define AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER         (1844674407370955161=
1ULL)
> +#define AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA (1844674407370955161=
0ULL)
> +#define AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER        (1844674407370955160=
9ULL)
> +#define AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE       (1844674407370955160=
8ULL)
> +#define AMDGPU_KERNEL_JOB_ID_MOVE_BLIT              (1844674407370955160=
7ULL)
> +#define AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER       (1844674407370955160=
6ULL)
> +#define AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER         (1844674407370955160=
5ULL)
> +#define AMDGPU_KERNEL_JOB_ID_FLUSH_GPU_TLB          (1844674407370955160=
4ULL)
> +#define AMDGPU_KERNEL_JOB_ID_KFD_GART_MAP           (1844674407370955160=
3ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST          (1844674407370955160=
2ULL)
> +
>  struct amdgpu_job {
>         struct drm_sched_job    base;
>         struct amdgpu_vm        *vm;
> @@ -95,7 +111,8 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struc=
t amdgpu_vm *vm,
>  int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
>                              struct drm_sched_entity *entity, void *owner=
,
>                              size_t size, enum amdgpu_ib_pool_type pool_t=
ype,
> -                            struct amdgpu_job **job);
> +                            struct amdgpu_job **job,
> +                            u64 k_job_id);
>  void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *=
gds,
>                               struct amdgpu_bo *gws, struct amdgpu_bo *oa=
);
>  void amdgpu_job_free_resources(struct amdgpu_job *job);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_jpeg.c
> index dda29132dfb2..41e083ed0758 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -194,7 +194,8 @@ static int amdgpu_jpeg_dec_set_reg(struct amdgpu_ring=
 *ring, uint32_t handle,
>         int i, r;
>
>         r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw=
 * 4,
> -                                    AMDGPU_IB_POOL_DIRECT, &job);
> +                                    AMDGPU_IB_POOL_DIRECT, &job,
> +                                    AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 0b9987781f76..0ca8f0362354 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1315,7 +1315,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_obj=
ect *bo)
>         if (r)
>                 goto out;
>
> -       r =3D amdgpu_fill_buffer(abo, 0, &bo->base._resv, &fence, true);
> +       r =3D amdgpu_fill_buffer(abo, 0, &bo->base._resv, &fence, true,
> +                              AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
>         if (WARN_ON(r))
>                 goto out;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 53b71e9d8076..72db29906c11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -226,7 +226,8 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_ob=
ject *bo,
>         r =3D amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
>                                      AMDGPU_FENCE_OWNER_UNDEFINED,
>                                      num_dw * 4 + num_bytes,
> -                                    AMDGPU_IB_POOL_DELAYED, &job);
> +                                    AMDGPU_IB_POOL_DELAYED, &job,
> +                                    AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER)=
;
>         if (r)
>                 return r;
>
> @@ -405,7 +406,7 @@ static int amdgpu_move_blit(struct ttm_buffer_object =
*bo,
>                 struct dma_fence *wipe_fence =3D NULL;
>
>                 r =3D amdgpu_fill_buffer(abo, 0, NULL, &wipe_fence,
> -                                      false);
> +                                      false, AMDGPU_KERNEL_JOB_ID_MOVE_B=
LIT);
>                 if (r) {
>                         goto error;
>                 } else if (wipe_fence) {
> @@ -1509,7 +1510,8 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm=
_buffer_object *bo,
>         r =3D amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
>                                      AMDGPU_FENCE_OWNER_UNDEFINED,
>                                      num_dw * 4, AMDGPU_IB_POOL_DELAYED,
> -                                    &job);
> +                                    &job,
> +                                    AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMO=
RY_SDMA);
>         if (r)
>                 goto out;
>
> @@ -2159,7 +2161,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_dev=
ice *adev,
>                                   struct dma_resv *resv,
>                                   bool vm_needs_flush,
>                                   struct amdgpu_job **job,
> -                                 bool delayed)
> +                                 bool delayed, u64 k_job_id)
>  {
>         enum amdgpu_ib_pool_type pool =3D direct_submit ?
>                 AMDGPU_IB_POOL_DIRECT :
> @@ -2169,7 +2171,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_dev=
ice *adev,
>                                                     &adev->mman.high_pr;
>         r =3D amdgpu_job_alloc_with_ib(adev, entity,
>                                      AMDGPU_FENCE_OWNER_UNDEFINED,
> -                                    num_dw * 4, pool, job);
> +                                    num_dw * 4, pool, job, k_job_id);
>         if (r)
>                 return r;
>
> @@ -2208,7 +2210,8 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, ui=
nt64_t src_offset,
>         num_loops =3D DIV_ROUND_UP(byte_count, max_bytes);
>         num_dw =3D ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw=
, 8);
>         r =3D amdgpu_ttm_prepare_job(adev, direct_submit, num_dw,
> -                                  resv, vm_needs_flush, &job, false);
> +                                  resv, vm_needs_flush, &job, false,
> +                                  AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER);
>         if (r)
>                 return r;
>
> @@ -2243,7 +2246,8 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *=
ring, uint32_t src_data,
>                                uint64_t dst_addr, uint32_t byte_count,
>                                struct dma_resv *resv,
>                                struct dma_fence **fence,
> -                              bool vm_needs_flush, bool delayed)
> +                              bool vm_needs_flush, bool delayed,
> +                              u64 k_job_id)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         unsigned int num_loops, num_dw;
> @@ -2256,7 +2260,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *=
ring, uint32_t src_data,
>         num_loops =3D DIV_ROUND_UP_ULL(byte_count, max_bytes);
>         num_dw =3D ALIGN(num_loops * adev->mman.buffer_funcs->fill_num_dw=
, 8);
>         r =3D amdgpu_ttm_prepare_job(adev, false, num_dw, resv, vm_needs_=
flush,
> -                                  &job, delayed);
> +                                  &job, delayed, k_job_id);
>         if (r)
>                 return r;
>
> @@ -2326,7 +2330,8 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>                         goto err;
>
>                 r =3D amdgpu_ttm_fill_mem(ring, 0, addr, size, resv,
> -                                       &next, true, true);
> +                                       &next, true, true,
> +                                       AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BU=
FFER);
>                 if (r)
>                         goto err;
>
> @@ -2345,7 +2350,8 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>                         uint32_t src_data,
>                         struct dma_resv *resv,
>                         struct dma_fence **f,
> -                       bool delayed)
> +                       bool delayed,
> +                       u64 k_job_id)
>  {
>         struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>         struct amdgpu_ring *ring =3D adev->mman.buffer_funcs_ring;
> @@ -2374,7 +2380,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>                         goto error;
>
>                 r =3D amdgpu_ttm_fill_mem(ring, src_data, to, cur_size, r=
esv,
> -                                       &next, true, delayed);
> +                                       &next, true, delayed, k_job_id);
>                 if (r)
>                         goto error;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.h
> index 208b7d1d8a27..57a1e0b7c1e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -180,7 +180,8 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>                         uint32_t src_data,
>                         struct dma_resv *resv,
>                         struct dma_fence **fence,
> -                       bool delayed);
> +                       bool delayed,
> +                       u64 k_job_id);
>
>  int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uvd.c
> index 74758b5ffc6c..5c38f0d30c87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1136,7 +1136,8 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *=
ring, struct amdgpu_bo *bo,
>         r =3D amdgpu_job_alloc_with_ib(ring->adev, &adev->uvd.entity,
>                                      AMDGPU_FENCE_OWNER_UNDEFINED,
>                                      64, direct ? AMDGPU_IB_POOL_DIRECT :
> -                                    AMDGPU_IB_POOL_DELAYED, &job);
> +                                    AMDGPU_IB_POOL_DELAYED, &job,
> +                                    AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vce.c
> index b9060bcd4806..ce318f5de047 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -449,7 +449,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ri=
ng *ring, uint32_t handle,
>         r =3D amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entit=
y,
>                                      AMDGPU_FENCE_OWNER_UNDEFINED,
>                                      ib_size_dw * 4, AMDGPU_IB_POOL_DIREC=
T,
> -                                    &job);
> +                                    &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_=
TEST);
>         if (r)
>                 return r;
>
> @@ -540,7 +540,8 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_r=
ing *ring, uint32_t handle,
>                                      AMDGPU_FENCE_OWNER_UNDEFINED,
>                                      ib_size_dw * 4,
>                                      direct ? AMDGPU_IB_POOL_DIRECT :
> -                                    AMDGPU_IB_POOL_DELAYED, &job);
> +                                    AMDGPU_IB_POOL_DELAYED, &job,
> +                                    AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 1991dd3d1056..9fc0f7ff6c53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -600,7 +600,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring=
 *ring,
>
>         r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>                                      64, AMDGPU_IB_POOL_DIRECT,
> -                                    &job);
> +                                    &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_=
TEST);
>         if (r)
>                 goto err;
>
> @@ -780,7 +780,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_r=
ing *ring,
>
>         r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>                                      ib_size_dw * 4, AMDGPU_IB_POOL_DIREC=
T,
> -                                    &job);
> +                                    &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_=
TEST);
>         if (r)
>                 goto err;
>
> @@ -910,7 +910,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgp=
u_ring *ring, uint32_t hand
>
>         r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>                                      ib_size_dw * 4, AMDGPU_IB_POOL_DIREC=
T,
> -                                    &job);
> +                                    &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_=
TEST);
>         if (r)
>                 return r;
>
> @@ -977,7 +977,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdg=
pu_ring *ring, uint32_t han
>
>         r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>                                      ib_size_dw * 4, AMDGPU_IB_POOL_DIREC=
T,
> -                                    &job);
> +                                    &job, AMDGPU_KERNEL_JOB_ID_VCN_RING_=
TEST);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index ce52b4d75e94..a33b177e1d5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -965,7 +965,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>         params.vm =3D vm;
>         params.immediate =3D immediate;
>
> -       r =3D vm->update_funcs->prepare(&params, NULL);
> +       r =3D vm->update_funcs->prepare(&params, NULL,
> +                                     AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES=
);
>         if (r)
>                 goto error;
>
> @@ -1134,7 +1135,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *ad=
ev, struct amdgpu_vm *vm,
>                 dma_fence_put(tmp);
>         }
>
> -       r =3D vm->update_funcs->prepare(&params, sync);
> +       r =3D vm->update_funcs->prepare(&params, sync,
> +                                     AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANG=
E);
>         if (r)
>                 goto error_free;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index f3ad687125ad..c1a3257463d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -309,7 +309,7 @@ struct amdgpu_vm_update_params {
>  struct amdgpu_vm_update_funcs {
>         int (*map_table)(struct amdgpu_bo_vm *bo);
>         int (*prepare)(struct amdgpu_vm_update_params *p,
> -                      struct amdgpu_sync *sync);
> +                      struct amdgpu_sync *sync, u64 k_job_id);
>         int (*update)(struct amdgpu_vm_update_params *p,
>                       struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr=
,
>                       unsigned count, uint32_t incr, uint64_t flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vm_cpu.c
> index 0c1ef5850a5e..22e2e5b47341 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -40,12 +40,14 @@ static int amdgpu_vm_cpu_map_table(struct amdgpu_bo_v=
m *table)
>   *
>   * @p: see amdgpu_vm_update_params definition
>   * @sync: sync obj with fences to wait on
> + * @k_job_id: the id for tracing/debug purposes
>   *
>   * Returns:
>   * Negativ errno, 0 for success.
>   */
>  static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
> -                                struct amdgpu_sync *sync)
> +                                struct amdgpu_sync *sync,
> +                                u64 k_job_id)
>  {
>         if (!sync)
>                 return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_pt.c
> index 30022123b0bf..f794fb1cc06e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -26,6 +26,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_trace.h"
>  #include "amdgpu_vm.h"
> +#include "amdgpu_job.h"
>
>  /*
>   * amdgpu_vm_pt_cursor - state for for_each_amdgpu_vm_pt
> @@ -395,7 +396,8 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>         params.vm =3D vm;
>         params.immediate =3D immediate;
>
> -       r =3D vm->update_funcs->prepare(&params, NULL);
> +       r =3D vm->update_funcs->prepare(&params, NULL,
> +                                     AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR);
>         if (r)
>                 goto exit;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_sdma.c
> index 46d9fb433ab2..36805dcfa159 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -40,7 +40,7 @@ static int amdgpu_vm_sdma_map_table(struct amdgpu_bo_vm=
 *table)
>
>  /* Allocate a new job for @count PTE updates */
>  static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
> -                                   unsigned int count)
> +                                   unsigned int count, u64 k_job_id)
>  {
>         enum amdgpu_ib_pool_type pool =3D p->immediate ? AMDGPU_IB_POOL_I=
MMEDIATE
>                 : AMDGPU_IB_POOL_DELAYED;
> @@ -56,7 +56,7 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_up=
date_params *p,
>         ndw =3D min(ndw, AMDGPU_VM_SDMA_MAX_NUM_DW);
>
>         r =3D amdgpu_job_alloc_with_ib(p->adev, entity, AMDGPU_FENCE_OWNE=
R_VM,
> -                                    ndw * 4, pool, &p->job);
> +                                    ndw * 4, pool, &p->job, k_job_id);
>         if (r)
>                 return r;
>
> @@ -69,16 +69,17 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_=
update_params *p,
>   *
>   * @p: see amdgpu_vm_update_params definition
>   * @sync: amdgpu_sync object with fences to wait for
> + * @k_job_id: identifier of the job, for tracing purpose
>   *
>   * Returns:
>   * Negativ errno, 0 for success.
>   */
>  static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
> -                                 struct amdgpu_sync *sync)
> +                                 struct amdgpu_sync *sync, u64 k_job_id)
>  {
>         int r;
>
> -       r =3D amdgpu_vm_sdma_alloc_job(p, 0);
> +       r =3D amdgpu_vm_sdma_alloc_job(p, 0, k_job_id);
>         if (r)
>                 return r;
>
> @@ -249,7 +250,8 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_upd=
ate_params *p,
>                         if (r)
>                                 return r;
>
> -                       r =3D amdgpu_vm_sdma_alloc_job(p, count);
> +                       r =3D amdgpu_vm_sdma_alloc_job(p, count,
> +                                                    AMDGPU_KERNEL_JOB_ID=
_VM_UPDATE);
>                         if (r)
>                                 return r;
>                 }
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v6_0.c
> index 1c07b701d0e4..ceb94bbb03a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -217,7 +217,8 @@ static int uvd_v6_0_enc_get_create_msg(struct amdgpu_=
ring *ring, uint32_t handle
>         int i, r;
>
>         r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw=
 * 4,
> -                                    AMDGPU_IB_POOL_DIRECT, &job);
> +                                    AMDGPU_IB_POOL_DIRECT, &job,
> +                                    AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>         if (r)
>                 return r;
>
> @@ -281,7 +282,8 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu=
_ring *ring,
>         int i, r;
>
>         r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw=
 * 4,
> -                                    AMDGPU_IB_POOL_DIRECT, &job);
> +                                    AMDGPU_IB_POOL_DIRECT, &job,
> +                                    AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v7_0.c
> index 9d237b5937fb..1f8866f3f63c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -225,7 +225,8 @@ static int uvd_v7_0_enc_get_create_msg(struct amdgpu_=
ring *ring, u32 handle,
>         int i, r;
>
>         r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw=
 * 4,
> -                                    AMDGPU_IB_POOL_DIRECT, &job);
> +                                    AMDGPU_IB_POOL_DIRECT, &job,
> +                                    AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>         if (r)
>                 return r;
>
> @@ -288,7 +289,8 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu=
_ring *ring, u32 handle,
>         int i, r;
>
>         r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw=
 * 4,
> -                                    AMDGPU_IB_POOL_DIRECT, &job);
> +                                    AMDGPU_IB_POOL_DIRECT, &job,
> +                                    AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
>         if (r)
>                 return r;
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_migrate.c
> index 79251f22b702..683ff02c45af 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -68,7 +68,8 @@ svm_migrate_gart_map(struct amdgpu_ring *ring, uint64_t=
 npages,
>                                      AMDGPU_FENCE_OWNER_UNDEFINED,
>                                      num_dw * 4 + num_bytes,
>                                      AMDGPU_IB_POOL_DELAYED,
> -                                    &job);
> +                                    &job,
> +                                    AMDGPU_KERNEL_JOB_ID_KFD_GART_MAP);
>         if (r)
>                 return r;
>
> --
> 2.43.0
>
