Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137ABCDE015
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 15:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D9910E319;
	Thu, 26 Sep 2024 15:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cUWAmyHq";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E896D10E319
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 15:21:48 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-20b0c5895aaso1287975ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727364108; x=1727968908; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgmOyvwdQW3iUTz3jP8Vx10T/VlDJ3XJIij+Nsff4iM=;
 b=cUWAmyHq4XRTM4IFtizBbI/WwpmWKK8bbGsxVR0ZlUNuHByk6xQTKB53auWQhwO0kG
 l/wO2+bISKW2Dqj5kCT6xihFk9leLmrL3PlYxy0/z+7RwbjFtiPBr92i07avff/KUYtx
 aEeYubPK0K2hsIj2H11MSRs6eynK9cggvyymzaeddGXORS7DUGaNCa7/B5142J4bFTxe
 cD4uOr1mWwuVJpItniTmzGHSFw4VmW1uNtARQFHEQ3IJaIRM/imEtgC+huXDA+8+l0ol
 Uq12Hz72Ru5lK3axboJ55Cpc4a0YjyGyJg18cqfB2wujt1FvYd/eP/dgGxvHGI9LdfNx
 sQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727364108; x=1727968908;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VgmOyvwdQW3iUTz3jP8Vx10T/VlDJ3XJIij+Nsff4iM=;
 b=SuB9tNHDbLOHz+uA25kepTRA0w1OWDs45KCQVWEIlwdfgFyyWqBAfKVIbcbhqqDtzn
 aDMWn5emTs+Pyq8MvYbSfepdUOMa1iHWGzdMtGZr0VFUKphjDD25w02KMLYEA4efBQDV
 knr618LNiqACRPSlz8bxwLTMU9GI09GPo+fynxHzmMQQYJzgldzkTjIRmgufHHS6iXgD
 7Vp+jcK0x7ZwXr1LggC2spG9BTmD/ufJttrsFJnJgoF4apuvTvCzMLBjHRhQs46EtpKG
 Q3v1SlZA+xAS1Th2tr/rD4op+yd4bimfpwYiq4rqYU2/Ni44py13Z5Yzt8ozbSrQxMC+
 3b+w==
X-Gm-Message-State: AOJu0Yx237yJvuXLRYKtQE7RPmTX42ipKSadz1r+u4DOfPWmAj7KuZE9
 8JDn/+Q98r/P5EUPtJo2Ogh+QMmDE9ZT9Cu33+3NeeYS0n9Su1Sa4LQeqlpzdvzizcsWbjWHzh7
 9B5bvJY5n4jSpDvzdIk5WfCkomXc=
X-Google-Smtp-Source: AGHT+IG03HZLdJmAcl5rG9y8SR68QEgemKXOJTo2kEbj3y7iEWX+OCqIw+I21N8zZOOcwMYdYJZCksEcPfNRrAWL8qc=
X-Received: by 2002:a17:902:e802:b0:207:14ab:c436 with SMTP id
 d9443c01a7336-20b37b71085mr376505ad.12.1727364108329; Thu, 26 Sep 2024
 08:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240923081931.2126969-1-yifan1.zhang@amd.com>
 <CADnq5_Nm_OdBNbDR+J_w4v2yK4_yH5GxVdRwinJsgZBys69Lgg@mail.gmail.com>
 <CY5PR12MB63693340F3FFE996395FFA97C1682@CY5PR12MB6369.namprd12.prod.outlook.com>
 <CADnq5_PT+A_+3_WnofKF3_4kLB6u=fPFSow5Nc-e8Hbrrg6OGw@mail.gmail.com>
 <CY5PR12MB6369888F85CD5118C63F206FC16A2@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB6369888F85CD5118C63F206FC16A2@CY5PR12MB6369.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Sep 2024 11:21:36 -0400
Message-ID: <CADnq5_OnFLnO6+MpfDo6jRAJrcPf0DN1Qp89_7nyKQaWThe_8Q@mail.gmail.com>
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

On Thu, Sep 26, 2024 at 10:45=E2=80=AFAM Zhang, Yifan <Yifan1.Zhang@amd.com=
> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, September 26, 2024 1:17 AM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip <Philip.Yang@amd.com>; Ku=
ehling, Felix <Felix.Kuehling@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: simplify vram alloc logic since 2GB limi=
tation removed
>
> On Tue, Sep 24, 2024 at 10:22=E2=80=AFAM Zhang, Yifan <Yifan1.Zhang@amd.c=
om> wrote:
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > 2GB limitation in VRAM allocation is removed in below patch. My patch i=
s a follow up refine for this. The remaing_size calculation was to address =
the 2GB limitation in contiguous VRAM allocation, and no longer needed afte=
r the limitation is removed.
> >
>
> Thanks.  Would be good to add a reference to this commit in the commit me=
ssage so it's clear what you are talking about and also provide a bit more =
of a description about why this can be cleaned up (like you did above).  On=
e other comment below as well.
>
> Sure, I will send patch V2 to change commit message.
>
> > commit b2dba064c9bdd18c7dd39066d25453af28451dbf
> > Author: Philip Yang <Philip.Yang@amd.com>
> > Date:   Fri Apr 19 16:27:00 2024 -0400
> >
> >     drm/amdgpu: Handle sg size limit for contiguous allocation
> >
> >     Define macro AMDGPU_MAX_SG_SEGMENT_SIZE 2GB, because struct scatter=
list
> >     length is unsigned int, and some users of it cast to a signed int, =
so
> >     every segment of sg table is limited to size 2GB maximum.
> >
> >     For contiguous VRAM allocation, don't limit the max buddy block siz=
e in
> >     order to get contiguous VRAM memory. To workaround the sg table seg=
ment
> >     size limit, allocate multiple segments if contiguous size is bigger=
 than
> >     AMDGPU_MAX_SG_SEGMENT_SIZE.
> >
> >     Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> >     Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> >
> >
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Tuesday, September 24, 2024 10:07 PM
> > To: Zhang, Yifan <Yifan1.Zhang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Yang, Philip <Philip.Yang@amd.com>;
> > Kuehling, Felix <Felix.Kuehling@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: simplify vram alloc logic since 2GB
> > limitation removed
> >
> > On Mon, Sep 23, 2024 at 4:28=E2=80=AFAM Yifan Zhang <yifan1.zhang@amd.c=
om> wrote:
> > >
> > > Make vram alloc loop simpler after 2GB limitation removed.
> >
> > Can you provide more context?  What 2GB limitation are you referring to=
?
> >
> > Alex
> >
> > >
> > > Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 15 +++++----------
> > >  1 file changed, 5 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > > index 7d26a962f811..3d129fd61fa7 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > > @@ -455,7 +455,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resourc=
e_manager *man,
> > >         struct amdgpu_bo *bo =3D ttm_to_amdgpu_bo(tbo);
> > >         u64 vis_usage =3D 0, max_bytes, min_block_size;
> > >         struct amdgpu_vram_mgr_resource *vres;
> > > -       u64 size, remaining_size, lpfn, fpfn;
> > > +       u64 size, lpfn, fpfn;
> > >         unsigned int adjust_dcc_size =3D 0;
> > >         struct drm_buddy *mm =3D &mgr->mm;
> > >         struct drm_buddy_block *block; @@ -516,25 +516,23 @@ static
> > > int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
> > >             adev->gmc.gmc_funcs->get_dcc_alignment)
> > >                 adjust_dcc_size =3D
> > > amdgpu_gmc_get_dcc_alignment(adev);
> > >
> > > -       remaining_size =3D (u64)vres->base.size;
> > > +       size =3D (u64)vres->base.size;
> > >         if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS && adjust_d=
cc_size) {
> > >                 unsigned int dcc_size;
> > >
> > >                 dcc_size =3D roundup_pow_of_two(vres->base.size + adj=
ust_dcc_size);
> > > -               remaining_size =3D (u64)dcc_size;
> > > +               size =3D (u64)dcc_size;
> > >
> > >                 vres->flags |=3D DRM_BUDDY_TRIM_DISABLE;
> > >         }
> > >
> > >         mutex_lock(&mgr->lock);
> > > -       while (remaining_size) {
> > > +       while (true) {
>
> I think you can also drop this while loop now too.
>
> Alex
>
> There is still a "continue" path left in the loop, I think the logic may =
be broken here if loop dropped.

Ah, yes, sorry I missed that continue.

Alex

>
>        r =3D drm_buddy_alloc_blocks(mm, fpfn,
>                         lpfn,
>                         size,
>                         min_block_size,
>                         &vres->blocks,
>                         vres->flags);
>
>          if (unlikely(r =3D=3D -ENOSPC) && pages_per_block =3D=3D ~0ul &&
>              !(place->flags & TTM_PL_FLAG_CONTIGUOUS)) {
>              vres->flags &=3D ~DRM_BUDDY_CONTIGUOUS_ALLOCATION;
>              pages_per_block =3D max_t(u32, 2UL << (20UL - PAGE_SHIFT),
>                          tbo->page_alignment);
>
>              continue; /* continue in the loop */
>          }
>
>
> > >                 if (tbo->page_alignment)
> > >                         min_block_size =3D (u64)tbo->page_alignment <=
< PAGE_SHIFT;
> > >                 else
> > >                         min_block_size =3D mgr->default_page_size;
> > >
> > > -               size =3D remaining_size;
> > > -
> > >                 if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS && =
adjust_dcc_size)
> > >                         min_block_size =3D size;
> > >                 else if ((size >=3D (u64)pages_per_block <<
> > > PAGE_SHIFT) && @@ -562,10 +560,7 @@ static int amdgpu_vram_mgr_new(st=
ruct ttm_resource_manager *man,
> > >                 if (unlikely(r))
> > >                         goto error_free_blocks;
> > >
> > > -               if (size > remaining_size)
> > > -                       remaining_size =3D 0;
> > > -               else
> > > -                       remaining_size -=3D size;
> > > +               break;
> > >         }
> > >         mutex_unlock(&mgr->lock);
> > >
> > > --
> > > 2.43.0
> > >
