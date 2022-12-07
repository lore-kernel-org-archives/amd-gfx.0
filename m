Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94DCC352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 16:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A17A10E3DE;
	Wed,  7 Dec 2022 16:08:47 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EFFC10E3DE;
 Wed,  7 Dec 2022 16:08:44 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id h132so21223890oif.2;
 Wed, 07 Dec 2022 08:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PPFbcQH3k2p6Ol7n3wtGili7wuwfw0fcoU2H/NtXps=;
 b=kGObYCicg2kWvsoq4B4ABBnY5XmfDMBecisweKvmW6RdS9hZW4CwxxWnPc/MTdH2kr
 CQHB3cOQeW+tp7tyrmkWk88BddbHHfN6fYmnbUkgMTM1R+vWzDAPpQW9vwr8UOVmdUoE
 f2i8M8naS3EFUUJEis5S2vjhBzQx8vKa5Q/AtEWBfGYN21hV4SX6+r7HdYf3NcORRxJd
 dWyIkRgj3yH9nVoOS5U7bHE8QsZIflm3VEPAvOwj7A38MC7G9tjcIEaOlaIBrz+xrvGc
 ICjlo/Vny1lDSg8mrefo/j7kwm650EbJmfVyN2u5/qYHhYtST41++TsNEgQ59eBsiePz
 ygIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PPFbcQH3k2p6Ol7n3wtGili7wuwfw0fcoU2H/NtXps=;
 b=48dSeGjjiMf+J1Bo0quriS56xClv7/F2SmDG8yAS9SA0avwEn13McQW9OXjBY+cJEx
 HnNmk9Hq1pGLVGCYfYZZwpZ+wqjywSc18Dsa4JVYcf0uwPLCNvoGAZBhrLKSibmqIuRA
 6GnU3k2rQw3T9R47jPDmjgIo+oyELKMYIxvkqoPoTJxUT+KQWOaFg/Bfa//ubIyHCUCY
 T9+cGByZrQTTu1WiH3X0qDRZ1Xh8x3j7NaRaao4QEnzvpA3zuxUcWPdERXie830QsmfU
 Fr78OP3UrWpKgmJwNQICaB42q0BdBlvS7exfhKc4Ok2ghtO3RNQnPXPK5qt4NEBXw3y3
 FKvg==
X-Gm-Message-State: ANoB5pl9RYeehg872vn82S/ud+1GSK5ZQWbPJzLDkcZor0i+Lhh7+OTu
 5VMnbE3XRp5RNLMMnDVi974RLPbgefsXXct42NfvNOZzaGA=
X-Google-Smtp-Source: AA0mqf6ss62lhGgR53OLEK2l1HiddU/zgwKT3P2Y8Yt7qS3geLVK//F/xRR2zQENVqrjI9pT1MOGMqHbVbRpe6cIrhU=
X-Received: by 2002:aca:1913:0:b0:35b:f5f7:3ed0 with SMTP id
 l19-20020aca1913000000b0035bf5f73ed0mr10976036oii.46.1670429323587; Wed, 07
 Dec 2022 08:08:43 -0800 (PST)
MIME-Version: 1.0
References: <DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CADnq5_NWr9SAzcQ=x-UVXWHDBci6f_pg-sRj3AD8q5GWYbBJOw@mail.gmail.com>
 <4e415872-3fcf-27b9-dc74-b3e86f171e1c@gmail.com>
 <CADnq5_PShNRZUwvnsTawW1OaCOjK73rdKTxxQhA=Znf2gqbJ=Q@mail.gmail.com>
 <ce75ecb5-1d07-d8a6-2722-59da84c22c10@gmail.com>
In-Reply-To: <ce75ecb5-1d07-d8a6-2722-59da84c22c10@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Dec 2022 11:08:32 -0500
Message-ID: <CADnq5_Mo_hmc7SCYJxQHc-TgdzXS7+YD-SUt9aF-Gx2AovriRw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer failed
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 amd-gfx <amd-gfx-bounces@lists.freedesktop.org>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>, "Zhang,
 Jesse\(Jie\)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 7, 2022 at 10:52 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 07.12.22 um 16:38 schrieb Alex Deucher:
> > On Wed, Dec 7, 2022 at 10:23 AM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> I would go a step further and just allow GTT domain on ASICs !=3D CARR=
IZO
> >> | STONEY.
> >>
> >> I can't see a good reason we should still have any limitation here, VR=
AM
> >> doesn't have any advantage any more as far as I know.
> > Well, if VRAM is available we want to make sure someone uses it
> > otherwise it's just wasted.
>
> Well it still gets used when it's free. So now problem at all here.
>
> We should just not force anything into VRAM or GTT any more if it's
> technically not necessary.

So just this?
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 919bbea2e3ac..8e8f07fa7a93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1506,7 +1506,7 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *b=
o)
 uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
                                            uint32_t domain)
 {
-       if (domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT))=
 {
+       if ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_type =3D=
=3D
CHIP_STONEY)) {
                domain =3D AMDGPU_GEM_DOMAIN_VRAM;
                if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRESHOLD)
                        domain =3D AMDGPU_GEM_DOMAIN_GTT;



>
> Christian.
>
> >
> > Alex
> >
> >
> >> Christian.
> >>
> >> Am 07.12.22 um 16:10 schrieb Alex Deucher:
> >>> Does this patch fix the problem?
> >>>
> >>> Alex
> >>>
> >>> On Wed, Dec 7, 2022 at 2:27 AM Zhang, Jesse(Jie) <Jesse.Zhang@amd.com=
> wrote:
> >>>> [AMD Official Use Only - General]
> >>>>
> >>>>
> >>>>       drm/amdgpu: try allowed domain when pin framebuffer failed.
> >>>>
> >>>>
> >>>>
> >>>>       [WHY&HOW]
> >>>>
> >>>>
> >>>>
> >>>>       in some scenarios, the allocate memory often failed. such as d=
o hot plug or play games.
> >>>>
> >>>>       so we can try allowed domain, if the preferred domain cannot a=
llocate memory.
> >>>>
> >>>>
> >>>>
> >>>>       Signed-off-by: jie1zhan jesse.zhang@amd.com
> >>>>
> >>>>       Change-Id: I4b62e2ff072d02c515f901000a5789339d481273
> >>>>
> >>>>
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_object.c
> >>>>
> >>>> index 1ae0c8723348..05fcaf7f9d92 100644
> >>>>
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>>
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>>
> >>>> @@ -39,6 +39,7 @@
> >>>>
> >>>> #include "amdgpu.h"
> >>>>
> >>>> #include "amdgpu_trace.h"
> >>>>
> >>>> #include "amdgpu_amdkfd.h"
> >>>>
> >>>> +#include "amdgpu_display.h"
> >>>>
> >>>>
> >>>>
> >>>> /**
> >>>>
> >>>>     * DOC: amdgpu_object
> >>>>
> >>>> @@ -942,8 +943,14 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *=
bo, u32 domain,
> >>>>
> >>>>                           bo->placements[i].lpfn =3D lpfn;
> >>>>
> >>>>           }
> >>>>
> >>>>
> >>>>
> >>>> +       retry:
> >>>>
> >>>>           r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> >>>>
> >>>>           if (unlikely(r)) {
> >>>>
> >>>> +               //try allowed domain when pin failed. just a workaro=
und.
> >>>>
> >>>> +               if (unlikely(r =3D=3D -ENOMEM) && domain !=3D bo->al=
lowed_domains) {
> >>>>
> >>>> +                       amdgpu_bo_placement_from_domain(bo, bo->allo=
wed_domains);
> >>>>
> >>>> +                       goto retry;
> >>>>
> >>>> +               }
> >>>>
> >>>>                   dev_err(adev->dev, "%p pin failed\n", bo);
> >>>>
> >>>>                   goto error;
> >>>>
> >>>>           }
>
