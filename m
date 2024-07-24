Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B058C3DA63
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 23:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F7BF10E107;
	Wed, 24 Jul 2024 23:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VSOf05/5";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9F5310E0F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 23:10:08 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-42803bbf842so2713585e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 16:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721862607; x=1722467407; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ew7EELakKtCO/FScT16IvgM6lq2FGyEy9vv0/1/4b4Q=;
 b=VSOf05/5adKVYd6zLb2GBQBrE+5h6Z+nScxJRwGfK2/Or3UVULJYgrOaaSXtyOo52Y
 3n2TcIIzm6TpYK+mKlR8jQtT2zoOISo0igTPKAFCpVBjgTTh1Aae/wEXb2+Z3E32ZSNW
 ZQsm7kcG/oEMw4C7wPASC1T0uoZLtZgl3ZkltTvv+DkI/YhjNY+8d+mcaTkzjt9Oitgo
 SQ8g8tdoqGBtC2iJUIh8r6LQfNe1g9HxBbrqWyEeBRvV8Ne+OjXxb+V+eNaxX25Yxzw7
 efRVYpz46CPn5x64Wp4amXgHVffx0cO07d+8B8R4uwfKbNqARy0EQG75nlRyeEyh979P
 dTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721862607; x=1722467407;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ew7EELakKtCO/FScT16IvgM6lq2FGyEy9vv0/1/4b4Q=;
 b=JEPfp8WtjzP1+4fm1niAeBcMc2Azd5uvrw/c3vBYtWcGUYWpilIaL6ZhVeAaVUGgYz
 7KbL2RdrKeAHwGXM793O12lvGZxEn+CsAfeFcKHi2c0tCKSy4OsZNEzalEytfmQtedb2
 9yLRLDGBOhD5nlmkFMaFY3a/2D87M8GE0ILcIVheoXBj16mbMl4KrL4pOsM5TTm3FAwM
 D/NHNHnhyNVuZ3it2GMIpriiGoeqDMiQAfKUSo/QVSvKUVxQSt+wrAbN2wVbzhxqRiMu
 8IcAr0mDDFWS1DdDwvOBnjJa6b9lOiPw0UWGiMMJPguzRl+TOymFuiKGC6RwMgzXJA1V
 s5Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFD36Y0DHgbQre8ECgH3L3gAtCD6JikcaYVtC0+11jHvRQhZmRIrItQyV5Iy7Sr8HQ3JZbsmMI2lkmd0emFp3keGVh2ohQpCqTtJqHiw==
X-Gm-Message-State: AOJu0YwdgRnDB958qJ47fD3cjn+/qty48OIbwzVYjcy7qI4u1EyD/P92
 xPubcOBwiztuJ5UnYoMrtt4H+382xhSAeIJjNmNdqymfKo1PqmKqzoQRX/kGsXyjDps5RnXuoA+
 XGUUENstVkJ34/CIup5UetxzTfI0=
X-Google-Smtp-Source: AGHT+IH7DBvtfboO9AYJz2s0dIr3DWFmLtQuZy2+uM+7dQq3kX4xrg876Svx7YavpgAwBN7nD8H7KXrfh/5S+ivEpk4=
X-Received: by 2002:a5d:634c:0:b0:368:5b38:14ee with SMTP id
 ffacd0b85a97d-36b363c62f3mr110242f8f.23.1721862606536; Wed, 24 Jul 2024
 16:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240724075047.57198-1-christian.koenig@amd.com>
 <CADnq5_PM6kfgYEgJmoCFXD8Rpiy2xqHzgy0Q=VLZejwpJ_ZAJw@mail.gmail.com>
In-Reply-To: <CADnq5_PM6kfgYEgJmoCFXD8Rpiy2xqHzgy0Q=VLZejwpJ_ZAJw@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 25 Jul 2024 09:09:54 +1000
Message-ID: <CAPM=9tx4UjPBtKWxHmPfHWSNYtW0=y21oseRp4brz4b7EG-zKg@mail.gmail.com>
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

NAK (just capitialising to avoid it getting committed)

This doesn't fix it, I think you also need
AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS set as well.

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
