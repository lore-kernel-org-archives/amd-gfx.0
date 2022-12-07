Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D477C63703
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 16:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 992D910E3F0;
	Wed,  7 Dec 2022 16:21:19 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A34010E3F0;
 Wed,  7 Dec 2022 16:21:16 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1322d768ba7so21866251fac.5; 
 Wed, 07 Dec 2022 08:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ISgEZ79pT/w46zigfPwoQ9W7P3gsvlg/BJ5lcBN+KDk=;
 b=mj3CqUzLokhm6y4VoNRencz1gvfNxOVPtll5zUV8f23HOF4OsNfFLaE5xRNDergZcu
 nMYfyZHIPD236RB4yvdMN73/uAY7sQ4bfzZroQAIaFkMmrjdw8dwqmb+LAS6nPGYEDw7
 wOQySwHtOxblLJRSzn2QNvcMoRe9vBiacnU3VNMIsVyIBG8YSoCAJs65G5f2MVUT/twU
 +wprgxPeAqC5JdlgGmlbaJUrrpQRi6Vx6NU4Nubvmz4zvBbf20ebTw8cFiCx8Tv1U7jI
 PfdwYH2iv+QQf/ZTx5sPKTecwjOsWlFHETLLYW/lXa+hiSCmuFofzZGlsqQpFDnVyFV/
 HtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ISgEZ79pT/w46zigfPwoQ9W7P3gsvlg/BJ5lcBN+KDk=;
 b=WY22IDwj8M2J9YvDrKrBvG82tY8E9UPaJqU8KR9NP+Mrsx76O8Pdz/RpNSSgcGsiMy
 GpgQg+TIDs75fbJl421CF6YnHmqR6Gfn+bSagsjzAhz0uQ1MDHFg11f//szMLI9RrNYI
 w82Fqd05u1cGklA31zuTfNhDSw37D90t9W7hGUEweh7aVrtU14VO/BeV+LzVgy5O+ovu
 5v9KkOhExGaaEi5b3nLYd1ElnfJv8L+zBemaVToPHhCN4mBXYvgb2Gf1GBacucV2P+Bc
 Xbw1EfkTwGBnBRwUjeJsUyzTGoa512rmOY1RxhkEC6Rk3r/8yld0pKFHTFRVMW8JOcOP
 DZnA==
X-Gm-Message-State: ANoB5plb+vTW2JnFeH7+wjzwbHYAyV1d/6Y1mkZ2zmKsEIUFcPcPrV7w
 ph9ywTzKIijJqIWnQvihONfIZvptKtzrLIjsVVxKUCxt
X-Google-Smtp-Source: AA0mqf4LvyA+goz9rF6i+rHvuaVG1YTbuDnnCB6f08LU6ra6+pA1qwaIoo3o0IfHQut9dc2ILVFkkKk8ywr4IsH6cxQ=
X-Received: by 2002:a05:6870:7a0c:b0:143:8a81:116c with SMTP id
 hf12-20020a0568707a0c00b001438a81116cmr28894609oab.96.1670430075661; Wed, 07
 Dec 2022 08:21:15 -0800 (PST)
MIME-Version: 1.0
References: <DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CADnq5_NWr9SAzcQ=x-UVXWHDBci6f_pg-sRj3AD8q5GWYbBJOw@mail.gmail.com>
 <4e415872-3fcf-27b9-dc74-b3e86f171e1c@gmail.com>
 <CADnq5_PShNRZUwvnsTawW1OaCOjK73rdKTxxQhA=Znf2gqbJ=Q@mail.gmail.com>
 <ce75ecb5-1d07-d8a6-2722-59da84c22c10@gmail.com>
 <CADnq5_Mo_hmc7SCYJxQHc-TgdzXS7+YD-SUt9aF-Gx2AovriRw@mail.gmail.com>
 <581403d1-f5f3-72a6-5447-6deef4405d47@gmail.com>
In-Reply-To: <581403d1-f5f3-72a6-5447-6deef4405d47@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Dec 2022 11:21:03 -0500
Message-ID: <CADnq5_OtFeSYKKjniNXuXUmX4WgXw1+hN-3YoRpBh-Ytjosv5g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer failed
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000048516605ef3f4fc7"
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

--00000000000048516605ef3f4fc7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 7, 2022 at 11:10 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
>
>
> Am 07.12.22 um 17:08 schrieb Alex Deucher:
> > On Wed, Dec 7, 2022 at 10:52 AM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> Am 07.12.22 um 16:38 schrieb Alex Deucher:
> >>> On Wed, Dec 7, 2022 at 10:23 AM Christian K=C3=B6nig
> >>> <ckoenig.leichtzumerken@gmail.com> wrote:
> >>>> I would go a step further and just allow GTT domain on ASICs !=3D CA=
RRIZO
> >>>> | STONEY.
> >>>>
> >>>> I can't see a good reason we should still have any limitation here, =
VRAM
> >>>> doesn't have any advantage any more as far as I know.
> >>> Well, if VRAM is available we want to make sure someone uses it
> >>> otherwise it's just wasted.
> >> Well it still gets used when it's free. So now problem at all here.
> >>
> >> We should just not force anything into VRAM or GTT any more if it's
> >> technically not necessary.
> > So just this?
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > index 919bbea2e3ac..8e8f07fa7a93 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -1506,7 +1506,7 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_b=
o *bo)
> >   uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
> >                                              uint32_t domain)
> >   {
> > -       if (domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_G=
TT)) {
>
> We still need to keep this check to avoid trying to adjust VRAM only
> allocations (the cursor still needs this IIRC).
>
> Apart from that I think that should work.

Attached.  Thanks,

Alex

>
> Christian.
>
> > +       if ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_type =
=3D=3D
> > CHIP_STONEY)) {
> >                  domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> >                  if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRESHOLD)
> >                          domain =3D AMDGPU_GEM_DOMAIN_GTT;
> >
> >
> >
> >> Christian.
> >>
> >>> Alex
> >>>
> >>>
> >>>> Christian.
> >>>>
> >>>> Am 07.12.22 um 16:10 schrieb Alex Deucher:
> >>>>> Does this patch fix the problem?
> >>>>>
> >>>>> Alex
> >>>>>
> >>>>> On Wed, Dec 7, 2022 at 2:27 AM Zhang, Jesse(Jie) <Jesse.Zhang@amd.c=
om> wrote:
> >>>>>> [AMD Official Use Only - General]
> >>>>>>
> >>>>>>
> >>>>>>        drm/amdgpu: try allowed domain when pin framebuffer failed.
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>        [WHY&HOW]
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>        in some scenarios, the allocate memory often failed. such a=
s do hot plug or play games.
> >>>>>>
> >>>>>>        so we can try allowed domain, if the preferred domain canno=
t allocate memory.
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>        Signed-off-by: jie1zhan jesse.zhang@amd.com
> >>>>>>
> >>>>>>        Change-Id: I4b62e2ff072d02c515f901000a5789339d481273
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>>>>
> >>>>>> index 1ae0c8723348..05fcaf7f9d92 100644
> >>>>>>
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>>>>
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>>>>
> >>>>>> @@ -39,6 +39,7 @@
> >>>>>>
> >>>>>> #include "amdgpu.h"
> >>>>>>
> >>>>>> #include "amdgpu_trace.h"
> >>>>>>
> >>>>>> #include "amdgpu_amdkfd.h"
> >>>>>>
> >>>>>> +#include "amdgpu_display.h"
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> /**
> >>>>>>
> >>>>>>      * DOC: amdgpu_object
> >>>>>>
> >>>>>> @@ -942,8 +943,14 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo=
 *bo, u32 domain,
> >>>>>>
> >>>>>>                            bo->placements[i].lpfn =3D lpfn;
> >>>>>>
> >>>>>>            }
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> +       retry:
> >>>>>>
> >>>>>>            r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> >>>>>>
> >>>>>>            if (unlikely(r)) {
> >>>>>>
> >>>>>> +               //try allowed domain when pin failed. just a worka=
round.
> >>>>>>
> >>>>>> +               if (unlikely(r =3D=3D -ENOMEM) && domain !=3D bo->=
allowed_domains) {
> >>>>>>
> >>>>>> +                       amdgpu_bo_placement_from_domain(bo, bo->al=
lowed_domains);
> >>>>>>
> >>>>>> +                       goto retry;
> >>>>>>
> >>>>>> +               }
> >>>>>>
> >>>>>>                    dev_err(adev->dev, "%p pin failed\n", bo);
> >>>>>>
> >>>>>>                    goto error;
> >>>>>>
> >>>>>>            }
>

--00000000000048516605ef3f4fc7
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-make-display-pinning-more-flexible-v2.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-make-display-pinning-more-flexible-v2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lbduxcwt0>
X-Attachment-Id: f_lbduxcwt0

RnJvbSA4Zjc4MjcwNzE4Mjk4NTFiZGVhNjZmMTE3OWMwYzU2OGM5Mzk4NGQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgNyBEZWMgMjAyMiAxMTowODo1MyAtMDUwMApTdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWRncHU6IG1ha2UgZGlzcGxheSBwaW5uaW5nIG1vcmUgZmxleGlibGUgKHYyKQoKT25s
eSBhcHBseSB0aGUgc3RhdGljIHRocmVzaG9sZCBmb3IgU3RvbmV5IGFuZCBDYXJyaXpvLgpUaGlz
IGhhcmR3YXJlIGhhcyBjZXJ0YWluIHJlcXVpcmVtZW50cyB0aGF0IGRvbid0IGFsbG93Cm1peGlu
ZyBvZiBHVFQgYW5kIFZSQU0uICBOZXdlciBhc2ljcyBkbyBub3QgaGF2ZSB0aGVzZQpyZXF1aXJl
bWVudHMgc28gd2Ugc2hvdWxkIGJlIGFibGUgdG8gYmUgbW9yZSBmbGV4aWJsZQp3aXRoIHdoZXJl
IGJ1ZmZlcnMgZW5kIHVwLgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9v
YmplY3QuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29i
amVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCmluZGV4
IDkxOWJiZWEyZTNhYy4uMmRmNTVjYzdlMDdmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X29iamVjdC5jCkBAIC0xNTA2LDcgKzE1MDYsOCBAQCB1NjQgYW1kZ3B1X2JvX2dw
dV9vZmZzZXRfbm9fY2hlY2soc3RydWN0IGFtZGdwdV9ibyAqYm8pCiB1aW50MzJfdCBhbWRncHVf
Ym9fZ2V0X3ByZWZlcnJlZF9kb21haW4oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkJ
CSAgICB1aW50MzJfdCBkb21haW4pCiB7Ci0JaWYgKGRvbWFpbiA9PSAoQU1ER1BVX0dFTV9ET01B
SU5fVlJBTSB8IEFNREdQVV9HRU1fRE9NQUlOX0dUVCkpIHsKKwlpZiAoKGRvbWFpbiA9PSAoQU1E
R1BVX0dFTV9ET01BSU5fVlJBTSB8IEFNREdQVV9HRU1fRE9NQUlOX0dUVCkpICYmCisJICAgICgo
YWRldi0+YXNpY190eXBlID09IENISVBfQ0FSUklaTykgfHwgKGFkZXYtPmFzaWNfdHlwZSA9PSBD
SElQX1NUT05FWSkpKSB7CiAJCWRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX1ZSQU07CiAJCWlm
IChhZGV2LT5nbWMucmVhbF92cmFtX3NpemUgPD0gQU1ER1BVX1NHX1RIUkVTSE9MRCkKIAkJCWRv
bWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX0dUVDsKLS0gCjIuMzguMQoK
--00000000000048516605ef3f4fc7--
