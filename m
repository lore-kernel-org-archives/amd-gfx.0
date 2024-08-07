Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCB3C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 19:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00E0610E194;
	Wed,  7 Aug 2024 19:16:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LnGp6oZy";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A493510E194
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 19:16:25 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2cfec641429so215045a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Aug 2024 12:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723058185; x=1723662985; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZ3L3crjJo9pfLsrFC2zY33bwC6pPU6pOd22o44fEbs=;
 b=LnGp6oZyHBr7xLm2b63YlaHQa9aEuapoT/Vf3tAz0JK3dmj6SCuWjwvrt//f8RSuq7
 xDlv7JwnH64XkfOT7HDlC09p1BzeioRBDwZjbeQvLM0h+4a22qreNmQXtQpzYtDUref+
 JCLfb1yfM0kjwWS8wtIjZG6ajWTW7T3uhCi8ULsjyTYSQXU/p5SRJf+DZ1/RDBgYCMLj
 9E08q7VqeQMAdd4ZRTq14DFvAzfSTEpFNX/NuRwiqUhaJInrXDZsjZs8Vuyi1mObMfTU
 Eh8OorUpRxNeeyhLrTYC/qx636yEJCCEIfMX3Xqn9ImWfEGySVlC8HxsICvNUNqfe+fT
 AnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723058185; x=1723662985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZ3L3crjJo9pfLsrFC2zY33bwC6pPU6pOd22o44fEbs=;
 b=NxPUBkoT0V2hs44sVf2F8E9fkz3M2dook3N4MLilyLov7irDWxzzk/hsAoEXITSXgV
 kr2ukWfkl8TYVkdgEEl0JtBy30rpv4nQrEdZvKPfn0eLgW+AJZhSk8wFWNBxUUOiQHtu
 jPH3sSTwIwJ5fNkWujhUgn0X+lLzFFAki+eoAHfYwsZqI9oNDLCaQTgn9W5pLcGLW41z
 NRJFOD9ugeRt/2k/Qqa/EE+BZykhjJv8EV6flRl4S3YluowtK0or9YZubggvInTsCuiU
 q5GeWq0AThxc4wN5yALtdMN2E50uL0rTw9o0J2UtObb2UGrBBxLKe8cnxRs91MfceA9Z
 BMWg==
X-Gm-Message-State: AOJu0Yz6APrcPYZd0Guhre7GMzVxDhdetztRHUBOsmuZ0aotdMjo9SrW
 VirkyfXT2lmFCne+Rs55QHlke/5YLkwdYEldWBkGiUDaE7TVL/6wL0zE/CdrtXVNJ+ef3h4vLJj
 qSPHxgQ8ecsTSjEF0WtbyT+uEGbBCMw==
X-Google-Smtp-Source: AGHT+IGQ6gZYKXaFEAUe8w3KIzfRktaAGGJX/xe7MWuJFkCWF5yiCbeNOkmlkwWsNracDzNxDikhLyuVNz3UIrPVjX8=
X-Received: by 2002:a17:90a:f293:b0:2c9:6f91:fc43 with SMTP id
 98e67ed59e1d1-2cff93c4c31mr18985636a91.3.1723058184875; Wed, 07 Aug 2024
 12:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240807093847.2084710-1-Jack.Xiao@amd.com>
 <20240807093847.2084710-9-Jack.Xiao@amd.com>
In-Reply-To: <20240807093847.2084710-9-Jack.Xiao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Aug 2024 15:16:12 -0400
Message-ID: <CADnq5_PkCtKYnenAAvE5OQm9pGU5gUcgDAh+eVs8WmKSLfRoAg@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/amdgpu/mes12: fix suspend issue
To: Jack Xiao <Jack.Xiao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
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

On Wed, Aug 7, 2024 at 5:39=E2=80=AFAM Jack Xiao <Jack.Xiao@amd.com> wrote:
>
> Use mes pipe to unmap kcq and kgq.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 22 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 27 +------------------------
>  2 files changed, 23 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index f165b9d49e29..c770cb201e64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -509,6 +509,16 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *ade=
v, int xcc_id)
>         int i, r =3D 0;
>         int j;
>
> +       if (adev->enable_mes) {
> +               for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> +                       j =3D i + xcc_id * adev->gfx.num_compute_rings;
> +                       amdgpu_mes_unmap_legacy_queue(adev,
> +                                                  &adev->gfx.compute_rin=
g[j],
> +                                                  RESET_QUEUES, 0, 0);
> +               }
> +               return 0;
> +       }
> +
>         if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>                 return -EINVAL;
>
> @@ -551,6 +561,18 @@ int amdgpu_gfx_disable_kgq(struct amdgpu_device *ade=
v, int xcc_id)
>         int i, r =3D 0;
>         int j;
>
> +       if (adev->enable_mes) {
> +               if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
> +                       for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> +                               j =3D i + xcc_id * adev->gfx.num_gfx_ring=
s;
> +                               amdgpu_mes_unmap_legacy_queue(adev,
> +                                                     &adev->gfx.gfx_ring=
[j],
> +                                                     PREEMPT_QUEUES, 0, =
0);
> +                       }
> +               }
> +               return 0;
> +       }
> +
>         if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>                 return -EINVAL;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index f384be0d1800..c77c66155d8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3519,33 +3519,9 @@ static int gfx_v12_0_hw_init(void *handle)
>         return r;
>  }
>
> -static int gfx_v12_0_kiq_disable_kgq(struct amdgpu_device *adev)
> -{
> -       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> -       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> -       int i, r =3D 0;
> -
> -       if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> -               return -EINVAL;
> -
> -       if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
> -                                       adev->gfx.num_gfx_rings))
> -               return -ENOMEM;
> -
> -       for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
> -               kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.gfx_ring[=
i],
> -                                          PREEMPT_QUEUES, 0, 0);
> -
> -       if (adev->gfx.kiq[0].ring.sched.ready)
> -               r =3D amdgpu_ring_test_helper(kiq_ring);
> -
> -       return r;
> -}
> -
>  static int gfx_v12_0_hw_fini(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -       int r;
>         uint32_t tmp;
>
>         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> @@ -3553,8 +3529,7 @@ static int gfx_v12_0_hw_fini(void *handle)
>
>         if (!adev->no_hw_access) {
>                 if (amdgpu_async_gfx_ring) {
> -                       r =3D gfx_v12_0_kiq_disable_kgq(adev);
> -                       if (r)
> +                       if (amdgpu_gfx_disable_kgq(adev, 0))
>                                 DRM_ERROR("KGQ disable failed\n");
>                 }
>
> --
> 2.41.0
>
