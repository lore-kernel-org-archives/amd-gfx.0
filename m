Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9BECCFA13
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 20:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DEDD10F16E;
	Wed, 29 Apr 2026 20:29:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bL7p/86Z";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B7210E3F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 20:29:15 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2bd5658b901so14260eec.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 13:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777494555; cv=none;
 d=google.com; s=arc-20240605;
 b=CSHmnIxEnQmBWU4aknhESqKsY7W/31BRjv/WopYRtcv4K6Ulw8f07H2rgN2ZiXSone
 oCs8ba3aGMhdQHxDtTiT02XOZQWdsgPPSekKlTio92aTWjUW6wFoFJJpKuJ9YQcE8VkX
 6AfJe9W+Yo/KI5LUFj1hS8RXeIn2ZB/y3NlwMAu8Xm9C9xXSWiwxkLNx6zhc4Dby+JY6
 /zqaSvQc77Jo1ULrGDmnMi60QBrRdOBT3JPfulAJMS5blQ4pYu4QHRcQxe11Da4w0wqv
 xraeZHUBZ7zSM3ibPamnAsCL59NihlsbfB8eZZPmwufi4VblA795QxW1KwjnSGIBuiG5
 EMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ftGRnT9qYwKpB5SafLy+48FIQDNwUhxgg20XCEss2OY=;
 fh=yP0NvAMm4tTGzk6oTk+E8Og7xuqSVJtnMKFMoafLYrM=;
 b=Xyd+MbarVREm/B8vD4X2TIGC/hb6f0cBV6rzChsnB1mLUQJURUZBlM0BLqX6zuqb+y
 aOC4ly9YkpCKpP68WhITCpYXVs9nJFGMov58nRTQ5dRq5rSyVGcrcNsI1229aQwAtOnP
 QB30FNo0bvE+kLr5lNkRAj+ZR5ouzjNLpYbZWGOVefcq0strtePzvBc6ykWDKi5Wj2Fx
 yZCC/A/Dc9nZ2nAtXgE6b7Kk0R+5TLAZalt2vJaPS2oAuQ83apjR1FHeMgZ+JaE8JDVP
 cUWPDb088osUiJVYcLueUu9NJK7jI1Sox66ZEdFiI35nq+tRKF3o3kTKKQjdjN3pT7oi
 Px+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777494555; x=1778099355; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftGRnT9qYwKpB5SafLy+48FIQDNwUhxgg20XCEss2OY=;
 b=bL7p/86ZpgfqOkpNBCAULlYLRaMjGT2rKQGvq98STc735gu8Rd2v/PGQGqrj818cKF
 yvDSD8QkX+1ZpbbsP/uW50SSnIy3N7T1DzTJpjQjtP7Kf/GX2032no3jiCVQSQnsSj1A
 B/W+kkDNhoY7ozOXWocV32mmCYTTNMFUS6hf3eSMWW5ZhHRmMvuT2xt+TOUFzGP9+e+F
 4Z/IuXuA+0YS+8xWwmVjv2kMjeLM/pnnzzuUbrVcMry2YgdoEGa2nCtZ/4QnjOebdstZ
 hdOuOqdbrn8czY/mgm4XuSLBF2STGhl5rcgJNSp48CQrpzcpBipl3/d7CYcl+4crwAkK
 fXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777494555; x=1778099355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ftGRnT9qYwKpB5SafLy+48FIQDNwUhxgg20XCEss2OY=;
 b=i08Bo3EQfY5j7pRlM0Pob922pG8+F8LEJyQrjqBTx31pRwEm543FqEo7g33o6LII19
 5UubmZQG4u8rljlXojm/yKscSrcMaQOYxyutpMgl1hRTXwlrdLwKGyvRAzpJkCNtIa2T
 B3XtOXah1njG05Y/LSopeBcQo5QQE6sxGSvkFhu+nRw/I4DoxInyA/4NtFXb6mYrvyio
 4+Xdbmbwv3XZJW3XrALjuAw03hJW2Vkku80lP2TsuZguydx27LHPvExwegfNdMAKArxO
 b/R1FJugNQwWj+/Qu3AHSYSU+Szd2hpmr3qrR/9anHsuJZcKGD7O+I1oaF9Lhl0RmmVa
 Qgdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/j+tbZAavU9XxAXpF/NkpcXULSiRApwShn0mrPeBMlIGNYt36L8DaCw0l5z4VOxBu3bvajJZ/s@lists.freedesktop.org
X-Gm-Message-State: AOJu0YydkUxINzln0LMo0l066EvJ1uPmZwbMUUnxJ7VDvof1nQIJUAjO
 pUiap6LjaMUQ9h1+37KOqp2rSXw8Q62z/uDA0SKxr+6t6EKBVjANWS37GtlXjoVbpGaZ1FZ9XDz
 cxdiJEHSabG0lyhyrjKsgZbu4Ty/nCzSHUaf9
X-Gm-Gg: AeBDiet+DL1WV5459wrsV3u0jYmJxHTznG8zH3m8pZMeWjt98Zdbq5pJsUCL+6+leEy
 wSyysSrq+/z3zkXCxMuWzGhNC9rX2tQ2dPbd/2g4HEyAMxBs3s2kveZdQ6Lh4scmmb5OXWK6sIT
 5LjgVC6LcSkHq8aGJ0k8warTc1GzphAJqu3EsYsxXmMjjzA2Q5zeTgBCMrmcCX0QyOoX3hoT2kB
 UnEcFC9+aYRcN0z8fX5HLIGVF+VvlAGGe3bCdT5hHK0VV2Jb2sP2Dr53HwlsuahHnyWrMrBlUZO
 dTbx2+6YWboD+mMb8YH0qSB2RqWQKSlYjhJvcRp0G48RI4vJMsBVbebWlewKsMHyB2EfZVnDOpF
 jxamQ
X-Received: by 2002:a05:7022:6896:b0:12c:888b:aaab with SMTP id
 a92af1059eb24-12dea8a668amr47216c88.0.1777494554698; Wed, 29 Apr 2026
 13:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260429202042.21718-1-jbmoore61@gmail.com>
In-Reply-To: <20260429202042.21718-1-jbmoore61@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Apr 2026 16:29:02 -0400
X-Gm-Features: AVHnY4KOtfgnBVurGIGG3gu9H7CrASa8qDMcdgfsKH7iWam_wms7p4vtgjraTUo
Message-ID: <CADnq5_O_MY4mJwrXXJSn=AoMN4XRG_XYpF7yo6zk5U6Hk6UF3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx: extract compute wptr doorbell helpers to
 amdgpu_gfx.c
To: "John B. Moore" <jbmoore61@gmail.com>
Cc: christian.koenig@amd.com, alexander.deucher@amd.com, 
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

On Wed, Apr 29, 2026 at 4:20=E2=80=AFPM John B. Moore <jbmoore61@gmail.com>=
 wrote:
>
> Move the duplicated doorbell-based get_wptr/set_wptr functions from
> gfx_v9_0.c, gfx_v10_0.c, gfx_v11_0.c, and gfx_v12_0.c into common
> helpers amdgpu_gfx_get_wptr_compute() and amdgpu_gfx_set_wptr_compute()
> in amdgpu_gfx.c.
>
> These functions are not HW generation dependent -- the doorbell path is
> identical across all four GFX versions:
>
>   get: atomic64_read(ring->wptr_cpu_addr)
>   set: atomic64_set(ring->wptr_cpu_addr) + WDOORBELL64()
>
> The non-doorbell fallback is replaced with WARN_ON_ONCE instead of BUG()
> since doorbell is the only supported method on gfx9+ compute rings.
>
> Not touched: gfx_v7_0, gfx_v8_0, gfx_v9_4_3 -- these have different
> wptr access patterns (MMIO registers or wb.wb[] offsets).
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: John Moore <jbmoore61@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 39 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 33 +++------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 34 +++------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 34 +++------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 39 +++----------------------
>  6 files changed, 58 insertions(+), 124 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 77578ecc6..9e9c5cb81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2596,3 +2596,42 @@ void amdgpu_debugfs_compute_sched_mask_init(struct=
 amdgpu_device *adev)
>  #endif
>  }
>
> +/**
> + * amdgpu_gfx_get_wptr_compute - common get_wptr for compute rings using=
 doorbells
> + * @ring: amdgpu_ring pointer
> + *
> + * Read the write pointer from the doorbell-mapped writeback address.
> + * This is HW-agnostic and shared across GFX generations that use
> + * doorbell-based compute queue management.
> + */
> +u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring)

I'd prefer to name this amdgpu_gfx_get_wptr_doorbell()

> +{
> +       /* XXX check if swapping is necessary on BE */
> +       if (ring->use_doorbell)
> +               return atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
> +
> +       WARN_ON_ONCE(1);
> +       return 0;
> +}
> +
> +/**
> + * amdgpu_gfx_set_wptr_compute - common set_wptr for compute rings using=
 doorbells
> + * @ring: amdgpu_ring pointer
> + *
> + * Write the write pointer to the doorbell-mapped writeback address and
> + * ring the doorbell.  This is HW-agnostic and shared across GFX
> + * generations that use doorbell-based compute queue management.
> + */
> +void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring)

And amdgpu_gfx_set_wptr_doorbell() here.

While they are used for compute, there is nothing compute specific to them.

Thanks,

Alex

> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +
> +       /* XXX check if swapping is necessary on BE */
> +       if (ring->use_doorbell) {
> +               atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wpt=
r);
> +               WDOORBELL64(ring->doorbell_index, ring->wptr);
> +       } else {
> +               WARN_ON_ONCE(1);
> +       }
> +}
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 585cc8e81..27f6beafb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -653,6 +653,9 @@ u32 amdgpu_gfx_csb_preamble_start(u32 *buffer);
>  u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, u32 *buffer, =
u32 count);
>  void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count);
>
> +u64 amdgpu_gfx_get_wptr_compute(struct amdgpu_ring *ring);
> +void amdgpu_gfx_set_wptr_compute(struct amdgpu_ring *ring);
> +
>  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 1893ceeeb..4c0272cba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8586,31 +8586,6 @@ static u64 gfx_v10_0_ring_get_rptr_compute(struct =
amdgpu_ring *ring)
>         return *(uint32_t *)ring->rptr_cpu_addr;
>  }
>
> -static u64 gfx_v10_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
> -{
> -       u64 wptr;
> -
> -       /* XXX check if swapping is necessary on BE */
> -       if (ring->use_doorbell)
> -               wptr =3D atomic64_read((atomic64_t *)ring->wptr_cpu_addr)=
;
> -       else
> -               BUG();
> -       return wptr;
> -}
> -
> -static void gfx_v10_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
> -{
> -       struct amdgpu_device *adev =3D ring->adev;
> -
> -       if (ring->use_doorbell) {
> -               atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> -                            ring->wptr);
> -               WDOORBELL64(ring->doorbell_index, ring->wptr);
> -       } else {
> -               BUG(); /* only DOORBELL method supported on gfx10 now */
> -       }
> -}
> -
>  static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> @@ -9881,8 +9856,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_compute =3D {
>         .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
>         .support_64bit_ptrs =3D true,
>         .get_rptr =3D gfx_v10_0_ring_get_rptr_compute,
> -       .get_wptr =3D gfx_v10_0_ring_get_wptr_compute,
> -       .set_wptr =3D gfx_v10_0_ring_set_wptr_compute,
> +       .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> +       .set_wptr =3D amdgpu_gfx_set_wptr_compute,
>         .emit_frame_size =3D
>                 20 + /* gfx_v10_0_ring_emit_gds_switch */
>                 7 + /* gfx_v10_0_ring_emit_hdp_flush */
> @@ -9921,8 +9896,8 @@ static const struct amdgpu_ring_funcs gfx_v10_0_rin=
g_funcs_kiq =3D {
>         .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
>         .support_64bit_ptrs =3D true,
>         .get_rptr =3D gfx_v10_0_ring_get_rptr_compute,
> -       .get_wptr =3D gfx_v10_0_ring_get_wptr_compute,
> -       .set_wptr =3D gfx_v10_0_ring_set_wptr_compute,
> +       .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> +       .set_wptr =3D amdgpu_gfx_set_wptr_compute,
>         .emit_frame_size =3D
>                 20 + /* gfx_v10_0_ring_emit_gds_switch */
>                 7 + /* gfx_v10_0_ring_emit_hdp_flush */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 427975b5a..404604f2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5818,32 +5818,6 @@ static u64 gfx_v11_0_ring_get_rptr_compute(struct =
amdgpu_ring *ring)
>         return *(uint32_t *)ring->rptr_cpu_addr;
>  }
>
> -static u64 gfx_v11_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
> -{
> -       u64 wptr;
> -
> -       /* XXX check if swapping is necessary on BE */
> -       if (ring->use_doorbell)
> -               wptr =3D atomic64_read((atomic64_t *)ring->wptr_cpu_addr)=
;
> -       else
> -               BUG();
> -       return wptr;
> -}
> -
> -static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
> -{
> -       struct amdgpu_device *adev =3D ring->adev;
> -
> -       /* XXX check if swapping is necessary on BE */
> -       if (ring->use_doorbell) {
> -               atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> -                            ring->wptr);
> -               WDOORBELL64(ring->doorbell_index, ring->wptr);
> -       } else {
> -               BUG(); /* only DOORBELL method supported on gfx11 now */
> -       }
> -}
> -
>  static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> @@ -7266,8 +7240,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_rin=
g_funcs_compute =3D {
>         .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
>         .support_64bit_ptrs =3D true,
>         .get_rptr =3D gfx_v11_0_ring_get_rptr_compute,
> -       .get_wptr =3D gfx_v11_0_ring_get_wptr_compute,
> -       .set_wptr =3D gfx_v11_0_ring_set_wptr_compute,
> +       .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> +       .set_wptr =3D amdgpu_gfx_set_wptr_compute,
>         .emit_frame_size =3D
>                 5 + /* update_spm_vmid */
>                 20 + /* gfx_v11_0_ring_emit_gds_switch */
> @@ -7307,8 +7281,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_rin=
g_funcs_kiq =3D {
>         .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
>         .support_64bit_ptrs =3D true,
>         .get_rptr =3D gfx_v11_0_ring_get_rptr_compute,
> -       .get_wptr =3D gfx_v11_0_ring_get_wptr_compute,
> -       .set_wptr =3D gfx_v11_0_ring_set_wptr_compute,
> +       .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> +       .set_wptr =3D amdgpu_gfx_set_wptr_compute,
>         .emit_frame_size =3D
>                 20 + /* gfx_v11_0_ring_emit_gds_switch */
>                 7 + /* gfx_v11_0_ring_emit_hdp_flush */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 79ea1af36..7ba436444 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -4363,32 +4363,6 @@ static u64 gfx_v12_0_ring_get_rptr_compute(struct =
amdgpu_ring *ring)
>         return *(uint32_t *)ring->rptr_cpu_addr;
>  }
>
> -static u64 gfx_v12_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
> -{
> -       u64 wptr;
> -
> -       /* XXX check if swapping is necessary on BE */
> -       if (ring->use_doorbell)
> -               wptr =3D atomic64_read((atomic64_t *)ring->wptr_cpu_addr)=
;
> -       else
> -               BUG();
> -       return wptr;
> -}
> -
> -static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
> -{
> -       struct amdgpu_device *adev =3D ring->adev;
> -
> -       /* XXX check if swapping is necessary on BE */
> -       if (ring->use_doorbell) {
> -               atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> -                            ring->wptr);
> -               WDOORBELL64(ring->doorbell_index, ring->wptr);
> -       } else {
> -               BUG(); /* only DOORBELL method supported on gfx12 now */
> -       }
> -}
> -
>  static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> @@ -5523,8 +5497,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_rin=
g_funcs_compute =3D {
>         .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
>         .support_64bit_ptrs =3D true,
>         .get_rptr =3D gfx_v12_0_ring_get_rptr_compute,
> -       .get_wptr =3D gfx_v12_0_ring_get_wptr_compute,
> -       .set_wptr =3D gfx_v12_0_ring_set_wptr_compute,
> +       .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> +       .set_wptr =3D amdgpu_gfx_set_wptr_compute,
>         .emit_frame_size =3D
>                 7 + /* gfx_v12_0_ring_emit_hdp_flush */
>                 5 + /* hdp invalidate */
> @@ -5561,8 +5535,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_rin=
g_funcs_kiq =3D {
>         .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
>         .support_64bit_ptrs =3D true,
>         .get_rptr =3D gfx_v12_0_ring_get_rptr_compute,
> -       .get_wptr =3D gfx_v12_0_ring_get_wptr_compute,
> -       .set_wptr =3D gfx_v12_0_ring_set_wptr_compute,
> +       .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> +       .set_wptr =3D amdgpu_gfx_set_wptr_compute,
>         .emit_frame_size =3D
>                 7 + /* gfx_v12_0_ring_emit_hdp_flush */
>                 5 + /*hdp invalidate */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 8249135d7..798f94bca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5640,37 +5640,6 @@ static u64 gfx_v9_0_ring_get_rptr_compute(struct a=
mdgpu_ring *ring)
>         return *ring->rptr_cpu_addr; /* gfx9 hardware is 32bit rptr */
>  }
>
> -static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
> -{
> -       u64 wptr;
> -
> -       /* XXX check if swapping is necessary on BE */
> -       if (ring->use_doorbell) {
> -               wptr =3D atomic64_read((atomic64_t *)ring->wptr_cpu_addr)=
;
> -       } else {
> -               WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr read on ring %s=
, "
> -                         "only doorbell method supported on gfx9\n",
> -                         ring->name);
> -               wptr =3D 0;
> -       }
> -       return wptr;
> -}
> -
> -static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
> -{
> -       struct amdgpu_device *adev =3D ring->adev;
> -
> -       /* XXX check if swapping is necessary on BE */
> -       if (ring->use_doorbell) {
> -               atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wpt=
r);
> -               WDOORBELL64(ring->doorbell_index, ring->wptr);
> -       } else {
> -               WARN_ONCE(1, "gfx_v9_0: non-doorbell wptr write on ring %=
s, "
> -                         "only doorbell method supported on gfx9\n",
> -                         ring->name);
> -       }
> -}
> -
>  static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 a=
ddr,
>                                          u64 seq, unsigned int flags)
>  {
> @@ -7627,8 +7596,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_compute =3D {
>         .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
>         .support_64bit_ptrs =3D true,
>         .get_rptr =3D gfx_v9_0_ring_get_rptr_compute,
> -       .get_wptr =3D gfx_v9_0_ring_get_wptr_compute,
> -       .set_wptr =3D gfx_v9_0_ring_set_wptr_compute,
> +       .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> +       .set_wptr =3D amdgpu_gfx_set_wptr_compute,
>         .emit_frame_size =3D
>                 20 + /* gfx_v9_0_ring_emit_gds_switch */
>                 7 + /* gfx_v9_0_ring_emit_hdp_flush */
> @@ -7669,8 +7638,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_kiq =3D {
>         .nop =3D PACKET3(PACKET3_NOP, 0x3FFF),
>         .support_64bit_ptrs =3D true,
>         .get_rptr =3D gfx_v9_0_ring_get_rptr_compute,
> -       .get_wptr =3D gfx_v9_0_ring_get_wptr_compute,
> -       .set_wptr =3D gfx_v9_0_ring_set_wptr_compute,
> +       .get_wptr =3D amdgpu_gfx_get_wptr_compute,
> +       .set_wptr =3D amdgpu_gfx_set_wptr_compute,
>         .emit_frame_size =3D
>                 20 + /* gfx_v9_0_ring_emit_gds_switch */
>                 7 + /* gfx_v9_0_ring_emit_hdp_flush */
> --
> 2.43.0
>
