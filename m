Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E308FC369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 14:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8832C10E7A6;
	Wed, 30 Apr 2025 14:22:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TY+endvN";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA88410E7A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 14:22:06 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2264aefc3b5so15421875ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746022926; x=1746627726; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UoMCq6NDBhFYU5deFAf0IfHwHevuptdIrRF9Or7gGpQ=;
 b=TY+endvNFVONuwIm9C2ePqyEqkYu7gxg3hANrK7gmM8nJTaLe49YJqNI0p82T1tJ8j
 iWnJHORgjq+olcfVHlC1DNMn5iIM+StNH7CvXlswXSTEwCNE0QGPWiggKZ3SAdJDTk7B
 GZKMko0S/5Pu5/gXtpV8A+beOsUdBu9b8FAD+0d0vIxfUjIim5a7XO63iAd6Y5n7c7ex
 MKtji/9l0TJOyCD11uAffnkL+Qvoljt0WB3a7e5xLeh4BEVWiGY7bWIBph+hyuHfZIqi
 gO2+yfJlwmvxckDlqZGMoIixB8v55EmA4rJQpf7g3XlIhiFUSvIGjTd3YlUMZEvU4JDu
 24hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746022926; x=1746627726;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UoMCq6NDBhFYU5deFAf0IfHwHevuptdIrRF9Or7gGpQ=;
 b=Fusgg/OCp5u7l8rFxHLMarxGa7tTHBBdBJ/cGJWpD9QmWQE1L3fwyNPt0g3u8m9//E
 8fJtuwkYJYuqRewwgCsIkxJxON5BX1qokEtFbHvfzDY0rbJ61+OwjXS/a2kjOsmPOXAB
 qfMXX7BsJLF0EwyO0oHea2M6gfrx+/ri66lNyiHPc1uXsOv1jD1Wxs6luHY1AYUPT/1V
 gYsF9j+7dTKJzo7UfaKy+Q3iPZxDO1n3x1hBtgp3Wx9qoJK9colFPTXqasvn9ifnwbWI
 R6VDUFgz/Db6sOl+wsTOWL5FKjXS4wVH3nL8qO35c0T3Y3av9le+GLg+LOl+tAXVav1K
 z/yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGiXyZDUwkOz2WFk7SCxtErhx0kdcdnDp3w3c2oWHQkoH17i2Bk9YJF3//CC3dg/By4yB8cIQ1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSONb3oE46YL6YTHcuMTERcwydcOt/IvXZhAsIoqtekvdB9NnK
 FchRsr5CCUEj21qLjcg0JtdgD0eShd4NnHPTv/lIBlteTGdEoKcpJJs6t7hKtjaApVhzuwPUNJp
 Cs/5Nz4xqrlj+Ra3CC97lmfc5DyTw/w==
X-Gm-Gg: ASbGncsWPpUGsHJG1tkrHMjX4uqKdUJC28xqjjKb44JLbj5Uli4jT08eqJbcLHUM4tv
 rRVPNWIJ3EkJ6ck4y8mHxpo07B+zHjXxExXPM3djGh82j3+y9RS+kEFVFnyiCOV6ACQzJJdlUg7
 /01Bo7KUM3u8DVypv7sigdqA==
X-Google-Smtp-Source: AGHT+IEswVx/ROP8dXmJaUkSTxzTlqgo9gyCeaL+ifhoqnmNmC2sqC3LA/Nw95waOJzp3s6e2uj94O1oaOwDkErobLs=
X-Received: by 2002:a17:903:1b24:b0:223:f9a4:dc25 with SMTP id
 d9443c01a7336-22df5836c79mr16097345ad.14.1746022926333; Wed, 30 Apr 2025
 07:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250429175022.1636538-1-alexander.deucher@amd.com>
 <9379f31c-392e-4ad2-d19b-f2c1a6917208@amd.com>
In-Reply-To: <9379f31c-392e-4ad2-d19b-f2c1a6917208@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Apr 2025 10:21:54 -0400
X-Gm-Features: ATxdqUHjCXyp8209Pazz3J2XJDZafL8FbQpzFBR3rQctqhON1hquyTgrTCxXgrg
Message-ID: <CADnq5_PVhhfGie2iRcoZbL9-gbsaUXDAd0+4x28hStoY0DA7TQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: properly handle GC vs MM in
 amdgpu_vmid_mgr_init()
To: "Yadav, Arvind" <arvyadav@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Arvind Yadav <Arvind.Yadav@amd.com>
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

On Wed, Apr 30, 2025 at 1:05=E2=80=AFAM Yadav, Arvind <arvyadav@amd.com> wr=
ote:
>
> Reviewed-by: Arvind Yadav <Arvind.Yadav@amd.com>
>
> On 4/29/2025 11:20 PM, Alex Deucher wrote:
> > When kernel queues are disabled, all GC vmids are available
> > for the scheduler.  MM vmids are still managed by the driver
> > so make all 16 available.
> >
> > Also fix gmc 10 vs 11 mix up in
> > commit 1f61fc28b939 ("drm/amdgpu/mes: make more vmids available when di=
sable_kq=3D1")
> >
> > Fixes: 1f61fc28b939 ("drm/amdgpu/mes: make more vmids available when di=
sable_kq=3D1")
> > Cc: Arvind Yadav <Arvind.Yadav@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 8 ++++++--
> >   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 2 +-
> >   3 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ids.c
> > index 359c19de9a5b9..c7a6d40ded5c3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> > @@ -576,8 +576,12 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *ad=
ev)
> >               INIT_LIST_HEAD(&id_mgr->ids_lru);
> >               id_mgr->reserved_use_count =3D 0;
> >
> > -             /* manage only VMIDs not used by KFD */
> > -             id_mgr->num_ids =3D adev->vm_manager.first_kfd_vmid;
> > +             if (AMDGPU_IS_MMHUB0(i) ||
> > +                 AMDGPU_IS_MMHUB1(i))
> > +                     id_mgr->num_ids =3D 16;
> > +             else
> > +                     /* manage only VMIDs not used by KFD */
> > +                     id_mgr->num_ids =3D adev->vm_manager.first_kfd_vm=
id;

We need to handle pre GC 10 here as well.  I just sent out an updated patch=
.

Alex

> >
> >               /* skip over VMID 0, since it is the system VM */
> >               for (j =3D 1; j < id_mgr->num_ids; ++j) {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v10_0.c
> > index 7648e977b44bc..a3e2787501f18 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > @@ -896,7 +896,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
> >        * amdgpu graphics/compute will use VMIDs 1-7
> >        * amdkfd will use VMIDs 8-15
> >        */
> > -     adev->vm_manager.first_kfd_vmid =3D adev->gfx.disable_kq ? 1 : 8;
> > +     adev->vm_manager.first_kfd_vmid =3D 8;
> >
> >       amdgpu_vm_manager_init(adev);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v11_0.c
> > index 7f5ca170f141a..917d894a1316a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > @@ -828,7 +828,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
> >        * amdgpu graphics/compute will use VMIDs 1-7
> >        * amdkfd will use VMIDs 8-15
> >        */
> > -     adev->vm_manager.first_kfd_vmid =3D 8;
> > +     adev->vm_manager.first_kfd_vmid =3D adev->gfx.disable_kq ? 1 : 8;
> >
> >       amdgpu_vm_manager_init(adev);
> >
