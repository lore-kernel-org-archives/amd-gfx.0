Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED0AF589AE
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 12:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0CB410F0DB;
	Thu, 23 Apr 2026 12:18:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eAJTe7rl";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F3E310F0DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 12:18:18 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so107569565e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 05:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776946697; x=1777551497; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CcU/jfxDioZ8JkxyjX2SsLfSw15vHub1TuHSz8yxwqU=;
 b=eAJTe7rlPWQVNuv+U/DSuKvyl2DbizhuqAQ03JP2cWteKbEyHbqK4qSj5clo/CBaMz
 PAXJ0YJ5K7CHnSrjmN5pt+N58hxWx6JqwAEAW0E34HDo5fSyNohk6UJgOssFMAJMul8E
 asYEXjgs4NKd/f0IVSp/Y7isg2SgnOQgG96dxY6+RaXaJAuCvi6OXTv60+2dIEf7PJx1
 H0IyvqaM0BJzETVrJLxP6msvRoM+6OMxqe8PK3U25e4LnnhuABLWYdTwVFEYxlHiLYZQ
 gkaYWK0UpZ0JWkaQywN0UftHqK7TUqln0uGncpu/S8w/wztUz77upDndubLRQdrhxCyW
 JK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776946697; x=1777551497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CcU/jfxDioZ8JkxyjX2SsLfSw15vHub1TuHSz8yxwqU=;
 b=jcigRdfveLyVy2LwbkAOJeEcl2kcGbJrQ6+3SXYSd510Eg7nmB3PDjAH8idfKw90T2
 pLN1ka8Sjo3RicMjgmOrZuQ2oJLU69zQgvuGxi6KWVr4UTeKxB8C9HasxSYkwwKIY42Y
 vcX0wDMLO2xMUFZNtnsC9NqCQzwBun24wxJOxAqOlXoLjKY0ouvUACpSoyFUUFxIubT0
 Do8kFtxmPVFfjs6gz/62lOFaCUqqCzi9XYiwiYYoRFxWY908iAcSzzavkePvVheJTVgG
 3hM0e0dcL7QQDjKAIDUOa4wddNcpFuNE8gx8vUNOOADWdG2avjHu6y1rlypUGEz+sWYc
 gB7Q==
X-Gm-Message-State: AOJu0Yy4iS4+e8sK8TW/O/hoJ8z7cuGV2wImYw2udLmd3q19nTJS2wbi
 LLUcnV/+ypb2CKptCGD6zISUQ9IzreMa6CE9Z4wMW6kwDE0LDhheJyfb56brEg==
X-Gm-Gg: AeBDiesJ8/9JmkOThRoo7Su94/rtgUG5XrrRZj8s2MuizMgiulJ5yPFUjA225xLPSNV
 7yz+7d8cJ8IANDXTjP8ptCGiZsg1Mzc2KL+46BNW8vEbjZzdEVKGOoQgPMXMBglf8R3G43y+a1k
 3V+9WFz9WeP8fhNOnlkT9HvJ06zBj0Du7pBmD5fE2o4qtM/JdcTynwspZB2enMh7VHXl0iI1tFD
 Fd+LxdxNwn7OF8jUyqlkKDiJVs6IZtKn7ivH5Pfaf26xdwqD2d8DnDOloueFe5wY8BzyIPdETzx
 4FFBbNxOSZsJ05Vxnr2Ry8ErhGRwa5T40c/7P7icLuuQulAX0+tOXGarH7pv8DM/yhlaje0NJpT
 MWGghVoE6mK5onhKmCftEswugWwe1rou5M4oPurK+lk6FeY8MXS/owC7zJow+H1XSb3buO+zkkx
 zevlfpYJbU0tCEhhdz1Y911IYG29TZoFApWMeigMIl2AodWI2eugtOEzT4FidQ6hYbxdK+SM6wZ
 nv9nveV3pA=
X-Received: by 2002:a05:600c:8183:b0:488:b187:3c with SMTP id
 5b1f17b1804b1-488fb765ab5mr394300255e9.14.1776946696606; 
 Thu, 23 Apr 2026 05:18:16 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4dc24cfsm52420203f8f.16.2026.04.23.05.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 05:18:16 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 John Olender <john.olender@gmail.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 01/11] drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB
 size on Tahiti
Date: Thu, 23 Apr 2026 14:18:15 +0200
Message-ID: <10056594.eNJFYEL58v@timur-hyperion>
In-Reply-To: <a3dc4b02-505a-4547-885a-ab585310e652@amd.com>
References: <20260423011614.309180-1-timur.kristof@gmail.com>
 <20260423011614.309180-2-timur.kristof@gmail.com>
 <a3dc4b02-505a-4547-885a-ab585310e652@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Thursday, April 23, 2026 1:04:53=E2=80=AFPM Central European Summer Time=
 Christian=20
K=C3=B6nig wrote:
> On 4/23/26 03:16, Timur Krist=C3=B3f wrote:
> > The TLB is organized in groups of 8 entries, each one is 4K.
> > On Tahiti, the HW requires these GART entries to be 32K-aligned.
> >=20
> > This fixes a VCE 1 firmware validation failure that can happen
> > after suspend/resume since we use amdgpu_gtt_mgr for VCE 1.
> >=20
> > Fixes: 698fa62f56aa ("drm/amdgpu: Add helper to alloc GART entries")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c index
> > 9b0bcf6aca445..673e9e08c66a0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > @@ -198,12 +198,19 @@ int amdgpu_gtt_mgr_alloc_entries(struct
> > amdgpu_gtt_mgr *mgr,>=20
> >  				 u64 num_pages,
> >  				 enum drm_mm_insert_mode mode)
> > =20
> >  {
> >=20
> > +	u32 alignment =3D 0;
> >=20
> >  	struct amdgpu_device *adev =3D container_of(mgr, typeof(*adev),
> >  	mman.gtt_mgr); int r;
>=20
> Only a nit, but reverse xmas tree order please for variable declarations.

I haven't found this in the Linux coding style guide, can you elaborate wha=
t=20
you are referring to exactly?

>=20
> > +	/* Align to TLB size on Tahiti */
>=20
> Oh that needs improvement.
>=20
> Maybe something like /* Align to TLB L2 cache entry size to work around V
> bit HW bug */
>=20
> Mostly nobody will know what that "V bit HW bug" is, but at least AMD peo=
ple
> can search for that in the HW docs.

Sounds good, will add those details to the comments (and commit message)
in the next version of the series.

>=20
> With that fixed Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.c=
om>.
>=20
> Thanks,
> Christian.

Thanks!

>=20
> > +	if (adev->asic_type =3D=3D CHIP_TAHITI) {
> > +		alignment =3D 32 * 1024 / AMDGPU_GPU_PAGE_SIZE;
> > +		num_pages =3D ALIGN(num_pages, alignment);
> > +	}
> > +
> >=20
> >  	spin_lock(&mgr->lock);
> >  	r =3D drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
> >=20
> > -					0,=20
GART_ENTRY_WITHOUT_BO_COLOR, 0,
> > +					alignment,=20
GART_ENTRY_WITHOUT_BO_COLOR, 0,
> >=20
> >  					adev->gmc.gart_size >>=20
PAGE_SHIFT,
> >  					mode);
> >  =09
> >  	spin_unlock(&mgr->lock);




