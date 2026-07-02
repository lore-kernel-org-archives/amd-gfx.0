Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40483C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 11:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C372710E4AA;
	Thu,  2 Jul 2026 11:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GZCQLuDm";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37DF510E4AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 11:52:12 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-461edb387ddso1620710f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jul 2026 04:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782993130; x=1783597930; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fcOdzUMYycvpjMN9JW0mbn3wsyAtYM+j1SiK+GfZmzo=;
 b=GZCQLuDm8x3fBtyV8O43Duik/THIMdJwgY5ZCtRClIEnR2GEeAmx2PJdy3+VwEv7tK
 Jk5BzBVbn0yRs3M1RXtGqH6CO9BjzGohULAbIerTtTekiWh17Lfyg6CG/aHphkU0vziV
 KPw3M8S68uh5WSnyKD08bctIbAXj93B3TLr2Tqx+o8YFmTgRHkUYynm1VnkyizOcx2an
 hv/gDLtTaoRMT14m1Rl5LeUdaXXFpwoxbh6BNHKBjQqSjqwKnm9os2ZDtGv30reKS2km
 UV9qAe7ctbnqeUHebAzbCKyh4uNVCH+UktGUtiUVy1LQ/EIEV6RbTt5hQhYIIgJt/X+p
 tRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782993130; x=1783597930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fcOdzUMYycvpjMN9JW0mbn3wsyAtYM+j1SiK+GfZmzo=;
 b=TBGDgUsRdw7PzC3sT3C4wpPsZ77+L9JVUHNKigsR7BewmqC3DxcZVgtlgV03EMeVgT
 xnrS+XTpEsk9BZnZQkhBn+EaK7aF0GhpQ9d/039nwkVEYkNbonCB96e5Ndu95lpMJqtC
 qyG7SJurwSdI1d6iFeRejH9GdUgRL8jM7jOYeGrlB1imPnMLbdKrAIrGLYC/aKs5SWrP
 Dakpjh1SqcacpAmeGLXlXIvkUI5wTd7smWQzzBLjpfVV542Q09vFaKN61RKtHcT/cKxj
 05M1KzpDB8G1eehGMLJ6hZwIWxd2mZ5nUzlfHe+E0B+YA7mVnfKS9Edxq5VkcCxKzlW4
 pqaQ==
X-Gm-Message-State: AOJu0Yyp9+VoTCTKLxbkJjRU9f8PByytFKr9HCMxlSRaluQhjrNGoAIq
 YfIEuaZpnSllC6fUFZf5FGy2kJIVx6b4fHB6qHKTkF2gZYJ8lEFZRpMHSjNRUILX
X-Gm-Gg: AfdE7ck984sn0AquvVBxYG60nQI7NQwq/UQpsR8tdxded8/MBX7KjnsThbK2/M36Z6X
 g8N7CH+A64D/HbNNNBJ2lCaZRE1g4DYcNgQgcMmfNC6WIsHz++iQA9C1e5IfemtoBlm/45c1pnL
 G+hFQq8TvnMagpzuz8G7Krv+1KZYPR3XAe+gfsMVxm2zvHzGC58VXjy4mwb+rztDmInsDKBBwDn
 oVJZ/tnxCVB42t00A1bkfUj06LMOqxhuBL59ZZIG3Pi09Z3xoLNnlN929LfciK420JooDjmFK7c
 uIflcloYSWHxBbzzeNGA1/DdM0o9SXIf5QXQwYuazEdLQXgaLU5BOlHVfF8VJx9RNGreyjnhE3H
 eoMOwfgGTXYblf+yBA+ikDC6C+DVAH+kN3i0E5QC8XgK52P9glckqPADYwJRq+KlYfFp/8PuxfI
 j2rh1e3odEPXEJ4eRgKDWwxEkymZnLj3X5+mKwOyg0twGxYEiKIdZj8dCcoNHHCeYEqhJgf/AhQ
 GifKfcJfZzGeKlBqwceDl7LhbWH
X-Received: by 2002:a5d:474a:0:b0:475:f0d1:eb62 with SMTP id
 ffacd0b85a97d-477b225850emr5514595f8f.61.1782993130424; 
 Thu, 02 Jul 2026 04:52:10 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EF0F0080162CDB5B2DFACF.dsl.pool.telekom.hu.
 [2001:4c4e:24ef:f00:8016:2cdb:5b2d:facf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dbe617b1sm8295835f8f.16.2026.07.02.04.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 04:52:10 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on IH
 6.0
Date: Thu, 02 Jul 2026 13:52:08 +0200
Message-ID: <2030676.7Z3S40VBb9@timur-max>
In-Reply-To: <4547ddd3-974a-4c9c-8fec-939dc132f7d0@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-12-timur.kristof@gmail.com>
 <4547ddd3-974a-4c9c-8fec-939dc132f7d0@amd.com>
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

On 2026. j=C3=BAlius 2., cs=C3=BCt=C3=B6rt=C3=B6k 12:23:42 k=C3=B6z=C3=A9p-=
eur=C3=B3pai ny=C3=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> On 7/1/26 18:17, Timur Krist=C3=B3f wrote:
> > The doorbell is not working on Navi 31.
> > Use the IH_RETRY_CAM_ACK register.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>=20
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>=20
> I still haven't found any explanation why we use a doorbell for the CAM in
> the first place? Lijo, Alex, Felix does anybody know that?

The first mention of the retry CAM in the kernel is:
commit 318e431b306e - drm/amdgpu: Enable IH retry CAM on GFX9
which was written by Mukul (also on CC for this series).
Mukul - can you please give us some information on that?

It seems that the IH 7.1 code was just copied from there.

As far as I see, Vega 20 already has the mmIH_RETRY_CAM_ACK register, thoug=
h I=20
don't know why that wasn't used. I guess you guys would have heard from you=
r=20
datacenter customers if the current code didn't work on Vega 20 and CDNA.
I can say with certainty that I couldn't get the doorbell working on Navi 3=
1=20
or Navi 48.

Unfortunately I don't have a Vega 20 card (or any datacenter GPU) so I can'=
t=20
test what actually works there. I have a Vega 10, but it's unclear if that =
has=20
a retry CAM or not.

Thanks & best regards,
Timur

>=20
> > ---
> >=20
> >  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> > b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c index 65e5d21753f9..a97c85b0cb99
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> > @@ -307,6 +307,11 @@ static int ih_v6_0_enable_ring(struct amdgpu_device
> > *adev,>=20
> >  	return 0;
> > =20
> >  }
> >=20
> > +static void ih_v6_0_retry_cam_ack(struct amdgpu_device *adev, u32
> > cam_index) +{
> > +	WREG32_SOC15(OSSSYS, 0, regIH_RETRY_CAM_ACK, cam_index);
> > +}
> > +
> >=20
> >  /**
> > =20
> >   * ih_v6_0_irq_init - init and enable the interrupt ring
> >   *
> >=20
> > @@ -807,7 +812,8 @@ static const struct amdgpu_ih_funcs ih_v6_0_funcs =
=3D {
> >=20
> >  	.get_wptr =3D ih_v6_0_get_wptr,
> >  	.decode_iv =3D amdgpu_ih_decode_iv_helper,
> >  	.decode_iv_ts =3D amdgpu_ih_decode_iv_ts_helper,
> >=20
> > -	.set_rptr =3D ih_v6_0_set_rptr
> > +	.set_rptr =3D ih_v6_0_set_rptr,
> > +	.retry_cam_ack =3D ih_v6_0_retry_cam_ack,
> >=20
> >  };
> > =20
> >  static void ih_v6_0_set_interrupt_funcs(struct amdgpu_device *adev)




