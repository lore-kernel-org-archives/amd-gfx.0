Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484D6C83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 23:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4EA310E171;
	Mon, 28 Jul 2025 23:19:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D26gA5ss";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A9F10E171
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 23:19:28 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-31ed2c4cfcbso292690a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 16:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753744768; x=1754349568; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VYYhcplW3PlhiOPpirg7g6PgjnkJvgcI/iVG3OCk8/s=;
 b=D26gA5ssiChUPVkBL8U5Yq3livbGx6ufXjyjAcbppddYWB5F2Fy1NCa35eMc6p2DzC
 DPoaRdistixezARYo/2XbxM2pG7TOiv/KSk7oDsiBuWh1qNOrhpF2G6eUYFnWY7NiNz2
 PWoldmUGuAZc8sxdvd9l5h6gU6WgcvsEHh5PQKUfMx2+qCBI6+7XflugPWd9m+R7QaCa
 C2KATWImLTAHrcwJ4qnoc8UF3O1yzWoLtSAqRxUYSk3HjILJKCvLTlxEsb61X8Q60+Hp
 pDdpNF6kyYQ+jx1pZThv5fwyNGSn29M67he+JGcHLd5DtkpvPz7a65nUCS0d7ht5HaBH
 GWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753744768; x=1754349568;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VYYhcplW3PlhiOPpirg7g6PgjnkJvgcI/iVG3OCk8/s=;
 b=iaDrbwTpUuMHLvV6AoRjrf37tx3mEFVcVyZmqHG+e0GQC4NYdU77d4fmgFIcvK915j
 R3ePaXcY8GICfuXG7gxJ/UdLLZQBTmRJ4Atwuyy26FaIpQdNEliMLWDQGYcWAjHEXfbd
 DMk7nRpbw6QoLybUDUUDnAz+SAzAi1twXDmkwegvFvrbdq8apuTAS/6ViGteIER8cwCR
 7KLShr/7di4qgLyS1cRgeckIAs6kVg6jCmTOZJ+77tXxHdUV/At3zM4LyLrXWaBh/efA
 ePL3+YEMxDDLGLyCJntlyB/pOFjdHEz5gbwf16Yi+Gao4w9SUfy9A0tcg22soAWivckA
 Kvhw==
X-Gm-Message-State: AOJu0YyBPEvoixKsVs3ge2u0vAlGjQYfDUtuPmKti90EdaNi4p8805GG
 X5bg/lcYCeF7hWfnVwNFphKMrPeRmfKp9aakLG5PbmW1zN/qNEl3uOWngfoMs1gz6ROFeNRJOSk
 ZhIieWbD4UAOTE36au4CnLB/AlLDGZWw=
X-Gm-Gg: ASbGncu11wElbFTP2w3GMDS5f0hz0g7+15aLhP4RA/78FYHjl36CnzVQJoq2IDDrA5c
 6qNW5+QIgvaYmFLOsEtTpV0l3lEDB4EtFFY31Sq8x/cW9fRHFd9U+8sjR4D7v6nxElXJmMLWNRC
 CbqtdH2+GgAiETxYsUnfr3s+DeGWWBKrfOf8xL8DgQs40+MjS0YB3FOKDnHBOxGsY2uwGf5mApK
 8upDjptq3bPara7e1o=
X-Google-Smtp-Source: AGHT+IFUqRNcfZkgwq5ABFfNUMDYr5YLzCWOBpKo1QIhPevdgWAeh+xgsbY4SJVtOc7YfYMdDYzgw6qH6I/0Nyuobrg=
X-Received: by 2002:a17:90b:4ac5:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-31e77a4a596mr7645257a91.5.1753744767527; Mon, 28 Jul 2025
 16:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250715212420.2254925-1-superm1@kernel.org>
In-Reply-To: <20250715212420.2254925-1-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jul 2025 19:19:16 -0400
X-Gm-Features: Ac12FXyQmf92Hcj18-3yH5aUSVIO8M2R2OfprFNkNeTBgX8f7q-RgWDPrvFbKco
Message-ID: <CADnq5_OoPXc4Ec2-HYxBGH23nJLM-+BvXGEEu9SO_RLj+ZGBKA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd: Use drm_*() macros instead of DRM_*() for
 amdgpu_cs
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
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

On Tue, Jul 15, 2025 at 5:24=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Some of the IOCTL messages can be called for different GPUs and it might
> not be obvious which one called them from a problem.  Using the drm_*()
> macros the correct device will be shown in the messages.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2:
>  * use adev_to_drm (Lijo)
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 9ea0d9b71f48..e1e48e6f1f35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -395,7 +395,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p=
,
>                            chunk_ib->ib_bytes : 0,
>                            AMDGPU_IB_POOL_DELAYED, ib);
>         if (r) {
> -               DRM_ERROR("Failed to get ib !\n");
> +               drm_err(adev_to_drm(p->adev), "Failed to get ib !\n");
>                 return r;
>         }
>
> @@ -467,7 +467,7 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgp=
u_cs_parser *p,
>
>         r =3D drm_syncobj_find_fence(p->filp, handle, point, flags, &fenc=
e);
>         if (r) {
> -               DRM_ERROR("syncobj %u failed to find fence @ %llu (%d)!\n=
",
> +               drm_err(adev_to_drm(p->adev), "syncobj %u failed to find =
fence @ %llu (%d)!\n",
>                           handle, point, r);
>                 return r;
>         }
> @@ -901,7 +901,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_pars=
er *p,
>                                          sizeof(struct page *),
>                                          GFP_KERNEL);
>                 if (!e->user_pages) {
> -                       DRM_ERROR("kvmalloc_array failure\n");
> +                       drm_err(adev_to_drm(p->adev), "kvmalloc_array fai=
lure\n");
>                         r =3D -ENOMEM;
>                         goto out_free_user_pages;
>                 }
> @@ -982,7 +982,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_pars=
er *p,
>         r =3D amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
>                                amdgpu_cs_bo_validate, p);
>         if (r) {
> -               DRM_ERROR("amdgpu_vm_validate() failed.\n");
> +               drm_err(adev_to_drm(p->adev), "amdgpu_vm_validate() faile=
d.\n");
>                 goto out_free_user_pages;
>         }
>
> @@ -1060,13 +1060,13 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_p=
arser *p,
>                 va_start =3D ib->gpu_addr & AMDGPU_GMC_HOLE_MASK;
>                 r =3D amdgpu_cs_find_mapping(p, va_start, &aobj, &m);
>                 if (r) {
> -                       DRM_ERROR("IB va_start is invalid\n");
> +                       drm_err(adev_to_drm(p->adev), "IB va_start is inv=
alid\n");
>                         return r;
>                 }
>
>                 if ((va_start + ib->length_dw * 4) >
>                     (m->last + 1) * AMDGPU_GPU_PAGE_SIZE) {
> -                       DRM_ERROR("IB va_start+ib_bytes is invalid\n");
> +                       drm_err(adev_to_drm(p->adev), "IB va_start+ib_byt=
es is invalid\n");
>                         return -EINVAL;
>                 }
>
> @@ -1234,7 +1234,7 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_pa=
rser *p)
>         r =3D amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_lead=
er_idx]);
>         if (r) {
>                 if (r !=3D -ERESTARTSYS)
> -                       DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n")=
;
> +                       drm_err(adev_to_drm(p->adev), "amdgpu_ctx_wait_pr=
ev_fence failed.\n");
>                 return r;
>         }
>
> @@ -1447,7 +1447,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)
>
>         r =3D amdgpu_cs_parser_init(&parser, adev, filp, data);
>         if (r) {
> -               DRM_ERROR_RATELIMITED("Failed to initialize parser %d!\n"=
, r);
> +               drm_err_ratelimited(dev, "Failed to initialize parser %d!=
\n", r);
>                 return r;
>         }
>
> @@ -1462,9 +1462,9 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *d=
ata, struct drm_file *filp)
>         r =3D amdgpu_cs_parser_bos(&parser, data);
>         if (r) {
>                 if (r =3D=3D -ENOMEM)
> -                       DRM_ERROR("Not enough memory for command submissi=
on!\n");
> +                       drm_err(dev, "Not enough memory for command submi=
ssion!\n");
>                 else if (r !=3D -ERESTARTSYS && r !=3D -EAGAIN)
> -                       DRM_DEBUG("Failed to process the buffer list %d!\=
n", r);
> +                       drm_dbg(dev, "Failed to process the buffer list %=
d!\n", r);
>                 goto error_fini;
>         }
>
> --
> 2.49.0
>
