Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48876C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 15:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C93FE10E0C5;
	Mon, 29 Jun 2026 15:12:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mPwNpomk";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B5AF10E0C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 15:11:59 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-30ca276118eso247410eec.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 08:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782745919; cv=none;
 d=google.com; s=arc-20260327;
 b=Q9lfpHbFclu6I5fNpaLKylJMmDnAvCm8zPlXGeUjN4Pu/Hd6tAouTVaYy1CZBcU+Xu
 +rWw6W1wEx4TIurULQ/z4orzL7nL46ZnMu88I6/Xaelp4cb/eTuIif8UjLh8s8eSQ3HG
 6C3uNB5sFc57UqgrjL8u05PHqqSvfEpJyrUgX5aSlBuGByFjL6IVTS35o3/YMTp/WC4G
 VJjNT8Iiu5CiB+gED5HPeSORBqjWEXX58ZnN1Z5ngYX0xVcVKAAPs17RW4CpmILCod5k
 hwA2uqrIwFCGLObZIf6HQb/57gbedbNVvR1KSgSPqIqLMBe5NgWS5CTEhdpNGh8ceP5G
 Hoaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RPeYvIyMGwvIDg96FUikLSPEOO0sj0qckPGMnXvJqio=;
 fh=1brykveYuWu5qciH6VrNzgjV2vepFhXzTCozvxMcUKQ=;
 b=U4Mjt1hT7u8hq0bnm+bfxZ8EVkTQ+TnXbsTtc1p7RNRLBpgv1io7SVvt4s0qjY8V86
 C3H2vouIM3HjDgMD/Dz5973wzxO9CGjUCStbzWoSk7MOc+sNi/ShZ2jGlPqWpuCzxFsV
 /tUZ++yVpePNfme0plt/lzul/qRCxj3I68Ll8XeGON4vZdBzUX7ggVnmppqmBu3cxpBU
 9acFuKuRei0jFKQkQz838JbtBI9md9QZnwgDHk64W5Yx2bF8u0ppDawj5meS8aecGnVV
 BHqFIBTJyI9Y+o0rkX/4aivRnbtii/mZqoOoM04634hdwIzPZqiOaVzs/nrT3qGdX9X8
 JNxw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782745919; x=1783350719; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RPeYvIyMGwvIDg96FUikLSPEOO0sj0qckPGMnXvJqio=;
 b=mPwNpomknPCgVG5CdaJe5BBqFDwaF87MnKV8WG1Livy4IWtFf8ni8lQKkDLCVf3KzP
 B6mQVtlHn6GzvbfkJZ2zapxMh+9f6Y2MnsvoSYNIt5xDx6Rmib4K4AkjEpurqfTty5zh
 pRsUZitOVQaTY7iFWzCttNOmRd/3SB1R41VkPi4SvuF7fRqIqtv9PFVcttXDAtvymyP2
 coB57lRI+ROqPun2psSMjPE8F+g+pX8K62lwAFBtV7Hk2hzzkfcG5veahsEs0an5llO7
 zkCz0WFLkxbNPSMz07k+15IueZgUvheEgFrsaI5iq44Qkeml5eHEmZFwLv0YxJiuQoOa
 J0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782745919; x=1783350719;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RPeYvIyMGwvIDg96FUikLSPEOO0sj0qckPGMnXvJqio=;
 b=VM85FiLsjzpgZ6HLmpxtJfB4CO/D4qv0ZUxjCoXa5YZgT2Ugk2AmrfdBaTNmVri4SW
 BcMcDc/TV34bUSBGqoWxbm6hNLlYPLZIa0QR6Ik8MtXiYNh8MV6YTFQl++MUKc1loL8I
 QGfX9G+zZ8iZlCb+h6RihpNQrGLVgraxJzxm220Ebzr54L6KAJWmFUtK6i8b13SnYmMo
 zRT8lXDniF+upezEPVB+L+1Tzm5Kq+szh6rYirHWiF9jZkugkEYdhrIu1H6EjJ/VcTG2
 PJ7nd5UxkdeuT1LsNErYGLBjhb33oXWQWG+k3eC99X6w4X2r1U93bK8cvnr1gV75axdQ
 kyhQ==
X-Gm-Message-State: AOJu0Yy5AYhyHbQRb/b8ErfElbqjy9796Fve3fQ9iEg8VZKhzJHlhtfS
 naYcvPyk8bqPR8iMNIlznu1Xd/Twee9Dpq5GhKrm/qmtBsdcsv9Ho1Fh261AT98sKB76nZIak/t
 2vqoH1zGHtvqDOVVkidRCoWTW+fyxd5M=
X-Gm-Gg: AfdE7clMeXlKsfd1AC3sS2x0iSyZpOkan8mlGsmia1Zws5faGjrjaqWHn2XhIbzx/8A
 0UpApZ309wd2GlFADF/E2GCjRCC8MgylBCeyh3QvbrqF8nlcqRLE/Cy8ehFwDAg9OESGVomuv59
 GFBnK9zYVPlKqBjQ5nrXcdDJhUY8qyKqYdqNyp6UxDQTmAipkfdeu1wy/auF1MBz6WtuB8oqBfz
 RktVCHIj99v5sYAi8vM5IRvQUn+lK7T0M/ijuNBZko+BRUS7YErYuAXiSDSo9FsPkUodJ71VITq
 feauIrExQgYnBisPhxOnIzS89SRsqQlNs+qZ+yNOzu0XX6rsIKYe/CEGFfZHXASrbDThPw==
X-Received: by 2002:a05:7023:b0f:b0:134:cf44:5fa9 with SMTP id
 a92af1059eb24-139db9529c6mr6434587c88.0.1782745918756; Mon, 29 Jun 2026
 08:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260625075206.1105650-1-donettom@linux.ibm.com>
In-Reply-To: <20260625075206.1105650-1-donettom@linux.ibm.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Jun 2026 11:11:47 -0400
X-Gm-Features: AVVi8Cde4vMWdpSZRbJTJDZOctaS3dT5ztUcMZBFxATne-kzRK_EAscILlOhPVQ
Message-ID: <CADnq5_Nx7HjPw9O5TttBhS2MY6JhOr-vf05VnuVx91ThFVH5qQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K
 systems
To: Donet Tom <donettom@linux.ibm.com>
Cc: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, 
 Philip Yang <yangp@amd.com>, pierre-eric.pelloux-prayer@amd.com,
 David.YatSin@amd.com, 
 Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>, 
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
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

On Thu, Jun 25, 2026 at 3:52=E2=80=AFAM Donet Tom <donettom@linux.ibm.com> =
wrote:
>
> Running RCCL unit tests on a system with a 64K PAGE_SIZE triggers
> the following warning and causes the test to terminate on latest
> upstream kernel:
>
> WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1335 at
> amdgpu_bo_release_notify+0x1bc/0x280 [amdgpu],
> CPU#18: rccl-UnitTests/33151
>
> Call trace:
> amdgpu_bo_release_notify
> ttm_bo_release
> amdgpu_gem_object_free
> drm_gem_object_free
> amdgpu_bo_unref
> amdgpu_bo_create
> amdgpu_bo_create_user
> amdgpu_gem_object_create
> amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu
> kfd_ioctl_alloc_memory_of_gpu
> kfd_ioctl
> sys_ioctl
>
> The warning is triggered because
> amdgpu_ttm_next_clear_entity() returns NULL when a clear buffer
> operation is requested. This happens because the GART window
> allocation for the default_entity, clear_entity and move_entity
> fails during initialization.
>
> Commit [1] introduced separate GART windows for the
> default_entity, clear_entity and move_entity of each SDMA
> instance. Their sizes are derived from
> AMDGPU_GTT_MAX_TRANSFER_SIZE, which is currently defined as 1024
> pages. This implicitly assumes a 4K PAGE_SIZE, where 1024 pages
> correspond to a 4MB transfer. On a 64K PAGE_SIZE system, however,
> the same value expands to 64MB.
>
> The default_entity and clear_entity each allocate one
> AMDGPU_GTT_MAX_TRANSFER_SIZE GART window, while the move_entity
> allocates two such windows. This results in 16MB of GART space
> per SDMA instance on a 4K PAGE_SIZE system, but 256MB per SDMA
> instance on a 64K PAGE_SIZE system.
>
> On an MI210 system with five SDMA instances and a 512MB GART
> aperture, the total GART space required becomes 1.25GB,
> exceeding the available GART aperture. Consequently, GART window
> allocation fails, amdgpu_ttm_next_clear_entity() returns NULL,
> and the above warning is triggered.
>
> Redefine AMDGPU_GTT_MAX_TRANSFER_SIZE in bytes instead of page
> units. Where a page count is required, convert it using
> PAGE_SHIFT. This preserves the existing 4MB transfer size across
> all PAGE_SIZE configurations while keeping GART window
> allocations within the available GART aperture.
>
> [1] https://lore.kernel.org/all/20260408100327.1372-3-pierre-eric.pelloux=
-prayer@amd.com/#t
>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 10 ++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h  |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  2 +-
>  3 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 2740de94e93c..bad33b3368eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -208,9 +208,10 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_b=
uffer_entity *entity,
>         void *cpu_addr;
>         uint64_t flags;
>         int r;
> +       const u64 GTT_MAX_PAGES =3D (AMDGPU_GTT_MAX_TRANSFER_SIZE >> PAGE=
_SHIFT);
>
>         BUG_ON(adev->mman.buffer_funcs->copy_max_bytes <
> -              AMDGPU_GTT_MAX_TRANSFER_SIZE * 8);
> +              GTT_MAX_PAGES * AMDGPU_GPU_PAGES_IN_CPU_PAGE * 8);
>
>         if (WARN_ON(mem->mem_type =3D=3D AMDGPU_PL_PREEMPT))
>                 return -EINVAL;
> @@ -230,7 +231,7 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_bu=
ffer_entity *entity,
>         offset =3D mm_cur->start & ~PAGE_MASK;
>
>         num_pages =3D PFN_UP(*size + offset);
> -       num_pages =3D min_t(uint32_t, num_pages, AMDGPU_GTT_MAX_TRANSFER_=
SIZE);
> +       num_pages =3D min_t(uint32_t, num_pages, GTT_MAX_PAGES);
>
>         *size =3D min(*size, (uint64_t)num_pages * PAGE_SIZE - offset);
>
> @@ -2015,6 +2016,7 @@ static int amdgpu_ttm_buffer_entity_init(struct amd=
gpu_gtt_mgr *mgr,
>                                          u32 num_gart_windows)
>  {
>         int i, r, num_pages;
> +       const u64 GTT_MAX_PAGES =3D (AMDGPU_GTT_MAX_TRANSFER_SIZE >> PAGE=
_SHIFT);
>
>         r =3D drm_sched_entity_init(&entity->base, prio, scheds, num_sche=
dulers, NULL);
>         if (r)
> @@ -2027,7 +2029,7 @@ static int amdgpu_ttm_buffer_entity_init(struct amd=
gpu_gtt_mgr *mgr,
>         if (num_gart_windows =3D=3D 0)
>                 return 0;
>
> -       num_pages =3D num_gart_windows * AMDGPU_GTT_MAX_TRANSFER_SIZE;
> +       num_pages =3D num_gart_windows * GTT_MAX_PAGES;
>         r =3D amdgpu_gtt_mgr_alloc_entries(mgr, &entity->gart_node, num_p=
ages,
>                                          DRM_MM_INSERT_BEST);
>         if (r) {
> @@ -2038,7 +2040,7 @@ static int amdgpu_ttm_buffer_entity_init(struct amd=
gpu_gtt_mgr *mgr,
>         for (i =3D 0; i < num_gart_windows; i++) {
>                 entity->gart_window_offs[i] =3D
>                         amdgpu_gtt_node_to_byte_offset(&entity->gart_node=
) +
> -                               i * AMDGPU_GTT_MAX_TRANSFER_SIZE * PAGE_S=
IZE;
> +                               i * GTT_MAX_PAGES * PAGE_SIZE;
>         }
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.h
> index 2d72fa217274..b5d938b31383 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -39,7 +39,7 @@
>  #define AMDGPU_PL_MMIO_REMAP   (TTM_PL_PRIV + 5)
>  #define __AMDGPU_PL_NUM        (TTM_PL_PRIV + 6)
>
> -#define AMDGPU_GTT_MAX_TRANSFER_SIZE   1024
> +#define AMDGPU_GTT_MAX_TRANSFER_SIZE   (1ULL << 22)
>
>  extern const struct attribute_group amdgpu_vram_mgr_attr_group;
>  extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_migrate.c
> index 28dc6886c1ff..8aec1ae60ca1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -128,7 +128,7 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *ad=
ev, dma_addr_t *sys,
>                              enum MIGRATION_COPY_DIR direction,
>                              struct dma_fence **mfence)
>  {
> -       const u64 GTT_MAX_PAGES =3D AMDGPU_GTT_MAX_TRANSFER_SIZE;
> +       const u64 GTT_MAX_PAGES =3D (AMDGPU_GTT_MAX_TRANSFER_SIZE >> PAGE=
_SHIFT);
>         struct amdgpu_ring *ring;
>         struct amdgpu_ttm_buffer_entity *entity;
>         u64 gart_s, gart_d;
> --
> 2.54.0
>
