Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E593ACCF9E7
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 17:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FE4310E24E;
	Wed, 25 Sep 2024 17:16:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LYwlVLzr";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F316710E24E
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 17:16:56 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2db6b13c6a0so20252a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727284616; x=1727889416; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6qxC/EH0/WqElNWjgvkNRHtcX3ifISpVqT4zcfCKu8I=;
 b=LYwlVLzrh02MR44MFf6CnubVnj7y0XsSWVdskv+dNt46aajI/rLuV11zNhnzmVfYXk
 ohVgE+SpcjgF4uFA0h4QmLjpIsNhBTMD50musZOPN3NKaKeLNQYWY5djvBzjRsvLT4wq
 QkMIQWuQWrDCX3JYtmxxRTFPaIziHRKY3fkaZZj6t5OW2dkoN/DvyCNSUX5UTTFT5RcI
 H3I7yFpAXt9rbldJAEqhD3hkqYUk6gioWlJNKqp5ioxU48qK7RMJBMtoFb2Y8kT45d0P
 El7clZKFGVW7Qudk4xeIh6VQ5yYmgT52H1xReAfhxRy/Pe3CbFGcUGJvpnUM3RLw/EWO
 Ae0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727284616; x=1727889416;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6qxC/EH0/WqElNWjgvkNRHtcX3ifISpVqT4zcfCKu8I=;
 b=d5Yf2QqEFK1TFc1Qkb3Dyl2BAmXsLHt6SbxEyc9ROJTzxTTZjpXwFNc1BeUv5xR60l
 6LJgQbDSkSDjB1Ut7CXeZdSQwYjSpMpweV8xY8VX9habCXpWNRDRql9UhaO9IJkE9MwS
 u4sljwiwMtlHNLkRkwrT63r5P0Uaq7cyR4vJ8gMlz8gnT6jKdjuj6+L4QIC88xdTOJtb
 UgHN/OIzbcp/sjpMhlqtTh6+ms3pvxBuEiNfXKVXObk7KLRqW9BIlj68tF5YNqC5Rb0O
 DOd8UsWDI+NXLoZXv9BANvsR/rPmvBtVgogZiHD5Z1kk6oDcpgrSRvp6pwl0HBxhYWFr
 rEEA==
X-Gm-Message-State: AOJu0Yy5e9tily0MG2EPrIKGJDIrMCHEHvQMbBamKvUhUFkJc75J4B7Y
 vluJc2aKp7Z9ur8floOazum9VVIv4HFYpkZtlyW8eOxRrU0Av7R7cLCjfJ6pRZnX/jpm10sD2Xt
 a72LVHuU9yrOTN4mvv1L+8k9vOS8=
X-Google-Smtp-Source: AGHT+IE5Pe8dT4NR5qcVrgKyQWpHqeBiqxL4w526t07YV9YOJ+1LX6nk/EmYbptJ7tCES3XxoY5qj9O2rJOT32NHrIk=
X-Received: by 2002:a17:90b:124d:b0:2ca:7e67:d11e with SMTP id
 98e67ed59e1d1-2e06ae26b15mr1704830a91.2.1727284616246; Wed, 25 Sep 2024
 10:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240923081931.2126969-1-yifan1.zhang@amd.com>
 <CADnq5_Nm_OdBNbDR+J_w4v2yK4_yH5GxVdRwinJsgZBys69Lgg@mail.gmail.com>
 <CY5PR12MB63693340F3FFE996395FFA97C1682@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB63693340F3FFE996395FFA97C1682@CY5PR12MB6369.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Sep 2024 13:16:44 -0400
Message-ID: <CADnq5_PT+A_+3_WnofKF3_4kLB6u=fPFSow5Nc-e8Hbrrg6OGw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: simplify vram alloc logic since 2GB
 limitation removed
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
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

On Tue, Sep 24, 2024 at 10:22=E2=80=AFAM Zhang, Yifan <Yifan1.Zhang@amd.com=
> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> 2GB limitation in VRAM allocation is removed in below patch. My patch is =
a follow up refine for this. The remaing_size calculation was to address th=
e 2GB limitation in contiguous VRAM allocation, and no longer needed after =
the limitation is removed.
>

Thanks.  Would be good to add a reference to this commit in the commit
message so it's clear what you are talking about and also provide a
bit more of a description about why this can be cleaned up (like you
did above).  One other comment below as well.


> commit b2dba064c9bdd18c7dd39066d25453af28451dbf
> Author: Philip Yang <Philip.Yang@amd.com>
> Date:   Fri Apr 19 16:27:00 2024 -0400
>
>     drm/amdgpu: Handle sg size limit for contiguous allocation
>
>     Define macro AMDGPU_MAX_SG_SEGMENT_SIZE 2GB, because struct scatterli=
st
>     length is unsigned int, and some users of it cast to a signed int, so
>     every segment of sg table is limited to size 2GB maximum.
>
>     For contiguous VRAM allocation, don't limit the max buddy block size =
in
>     order to get contiguous VRAM memory. To workaround the sg table segme=
nt
>     size limit, allocate multiple segments if contiguous size is bigger t=
han
>     AMDGPU_MAX_SG_SEGMENT_SIZE.
>
>     Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>     Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
>
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, September 24, 2024 10:07 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip <Philip.Yang@amd.com>; Ku=
ehling, Felix <Felix.Kuehling@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: simplify vram alloc logic since 2GB limi=
tation removed
>
> On Mon, Sep 23, 2024 at 4:28=E2=80=AFAM Yifan Zhang <yifan1.zhang@amd.com=
> wrote:
> >
> > Make vram alloc loop simpler after 2GB limitation removed.
>
> Can you provide more context?  What 2GB limitation are you referring to?
>
> Alex
>
> >
> > Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 15 +++++----------
> >  1 file changed, 5 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > index 7d26a962f811..3d129fd61fa7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > @@ -455,7 +455,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_=
manager *man,
> >         struct amdgpu_bo *bo =3D ttm_to_amdgpu_bo(tbo);
> >         u64 vis_usage =3D 0, max_bytes, min_block_size;
> >         struct amdgpu_vram_mgr_resource *vres;
> > -       u64 size, remaining_size, lpfn, fpfn;
> > +       u64 size, lpfn, fpfn;
> >         unsigned int adjust_dcc_size =3D 0;
> >         struct drm_buddy *mm =3D &mgr->mm;
> >         struct drm_buddy_block *block; @@ -516,25 +516,23 @@ static
> > int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
> >             adev->gmc.gmc_funcs->get_dcc_alignment)
> >                 adjust_dcc_size =3D amdgpu_gmc_get_dcc_alignment(adev);
> >
> > -       remaining_size =3D (u64)vres->base.size;
> > +       size =3D (u64)vres->base.size;
> >         if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS && adjust_dcc=
_size) {
> >                 unsigned int dcc_size;
> >
> >                 dcc_size =3D roundup_pow_of_two(vres->base.size + adjus=
t_dcc_size);
> > -               remaining_size =3D (u64)dcc_size;
> > +               size =3D (u64)dcc_size;
> >
> >                 vres->flags |=3D DRM_BUDDY_TRIM_DISABLE;
> >         }
> >
> >         mutex_lock(&mgr->lock);
> > -       while (remaining_size) {
> > +       while (true) {

I think you can also drop this while loop now too.

Alex

> >                 if (tbo->page_alignment)
> >                         min_block_size =3D (u64)tbo->page_alignment << =
PAGE_SHIFT;
> >                 else
> >                         min_block_size =3D mgr->default_page_size;
> >
> > -               size =3D remaining_size;
> > -
> >                 if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS && ad=
just_dcc_size)
> >                         min_block_size =3D size;
> >                 else if ((size >=3D (u64)pages_per_block << PAGE_SHIFT)
> > && @@ -562,10 +560,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resou=
rce_manager *man,
> >                 if (unlikely(r))
> >                         goto error_free_blocks;
> >
> > -               if (size > remaining_size)
> > -                       remaining_size =3D 0;
> > -               else
> > -                       remaining_size -=3D size;
> > +               break;
> >         }
> >         mutex_unlock(&mgr->lock);
> >
> > --
> > 2.43.0
> >
