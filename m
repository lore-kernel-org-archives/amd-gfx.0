Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25BDC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 01:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EDF710F08A;
	Wed, 24 Apr 2024 01:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M58lEb9R";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 769D810F08A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 01:46:07 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2a2e5d86254so324294a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 18:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713923166; x=1714527966; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvp9Eq/mCdlYSdpoWboJyGD5SXAiya+xfkkQ6LR89xg=;
 b=M58lEb9RxZ0sqlYmJu7cOOgrr2VlqlZDKhF9N5SU0DiMVS4iPAhVxLlmDsrO9PVu5Z
 OQlJEc4lu1cjo+FP2wILSkiXL0zf/3C13NZiJKfqkizPOVDLxGE/6V+aD3tv1UmGS5ln
 H8cL46DKhe5yEvLU/GJogir84+ITRtwJETvKNdnFLrGb3W++F1wkynxq0O2mrOWLY0hn
 L9HmN6JaUYhdk522is3FA2Kk6O64Oobff38gbUvR5T6AWZslYIYOsfzYjl/p1JizayAJ
 CwPXSubImjJaERdMKIs3Xf7L0H/Do+20+lkGETnzXCKWxvaY2AdvpcfnrqEipA9UxiYe
 21JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713923166; x=1714527966;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvp9Eq/mCdlYSdpoWboJyGD5SXAiya+xfkkQ6LR89xg=;
 b=mV24adxedqXzEGANoaJoNfGro8wgT+9gMWnVbbB4CdNJXa7CKBvqzB6bXm88JScG2E
 dgzsYeWXGYfh1xrFpwEQ/m66EITmXPuHktBKSg9R+SrfGMI9UaxW7pkxmNT5VCdJITTL
 Lb/wkFv+zw1T4H9bO8DKo+KIQ/D6UPEKbtX3TN1EbO2Ckcq/YOxEEOp4CqDuUEv21RNR
 jg9+dhctNGUm3dULb7rVRBL9DrsuRpTb/MYQQQ9bPrey3QCDiTnIuVUT8feZKZrzICu6
 EogYnwoMMzsgV4SrXBf2qbCvxSz9TWNWAo8pcDNvFjw1s7xKiw1AnJyg57Z+X6fbBIdV
 U3pQ==
X-Gm-Message-State: AOJu0YwA3f46IxHSe33Kr9vj0U2LDMoJtfssFlq/t/hqpUf6DNMOgZHX
 q2ECNLMY2vLqqdw9GMtZTHIZD3LVRvu5FopIP+BL77dh9HZgzj+tXUjL3PGAAg96kn14gDLR3LR
 H4B8UB1F5H9GcyiTWp/WsFdRNra9KXw==
X-Google-Smtp-Source: AGHT+IEdTAWgX8ZFbUF+2n0VyNzn/d3Bx5xiZFIBZxp2EZGhNGstxcAL3BMR++zhuEvnZvrltRx2CkONp6A3eTO2Rmc=
X-Received: by 2002:a17:90a:d482:b0:29b:fb23:863e with SMTP id
 s2-20020a17090ad48200b0029bfb23863emr1471337pju.17.1713923166499; Tue, 23 Apr
 2024 18:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240424011940.723906-1-jesse.zhang@amd.com>
In-Reply-To: <20240424011940.723906-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Apr 2024 21:45:53 -0400
Message-ID: <CADnq5_MZeCg3dUnkCmKXu-m1Kp01yR0h1uz2htKoWaQdbj-+_A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix some uninitialized variables
To: Jesse Zhang <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Tim.Huang@amd.com
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

On Tue, Apr 23, 2024 at 9:27=E2=80=AFPM Jesse Zhang <jesse.zhang@amd.com> w=
rote:
>
> Fix some variables not initialized before use.
> Scan them out using Synopsys tools.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 5 +++++
>  drivers/gpu/drm/amd/amdgpu/atom.c       | 1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c  | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c  | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c  | 3 ++-

Please split out the SDMA changes into a separate patch.

More comments below on the other hunks.

>  6 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vce.c
> index 59acf424a078..60d97cd14855 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -742,7 +742,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser =
*p,
>         uint32_t destroyed =3D 0;
>         uint32_t created =3D 0;
>         uint32_t allocated =3D 0;
> -       uint32_t tmp, handle =3D 0;
> +       uint32_t tmp =3D 0, handle =3D 0;

Can you elaborate on what the issue is here?  Presumably it's warning
about size being passed as a parameter in the function?

>         uint32_t *size =3D &tmp;
>         unsigned int idx;
>         int i, r =3D 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 677eb141554e..13125ddd5e86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -410,6 +410,11 @@ static void amdgpu_vcn_idle_work_handler(struct work=
_struct *work)
>                         else
>                                 new_state.fw_based =3D VCN_DPG_STATE__UNP=
AUSE;
>
> +                       if (amdgpu_fence_count_emitted(adev->jpeg.inst->r=
ing_dec))
> +                               new_state.jpeg =3D VCN_DPG_STATE__PAUSE;
> +                       else
> +                               new_state.jpeg =3D VCN_DPG_STATE__UNPAUSE=
;
> +
>                         adev->vcn.pause_dpg_mode(adev, j, &new_state);
>                 }
>

This should be a separate patch as well.

> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 72362df352f6..d552e013354c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -1243,6 +1243,7 @@ static int amdgpu_atom_execute_table_locked(struct =
atom_context *ctx, int index,
>         ectx.ps_size =3D params_size;
>         ectx.abort =3D false;
>         ectx.last_jump =3D 0;
> +       ectx.last_jump_jiffies =3D 0;
>         if (ws) {
>                 ectx.ws =3D kcalloc(4, ws, GFP_KERNEL);
>                 ectx.ws_size =3D ws;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_0.c
> index 45a2d0a5a2d7..b7d33d78bce0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -999,7 +999,8 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_rin=
g *ring)
>         r =3D amdgpu_ring_alloc(ring, 20);
>         if (r) {
>                 DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", r=
ing->idx, r);
> -               amdgpu_device_wb_free(adev, index);
> +               if (!ring->is_mes_queue)
> +                       amdgpu_device_wb_free(adev, index);
>                 return r;
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_2.c
> index 43e64b2da575..cc9e961f0078 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -839,7 +839,8 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_rin=
g *ring)
>         r =3D amdgpu_ring_alloc(ring, 20);
>         if (r) {
>                 DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", r=
ing->idx, r);
> -               amdgpu_device_wb_free(adev, index);
> +               if (!ring->is_mes_queue)
> +                       amdgpu_device_wb_free(adev, index);
>                 return r;
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index 1f4877195213..c833b6b8373b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -861,7 +861,8 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_rin=
g *ring)
>         r =3D amdgpu_ring_alloc(ring, 5);
>         if (r) {
>                 DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", r=
ing->idx, r);
> -               amdgpu_device_wb_free(adev, index);
> +               if (!ring->is_mes_queue)
> +                       amdgpu_device_wb_free(adev, index);
>                 return r;
>         }
>
> --
> 2.25.1
>
