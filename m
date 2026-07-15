Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934BEC44507
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 19:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FF910E298;
	Wed, 15 Jul 2026 19:23:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RkE+b7VD";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1817610E298
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 19:23:11 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47dec32798aso6034676f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 12:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784143389; x=1784748189; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sH+TuEWYDpDiV+0F/lj8zm6H3Buptydm1QWWc05zGvo=;
 b=RkE+b7VDT/DvlgPo49iB37DfNDzEOrmIlAycBJ7LRNMZUJqqNnL0bMmH70IFgjtSR8
 /9ySISVI0hQaRXgrQqSciz/s35nnQQLusZA2j7+GFPFTqK0ENeyazqu0gi+B7SLHWwM5
 8UOB3sRuzHgylVjreqvdhIA9oVMafk9RA6YtbQ1ld7S4wkmAK5oTRx6afVEcTVBU0Qij
 hVperXl+5jy4KuOSeuTEHxAi4F5MtEKE0gkGdzt6zgbocu9e0XGlHZm6rKV2Tmchu3qi
 O2imaDJBCxmZxRafYvOJP1HOD7v0NDI7g343eBTnDMaSbgwkvcnTd49qmEBHIrZDDdLm
 AXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784143389; x=1784748189;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sH+TuEWYDpDiV+0F/lj8zm6H3Buptydm1QWWc05zGvo=;
 b=HTasBfG7a5Qhmwpj08Q3hHKnsmCrpQjRTSgkmpbxjXjg2hJEx31Ufi7x7NRaGp0Sit
 pwcru+PfE79oo8bC8eZxokejfqTc1wDmhiWMmZX+GqNF7Jhp5XFR/T+rpM3aQV1QfM9V
 F59eEiJeuXSQHmvJhnofF7WTfFFlUQDilXztD2cc3sAY/dPYDHsmPLtTEa/a9rPvb7ao
 RigKCsagRGIAaDi5CgQBZnJgvTfYykcHuIZ0kyQwee4iqkfzQg2OCSPRS/N6Gi9c9Tta
 xdz2XznJDvKu5g2iCjrt9EpCttTNdbYqFTlRxaQDd2D9/eaZjjsIgaYWGJAgXBvPTMuh
 tNWA==
X-Gm-Message-State: AOJu0YwNAcinRcZziWc7XkvLjOxEaiMzePZ3K+xkxuWaJjzcdUOiVq+W
 xc4HTrbsVbEQVX3GWIc2X1CfL1ujEizwYNW8lR7L+D8sEClcVgzLGCGNaUxqZQaH
X-Gm-Gg: AfdE7ck25C3f1C/bZrNDh2V/Q83FYwlvk7cCduMG665oCfYk4Eka6WLYyDWChpPDJrp
 buArNLwQPzyLon/tnqZTEKtX06AWs+jgU58hIvtNgvMuDWuOwuEzXajVjD/DfEFjgFNKhFffj0j
 jbM93zQxuJ05tNsEilg00Qnf/z4Qq0PxqbvzPhcFgxqP1Br4h9tSgavr3ZWbuhsRh187ByaDAeq
 58r86IqjM6EJiMgM+3zWicdAPYOJL4HYCKgev7U8OSxfs+Vy4Hwg7QwoGEVSjyEqoD0EXavRK4W
 TcT79H3O8Zi7/sf8o2d1JZt+1gEoHvMeun73SlDOiv/W12PKWTLgo+iZ7BOXoeflRqQndlkZ8Vd
 2wcTvUDmEzc+9vnd1Rsjh2nlZzDEEjdjIXiiH6reTVdnLlpIG/qNbiG5H72i28kqRNO1IgPGvzI
 oQuZYgb54/vqxS71RwuXYnL3J4nhpqGQPecO/kw0Jq9iiFcGAk/tvYcufqvRTf9zyKo3oRltCMP
 dMuoXsgkiAHY7etJbaSR6EnwyK19Q==
X-Received: by 2002:a05:6000:2013:b0:47e:4b03:4909 with SMTP id
 ffacd0b85a97d-47f4885709cmr9148097f8f.18.1784143389263; 
 Wed, 15 Jul 2026 12:23:09 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24CD7200F6BBA872344E1A32.dsl.pool.telekom.hu.
 [2001:4c4e:24cd:7200:f6bb:a872:344e:1a32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4829896asm16626589f8f.23.2026.07.15.12.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 12:23:08 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 07/11] drm/amdgpu/gfx6: Properly enable/disable priv_req
 and priv_inst interrupts
Date: Wed, 15 Jul 2026 21:23:07 +0200
Message-ID: <178429166.VBMTVartND@timur-max>
In-Reply-To: <d56d2eef-0bd1-4289-b315-8ecb7f5d01eb@ursulin.net>
References: <20260713130709.34262-1-timur.kristof@gmail.com>
 <5733138.E0xQCEvomI@timur-max>
 <d56d2eef-0bd1-4289-b315-8ecb7f5d01eb@ursulin.net>
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

On 2026. j=C3=BAlius 15., szerda 13:22:21 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> On 15/07/2026 11:53, Timur Krist=C3=B3f wrote:
> > On 2026. j=C3=BAlius 15., szerda 12:19:40 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Tvrtko
> > Ursulin
> >=20
> > wrote:
> >> On 13/07/2026 14:07, Timur Krist=C3=B3f wrote:
> >>> These were used without ever calling get()/put() on them.
> >>=20
> >>> Implement it like on GFX7-8:
> >> Used as in how? Are they even enabled without this change and if not
> >> then does this patch fixes something other than being prep work for so=
ft
> >> reset?
> >=20
> > If you open gfx_v6_0.c and search for priv_reg or priv_inst, you can see
> > that the interrupts are used in the same manner as gfx7 and newer, but
> > without get() and put().
>=20
> Yes, they are used in code. Are they used in reality was my question. :)

Looking at the code I think the original intention was to wire up these=20
interrupts. I think the hardware actually supports these interrupts and the=
=20
author of the code simply forgot to call get() and put().

If you are not convinced, maybe Alex or Christian can confirm whether the=20
interrupt actually exists on this HW generation. If it turns out it doesn't=
=20
exist then we should just delete this code.

> I ask because it appears that without amdgpu_irq_get() they may not even
> get enabled so never received. Yes or no? Consequences if yes?

Yes, that sounds correct. The consequence is that the interrupt will now be=
=20
enabled and the HW will tell us about some illegal register access and some=
=20
illegal instructions when it happens.

To give you additional context: for the purpose of diagnosing issues relate=
d=20
to GPU hangs and recovery, all additional information helps. If the CP has=
=20
interrupts to tell us about some error cases, we should absolutely use that.

Side note: from the register definitions it looks like the HW actually supp=
orts=20
other interrupts which would be interesting to enable in the future.
In this patch I just wanted to fix up the two that were already in the code.

>=20
> >>> * Call amdgpu_irq_get() from gfx_v6_0_late_init()
> >>> * Call amdgpu_irq_put() from gfx_v6_0_hw_fini()
> >>>=20
> >>> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >>> ---
> >>>=20
> >>>    drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 19 +++++++++++++++++++
> >>>    1 file changed, 19 insertions(+)
> >>>=20
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> >>> b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c index 5b570a4b5c01..1c7cd265f=
bca
> >>> 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> >>> @@ -3131,6 +3131,22 @@ static int gfx_v6_0_early_init(struct
> >>> amdgpu_ip_block *ip_block)>
> >>>=20
> >>>    	return 0;
> >>>   =20
> >>>    }
> >>>=20
> >>> +static int gfx_v6_0_late_init(struct amdgpu_ip_block *ip_block)
> >>> +{
> >>> +	struct amdgpu_device *adev =3D ip_block->adev;
> >>> +	int r;
> >>> +
> >>> +	r =3D amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> >>> +	if (r)
> >>> +		return r;
> >>> +
> >>> +	r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
> >>> +	if (r)
> >>> +		return r;
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>>=20
> >>>    static int gfx_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
> >>>    {
> >>>   =20
> >>>    	struct amdgpu_ring *ring;
> >>>=20
> >>> @@ -3243,6 +3259,8 @@ static int gfx_v6_0_hw_fini(struct amdgpu_ip_bl=
ock
> >>> *ip_block)>
> >>>=20
> >>>    {
> >>>   =20
> >>>    	struct amdgpu_device *adev =3D ip_block->adev;
> >>>=20
> >>> +	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> >>> +	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> >>>=20
> >>>    	gfx_v6_0_cp_enable(adev, false);
> >>>    	adev->gfx.rlc.funcs->stop(adev);
> >>>    	gfx_v6_0_fini_pg(adev);
> >>>=20
> >>> @@ -3532,6 +3550,7 @@ static void gfx_v6_0_emit_mem_sync(struct
> >>> amdgpu_ring *ring)>
> >>>=20
> >>>    static const struct amd_ip_funcs gfx_v6_0_ip_funcs =3D {
> >>>   =20
> >>>    	.name =3D "gfx_v6_0",
> >>>    	.early_init =3D gfx_v6_0_early_init,
> >>>=20
> >>> +	.late_init =3D gfx_v6_0_late_init,
> >>>=20
> >>>    	.sw_init =3D gfx_v6_0_sw_init,
> >>>    	.sw_fini =3D gfx_v6_0_sw_fini,
> >>>    	.hw_init =3D gfx_v6_0_hw_init,




