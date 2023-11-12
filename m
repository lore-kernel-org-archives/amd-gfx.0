Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08400C4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Nov 2023 18:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81E8C10E14A;
	Sun, 12 Nov 2023 18:13:36 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE1010E14A
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Nov 2023 18:13:34 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1f066fc2a2aso1789063fac.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Nov 2023 10:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699812813; x=1700417613; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1A7DhyrdJtj01ZSvnrpy1XUymLK01C6IISiNADt+dI=;
 b=VOliTjm4oLnVgelIsJER3X7fyFe/ebuKgdu3a5JaglL/Wq0tFYFiEDaAIOo4H+UnEy
 IsglYS9FZL2+t8UWSVmNyCC86YVl4RZENfB1aR5MMpMrEISbjtWy/Pa+jp+CKCEsrGwJ
 arxXiT3eeorTKqBpnslWFAnuvxWikgFYZfn2NgRJuRR0C3ypB4b5XyBRTAFonlJ6kl1l
 Sc94u9xmBMP3lRHxLJQ2gB6LSC10kegI0yGG0dornOPK4nf4oq591TP05wfxXLkOU2rB
 f2gjFrZ7Jytsnq2dj328XFrgO5oXLwSfvL7BOPiO75sH0knxfxBAZdYPGjMwMZPxIVI9
 4SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699812813; x=1700417613;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L1A7DhyrdJtj01ZSvnrpy1XUymLK01C6IISiNADt+dI=;
 b=dl3BsxnawmagUSSSn1BEyxlq/mCogN0P/sZEQkx4IdzoDtRzjwrVIhFa9w8rMbVH2B
 nYBKOL0eF0EarVGjqB4xoeOscff428vVukpaCcE5meX5UlKYzR2LDHBV4Y3gMburqDCD
 qd8vIcyqGgCy6h6XnBeB2BGpcbKlrIkovI4omtmhpDMpAK7JQhKHJIkbNPkbxWvhpKM8
 1xQU74Wl4HAA2aH0s7Fl/Qotm9Z68Em/CjmtdIn9+PRlzT/GCvEMpCBvaN8PU1bPN0lG
 ex0QEDS11kMvglQqVZpV2W67nazEFczAo2npfQGKOpqPf58nIED9bf5ydcX8faoFlYDF
 r39g==
X-Gm-Message-State: AOJu0YwjFN0mOk5aNgGlyruOB285S43Wnk3OnCn9iWdYUv1y+7k7DyuV
 9C3BkBqGfVIPEhloINwnHBr2rYKFg7uYg1nFWUQWtpTk
X-Google-Smtp-Source: AGHT+IHpRfEUrgPJlsixQw6CwAzA1snXs6KEvrmsZKExPZPsvYpqWJciqbwRmZ0P498Yyia+XaaRLl/thD1Fg2m0c1k=
X-Received: by 2002:a05:6870:7e0d:b0:1e9:8e4f:30dd with SMTP id
 wx13-20020a0568707e0d00b001e98e4f30ddmr5122982oab.6.1699812813387; Sun, 12
 Nov 2023 10:13:33 -0800 (PST)
MIME-Version: 1.0
References: <20231110144701.1895397-1-alexander.deucher@amd.com>
 <59668638-00ce-4407-a0c1-47200480fe8f@amd.com>
In-Reply-To: <59668638-00ce-4407-a0c1-47200480fe8f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 12 Nov 2023 13:13:22 -0500
Message-ID: <CADnq5_O49zWhVhCopXFTC+9ijepy4iuV6vMbogP6+O8GWrZZOw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix AGP addressing when GART is not at 0
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Nov 11, 2023 at 2:17=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 10.11.23 um 15:47 schrieb Alex Deucher:
> > This worked by luck if the GART aperture ended up at 0.  When
> > we ended up moving GART on some chips, the GART aperture ended
> > up offsetting the the AGP address since the resource->start is
> > a GART offset, not an MC address.  Fix this by moving the AGP
> > address setup into amdgpu_bo_gpu_offset_no_check().
> >
> > Reported-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > Reported-by: Yifan Zhang <yifan1.zhang@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: christian.koenig@amd.com
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++++---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  4 +---
> >   2 files changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> > index cef920a93924..1b3e97522838 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -1527,10 +1527,14 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
> >   u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
> >   {
> >       struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> > -     uint64_t offset;
> > +     uint64_t offset, addr;
> >
> > -     offset =3D (bo->tbo.resource->start << PAGE_SHIFT) +
> > -              amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_type=
);
> > +     addr =3D amdgpu_gmc_agp_addr(&bo->tbo);
>
> IIRC you must check bo->tbo.resource->mem_type before calling
> amdgpu_gmc_agp_addr().

Yes, this was fixed in v2.

Alex

>
> Regards,
> Christian.
>
> > +     if (addr !=3D AMDGPU_BO_INVALID_OFFSET)
> > +             offset =3D addr;
> > +     else
> > +             offset =3D (bo->tbo.resource->start << PAGE_SHIFT) +
> > +                     amdgpu_ttm_domain_start(adev, bo->tbo.resource->m=
em_type);
> >
> >       return amdgpu_gmc_sign_extend(offset);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 05991c5c8ddb..ab4a762aed5b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -959,10 +959,8 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object=
 *bo)
> >               return 0;
> >
> >       addr =3D amdgpu_gmc_agp_addr(bo);
> > -     if (addr !=3D AMDGPU_BO_INVALID_OFFSET) {
> > -             bo->resource->start =3D addr >> PAGE_SHIFT;
> > +     if (addr !=3D AMDGPU_BO_INVALID_OFFSET)
> >               return 0;
> > -     }
> >
> >       /* allocate GART space */
> >       placement.num_placement =3D 1;
>
