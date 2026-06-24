Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A13CDE001
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 15:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 981AB10EF8F;
	Wed, 24 Jun 2026 15:17:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cTsZxRhn";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64C1E10EF8F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 15:16:59 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4922244f7c7so10684195e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782314218; x=1782919018; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hfev2BF9XXqZu6qr7sd+dwJ4FJPO+rg18vv7f38ltrU=;
 b=cTsZxRhn45bmRS2hnve96tWIPq9Y3Ht7Bku7vLyceexWuZ880X5A7hyCusR7dtDUJb
 I88NdbITnU7CbLIJoS7r4LCR8AWNEGJWWlo/cMdoc5u/JN3+c80JxOeUgBOr35PlGAJg
 3MiH1NSYVmYwHYK0ucSkMCKhmwjcQocyYA7+zd7nnWoDw/oVfZo/i+EhcKsUdmOpmsuK
 ELjRXj14oRt1PMPQWkWzgPpwzi3gC8vejNttdNehV1+YIjru06VUTfMnJKLNeO7A+++1
 CCtzXaQfA1iFPNM8xKlgEHYk98Zq0tR5WWj/wI2iQIuWk2LdN5IIFBQwztDmTNuQqutZ
 YUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782314218; x=1782919018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hfev2BF9XXqZu6qr7sd+dwJ4FJPO+rg18vv7f38ltrU=;
 b=c5ARcfEnb6joG3Ovbeskknrr9sgiTORd2VHHo0EzDSMS9CfuhfeNC9KfyKHXoFemFV
 1/tHZs3KAXXNEiJBV94xFwvss6dtUqaSxXW2DaBbrIE/nnM99pHPEI4CdBv6Sx2fXnzr
 6LyZzljFLRSS3TwuDXiyHVFZhjSPs1/a4W+SkWxlp5aLSDkLIbdgc2gdio2M2n3c84S1
 afuTZ2uVn0NiMmERBYxxMcbo42RqkX3/vcQirgc21DIHswRycgTQKyM3yFT2/zEU4CPM
 dH4x6ZxoVBRmpG6hvFwvZS8c60xG9SORMyCdHTkTPprecJCNW/XOTcUnD85grluVFmVo
 w5jg==
X-Gm-Message-State: AOJu0Yw3iBp9qTKpLy4BKj8FM1IhdcCdFFBQuk1UQyM5NcODWTKgcDoi
 boAWTgN0QqVFfN+VfztMcYRWGroLkVWfyOj6lnsz0PyFCNMK8zEdl4gHQ9W8tA==
X-Gm-Gg: AfdE7cnHvfmPBtdFoJGMxH/Ww7fip1g1SrKkVNAFrIWY4bRrFsJfdW7Saw0ZMTz3KHs
 0V1R0yMF3BGE/tVCMkf57zfFJnf2Pn5uljI+hmw0d9yXFIy5hiZ6UoCIK7D0KF4pngOK9TCmVMO
 HxCruuwFDlKZ4adCBtFg2FpndTLA8uSWAwoDkjO/9bQcPUvXvgM5cP+yCOWUnAQZ2sCeMxJAX3Z
 qBSCr+0H2Lr+Jcguv/+IzrlLzcya1AamVQ2otKK0QUkFFKbQl1ZfoWgihlQ/fkwr9tf90GL0Sb3
 ImCn+heGhKEX+fWibak6hMKQWbrUOIJuuGDJWKXPGEEWrTqzTKUe+QpjiqwXcNYmMqikoft62Om
 iPTzHL8z8RNfBhcFsEyjrRUHwDF8VfEQJ5RM1LCq+cfPWIvlPzAq+HtptiRk4h6HaetEpaDubzW
 /OcXY23JGVTbmBI2l5b+r7XPBxbQ==
X-Received: by 2002:a05:600c:4686:b0:490:50c5:8153 with SMTP id
 5b1f17b1804b1-4926084ab47mr55255735e9.2.1782314217711; 
 Wed, 24 Jun 2026 08:16:57 -0700 (PDT)
Received: from timur-max.localnet ([62.77.225.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926092176bsm68368655e9.2.2026.06.24.08.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 08:16:56 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 4/7] drm/amdgpu/ih7.0: Use IH_SW_RING_SIZE for soft IH ring
 instead of PAGE_SIZE
Date: Wed, 24 Jun 2026 17:16:55 +0200
Message-ID: <5847800.IbC2pHGDlb@timur-max>
In-Reply-To: <6297d359-2d4e-4961-a645-a2a241aba823@ursulin.net>
References: <20260529103059.21470-1-timur.kristof@gmail.com>
 <20260529103059.21470-5-timur.kristof@gmail.com>
 <6297d359-2d4e-4961-a645-a2a241aba823@ursulin.net>
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

On 2026. j=C3=BAnius 24., szerda 16:37:11 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> On 29/05/2026 11:30, Timur Krist=C3=B3f wrote:
> > When there are a lot of retry faults happening, the soft IH ring
> > can fill up really quickly and possibly overflow. PAGE_SIZE was
> > too small, use IH_SW_RING_SIZE to match what other GPU generations
> > are doing.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> > b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c index 4e6d14facf93a..ec0919fa825=
40
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> > @@ -587,7 +587,6 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block
> > *ip_block)>=20
> >   	int r;
> >   	struct amdgpu_device *adev =3D ip_block->adev;
> >   	bool use_bus_addr;
> >=20
> > -	unsigned int sw_ring_size;
> >=20
> >   	r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_IH, 0,
> >   =09
> >   			      &adev->irq.self_irq);
> >=20
> > @@ -619,9 +618,7 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block
> > *ip_block)>=20
> >   	/* initialize ih control register offset */
> >   	ih_v7_0_init_register_offset(adev);
> >=20
> > -	sw_ring_size =3D (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D=20
IP_VERSION(7,
> > 1, 0)) ? -			IH_SW_RING_SIZE : PAGE_SIZE;
> > -	r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, sw_ring_size,=20
true);
> > +	r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE,
> > true);
> >=20
> >   	if (r)
> >   =09
> >   		return r;
>=20
> Looks plausible to me.
>=20
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>=20
> The only other which uses PAGE_SIZE for the soft IH ring is ih_v6_1.c so
> maybe that one needs tweaking too?

I can tweak that too for sure.

As a side note, though, IH 6.1 is used by RDNA 3.5 APUs which need further=
=20
work to make use of retry faults because the APUs don't have the retry CAM =
so=20
we'll need to come up with a different way to filter the interrupts in soft=
ware=20
as we already discussed in a thread on the previous series. Same goes for=20
RDNA1-2 dGPUs which also don't seem to have the retry CAM.

Thanks & best regards,
Timur




