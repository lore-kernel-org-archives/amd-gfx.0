Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62FDC83F1A
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Jul 2025 15:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0CAE10E37C;
	Sun, 20 Jul 2025 15:32:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="z43EccIG";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAD0810EA2A
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 17:57:19 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2357c61cda7so13385ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1752861439; x=1753466239;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQwq6XL4XMMDUVPyAAts9uHNc3Wh3Ah7TMpl+x8VXU4=;
 b=z43EccIG2lRK9j1LP1nZmdFBxXoPGUnzbBry4agKBKx10LQ+ni1bzFBVlagILBwbHs
 TMfvSDloojsr+jxI8YwNQMLuN1uP2mzAQ+dhPPQiZqhtOj81C7yFuXZIcNYKFF8ggxaU
 uk76sANW7Cq5xFjUWv1c4Z2osdeES8nyS44hu2R41ROLMZOhAtPjc6gX2SxUvpDd1xmS
 nr8nBEfKxiV2pPQ1doZRzGmYGsEz/9gU2YYvuXYihPfKS3mrlqzz6ECLiYSR1Shu6wHN
 cC1XAIBpbMBo2M09yonP0zhs1xTRIcS41UKIkK38EzdsAFdyU52qGmbhVBoCd9Y+irzo
 GxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752861439; x=1753466239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fQwq6XL4XMMDUVPyAAts9uHNc3Wh3Ah7TMpl+x8VXU4=;
 b=VcWGoS5GTdMTwn1o6BtSYg4aAU9aKr6aJRf+mFnhhox0OxfGna54e7P+ECeKqFdACV
 cAXZMUj2GbJtfnSy2uAqpdZm9IDcCQBtCvoRHq0fFt5Tx2RsXNEEFd+A0UW9aPuQXz7t
 f/7MEdKA7eqwAXxQP/U2Xdy6FLJ9SHYkqALdtfjGmfbNg/bYH15HOOJfGOTUSpNLleHj
 QmuKB1tHt/Ksvex8kF1191QYr4p1qljGGae/AOiMEvVj2OO8i9bXJXzBYyOOrYFYW25b
 9vFVnAJhavxEbm2iaHNRNLktrzrSZoCPkpLbsEFDsE/sgYxwzst65sB+9hSa9PSg6H2A
 krMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEJsaCtYqTe+0tMmt5nJ7w7hurKO8SgPw6DCqMPA520X0rnmVIyXZN70Go2ACd8BBi6dkw8xaq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiTiA9eSZXiafUe93+MqGp4dYNYJ/kTLdzml6V9NYJAzZlibjn
 hL/HDOB+x178Lpx4NMR2o0HJcemW2BK6N/P11pFVg9qxPrdZJ9TBvKkoo7nXfjePMW+zbz9caTj
 U7IPmSZakQe20BwKXcGcN8Okb9acmsxYQpUmylM0f
X-Gm-Gg: ASbGncvL3ZB3bJLX8xQ1BkuZ0cY5KhjMMkxehC/GIbY9xNgEW0Jj2w4+CKHEs1YPmWj
 E99xjSgNQWGDm7oIJzo0saVVFlL4LkDEmPbhBsYAGsBOzQ5jb4koGWMrHrL/XHeybaX0tj9xs+t
 am4CIYq8bJzV4NNZ1Q9FqZPbZ1qEvkWWQJ1dH/lE3Xv48PxFmiElXu29ufMs7eymfIsE6TJtq0S
 LbNkw==
X-Google-Smtp-Source: AGHT+IFB7mRsL16wpHPWottVi1OKrwf75zBs0DCPDQD+QRajm4wHJjRQeKVuBUPTfJF/u36oAJXSpzv3mDvRuLFSvUg=
X-Received: by 2002:a17:902:e845:b0:231:d0ef:e8ff with SMTP id
 d9443c01a7336-23f71cf6272mr147495ad.8.1752861438668; Fri, 18 Jul 2025
 10:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250716161753.231145-1-bgeffon@google.com>
 <CADnq5_P+a2g_YzKW7S4YSF5kQgXe+PNrMKEOAHuf9yhFg98pSQ@mail.gmail.com>
 <CADyq12zB7+opz0vUgyAQSdbHcYMwbZrZp+qxKdYcqaeCeRVbCw@mail.gmail.com>
 <CADnq5_OeTJqzg0DgV06b-u_AmgaqXL5XWdQ6h40zcgGj1mCE_A@mail.gmail.com>
 <CADyq12ysC9C2tsQ3GrQJB3x6aZPzM1o8pyTW8z4bxjGPsfEZvw@mail.gmail.com>
 <CADnq5_PnktmP+0Hw0T04VkrkKoF_TGz5HOzRd1UZq6XOE0Rm1g@mail.gmail.com>
In-Reply-To: <CADnq5_PnktmP+0Hw0T04VkrkKoF_TGz5HOzRd1UZq6XOE0Rm1g@mail.gmail.com>
From: Brian Geffon <bgeffon@google.com>
Date: Fri, 18 Jul 2025 13:56:42 -0400
X-Gm-Features: Ac12FXy1d35S96EobB812Shedx-VhbSYaFw_UhX7goQUz4ANBgmd9GU0nbH0gb8
Message-ID: <CADyq12x1f0VLjHKWEmfmis8oLncqSWxeTGs5wL0Xj2hua+onOQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Raven: don't allow mixing GTT and VRAM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>, 
 Pratap Nirujogi <pratap.nirujogi@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Garrick Evans <garrick@google.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 20 Jul 2025 15:32:54 +0000
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

On Thu, Jul 17, 2025 at 10:59=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Wed, Jul 16, 2025 at 8:13=E2=80=AFPM Brian Geffon <bgeffon@google.com>=
 wrote:
> >
> > On Wed, Jul 16, 2025 at 5:03=E2=80=AFPM Alex Deucher <alexdeucher@gmail=
.com> wrote:
> > >
> > > On Wed, Jul 16, 2025 at 12:40=E2=80=AFPM Brian Geffon <bgeffon@google=
.com> wrote:
> > > >
> > > > On Wed, Jul 16, 2025 at 12:33=E2=80=AFPM Alex Deucher <alexdeucher@=
gmail.com> wrote:
> > > > >
> > > > > On Wed, Jul 16, 2025 at 12:18=E2=80=AFPM Brian Geffon <bgeffon@go=
ogle.com> wrote:
> > > > > >
> > > > > > Commit 81d0bcf99009 ("drm/amdgpu: make display pinning more fle=
xible (v2)")
> > > > > > allowed for newer ASICs to mix GTT and VRAM, this change also n=
oted that
> > > > > > some older boards, such as Stoney and Carrizo do not support th=
is.
> > > > > > It appears that at least one additional ASIC does not support t=
his which
> > > > > > is Raven.
> > > > > >
> > > > > > We observed this issue when migrating a device from a 5.4 to 6.=
6 kernel
> > > > > > and have confirmed that Raven also needs to be excluded from mi=
xing GTT
> > > > > > and VRAM.
> > > > >
> > > > > Can you elaborate a bit on what the problem is?  For carrizo and
> > > > > stoney this is a hardware limitation (all display buffers need to=
 be
> > > > > in GTT or VRAM, but not both).  Raven and newer don't have this
> > > > > limitation and we tested raven pretty extensively at the time.
> > > >
> > > > Thanks for taking the time to look. We have automated testing and a
> > > > few igt gpu tools tests failed and after debugging we found that
> > > > commit 81d0bcf99009 is what introduced the failures on this hardwar=
e
> > > > on 6.1+ kernels. The specific tests that fail are kms_async_flips a=
nd
> > > > kms_plane_alpha_blend, excluding Raven from this sharing of GTT and
> > > > VRAM buffers resolves the issue.
> > >
> > > + Harry and Leo
> > >
> > > This sounds like the memory placement issue we discussed last week.
> > > In that case, the issue is related to where the buffer ends up when w=
e
> > > try to do an async flip.  In that case, we can't do an async flip
> > > without a full modeset if the buffers locations are different than th=
e
> > > last modeset because we need to update more than just the buffer base
> > > addresses.  This change works around that limitation by always forcin=
g
> > > display buffers into VRAM or GTT.  Adding raven to this case may fix
> > > those tests but will make the overall experience worse because we'll
> > > end up effectively not being able to not fully utilize both gtt and
> > > vram for display which would reintroduce all of the problems fixed by
> > > 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)").
> >
> > Thanks Alex, the thing is, we only observe this on Raven boards, why
> > would Raven only be impacted by this? It would seem that all devices
> > would have this issue, no? Also, I'm not familiar with how
>
> It depends on memory pressure and available memory in each pool.
> E.g., initially the display buffer is in VRAM when the initial mode
> set happens.  The watermarks, etc. are set for that scenario.  One of
> the next frames ends up in a pool different than the original.  Now
> the buffer is in GTT.  The async flip interface does a fast validation
> to try and flip as soon as possible, but that validation fails because
> the watermarks need to be updated which requires a full modeset.
>
> It's tricky to fix because you don't want to use the worst case
> watermarks all the time because that will limit the number available
> display options and you don't want to force everything to a particular
> memory pool because that will limit the amount of memory that can be
> used for display (which is what the patch in question fixed).  Ideally
> the caller would do a test commit before the page flip to determine
> whether or not it would succeed before issuing it and then we'd have
> some feedback mechanism to tell the caller that the commit would fail
> due to buffer placement so it would do a full modeset instead.  We
> discussed this feedback mechanism last week at the display hackfest.
>
>
> > kms_plane_alpha_blend works, but does this also support that test
> > failing as the cause?
>
> That may be related.  I'm not too familiar with that test either, but
> Leo or Harry can provide some guidance.
>
> Alex

Thanks everyone for the input so far. I have a question for the
maintainers, given that it seems that this is functionally broken for
ASICs which are iGPUs, and there does not seem to be an easy fix, does
it make sense to extend this proposed patch to all iGPUs until a more
permanent fix can be identified? At the end of the day I'll take
functional correctness over performance.

Brian

>
> >
> > Thanks again,
> > Brian
> >
> > >
> > > Alex
> > >
> > > >
> > > > Brian
> > > >
> > > > >
> > > > >
> > > > > Alex
> > > > >
> > > > > >
> > > > > > Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more fle=
xible (v2)")
> > > > > > Cc: Luben Tuikov <luben.tuikov@amd.com>
> > > > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > > > Cc: stable@vger.kernel.org # 6.1+
> > > > > > Tested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > > > > > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > > > index 73403744331a..5d7f13e25b7c 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > > > @@ -1545,7 +1545,8 @@ uint32_t amdgpu_bo_get_preferred_domain(s=
truct amdgpu_device *adev,
> > > > > >                                             uint32_t domain)
> > > > > >  {
> > > > > >         if ((domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM=
_DOMAIN_GTT)) &&
> > > > > > -           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->as=
ic_type =3D=3D CHIP_STONEY))) {
> > > > > > +           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->as=
ic_type =3D=3D CHIP_STONEY) ||
> > > > > > +            (adev->asic_type =3D=3D CHIP_RAVEN))) {
> > > > > >                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> > > > > >                 if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THR=
ESHOLD)
> > > > > >                         domain =3D AMDGPU_GEM_DOMAIN_GTT;
> > > > > > --
> > > > > > 2.50.0.727.gbf7dc18ff4-goog
> > > > > >
