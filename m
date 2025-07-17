Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D819BC83F1B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jul 2025 07:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65DBE10E71B;
	Thu, 17 Jul 2025 07:38:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="xIbBqHzs";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9781410E3D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jul 2025 00:13:36 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2357c61cda7so35975ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 17:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1752711216; x=1753316016;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxwcBRFZJ/IWYAmgYMBlaC5GLM/oN1cP6KDw+nUVd+c=;
 b=xIbBqHzsi1uXxvxG/oO2sTwoLXGpVqbmlFRjiI2eF94Dr75hEIzCz0rcm4gsyIW8Nc
 qHwYPHEtZI7hwJb5E6FOiFeVCMlXRq360maMzZeeBDZqGJmsklmuMGhJrinc/HMljK8b
 06L5U4s46XIcASvYwtEpsu3irdAi6c2dUgqNc5orrqeDZtWCAQPAj6N68X6wTxSOHCMQ
 sl35uxbu1FbiUbRLxbxYU8AP3eZsLRs5TzEUfLI+CUUSSduiyNXO7VZbpYbOB+Kk0eEQ
 aRjbVjWTw1fON+KxQfvvp62KYATqrJQJ9miH5dIbwnv1RBVGiI09rE0e9ukYbaykhLmw
 uvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752711216; x=1753316016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YxwcBRFZJ/IWYAmgYMBlaC5GLM/oN1cP6KDw+nUVd+c=;
 b=KCCIr+0h6Z4LPG0KnF0xfuUkb59DNoQC0xUqQaU5UHRPl2KPMAp9rpCVmr8+leC+kY
 +01J1gfa4Y7kPPWMTRE9tkI3HFfWgQZR9Fj8vIWQDvsJ4B7HrzgpeTZBUKorJUcVGXbs
 CcYTDx10JTHYQI8S/5Qt+yyK4KArxxT6ohPGpeVnGPgCyszzMAJGaaWcwwu4lnxQQM8Y
 pDKe0xmhjyXByMCL9ZgZc79Z1Voh6EpL3KXB9/LvJGied5Ob3rKAZX2owMByO7xV4cgB
 KPXElB+2rCZOBSJpykwFXPJPGPYng7jdbdPGrfF+B8xTFXKug1Ulcigz6KC7GAYT73Ov
 CRqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/S/6byL3oj2cE9HswyYVb6EnI9llQoxOanMRnfw+cb9zQfoYbxD0IsHbLaTrGnY21/OHAOWDZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBN05jmBdrqhVaGPRwQagWLE5aay7anPsvFshZVMwe6c4V+rBz
 iBUJ6vLa1iKGVpgbn7d49S/1u/6WO5ROvSwrroqnV5oKFqRv68qeFukNK3hOuZQFlmwJKE5oXMt
 mBAMbgOKW6mDk5BTmVKSMn5KSrSkdKW4kLFbdPkms
X-Gm-Gg: ASbGncvF+HfxWQlPHTlGJXLq8TN2RdnRuPS/A2MfZA2/IOT13DToVCGwtrlLmY5wnUL
 z7PveMiaDO9pUGy+LE2Z31m5e9zfCe/0bs3+v8yQJOrVWu88oXnPs2fdBjq1tNsP+FV6oW+qGFw
 1m/Y7CHqjRchLRiUpsfqFNHPn2GsSkxxbaM5vQsP7MuOyIW/J6txOXuSN6K1e3dbMEXbXTTZLfz
 l2qiA==
X-Google-Smtp-Source: AGHT+IExZ6YQpVxQMTJs5x1bFUTqRcgLAU1GhDN/RUviVrMpTxpuEVJRR17jv0s7D2xBNTbduIancHz0YHYlnDWvA9k=
X-Received: by 2002:a17:902:f548:b0:231:d0ef:e8ff with SMTP id
 d9443c01a7336-23e2fda6d9fmr1332865ad.8.1752711215586; Wed, 16 Jul 2025
 17:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250716161753.231145-1-bgeffon@google.com>
 <CADnq5_P+a2g_YzKW7S4YSF5kQgXe+PNrMKEOAHuf9yhFg98pSQ@mail.gmail.com>
 <CADyq12zB7+opz0vUgyAQSdbHcYMwbZrZp+qxKdYcqaeCeRVbCw@mail.gmail.com>
 <CADnq5_OeTJqzg0DgV06b-u_AmgaqXL5XWdQ6h40zcgGj1mCE_A@mail.gmail.com>
In-Reply-To: <CADnq5_OeTJqzg0DgV06b-u_AmgaqXL5XWdQ6h40zcgGj1mCE_A@mail.gmail.com>
From: Brian Geffon <bgeffon@google.com>
Date: Wed, 16 Jul 2025 20:12:59 -0400
X-Gm-Features: Ac12FXw4FWxTyOpiBAh39vdC9AS1nFe7p6dT3CD8-f9rngBIdz8mZXayZeabz6s
Message-ID: <CADyq12ysC9C2tsQ3GrQJB3x6aZPzM1o8pyTW8z4bxjGPsfEZvw@mail.gmail.com>
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
X-Mailman-Approved-At: Thu, 17 Jul 2025 07:38:58 +0000
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

On Wed, Jul 16, 2025 at 5:03=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Wed, Jul 16, 2025 at 12:40=E2=80=AFPM Brian Geffon <bgeffon@google.com=
> wrote:
> >
> > On Wed, Jul 16, 2025 at 12:33=E2=80=AFPM Alex Deucher <alexdeucher@gmai=
l.com> wrote:
> > >
> > > On Wed, Jul 16, 2025 at 12:18=E2=80=AFPM Brian Geffon <bgeffon@google=
.com> wrote:
> > > >
> > > > Commit 81d0bcf99009 ("drm/amdgpu: make display pinning more flexibl=
e (v2)")
> > > > allowed for newer ASICs to mix GTT and VRAM, this change also noted=
 that
> > > > some older boards, such as Stoney and Carrizo do not support this.
> > > > It appears that at least one additional ASIC does not support this =
which
> > > > is Raven.
> > > >
> > > > We observed this issue when migrating a device from a 5.4 to 6.6 ke=
rnel
> > > > and have confirmed that Raven also needs to be excluded from mixing=
 GTT
> > > > and VRAM.
> > >
> > > Can you elaborate a bit on what the problem is?  For carrizo and
> > > stoney this is a hardware limitation (all display buffers need to be
> > > in GTT or VRAM, but not both).  Raven and newer don't have this
> > > limitation and we tested raven pretty extensively at the time.
> >
> > Thanks for taking the time to look. We have automated testing and a
> > few igt gpu tools tests failed and after debugging we found that
> > commit 81d0bcf99009 is what introduced the failures on this hardware
> > on 6.1+ kernels. The specific tests that fail are kms_async_flips and
> > kms_plane_alpha_blend, excluding Raven from this sharing of GTT and
> > VRAM buffers resolves the issue.
>
> + Harry and Leo
>
> This sounds like the memory placement issue we discussed last week.
> In that case, the issue is related to where the buffer ends up when we
> try to do an async flip.  In that case, we can't do an async flip
> without a full modeset if the buffers locations are different than the
> last modeset because we need to update more than just the buffer base
> addresses.  This change works around that limitation by always forcing
> display buffers into VRAM or GTT.  Adding raven to this case may fix
> those tests but will make the overall experience worse because we'll
> end up effectively not being able to not fully utilize both gtt and
> vram for display which would reintroduce all of the problems fixed by
> 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)").

Thanks Alex, the thing is, we only observe this on Raven boards, why
would Raven only be impacted by this? It would seem that all devices
would have this issue, no? Also, I'm not familiar with how
kms_plane_alpha_blend works, but does this also support that test
failing as the cause?

Thanks again,
Brian

>
> Alex
>
> >
> > Brian
> >
> > >
> > >
> > > Alex
> > >
> > > >
> > > > Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more flexibl=
e (v2)")
> > > > Cc: Luben Tuikov <luben.tuikov@amd.com>
> > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > Cc: stable@vger.kernel.org # 6.1+
> > > > Tested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > > > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_object.c
> > > > index 73403744331a..5d7f13e25b7c 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > @@ -1545,7 +1545,8 @@ uint32_t amdgpu_bo_get_preferred_domain(struc=
t amdgpu_device *adev,
> > > >                                             uint32_t domain)
> > > >  {
> > > >         if ((domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOM=
AIN_GTT)) &&
> > > > -           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_t=
ype =3D=3D CHIP_STONEY))) {
> > > > +           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_t=
ype =3D=3D CHIP_STONEY) ||
> > > > +            (adev->asic_type =3D=3D CHIP_RAVEN))) {
> > > >                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> > > >                 if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRESHO=
LD)
> > > >                         domain =3D AMDGPU_GEM_DOMAIN_GTT;
> > > > --
> > > > 2.50.0.727.gbf7dc18ff4-goog
> > > >
