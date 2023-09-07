Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC67EC8758
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 20:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1328110E095;
	Thu,  7 Sep 2023 20:34:39 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80DBA10E095
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 20:34:36 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1c8c44053e8so705546fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Sep 2023 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694118875; x=1694723675; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9h7IPXqY30s3vlnhZjWCz1icv85zvx9M/gASr/Ioew=;
 b=RPx51+KRPn+ltwO389/vtCv8HstSS4UNdkPSQ+rSKDV9qJaPkx4KNAcV12aZZSGs+i
 6rU8xuuhpTLK3wRr/A0slUlNpwct2VcCePooHnzt+QzKjtPCyq1Dv3D2B0/BsDrFY+oU
 VgYdsIA3n481BzHgdUG2g8yD0oSxRgtupy/Bm26osqhzfcPJjCursfeMTUG8fPApXRrz
 D+sWOYNaqavsZia3S7zcUP2DO5BRlh6nvXg4vWl2xhj3w78FM3J4KRBhR4DZGSztHkV4
 i6hRj74qJel5r5oJt7+MDur9xqte2o5OIjcDxzaLhiokM/xJ+gXM7+xKlfOoTiTZg3jL
 9njA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694118875; x=1694723675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9h7IPXqY30s3vlnhZjWCz1icv85zvx9M/gASr/Ioew=;
 b=uCKmH5heYqh0Z/XLlqKpcubCtjvA+on9eqiAxHqkhPeeuoDAh2i2vO2SrzqTyFxRMh
 2l76Lw2tv0Oct6N3URFI2aPyKNYZIhWKHrUxIBcESWOPHAv0ZuFIJxkPhzdQZ81QRUjb
 pg5lKhJKXiOuZ9/+YOAlMSxzLpTJPuUuAwppC7sdqjWh6TFNPbhEivwaJCkxZz1VZ6o6
 sQsRaT0llfBsH6XcL5mp5j6bV51NYEQnh5T3wDjHXkRk5AGSAeoc+93A8Evt9lnLO6rs
 +NSUQfnJNCQjFkyyaeL5gl0Y8w2Oz22eKKY474CdWu5Y3k/AiOtyONQR5bSF8ABFi815
 F43g==
X-Gm-Message-State: AOJu0YyV6B4IApwI1EXM19lBtx8rAbUJ0h+6LblW+dknmiyxkxyWbSfX
 GxoDLlOJIeHzPvriXF846gfiBTFV0dq38gpR/Jo=
X-Google-Smtp-Source: AGHT+IGNG0v4pAKAt4Megoy9yOX9ndc4y5RbA9i9OSriJ42fXgtl4avRsSP7NbqAPa73dOsIU1+sT/yfDYlOox7b8VA=
X-Received: by 2002:a05:6870:c596:b0:1b4:3388:d69d with SMTP id
 ba22-20020a056870c59600b001b43388d69dmr2197609oab.2.1694118875650; Thu, 07
 Sep 2023 13:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <ea9bfa9b-2689-45cf-95b7-57577f0d76c2@moroto.mountain>
 <DM6PR12MB26197B9B9A827160B1932F60E4EEA@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26197B9B9A827160B1932F60E4EEA@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Sep 2023 16:34:24 -0400
Message-ID: <CADnq5_M==-2-2vWThG3TeC-o+6Ya5xiDT0SoSj1XHVNDvo4Wmw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix retry loop test
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kamal,
 Asad" <Asad.Kamal@amd.com>, Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, David Airlie <airlied@gmail.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Sep 6, 2023 at 10:00=E2=80=AFPM Quan, Evan <Evan.Quan@amd.com> wrot=
e:
>
> [AMD Official Use Only - General]
>
> Yeah, nice catch. But personally I would prefer to change the check as "i=
f (retry <=3D 0)".
> Either way, the patch is reviewed-by: Evan Quan <evan.quan@amd.com>
>
> Evan
> > -----Original Message-----
> > From: Dan Carpenter <dan.carpenter@linaro.org>
> > Sent: Wednesday, September 6, 2023 6:55 PM
> > To: Quan, Evan <Evan.Quan@amd.com>; Wang, Yang(Kevin)
> > <KevinYang.Wang@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
> > Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; Lazar, Lij=
o
> > <Lijo.Lazar@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Zhang,
> > Hawking <Hawking.Zhang@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; amd-gfx@lists.freedesktop.org; kernel-
> > janitors@vger.kernel.org
> > Subject: [PATCH] drm/amdgpu: fix retry loop test
> >
> > This loop will exit with "retry" set to -1 if it fails but the code
> > checks for if "retry" is zero.  Fix this by changing post-op to a
> > pre-op.  --retry vs retry--.
> >
> > Fixes: e01eeffc3f86 ("drm/amd/pm: avoid driver getting empty metrics ta=
ble
> > for the first time")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > Obviously this only loop 99 times now instead of a hundred but that's
> > fine, this is an approximation.
> >
> >  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> > index ff58ee14a68f..20163a9b2a66 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> > @@ -336,7 +336,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct
> > smu_context *smu)
> >
> >       /* Store one-time values in driver PPTable */
> >       if (!pptable->Init) {
> > -             while (retry--) {
> > +             while (--retry) {
> >                       ret =3D smu_v13_0_6_get_metrics_table(smu, NULL,
> > true);
> >                       if (ret)
> >                               return ret;
> > --
> > 2.39.2
>
