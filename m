Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF98DC44507
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 10:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7326910EC3D;
	Wed, 15 Jul 2026 10:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TSjMgCZP";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9307B10EC3D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 10:53:24 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493ec555a26so34049035e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 03:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784112803; x=1784717603; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fZB6OEmMIAVgJFmzQzzFpnxA33krr9gVl8n9S65vQLg=;
 b=TSjMgCZPUh7Iz1Y/P2P5E7xvHi2cYuYtGQykQAa5RClj7AuVZwg7LJYelAHzcThAQO
 dZicA4CQ3uJ/46Fz7Snr98nFr3JlaUoGmLMxn6Bk7s37B19BDqIyT9mvkTXZabk5629x
 W1oH9n2Uyc0YCkNAy6mLKHW+BCgZiXH2t4thLfBvkTqGOl2nIEGv/vzKc3eneHgEMxP+
 w9XwlC4dl5FLZeL3OTdJDpL2u+WulqvTL1QA1d4cN/MXyU4W8Dm5ElLX2h857Ji2XPKR
 T+QjelklJHjLrCUw/DLVxGI+rzgDRRnRgP0i3PyRVO9PGi+YSVVQXUh2yZ/GNRV+Q/Vm
 n6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784112803; x=1784717603;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fZB6OEmMIAVgJFmzQzzFpnxA33krr9gVl8n9S65vQLg=;
 b=HPXBF9qXYvy+bmpTwm32SBSRjCmYkQjzDSbJ1jHCn42CNYJ0miQQrN+oXJMhF9GPXD
 6AleuhHUHaaWKDRLvPerg48/z+6F4CuJmihTEzFKrD5JQD8pMlb30UwsgVaetGoYZqis
 +oPGJA/czyi4KJ5XN6NHPG6l4HkKNW6+nw5/ociEOCp2glpY3yOTMBcb4ztyjwbvcS4/
 jyGqSnw1dnwo8Pd21m61/2cJT7wqWGG4/Fl2UD38BRHQ8wuvWWKa5OXb38GKeyPsIN+P
 FVw8BgOgBU7lwvksiwZu/QzcpsBAzEOotNr6Ct/km4d8+q4ZDQkdldzteUuUkKMpYpyO
 QFig==
X-Gm-Message-State: AOJu0Yxj8xcpaYNzAg395SB5SxesGQMVeBWgxGSe9bnbMMVOVHlqph/0
 LKZEcj4iPRXP3sTrowQqtwb42tCiS1jAMwfoWa3cWuIR/f/1Jl7qBjDVinFXdg==
X-Gm-Gg: AfdE7clqs57xhf69aVdKhWqgXBPP3jH/3wliTh6j10zugzdyP7rYTw6QcihbnLMpGyh
 iiN3JU+obY/L9WgPTaTQNw9CpHycWdVo3yRXZcCGFMxAyENX6X07D3mkuDN6jsbW0N0y70rIfqf
 I/Pymjl9ofTnoqYvjHCWhu1fk7ZVy66xpmgJobx5dlQ4w3QqDNiFfUOPi76jXyeBIAqdcTDFwsn
 /WZ/ggszy6tZiE5jvuUxMO81YsZ2lmkMGy2BnWm5D7q2r8pg/VNRat606MXBRUiCSP7Szcv2/Bj
 e4VO+riAhSCYsejr+lX4gjCow7i2GvxJ6e9mrynA4wLSUGl5tQ8/PZVTYrVKJ/V0zQGTA5JkFxE
 BtpWA2elvsp6TjqAGbSo983HWR4zL7+4jZ57g/QbMWczwBv31rr/sKaEee62oPoyT15D0DMafLx
 SNqENFcvqVvmaXXRL030rP9jS0YgxEBszfr5fi18fn974go72n+prGKOf0cmnAABeS9zknoGFMA
 2SIKUoLptyi4Mmsj9I=
X-Received: by 2002:a7b:c5d9:0:b0:493:e57e:7aa5 with SMTP id
 5b1f17b1804b1-4953c27b35fmr19138965e9.22.1784112802917; 
 Wed, 15 Jul 2026 03:53:22 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24CD7200F6BBA872344E1A32.dsl.pool.telekom.hu.
 [2001:4c4e:24cd:7200:f6bb:a872:344e:1a32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a96fdsm15887893f8f.24.2026.07.15.03.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:53:22 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 07/11] drm/amdgpu/gfx6: Properly enable/disable priv_req
 and priv_inst interrupts
Date: Wed, 15 Jul 2026 12:53:21 +0200
Message-ID: <5733138.E0xQCEvomI@timur-max>
In-Reply-To: <12b8dbe8-579d-4b90-a3af-ec604710299c@ursulin.net>
References: <20260713130709.34262-1-timur.kristof@gmail.com>
 <20260713130709.34262-8-timur.kristof@gmail.com>
 <12b8dbe8-579d-4b90-a3af-ec604710299c@ursulin.net>
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

On 2026. j=C3=BAlius 15., szerda 12:19:40 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> On 13/07/2026 14:07, Timur Krist=C3=B3f wrote:
> > These were used without ever calling get()/put() on them.
>=20
> > Implement it like on GFX7-8:
> Used as in how? Are they even enabled without this change and if not
> then does this patch fixes something other than being prep work for soft
> reset?

If you open gfx_v6_0.c and search for priv_reg or priv_inst, you can see th=
at=20
the interrupts are used in the same manner as gfx7 and newer, but without=20
get() and put().

>=20
> > * Call amdgpu_irq_get() from gfx_v6_0_late_init()
> > * Call amdgpu_irq_put() from gfx_v6_0_hw_fini()
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 19 +++++++++++++++++++
> >   1 file changed, 19 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c index 5b570a4b5c01..1c7cd265fbca
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> > @@ -3131,6 +3131,22 @@ static int gfx_v6_0_early_init(struct
> > amdgpu_ip_block *ip_block)>=20
> >   	return 0;
> >  =20
> >   }
> >=20
> > +static int gfx_v6_0_late_init(struct amdgpu_ip_block *ip_block)
> > +{
> > +	struct amdgpu_device *adev =3D ip_block->adev;
> > +	int r;
> > +
> > +	r =3D amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> > +	if (r)
> > +		return r;
> > +
> > +	r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
> > +	if (r)
> > +		return r;
> > +
> > +	return 0;
> > +}
> > +
> >=20
> >   static int gfx_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
> >   {
> >  =20
> >   	struct amdgpu_ring *ring;
> >=20
> > @@ -3243,6 +3259,8 @@ static int gfx_v6_0_hw_fini(struct amdgpu_ip_block
> > *ip_block)>=20
> >   {
> >  =20
> >   	struct amdgpu_device *adev =3D ip_block->adev;
> >=20
> > +	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> > +	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> >=20
> >   	gfx_v6_0_cp_enable(adev, false);
> >   	adev->gfx.rlc.funcs->stop(adev);
> >   	gfx_v6_0_fini_pg(adev);
> >=20
> > @@ -3532,6 +3550,7 @@ static void gfx_v6_0_emit_mem_sync(struct
> > amdgpu_ring *ring)>=20
> >   static const struct amd_ip_funcs gfx_v6_0_ip_funcs =3D {
> >  =20
> >   	.name =3D "gfx_v6_0",
> >   	.early_init =3D gfx_v6_0_early_init,
> >=20
> > +	.late_init =3D gfx_v6_0_late_init,
> >=20
> >   	.sw_init =3D gfx_v6_0_sw_init,
> >   	.sw_fini =3D gfx_v6_0_sw_fini,
> >   	.hw_init =3D gfx_v6_0_hw_init,




