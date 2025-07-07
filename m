Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DA9C83F07
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 13:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0909910E476;
	Mon,  7 Jul 2025 13:03:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IiN7gjCA";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B51110E476
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 13:03:36 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-313336f8438so663393a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Jul 2025 06:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751893416; x=1752498216; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ps9X8ufb82dg+lp3XJ4J4ECBoLNhOErAjP3M+Jw4k4=;
 b=IiN7gjCAAAKtn63ZP75VLQ4pJyzQOgO3rbguy8uOJkdffdMZJzQ3t3qp6Gxb4hfY3z
 WsUbga+dhTbWMVHi3YAKz8EYAALRyWCMptQ8EFuIjWhbO5Q++eruwQKajENwAhe0g/yJ
 DkcpAY0euviMnLiwcrTAImizTTUO8A6utff2UYbt3z4HNOMv2utUr0KvatKf3g1s0ogj
 +/7fsmOzhg6TDOhT0S2+zj5eglc2aWsvzOJ3Ii3n2zvwFT8msIUq3kpU3VErR0bw7HlB
 XUR7PyGMvWNpO/prOtYsRjl/sBOAPcCdDM2Ho53HalC87JHf4IpyZ9sQNsfCg2hh5G8j
 EsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751893416; x=1752498216;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ps9X8ufb82dg+lp3XJ4J4ECBoLNhOErAjP3M+Jw4k4=;
 b=qHkzwZ2gbRM+fSSJyxz2GZTZuAFaLJdbZrXIk1RXL/KisDdXHjOlljD9gQoccd4XkX
 LGpqn7L4Lg3N53Q3kisTL+9f5iFvsLGKvNHeEodWagWR+wmMK+Y3PJCnAmNnk9UrKXT9
 5dxy7u9ZT7C9+SK3i2wnw0EZH7YzbIzgKYON22CQCEEHy0Bz+mS6bcQZ/3dEtnje7/uq
 83SOUsR98XXhzpcMoFqrgNt6nsH6d61dxer1YpHrjraRTyvdVLRz9syweP99yQAbyxb8
 bQkYaZVf7LE57AtcJS1vwud047xLQwfqIGyxGLlzt4APgAKkifiNdw9+UXXIvn2oLHZT
 QuJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb1vfvEG+uVjltzzTRTr3XtRRpyhu0eqhw2tcc4iGkQB5Ge0pMjyD64J/ua7YldM3JKFD25AVe@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywgldu2MSaAkt7kPhxVpR2WgBpVvVF3rdoWufKJiim6DbBMia5K
 b/zRZMTil6dWSSjD/Q2ffns5mc8wKvcJi6tsUaGgtophu2ZFb30VpQAyI8gNM/vqhfstsp0p+db
 cCSITw2ENOQUTasprV4H3VsZWAbZ0SsI=
X-Gm-Gg: ASbGncu3BHdEqn2ZLQa1kC99mG889Y/9p0HAkjexboG1q7EcvsP/5HL+f0F5oH2Dj+I
 cXcrbusl1kbdRCO6mmaefEIq6mvguaG1uojVgBcXQUhYacyh7HLzB5wJV2Yvq2Qaod3OhdaDOwT
 X8Jix6Zre0z/i/Wul/J/8XeLcPitxQ8hMKoqKR7noZdfCp
X-Google-Smtp-Source: AGHT+IH30qggdKH6B6+EylprhDyrOpOVbv6HTAaXqcKzRxmmTbRpuOUP+uKLzSkXVLbT6R8+d7ieOsSDYHeB4+bobNI=
X-Received: by 2002:a17:90b:1dcc:b0:311:c1da:3858 with SMTP id
 98e67ed59e1d1-31aaca78c4dmr6248221a91.0.1751893415325; Mon, 07 Jul 2025
 06:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250701184451.11868-1-alexander.deucher@amd.com>
 <20250701184451.11868-2-alexander.deucher@amd.com>
 <a4uhvkpsbekjywwjc2lamhxf3hspdiwgj4gvxk5uwnc6sjt2hd@q47f7oyp2uxm>
In-Reply-To: <a4uhvkpsbekjywwjc2lamhxf3hspdiwgj4gvxk5uwnc6sjt2hd@q47f7oyp2uxm>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Jul 2025 09:03:23 -0400
X-Gm-Features: Ac12FXxgzXLDD3ixZSDcasIxFD4HvTQw7-s6jHfABGuXnMg6KZ6T2BZq1rIDL4k
Message-ID: <CADnq5_PN43ZujUWtBV47N9M_wj3j1FTMHg-3jPed=_MUXpUueA@mail.gmail.com>
Subject: Re: [PATCH 01/28] drm/amdgpu/sdma: consolidate engine reset handling
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com, sasundar@amd.com
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

On Sun, Jul 6, 2025 at 10:34=E2=80=AFAM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 07/01, Alex Deucher wrote:
> > Move the force completion handling into the common
> > engine reset function.  No need to duplicate it for
> > every IP version.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  5 ++++-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 17 +----------------
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  6 ++----
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  6 ++----
> >  4 files changed, 9 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_sdma.c
> > index 89a849640ab91..91e8f45fe886e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > @@ -573,9 +573,12 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device =
*adev, uint32_t instance_id)
> >        * to be submitted to the queues after the reset is complete.
> >        */
> >       if (!ret) {
> > +             amdgpu_fence_driver_force_completion(gfx_ring);
> >               drm_sched_wqueue_start(&gfx_ring->sched);
> > -             if (adev->sdma.has_page_queue)
> > +             if (adev->sdma.has_page_queue) {
> > +                     amdgpu_fence_driver_force_completion(page_ring);
> >                       drm_sched_wqueue_start(&page_ring->sched);
> > +             }
> >       }
> >       mutex_unlock(&sdma_instance->engine_reset_mutex);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm=
/amd/amdgpu/sdma_v4_4_2.c
> > index d3072bca43e3f..572d105420ec3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > @@ -1714,7 +1714,7 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_r=
ing *ring)
> >  static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     u32 inst_mask, tmp_mask;
> > +     u32 inst_mask;
> >       int i, r;
> >
> >       inst_mask =3D 1 << ring->me;
> > @@ -1733,21 +1733,6 @@ static int sdma_v4_4_2_restore_queue(struct amdg=
pu_ring *ring)
> >       }
> >
> >       r =3D sdma_v4_4_2_inst_start(adev, inst_mask, true);
>
> Now that you have deleted the below code, I think you can remove the
> variable 'r' and use 'return sdma_v4_4_2_inst_start'.
>
> > -     if (r)
> > -             return r;
> > -
> > -     tmp_mask =3D inst_mask;
> > -     for_each_inst(i, tmp_mask) {
> > -             ring =3D &adev->sdma.instance[i].ring;
> > -
> > -             amdgpu_fence_driver_force_completion(ring);
> > -
> > -             if (adev->sdma.has_page_queue) {
> > -                     struct amdgpu_ring *page =3D &adev->sdma.instance=
[i].page;
> > -
> > -                     amdgpu_fence_driver_force_completion(page);
>
> I guess I'm missing something, but this part is slightly different from
> amdgpu_sdma_reset_engine since here
> amdgpu_fence_driver_force_completion() can be called twice in some
> cases.

The logic should be the same.  There are potentially two kernel rings
per instance: gfx and page.  This function is only ever called per
engine instance so we'd only ever reset one instance.

Alex

>
> Thanks
>
> > -             }
> > -     }
> >
> >       return r;
> >  }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_0.c
> > index 4d72b085b3dd7..ed1706da7deec 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > @@ -1618,10 +1618,8 @@ static int sdma_v6_0_restore_queue(struct amdgpu=
_ring *ring)
> >
> >       r =3D sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
> >       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> > -     if (r)
> > -             return r;
> > -     amdgpu_fence_driver_force_completion(ring);
> > -     return 0;
> > +
> > +     return r;
> >  }
> >
> >  static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_2.c
> > index 42a25150f83ac..b87a4b44fa939 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > @@ -1534,10 +1534,8 @@ static int sdma_v5_2_restore_queue(struct amdgpu=
_ring *ring)
> >       r =3D sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
> >
> >       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> > -     if (r)
> > -             return r;
> > -     amdgpu_fence_driver_force_completion(ring);
> > -     return 0;
> > +
> > +     return r;
> >  }
> >
> >  static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
> > --
> > 2.50.0
> >
>
> --
> Rodrigo Siqueira
