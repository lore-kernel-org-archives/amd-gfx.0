Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363FEE6FE3B
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 17:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89EE910EAB9;
	Fri,  6 Sep 2024 17:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="akI0XK+w";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F400F10EAB9
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 17:53:54 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-7179723919cso139258b3a.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Sep 2024 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725645234; x=1726250034; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7HSiYHFYtIYD3DFC2tu7ra533pBvEU3b7z7FlC/7L4=;
 b=akI0XK+wV1c/ovsGaK5+E2Rfj+Q29lxY815daWvaRIZz2Y/7yKIw3dq7lvtt667+QH
 8IW49Jb5/ZJm3u5t/J8bjksIUjULfX9PRoi1GcMa/qFm2x9KoWkoqJfCvReC+ByPv/3R
 /NeKphjqml0oJBgIo14KJdgpDSrP0bqGY/GsSmzBp/IrbxH4FUNfRrlqDJaa1W/Xaj3A
 6GZguPYfdiMhltN0RNdaUzeU7n0mHw8F3sQt/6AkAvqwPzqaoh0JYPJ+CEvEQLsCka7V
 XtRytzFugQhz4hojB4diNmpYp70MJuelNfziRd9GU8XMpgcF5BLWK+H92WmV6sgJyRe4
 vYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725645234; x=1726250034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P7HSiYHFYtIYD3DFC2tu7ra533pBvEU3b7z7FlC/7L4=;
 b=Pdic8mfu424DqZac2Y/Xt+tHHuda0OvMz2jPzeTXHQGo4g+o7o3XYB1zGOrD/iS6+U
 5QWkR1O6qym0gyuEEWLV3zqurtoNEGBLw80JGJextVjrOScKYM+cPJInHM3POsBwjduC
 ePOI00Kw02Kn1cOXkWbkGR0nKnzxmd3pLye8oO/LPMHX9Fgm7MpJBqQgcF3hsMar+0WV
 sqkBR0I5trqWX0+J1te1AcsSBWHC3AxFGbMy34/F+8t5Hyi7xEdRx6zqIJPxxPVyGvgS
 uEgZ/4ZA0eZuAkSq6iwS8F4LlTuRBV9EY0KsnBrMSq21qEWHaqtjIZ3GMrf4pAeZNkBR
 kNGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWku37UPg4U/tRE0K9lz1cNMKiBd0473tc6LjhA8mwz0nbmzUgVIccGa62bcf6uGaZ2Zl3rGyZt@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqWvpeoC7kA5/aFVil8/gnp1vXVB5137/FU+LiFRIV76Kf2sx8
 CYAeF0VZeA6usJdB2yO1gf7SdK3ox1DRFQXxdk5eyCh1RDu8rSjVHr4g7HJtmm2NTVDVqAfB17N
 FhRkCkN0X+Y8P+VKg1bx0f0gaeBtiNw==
X-Google-Smtp-Source: AGHT+IFPAo7VaGnfPSoAQX5ULMTVhkqlXUYsJc8XSetMKkWwzvuD97FvNWY5v0lz9jmz5tpN38s7pW12wjCUW7cq8qU=
X-Received: by 2002:a05:6a00:2d15:b0:70b:705f:dda7 with SMTP id
 d2e1a72fcca58-718d5f64795mr2053273b3a.4.1725645234250; Fri, 06 Sep 2024
 10:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240829172645.1678920-1-alexander.deucher@amd.com>
 <c52a3df8-dcad-4fc7-8051-b8a05e1b49f2@amd.com>
 <CAAxE2A6HqOqx3jYkGDtHYd=NRSWY__+JYE6enF=skcpwYBtYhQ@mail.gmail.com>
In-Reply-To: <CAAxE2A6HqOqx3jYkGDtHYd=NRSWY__+JYE6enF=skcpwYBtYhQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Sep 2024 13:53:42 -0400
Message-ID: <CADnq5_MqtR9govD=dyWt79Roit8n4danMNJVQYUo6Sg0TD=y3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always allocate cleared VRAM for GEM
 allocations
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Fri, Sep 6, 2024 at 10:18=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gmail=
.com> wrote:
>
> Can you also bump the DRM version, so that userspace knows when to
> skip its own clear?

Sure, although going forward, it might be better to migrate to a
generic flags query in the INFO ioctl so we can just check for various
feature bits so we can backport functionality to older kernels more
easily.

Alex

>
> Also, clearing with SDMA takes up to 33 times more time (=3D is up to
> 97% slower) than clearing with compute.
>
> Marek
>
> On Thu, Aug 29, 2024 at 2:23=E2=80=AFPM Paneer Selvam, Arunpravin
> <arunpravin.paneerselvam@amd.com> wrote:
> >
> > this will fix performance issues,
> > Acked-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> >
> > On 8/29/2024 10:56 PM, Alex Deucher wrote:
> >
> > This adds allocation latency, but aligns better with user
> > expectations.  The latency should improve with the drm buddy
> > clearing patches that Arun has been working on.
> >
> > In addition this fixes the high CPU spikes seen when doing
> > wipe on release.
> >
> > v2: always set AMDGPU_GEM_CREATE_VRAM_CLEARED (Christian)
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3528
> > Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> > Reviewed-by: Michel D=C3=A4nzer <mdaenzer@redhat.com> (v1)
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gem.c
> > index 1f149c9e2177..8794661b0bfa 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > @@ -349,6 +349,9 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev,=
 void *data,
> >   return -EINVAL;
> >   }
> >
> > + /* always clear VRAM */
> > + flags |=3D AMDGPU_GEM_CREATE_VRAM_CLEARED;
> > +
> >   /* create a gem object to contain this object in */
> >   if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
> >      AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
> >
> >
