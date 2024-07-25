Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC57EC3DA61
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 03:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 387FC10E5E0;
	Thu, 25 Jul 2024 03:24:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bf2H1kxc";
	dkim-atps=neutral
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76D2D10E5E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 03:24:44 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2ef23d04541so5069021fa.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 20:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721877882; x=1722482682; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WayTTBi5jxxOEVyhxmF/XI29Wve/qL50w0UXqsWCVVI=;
 b=Bf2H1kxc9FTlLMlAeIicE/F0GUNss4XOuV5IzktlLOOIedPwkcVLp2qZznHBjohtZB
 nHcQfpDgOe1nhQzbJPF8D6NHJLXat8bw8zwJLTbMpV47FgjS9oZDWCJBP3GbIX56NQZj
 GcLgC3VxQbTbvexPn46j8i22yZhm/LpWP13jPHBqRtWXPlKq/P6mmHfyCHQcOLoKS4M6
 k0HkFISKO//VOLyOW9j/08GXclGPe0aXeHDKXhT+2JjBBKfaaVFlZ7XCgLm5rb7c7+Tb
 KN3kDAxPF2ltaMaNqlGkAJ/P8vUvI2BkU2ZRKIhOoLtCPgg/aF7ILrUsyai2yUQYQp+I
 ohXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721877882; x=1722482682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WayTTBi5jxxOEVyhxmF/XI29Wve/qL50w0UXqsWCVVI=;
 b=b7IZK4H36+OqqrXWrFlKcmcjUBW9mSdgLzo4i/MyEZneqSYobcH/o27XS4c6eSxN7z
 61a0cYEgam0xsMRJc/8YY2YlJj4Oqe6pYiLVjYXd3xGAqhjCrbgZoIv+gI2Loq4Fm+S9
 9CsnqODQOImqqk0eOw8acLxu6CzGtOV5IUzIWSwLBKC99Pmp3YFQLs+mjIzuK9OubKv6
 6f6zQoePz6LsRjASwIW3/kClwTcJPewBOEZIo2tg0LG3mfQWQmqE2/KtUlUgBYqs05oa
 14t6gSUpMWWWG0UakjJWQ0VyLORD9SsMJKgIx0B3Q8FVuvmdAHSpkfa3ZHtTYLNX2HVE
 NB5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx7gxZgIe37CNmf69xL75FFNtL45NhV0m8drEo0X7V8gIPSX/yuMeffuOUKwOHOqeGZjQ7EHCqR77q9mY2tSsmLUSfs5BlD3wuKNLBDg==
X-Gm-Message-State: AOJu0YxmQvqwynbjWdflT+keN3/14V6CtBRUnU/7SD7bdILTeTspknke
 yQZiqLVmFmFWXthiWOO4mr8mte/qhayA+HkyUV3RWJ1yMVCv3VXHiOT9j5zPFN/DIqaPfLAQ0bJ
 86my4Lx5hC1fkWEc/6Hvh7fbe8y8=
X-Google-Smtp-Source: AGHT+IHssJjOGeDRktR1vg4ZiQrKPbsYJfY3oCBVAbeFlvYJYlzdx6NLyUBW0hGACJTGHzIROCkIBG4A40s/Puq8OEg=
X-Received: by 2002:a05:6512:308d:b0:52e:be14:7012 with SMTP id
 2adb3069b0e04-52fd3f24d19mr1032910e87.32.1721877882094; Wed, 24 Jul 2024
 20:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240724075047.57198-1-christian.koenig@amd.com>
 <CADnq5_PM6kfgYEgJmoCFXD8Rpiy2xqHzgy0Q=VLZejwpJ_ZAJw@mail.gmail.com>
In-Reply-To: <CADnq5_PM6kfgYEgJmoCFXD8Rpiy2xqHzgy0Q=VLZejwpJ_ZAJw@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 25 Jul 2024 13:24:30 +1000
Message-ID: <CAPM=9twKYoHHFWJmTZeESjBGTjpSSDwAhoV0CjtiOnsCWgX9-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix contiguous handling for IB parsing
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 amd-gfx@lists.freedesktop.org
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

On Wed, 24 Jul 2024 at 23:32, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Jul 24, 2024 at 4:00=E2=80=AFAM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Otherwise we won't get correct access to the IB.
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3501
> Fixes: e362b7c8f8c7 ("drm/amdgpu: Modify the contiguous flags behaviour")
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Please also add

Cc: stable@vger.kernel.org

since this is apparently needed for fixes to get into 6.10

Dave.
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index ec888fc6ead8..41055224930f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -1763,7 +1763,7 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parse=
r *parser,
> >         struct ttm_operation_ctx ctx =3D { false, false };
> >         struct amdgpu_vm *vm =3D &fpriv->vm;
> >         struct amdgpu_bo_va_mapping *mapping;
> > -       int r;
> > +       int i, r;
> >
> >         addr /=3D AMDGPU_GPU_PAGE_SIZE;
> >
> > @@ -1778,13 +1778,12 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_par=
ser *parser,
> >         if (dma_resv_locking_ctx((*bo)->tbo.base.resv) !=3D &parser->ex=
ec.ticket)
> >                 return -EINVAL;
> >
> > -       if (!((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)) {
> > -               (*bo)->flags |=3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> > -               amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_dom=
ains);
> > -               r =3D ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &=
ctx);
> > -               if (r)
> > -                       return r;
> > -       }
> > +       amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
> > +       for (i =3D 0; i < (*bo)->placement.num_placement; i++)
> > +               (*bo)->placements[i].flags |=3D TTM_PL_FLAG_CONTIGUOUS;
> > +       r =3D ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
> > +       if (r)
> > +               return r;
> >
> >         return amdgpu_ttm_alloc_gart(&(*bo)->tbo);
> >  }
> > --
> > 2.34.1
> >
