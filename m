Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96248C77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 15:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3813F10E02D;
	Mon, 23 Jun 2025 15:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EgelVo2E";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FDDC10E02D
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 15:51:40 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3138e64fc73so493172a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750693899; x=1751298699; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFRDkAbXbVnL6VjN+e4Y9RzodQqZVv202wILNyNgeHc=;
 b=EgelVo2EhLG3s4Y7XbRchIRIugV8WgO6vofqX5OPiN9RR8srLZF/KWYXw5wYx8i7XL
 6ZXpHpp0IVSws5GNI7aP/ydLK8CMCzu3pPSasdRA8MBCerBf+0MFeI9orHHdxm6knD35
 dw/7EzU+Mpto0FivksGG7mlLZQMu3BLHgCHbB+rSqV85EYiURCNKpzvuOXTyTN2y95MH
 go93Y2skpjPF5rgbngQkZw0ofWN7LnTN/4/JxAg4HZ/BgwM2EPmeQbJNe4f6jaSy1KXe
 yO4xstf2YhkGOctITP4O9P9kf/GF+44tLBw1WYtlLiSCfbikIBG56fcfJWKT6GoiiWzc
 29aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750693899; x=1751298699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFRDkAbXbVnL6VjN+e4Y9RzodQqZVv202wILNyNgeHc=;
 b=svrR7ZMe0VJgxxZo4c+ar/ramYnep4YfMNp+gCRzyRJRTttU3ets4XG+ENTQCLW+uc
 C6b4s4uAbBcT4lCHyN5X3IhPKBaQk16JOfB8MK9vrZqCFpJNz+T7cU/NPLwnbBOHXqBW
 Gcu1KRbJ8IjO1+Et6zJVSoKOoHKtkKKG2cU0jpm5wV9XHOlng+u4RTQqgj0OLn3VTKCh
 QM+9Z+xDMzWT8vYu6KVEciayE4GZ5b0SaYmK2h/6TwfnRHeg/SvdAjaibvrEb4QrxetW
 HS7AJF5qGzzBj6LRK4QtyFq+F3KhaLqFFCwe56/g7xrPDo+fd3Sk8NX3UfCLOKT4vrbR
 rGZA==
X-Gm-Message-State: AOJu0Ywlfmr7cwQETR/rlcGLh/zzjEPtXT4B7cwEJ31c0HvhPyUrEAMt
 tSxRs+QMq0q/UzfeX3rTfHXqzGLcsB5RYwsuNmROEd+S9kXhBIT+UBSkp8AAb9k2QCwx6LtR+XF
 Gk7WN/qMrSXJ28i15J5u0jsbwTK753D4=
X-Gm-Gg: ASbGnctY58got1kZgeGmjqc/YshO2eAo7bTex2qDNc5ViFi/2uz2Gf6swGXlG24QavH
 3I4a1yZzSDUkXeGz0gZz2VlESAcSLw90ZFb67v0r42uXO/YL5TR0F70hYlWPS/jkFJD99EwiMaZ
 XAa5wehxn6PzdF/MI0JIIdX7frFL9XUvIf2cTEkAB63qR2
X-Google-Smtp-Source: AGHT+IGZ7ALMWBH6iGHIfQgu9jnTubb31yRkzuslPyfDBx+bf9v7kB4TguLjNeDrhJk+uq21d0v5zs1KQHIbzbXUrcA=
X-Received: by 2002:a17:90b:2ecb:b0:313:f9fc:7214 with SMTP id
 98e67ed59e1d1-3159d628b4cmr8106673a91.1.1750693899427; Mon, 23 Jun 2025
 08:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250623090439.3811614-1-jesse.zhang@amd.com>
In-Reply-To: <20250623090439.3811614-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Jun 2025 11:51:27 -0400
X-Gm-Features: AX0GCFvROrV0X6aCrgJd6XDCliCjVZNTnWXCfe0y-_625_NivC4Y_dEFobAzR9E
Message-ID: <CADnq5_OZt-6DYOyNXE2JfexmznBqxbNuEdgeHYOK++OMGF6ZGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Add user queue instance count reporting
 for gfx12
To: Jesse Zhang <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Mon, Jun 23, 2025 at 5:13=E2=80=AFAM Jesse Zhang <jesse.zhang@amd.com> w=
rote:
>
> This change exposes the number of available user queue instances
> through the HW IP info query interface. The information helps
> user mode drivers properly allocate and manage queue resources.
>
> Key changes:
> 1. Added userq_gfx_instances and userq_compute_instances fields
>    to amdgpu_gfx structure
> 2. Initialized the values during GFX IP early init for v12
>    (only when user queues are not disabled via disable_uq)
> 3. Exposed the values through drm_amdgpu_info_hw_ip structure
>    via amdgpu_hw_ip_info()
>
> The values represent:
> - userq_gfx_instances: Number of GFX ring instances available
> - userq_compute_instances: Number of compute ring instances available
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 5 +++++
>  include/uapi/drm/amdgpu_drm.h           | 2 ++
>  4 files changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 08f268dab8f5..63a7f0e0db5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -452,6 +452,8 @@ struct amdgpu_gfx {
>         unsigned                        num_gfx_rings;
>         struct amdgpu_ring              compute_ring[AMDGPU_MAX_COMPUTE_R=
INGS * AMDGPU_MAX_GC_INSTANCES];
>         unsigned                        num_compute_rings;
> +       unsigned                        userq_gfx_instances;
> +       unsigned                        userq_compute_instances;
>         struct amdgpu_irq_src           eop_irq;
>         struct amdgpu_irq_src           priv_reg_irq;
>         struct amdgpu_irq_src           priv_inst_irq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 195ed81d39ff..ff05c82a3dff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -411,6 +411,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                         if (adev->gfx.gfx_ring[i].sched.ready &&
>                             !adev->gfx.gfx_ring[i].no_user_submission)
>                                 ++num_rings;
> +
> +               result->userq_num_instance =3D adev->gfx.userq_gfx_instan=
ces;
>                 ib_start_alignment =3D 32;
>                 ib_size_alignment =3D 32;
>                 break;
> @@ -420,6 +422,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>                         if (adev->gfx.compute_ring[i].sched.ready &&
>                             !adev->gfx.compute_ring[i].no_user_submission=
)
>                                 ++num_rings;
> +
> +               result->userq_num_instance =3D adev->gfx.userq_compute_in=
stances;
>                 ib_start_alignment =3D 32;
>                 ib_size_alignment =3D 32;
>                 break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 1234c8d64e20..482490783a0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3852,6 +3852,11 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_b=
lock *ip_block)
>                                                   AMDGPU_MAX_COMPUTE_RING=
S);
>         }
>
> +       if (!adev->gfx.disable_uq) {
> +               adev->gfx.userq_gfx_instances =3D GFX12_NUM_GFX_RINGS;
> +               adev->gfx.userq_compute_instances =3D AMDGPU_MAX_COMPUTE_=
RINGS;

These are kernel queue values.  If you want to expose something like
this, it should be something like the number of HQD slots available
for user queues for each queue type.  That said, what's the use case
for this?  Applications don't know what other applications are doing.

Alex

> +       }
> +
>         gfx_v12_0_set_kiq_pm4_funcs(adev);
>         gfx_v12_0_set_ring_funcs(adev);
>         gfx_v12_0_set_irq_funcs(adev);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 45c4fa13499c..8082270a7ceb 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1493,6 +1493,8 @@ struct drm_amdgpu_info_hw_ip {
>         __u32  available_rings;
>         /** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
>         __u32  ip_discovery_version;
> +       /* Userq available instance */
> +       __u32  userq_num_instance;
>  };
>
>  /* GFX metadata BO sizes and alignment info (in bytes) */
> --
> 2.34.1
>
