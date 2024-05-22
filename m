Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4D0C25B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 13:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6148510EEC0;
	Wed, 22 May 2024 13:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TqctU6AN";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7B110EEC0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 13:58:05 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2ac9b225a91so2070340a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716386284; x=1716991084; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9i7p8OLX22XYY6z0ue6uLysJx4xEFMOAUMU9snSVeg=;
 b=TqctU6ANifxfLBgb0JmhSCNBYGmj1zJVGzUwotFHgGcGYFhdiUUblUVIlx+ALCpzAO
 qXddP8xL9bKC4iMup3wOpvoGwG9bSET3amKt3rHzEEDSbRXdrRNvOBhXnQnN2Ou9POqV
 qiI+94Ywe03atJfbx7tAIKl9ANWUREeot8AMEGmMMQxUYxru2PsODo+xAAiJE0gYGMlK
 zcgrDofPcb7C2tizGCTIhncU/L8Dn24loqpDs/bDeTQhxG7bY0jP+1Y3Ex/cMpUdlBa0
 YZgM/nVHaz9p1WkMozQkV2T37u0FLUcWVGyzxzA10m0t7eo+IwXuqB5Lsyy4TY4MuqyO
 aReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716386284; x=1716991084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z9i7p8OLX22XYY6z0ue6uLysJx4xEFMOAUMU9snSVeg=;
 b=HgEz8VapXgOsBgFK0ygVGPNyMjjcGU8sHZDs6Dew9ESCbgnl6KxFx7uy/+D9zxq4wn
 61WilLHMbVZi7pWaNTCW1zQf77re2vyDtr6mOz61gl4vDwBs+xQjZnABEuv31ZLbQozG
 BF1MXEejeAoAg2aiFAAI9s61R/8sqDEDvsIdgOERMa5Pwy8UCGu9uQFtYj3wvRWaV4Nj
 cvKhAT8kmXoI02C6R00kf9fZzbnbWpomtGeJ1JxjS6fNRSDQpSBmV9UQBG6OKEDqsVL4
 z3/ABwCwc5Wftr5PJ9B6+sU1Gyd0MC9uftNgxGntG/dkQfLFXFv+DcAXZtNPMJNhb9qg
 p/wg==
X-Gm-Message-State: AOJu0YzjexjYgdoDMH/uH1Ex2LwOO+01yESCmQPIhIObrYQLYJqZ8XWi
 wPTg2CscUYJ0c3pjZBEQR8QK6DEPGUOrH5OJZjN5/juc8rR671UXrC61PjEVuyiNUCtejacwl0w
 C1Thn6guE/WqALUHXAwOduMH+rWY=
X-Google-Smtp-Source: AGHT+IFznbo6UHgwLdVzOVARDEAixFkXPZ2kMDwuapjHjAuN3zXihbnzN/EQy5e8u6q01xr1cTbbxR5g5UavKfoFZdg=
X-Received: by 2002:a17:90a:39ce:b0:2b6:2067:dde0 with SMTP id
 98e67ed59e1d1-2bd9f345603mr2258696a91.5.1716386284561; Wed, 22 May 2024
 06:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240522053532.2896100-1-shane.xiao@amd.com>
 <20240522053532.2896100-3-shane.xiao@amd.com>
In-Reply-To: <20240522053532.2896100-3-shane.xiao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 May 2024 09:57:52 -0400
Message-ID: <CADnq5_MvJzNne1ekxh-VvszcVZ41-ahxLbVNjCZpOjZ204+mrg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Update the impelmentation of
 AMDGPU_PTE_MTYPE_VG10
To: Shane Xiao <shane.xiao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 felix.kuehling@amd.com, hawking.zhang@amd.com, aaron.liu@amd.com, 
 sreekant.somasekharan@amd.com, longlyao <Longlong.Yao@amd.com>
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, May 22, 2024 at 1:47=E2=80=AFAM Shane Xiao <shane.xiao@amd.com> wro=
te:
>
> This patch changes the implementation of AMDGPU_PTE_MTYPE_VG10,
> clear the bits before setting the new one.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: longlyao <Longlong.Yao@amd.com>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  3 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  7 ++++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 32 ++++++++++++-------------
>  3 files changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 0364a7bb5893..f09f33d1beec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -844,8 +844,7 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdg=
pu_device *adev,
>         int num_xcc =3D max(1U, adev->gfx.num_xcc_per_xcp);
>         uint64_t page_idx, pages_per_xcc;
>         int i;
> -       uint64_t ctrl_flags =3D (flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
> -                       AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);
> +       uint64_t ctrl_flags =3D AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE=
_NC);
>
>         pages_per_xcc =3D total_pages;
>         do_div(pages_per_xcc, num_xcc);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 0c4a01fad851..9990794e275e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -94,8 +94,11 @@ struct amdgpu_mem_stats;
>  #define AMDGPU_VM_NORETRY_FLAGS_TF (AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM=
 | \
>                                    AMDGPU_PTE_PRT)
>  /* For GFX9 */
> -#define AMDGPU_PTE_MTYPE_VG10(a)       ((uint64_t)(a) << 57)
> -#define AMDGPU_PTE_MTYPE_VG10_MASK     AMDGPU_PTE_MTYPE_VG10(3ULL)
> +#define AMDGPU_PTE_MTYPE_VG10_SHIFT(mtype)     ((uint64_t)(mtype) << 57)
> +#define AMDGPU_PTE_MTYPE_VG10_MASK     AMDGPU_PTE_MTYPE_VG10_SHIFT(3ULL)
> +#define AMDGPU_PTE_MTYPE_VG10(flags, mtype)                    \
> +       ((flags) & ((~AMDGPU_PTE_MTYPE_VG10_MASK)) |    \
> +         AMDGPU_PTE_MTYPE_VG10_SHIFT(mtype))
>
>  #define AMDGPU_MTYPE_NC 0
>  #define AMDGPU_MTYPE_CC 2
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 094c08cb98e7..6809ab532c40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1075,19 +1075,19 @@ static uint64_t gmc_v9_0_map_mtype(struct amdgpu_=
device *adev, uint32_t flags)
>  {
>         switch (flags) {
>         case AMDGPU_VM_MTYPE_DEFAULT:
> -               return AMDGPU_PTE_MTYPE_VG10(MTYPE_NC);
> +               return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC);
>         case AMDGPU_VM_MTYPE_NC:
> -               return AMDGPU_PTE_MTYPE_VG10(MTYPE_NC);
> +               return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC);
>         case AMDGPU_VM_MTYPE_WC:
> -               return AMDGPU_PTE_MTYPE_VG10(MTYPE_WC);
> +               return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_WC);
>         case AMDGPU_VM_MTYPE_RW:
> -               return AMDGPU_PTE_MTYPE_VG10(MTYPE_RW);
> +               return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_RW);
>         case AMDGPU_VM_MTYPE_CC:
> -               return AMDGPU_PTE_MTYPE_VG10(MTYPE_CC);
> +               return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_CC);
>         case AMDGPU_VM_MTYPE_UC:
> -               return AMDGPU_PTE_MTYPE_VG10(MTYPE_UC);
> +               return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_UC);
>         default:
> -               return AMDGPU_PTE_MTYPE_VG10(MTYPE_NC);
> +               return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC);
>         }
>  }
>
> @@ -1228,8 +1228,8 @@ static void gmc_v9_0_get_coherence_flags(struct amd=
gpu_device *adev,
>         }
>
>         if (mtype !=3D MTYPE_NC)
> -               *flags =3D (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
> -                        AMDGPU_PTE_MTYPE_VG10(mtype);
> +               *flags =3D AMDGPU_PTE_MTYPE_VG10(*flags, mtype);
> +
>         *flags |=3D snoop ? AMDGPU_PTE_SNOOPED : 0;
>  }
>
> @@ -1281,9 +1281,9 @@ static void gmc_v9_0_override_vm_pte_flags(struct a=
mdgpu_device *adev,
>          * and can also be overridden.
>          */
>         if ((*flags & AMDGPU_PTE_MTYPE_VG10_MASK) !=3D
> -           AMDGPU_PTE_MTYPE_VG10(MTYPE_NC) &&
> +           AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC) &&
>             (*flags & AMDGPU_PTE_MTYPE_VG10_MASK) !=3D
> -           AMDGPU_PTE_MTYPE_VG10(MTYPE_UC)) {
> +           AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_UC)) {
>                 dev_dbg_ratelimited(adev->dev, "MTYPE is not NC or UC\n")=
;
>                 return;
>         }
> @@ -1312,7 +1312,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct a=
mdgpu_device *adev,
>         if (nid =3D=3D local_node) {
>                 uint64_t old_flags =3D *flags;
>                 if ((*flags & AMDGPU_PTE_MTYPE_VG10_MASK) =3D=3D
> -                       AMDGPU_PTE_MTYPE_VG10(MTYPE_NC)) {
> +                       AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC)) {
>                         unsigned int mtype_local =3D MTYPE_RW;
>
>                         if (amdgpu_mtype_local =3D=3D 1)
> @@ -1320,12 +1320,10 @@ static void gmc_v9_0_override_vm_pte_flags(struct=
 amdgpu_device *adev,
>                         else if (amdgpu_mtype_local =3D=3D 2)
>                                 mtype_local =3D MTYPE_CC;
>
> -                       *flags =3D (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK)=
 |
> -                                AMDGPU_PTE_MTYPE_VG10(mtype_local);
> +                       *flags =3D AMDGPU_PTE_MTYPE_VG10(*flags, mtype_lo=
cal);
>                 } else if (adev->rev_id) {
>                         /* MTYPE_UC case */
> -                       *flags =3D (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK)=
 |
> -                                AMDGPU_PTE_MTYPE_VG10(MTYPE_CC);
> +                       *flags =3D AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC=
);
>                 }
>
>                 dev_dbg_ratelimited(adev->dev, "flags updated from %llx t=
o %llx\n",
> @@ -1772,7 +1770,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device =
*adev)
>         if (r)
>                 return r;
>         adev->gart.table_size =3D adev->gart.num_gpu_pages * 8;
> -       adev->gart.gart_pte_flags =3D AMDGPU_PTE_MTYPE_VG10(MTYPE_UC) |
> +       adev->gart.gart_pte_flags =3D AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_U=
C) |
>                                  AMDGPU_PTE_EXECUTABLE;
>
>         if (!adev->gmc.real_vram_size) {
> --
> 2.25.1
>
