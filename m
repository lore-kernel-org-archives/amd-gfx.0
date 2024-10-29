Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17911D5B17B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 14:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D39810E677;
	Tue, 29 Oct 2024 14:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Js96qFRX";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F7610E66D
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 14:11:23 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-72088a79f57so153498b3a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730211082; x=1730815882; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2xzbukThybnH+o8icROAf0zpvMaEJp2eWbXZ75rQiw=;
 b=Js96qFRXuvIiKY9RXlqv6vB04pSzR+jKK4ueZpOKA2+JB0Q/ck+NYt/iVuDqwhwzxa
 pCFyLOBskONOjCKplBopNx+gky/H1NuO9T6Bsnlfa9GocVaS9Md4Hy4Y75jV1yg0umIx
 tBLUVuh3SNPNkoHYniaIGSlCUeLqNyoxbA28BSiS96LqO6WcrQ0KtrGOffyUqodQo3Eb
 N0iBZhzCpT06fwSh/mViM1NNw4TDkEJjJfCWYcog5UXGMHxxk5UoxtJjze7PsDJFaqpS
 7bn+WCJaQZ6aAgjHVaU7L9+wEnRq/FhbrO/0jPl7abRwslGEX81/ChOc52BecRfVQq18
 gczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730211082; x=1730815882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2xzbukThybnH+o8icROAf0zpvMaEJp2eWbXZ75rQiw=;
 b=UJLE78pOvywVWluDCzPnjH8VJypEJnaj3v0BHA8IRS1nBJnFT/W5Ro7siBL/QzjZ8i
 XeSK4xOhMMDNukeToistLIdZyaMYX/dICctNKtvAOL7AjR5fNcEtGLDWObRuiGKQeiRW
 Jy5ED6yUcMiNDOoqMcVc/1KDYvz3SdQcxFGWE+CxAcnGPCoozXlqt96g5lupeXJgefc/
 8VBshj22KlhXe5CmNcDZ8OAAo9dKJW5hRo733NBblRjHjRle8U+7pkxSCldGi2QfDURY
 h5D7vsrN4tutTQU+ntF3Aak0gE1V12u6VuSycrDH4yiTtbuWxDTtbitNbmFZu2LxUk7w
 NxIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd98JthGR7itZfX1Ij81b5WXhEUJYtoIkT42WE6wiGVf1Hero8j99BQmw7rD4AFbR6HBDaUFXE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyoRqG3Lywl1qfNkpH+upmIJaT7tjAizsS5KJiNWf8hTpPycDL
 WCP6nYeXwoB84RxC3FLezE/ctjb0A92zwczzMentOGofyCSZU/McbNlLQ3E8/H9d84u1P0pgLQp
 KOvYDyhd0wtLkgbBR8K2QmEdRQyI=
X-Google-Smtp-Source: AGHT+IFMSy3vbe6Ct795A3WfvFplp0LJGWxvYRF4eaBFK9A253oEC6YAJwwBml1xj1crU2OWArBEbi5VhNMvQc6jtOY=
X-Received: by 2002:a05:6a00:810:b0:71e:6ccb:bb9c with SMTP id
 d2e1a72fcca58-7206302bda0mr7265149b3a.5.1730211082405; Tue, 29 Oct 2024
 07:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241024092342.98760-1-tursulin@igalia.com>
 <20241024092342.98760-5-tursulin@igalia.com>
 <07f7b6b3-5fd5-4a2f-a619-966d7a1d03bb@amd.com>
In-Reply-To: <07f7b6b3-5fd5-4a2f-a619-966d7a1d03bb@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Oct 2024 10:11:11 -0400
Message-ID: <CADnq5_PUvEi6+43LO8hDe4bzo--G9CRv8HoNat-nAuFom+VQSQ@mail.gmail.com>
Subject: Re: [RFC 4/4] drm/amdgpu: Expose special on chip memory pools in
 fdinfo
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Yunxiang Li <Yunxiang.Li@amd.com>
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

Applied the series.  Thanks!

Alex

On Mon, Oct 28, 2024 at 1:51=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 24.10.24 um 11:23 schrieb Tvrtko Ursulin:
> > From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >
> > In the past these specialized on chip memory pools were reported as sys=
tem
> > memory (aka 'cpu') which was not correct and misleading. That has since
> > been removed so lets make them visible as their own respective memory
> > regions.
> >
> > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Yunxiang Li <Yunxiang.Li@amd.com>
> > Cc: Alex Deucher <alexdeucher@gmail.com>
>
> Of hand looks correct to me, feel free to add my Reviewed-by: Christian
> K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> > It is easy to do but is it worth it I leave to AMD experts to decide.
> >
> > I gave it a quick spin and have only seen all zeros when running a Stea=
m
> > game.
>
> Usage depends on HW generation and use case. IIRC GDS is the most used,
> but only in some rare use cases.
>
> The upcoming HW generations will depend quite a bit on doorbells.
>
> Regards,
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fdinfo.c
> > index 7a9573958d87..df2cf5c33925 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> > @@ -66,6 +66,10 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struc=
t drm_file *file)
> >               [TTM_PL_VRAM] =3D "vram",
> >               [TTM_PL_TT] =3D "gtt",
> >               [TTM_PL_SYSTEM] =3D "cpu",
> > +             [AMDGPU_PL_GDS] =3D "gds",
> > +             [AMDGPU_PL_GWS] =3D "gws",
> > +             [AMDGPU_PL_OA] =3D "oa",
> > +             [AMDGPU_PL_DOORBELL] =3D "doorbell",
> >       };
> >       unsigned int hw_ip, i;
> >       int ret;
> > @@ -87,12 +91,16 @@ void amdgpu_show_fdinfo(struct drm_printer *p, stru=
ct drm_file *file)
> >
> >       drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
> >
> > -     for (i =3D 0; i < TTM_PL_PRIV; i++)
> > +     for (i =3D 0; i < ARRAY_SIZE(pl_name); i++) {
> > +             if (!pl_name[i])
> > +                     continue;
> > +
> >               drm_print_memory_stats(p,
> >                                      &stats[i].drm,
> >                                      DRM_GEM_OBJECT_RESIDENT |
> >                                      DRM_GEM_OBJECT_PURGEABLE,
> >                                      pl_name[i]);
> > +     }
> >
> >       /* Legacy amdgpu keys, alias to drm-resident-memory-: */
> >       drm_printf(p, "drm-memory-vram:\t%llu KiB\n",
>
