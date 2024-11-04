Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1322D132D7
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 14:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C41910E453;
	Mon,  4 Nov 2024 14:48:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HcoxTybU";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A9D10E44B
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 14:48:50 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-20b533c6865so5147775ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Nov 2024 06:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730731729; x=1731336529; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onfQeZqxr03TO7ojzu78tUavMfNz7YEwqQzZsVSVnoA=;
 b=HcoxTybUgc2bf11sabKQj89p2Y2mKdiI89KmLMO+fjr2byarIXSNwwKGQfkoe9SDfu
 vjhQtj1HQN+6Kisv4frJRIxuhhCwkY8Xz6xgTcJ75PJGBkrsUB8eG6/cimYtBKd0r1Iu
 bdPB+OkShgRvAWqIM7p7xKjCkL1Z5nCScXfqdCg4gtqaSQ4/Evr9Mw6GDZ38A1skztzT
 fhaNoXnouGLDyMXMLMZ8KJz8vyNaIOVjEfucmOqIkjPfK8VloYhbK0aKObWBbU9GvPHW
 HFuTrlVWRu1355RNhkSyKj8hPXQ4MBSpb7l2tSLnsf8fHnabFBFKxOWCkOMyNzChMhTX
 knSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730731729; x=1731336529;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=onfQeZqxr03TO7ojzu78tUavMfNz7YEwqQzZsVSVnoA=;
 b=hC05MdFlHUFS7bZRr+OHpEylBHBvEYefcDRUENFqn0n6TWI+XO10PGDSKlVP3HiIu3
 l+dDBQKDYPsHon4LMpuEKjQ93edHueyNoukTjuO89XWl1jIuOACkMQrynuic9oY9JsK2
 nK/2p8eRoNDXFgUg3AGj9PyUHKvXONyXdudObxFzQfQKGKpcDIwZEMIFSu+GI25WXdn0
 tCl7fU7rphrqP0d5Wik1+A8PAa3kU1uNSqOWkhYeGq0wYRu9VbvdC/gZpfTQIaeV0+Ek
 hBHUB0Kyg4FxHQuaNQi/brsOhdhhPRNMBY4a41mT4LxEAwMMpiO2JBHIM9IcqfZmsWJW
 gPEA==
X-Gm-Message-State: AOJu0Yw8ACGWG0uE0tOmXTSUoyUgtlOD+J3q/DbcLWYsJnfLd30gpZqW
 mnujtu+SncJktaAU++LPe5YBplwbme/mmSspJOMNzyChhMlCoJ59OIAjAhHmC4Qx0JRMW1U4PTW
 G9aTNCy9uG7kjjA1ia9klZP2lIfU=
X-Google-Smtp-Source: AGHT+IFu6b8eSCNn24gFm0crtpFV81KwlJKG51wCuuB3zgPVDZoUKTb8lPyaJ2nXLDT85UfPk9e0V/Fh5Mm7mFHAgX8=
X-Received: by 2002:a17:902:d488:b0:20c:e169:eb6a with SMTP id
 d9443c01a7336-210c6c9bf08mr187603745ad.10.1730731729325; Mon, 04 Nov 2024
 06:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20241031094929.55323-1-christian.koenig@amd.com>
In-Reply-To: <20241031094929.55323-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Nov 2024 09:48:37 -0500
Message-ID: <CADnq5_Pqz1z8KashAP1BfhF1cdpCJznqWyur=yX-d9H2VW6Zgg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix check in gmc_v9_0_get_vm_pte()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com, 
 rajneesh.bhardwaj@amd.com, Pierre-eric.Pelloux-prayer@amd.com
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

On Thu, Oct 31, 2024 at 5:49=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> The coherency flags can only be determined when the BO is locked and that
> in turn is only guaranteed when the mapping is validated.
>
> Fix the check, move the resource check into the function and add an asser=
t
> that the BO is locked.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Fixes: d1a372af1c3d ("drm/amdgpu: Set MTYPE in PTE based on BO flags")

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index f43ded8a0aab..50c5da3020cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1130,8 +1130,10 @@ static void gmc_v9_0_get_coherence_flags(struct am=
dgpu_device *adev,
>                                          uint64_t *flags)
>  {
>         struct amdgpu_device *bo_adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> -       bool is_vram =3D bo->tbo.resource->mem_type =3D=3D TTM_PL_VRAM;
> -       bool coherent =3D bo->flags & (AMDGPU_GEM_CREATE_COHERENT | AMDGP=
U_GEM_CREATE_EXT_COHERENT);
> +       bool is_vram =3D bo->tbo.resource &&
> +               bo->tbo.resource->mem_type =3D=3D TTM_PL_VRAM;
> +       bool coherent =3D bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +                                    AMDGPU_GEM_CREATE_EXT_COHERENT);
>         bool ext_coherent =3D bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENT;
>         bool uncached =3D bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
>         struct amdgpu_vm *vm =3D mapping->bo_va->base.vm;
> @@ -1139,6 +1141,8 @@ static void gmc_v9_0_get_coherence_flags(struct amd=
gpu_device *adev,
>         bool snoop =3D false;
>         bool is_local;
>
> +       dma_resv_assert_held(bo->tbo.base.resv);
> +
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>         case IP_VERSION(9, 4, 1):
>         case IP_VERSION(9, 4, 2):
> @@ -1257,9 +1261,8 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_devic=
e *adev,
>                 *flags &=3D ~AMDGPU_PTE_VALID;
>         }
>
> -       if (bo && bo->tbo.resource)
> -               gmc_v9_0_get_coherence_flags(adev, mapping->bo_va->base.b=
o,
> -                                            mapping, flags);
> +       if ((*flags & AMDGPU_PTE_VALID) && bo)
> +               gmc_v9_0_get_coherence_flags(adev, bo, mapping, flags);
>  }
>
>  static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
> --
> 2.34.1
>
