Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013AFC83F35
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jul 2025 07:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 936B410E726;
	Thu, 17 Jul 2025 07:39:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="nguGav4J";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC29A10E3A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 16:40:52 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-237f18108d2so2885ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 09:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1752684052; x=1753288852;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBVaXc10A4jRruPriSxBpOpyudYSZuIpQyGPNMCEI5A=;
 b=nguGav4JBPz6WDgk71CnAxPtkPPduFmHOD6Jvl5ciH0Tq/fxOuYeWOHz168H7CLcMq
 gQWFfr68H2xeuiF1D21lXl5RCW1JdhSv59cw7wMQ4PuVf47N0b1qZpVPcvSV+NSbfuDu
 0YBoRB6SV6Oc7uQMot/bJbHcAi51Ikiz0pUYZiWks6nhdlAdK7w+8zr+L5UWduz6oft3
 eWb3n1yfzCD+wA0NibmOVXkHN5mYc2kpslzTjRCda1ejfxzakUgGviwP/vUVAfzFNVIQ
 bjf6zncU3ZEtY8VnPSpGKgnFVBdDao+MmDH27Mb2aJ7ACihd4JR8Hepeu5re44MJ0B1K
 2Epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752684052; x=1753288852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BBVaXc10A4jRruPriSxBpOpyudYSZuIpQyGPNMCEI5A=;
 b=VviVYE4BGm2DmwTvDJlkQwA6/jNPJuNwZLFSoDg34nEtBpCUGMjkdN/A3rXvXI2Vts
 0gS5JYMeacntsvlcyXfhpcMVjCw0BIa3lALwh/lnvfLlgGVPKOuiZJ1zdnh9sO5Y3jBQ
 9ZBQ5DnpiFyozG+cddtx6f4KkMe5WjO46PnwwSlZOF0U8CouFdy7goYjDUlwQbbeTnqq
 tda38wnXcBsokogA+5OOe6+6rzQoNK0UzeH5wXvO/io7i/ZstshNMTbCVR++Au6GnWBK
 pbIxiDtjQ35hNTJ7X6uVA1AUI3xZ2mA8JFCLyWzzDoxRyG95jAkfwWYXwqKNBsJpIMHM
 qO2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4Q1sxz/Jf81ER+nSar1IPv0NzkhuO0jqrtF9HTg79uwc//A/KZjMOnQcfZCKr4Df4JHuEjHhd@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw74aku1aFIuIJ3loY30BnvPM6nmj8SyvfdxpkidjV36aQz6uUb
 yN/KydpTKMTfQZbGcMMkIxZD2Ddj59Jopf0w9AZI5A2CFAqTnu7BPXhkA8bwWRuPqy+OrwwTxYg
 YKCFMQ9IGt30dshb86Vrd592+vdr33IhLErgMKF0SUMSzB/XZrlGKCEWpiew=
X-Gm-Gg: ASbGncsUAtG7DoIFmn0IJQEMvJ6bLIpTClcU9u+4QYrxTdtn4cXL8OgevWOeAht3k/2
 OLmifCMHiM+xqkArUgdqC/z5YcGC7/K+Gh21kkg7Pz7exCbYP5b4cHs7pWPBL91o9jazbiHsZE1
 7bcFFm0sP+oksgH4yhyKRWXGnccXYf5lk284F/R5gfobtogTltEtqxTWOh+lxbHxOMpHLIvpu9g
 cK7GDoWUuO3ZmPD
X-Google-Smtp-Source: AGHT+IHYQT5VXdCLT8hxrmg+0yfaXwrBL7UyuNaYscaOfd+9wb7KNDQaQqvXeihVJ+Iuuagh7P0Alzo8AVqhcyLotSs=
X-Received: by 2002:a17:902:e5c2:b0:235:f298:cbbb with SMTP id
 d9443c01a7336-23e2644036cmr3043915ad.26.1752684051728; Wed, 16 Jul 2025
 09:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250716161753.231145-1-bgeffon@google.com>
 <CADnq5_P+a2g_YzKW7S4YSF5kQgXe+PNrMKEOAHuf9yhFg98pSQ@mail.gmail.com>
In-Reply-To: <CADnq5_P+a2g_YzKW7S4YSF5kQgXe+PNrMKEOAHuf9yhFg98pSQ@mail.gmail.com>
From: Brian Geffon <bgeffon@google.com>
Date: Wed, 16 Jul 2025 12:40:15 -0400
X-Gm-Features: Ac12FXyULN47EIoDp4OeB3JlE-FJDnHi4sIL1ptSRWoQg8L9yjUdgo_BV4vPoWI
Message-ID: <CADyq12zB7+opz0vUgyAQSdbHcYMwbZrZp+qxKdYcqaeCeRVbCw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Raven: don't allow mixing GTT and VRAM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, 
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

On Wed, Jul 16, 2025 at 12:33=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Wed, Jul 16, 2025 at 12:18=E2=80=AFPM Brian Geffon <bgeffon@google.com=
> wrote:
> >
> > Commit 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v=
2)")
> > allowed for newer ASICs to mix GTT and VRAM, this change also noted tha=
t
> > some older boards, such as Stoney and Carrizo do not support this.
> > It appears that at least one additional ASIC does not support this whic=
h
> > is Raven.
> >
> > We observed this issue when migrating a device from a 5.4 to 6.6 kernel
> > and have confirmed that Raven also needs to be excluded from mixing GTT
> > and VRAM.
>
> Can you elaborate a bit on what the problem is?  For carrizo and
> stoney this is a hardware limitation (all display buffers need to be
> in GTT or VRAM, but not both).  Raven and newer don't have this
> limitation and we tested raven pretty extensively at the time.

Thanks for taking the time to look. We have automated testing and a
few igt gpu tools tests failed and after debugging we found that
commit 81d0bcf99009 is what introduced the failures on this hardware
on 6.1+ kernels. The specific tests that fail are kms_async_flips and
kms_plane_alpha_blend, excluding Raven from this sharing of GTT and
VRAM buffers resolves the issue.

Brian

>
>
> Alex
>
> >
> > Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v=
2)")
> > Cc: Luben Tuikov <luben.tuikov@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: stable@vger.kernel.org # 6.1+
> > Tested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> > index 73403744331a..5d7f13e25b7c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -1545,7 +1545,8 @@ uint32_t amdgpu_bo_get_preferred_domain(struct am=
dgpu_device *adev,
> >                                             uint32_t domain)
> >  {
> >         if ((domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_=
GTT)) &&
> > -           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_type =
=3D=3D CHIP_STONEY))) {
> > +           ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_type =
=3D=3D CHIP_STONEY) ||
> > +            (adev->asic_type =3D=3D CHIP_RAVEN))) {
> >                 domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> >                 if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRESHOLD)
> >                         domain =3D AMDGPU_GEM_DOMAIN_GTT;
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
