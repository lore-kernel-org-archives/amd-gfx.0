Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C67DC43458
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 18:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E49A10E661;
	Fri,  3 Jul 2026 18:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ra2ZT+P2";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE4F610E661
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 18:41:30 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493be1b9564so6240685e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Jul 2026 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783104089; x=1783708889; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m7YfBXOv51ZVzjlUCxN6xEUe8VxlUD8aw2i057xsye0=;
 b=Ra2ZT+P2G5MwtB8uUQUEsVq3j1Cm+wSiAKkjYIHw1OLoPqfAKHGkYdlZljA9g+tt18
 ip8mkQYNjM5tm/n26EihqlTigQrvUOpMjUU0QQKWFDwVDDuH/yyI4DGNRK4CIEHybzSw
 RurNHyHR9H1/BSdiIwsChffogJOo1TY1p8EP/OVVxlRmprxfDVlL5dkv3xLtzvsTs7rq
 7Wl35uZfyJ8V/WI2jJEObcsw3Ed6UUQJj3aDof5/w4KSr/D79T9XM6LRQIc10Ig1L0n4
 PxpT7mL4FuAIVXn3mxGKwj/IfCpQ4qjo8KBdAdQCmZDnrDymkMHBNmmXXzbKVp+c7VB/
 Ujeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783104089; x=1783708889;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m7YfBXOv51ZVzjlUCxN6xEUe8VxlUD8aw2i057xsye0=;
 b=D63Ok6OHadpcShGD+wSONXYUYS+45C5fYJQKOYk1tw4D5NjkOgoYMXYLP6tfgg3v5m
 OhquwdEa0vg+DRP6y1ipNAIKD1lkakvWZelxYbpE6Ruj+BRbQacU9LJzMQ2LEfJzstnu
 lUIyEP1L7OUs8U0G3iMrVaCVImVhEItgpUyoNzQItOV6KDSuAFom08fo8utX/sATu6LJ
 et5rfuy/V/Ro/EnlZP+AWe9SuCCunVAlwdy7YtqJRCCg4k4Via+c/LNSbJGka1aOTEF8
 GJAVe1BLz6b2++J0K2Bq4rsKYSiisWGnuXkxBWowuwZ17oHNQ3NioO0WtQYKl2IECYiw
 53xw==
X-Gm-Message-State: AOJu0YwbFyT2MRnSaIRVqrqr5CU6w0nU1NY4WVgW8dTUYPTf8hz0EFl6
 lYWvBKVN6OOyfmGAKBd6gl8p9mTM6xoLgcZ51I5XO0rYRb/BmAZmtB4ACKw3sbPv
X-Gm-Gg: AfdE7ckmIoWOxZvnWTWaNnqi8xgfUZegLXyicFaDd3NsgUY3A7NeXNZ3jVqN/pqe+uH
 A03V9G01cadkJxdzB6Ymr/YqwDeANVf5qgGMx6UL92Y7nG2a3BJNNZvR3f7fVS+WLqdwdlAvijj
 VfgCijh91Yvj837hmBFAnAp6bj+TYnSHX2ML9Sej64trm4Byf2yNIs3vkV5u5NHODCtLRLCPq4a
 JddIqr3EyVdkhmc4r4aSlIopfjYL1n9Ha3EY5wywWpPypWFpUGvH2dt8Kj2I6hAymaJv2lmSEnk
 wrGjV6+mR1Z8XKKG2P2cQ2qN83BF+QV70lH3ysV/zrh7vhO6hI1NCqYuwDqUZTcMmQG4GIHHCTE
 64EyyGmEYpJ96UA8dKms639rcIqh3h4Upni5B5tB7msOk38Q7lnzzzEQTU87U3BvfaiBtxdDAfd
 oHMKHMQcP6bSP5HCBZQ1BApPF8e+V5v90T9ncHag8ls2EahikjvkhvlPre6yyJNuE7MIN0sjTgZ
 0R2lhnTV2AK5RkYybc=
X-Received: by 2002:a05:600c:3491:b0:493:b8dd:9d68 with SMTP id
 5b1f17b1804b1-493d11d7b19mr4885675e9.10.1783104088894; 
 Fri, 03 Jul 2026 11:41:28 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24D8E500AC9DAEE3E0CDFA47.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e500:ac9d:aee3:e0cd:fa47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f21543sm1168789f8f.35.2026.07.03.11.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:41:28 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, "Shetaia, Amir" <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "He, Siwei" <Siwei.He@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: Re: [PATCH 12/14] drm/amdgpu/ih7.0: Use MMIO ACK instead of doorbell
 for retry CAM on IH 7.0
Date: Fri, 03 Jul 2026 20:41:27 +0200
Message-ID: <5742390.E0xQCEvomI@timur-max>
In-Reply-To: <BL3PR12MB64256E6E84188CD2CCAB6C09EEF42@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-13-timur.kristof@gmail.com>
 <BL3PR12MB64256E6E84188CD2CCAB6C09EEF42@BL3PR12MB6425.namprd12.prod.outlook.com>
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

On 2026. j=C3=BAlius 3., p=C3=A9ntek 18:31:12 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Joshi, Mukul=20
wrote:
> AMD General
>=20
>=20
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Timur
> > Krist=C3=B3f
> > Sent: Wednesday, July 1, 2026 12:17 PM
> > To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Natalie Vock <natalie.vock@gmx.de>; Shetaia,
> > Amir <Amir.Shetaia@amd.com>; Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>;
> > Limonciello, Mario <Mario.Limonciello@amd.com>; Tvrtko Ursulin
> > <tursulin@ursulin.net>; Kuehling, Felix <Felix.Kuehling@amd.com>; Lazar,
> > Lijo
 <Lijo.Lazar@amd.com>; He, Siwei <Siwei.He@amd.com>; Yang, Philip
> > <Philip.Yang@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> > Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Subject: [PATCH 12/14] drm/amdgpu/ih7.0: Use MMIO ACK instead of
> > doorbell for retry CAM on IH 7.0
> >
> >
> >
> > The doorbell is not working on Navi 48.
> > Use the IH_RETRY_CAM_ACK register just like on Navi 3x.
> >
> >
> >
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >  drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 17 +----------------
> >  1 file changed, 1 insertion(+), 16 deletions(-)
> >
> >
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> > b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> > index f1de6450a31d..291326d2ee8b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> > @@ -279,19 +279,9 @@ static int ih_v7_0_enable_ring(struct amdgpu_device
> > *adev,
> >=20
> >       return 0;
> > =20
> >  }
> >
> >
> >
> > -static uint32_t ih_v7_0_setup_retry_doorbell(u32 doorbell_index) -{
> > -     u32 val =3D 0;
> > -
> > -     val =3D REG_SET_FIELD(val, IH_DOORBELL_RPTR, OFFSET,
> > doorbell_index);
> > -     val =3D REG_SET_FIELD(val, IH_DOORBELL_RPTR, ENABLE, 1);
> > -
> > -     return val;
> > -}
> > -
> >=20
> >  static void ih_v7_0_retry_cam_ack(struct amdgpu_device *adev, u32
> >=20
> > cam_index)  {
> > -     WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
> > +     WREG32_SOC15(OSSSYS, 0, regIH_RETRY_CAM_ACK, cam_index);
> >=20
> >  }
> >
> >
> >
> >  #define regIH_RING1_CLIENT_CFG_INDEX_V7_1             0x122
> >=20
> > @@ -401,11 +391,6 @@ static int ih_v7_0_irq_init(struct amdgpu_device
> > *adev)
> >=20
> >       pci_set_master(adev->pdev);
> >
> >
> >
> >       if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(7, =
1, 0))
> >=20
> > {
>=20
>=20
> We are re-purposing the IH 7.0 file for IH v7.1 since most of it is same.
> The code being removed below is for IH 7.1 and not 7.0.
> Using doorbells for acking INT CAM works completely fine for GFX 12.1 and=
 IH
> 7.1.
> I would recommend to drop this patch.
>=20

Hello Mukul,

Unfortunately I couldn't figure out how to get the doorbell working on Navi=
 48=20
and in the previous thread Amir said that it also didn't work for him, and=
=20
that's why I decided to try the MMIO register.

If you have an idea how to get the doorbell to work on Navi 48, I'm happy t=
o=20
try your suggestion.

Ideally I'd prefer a solution here that works on both Navi 48 and GFX12.1 t=
o=20
keep the code maintainable. If it's not possible then we can also have a=20
slightly different code path for the two different IH versions here.

Thanks & best regards,
Timur

>=20
>=20
> > -             /* Allocate the doorbell for IH Retry CAM */
> > -             adev->irq.retry_cam_doorbell_index =3D (adev-
> >=20
> > >doorbell_index.ih + 2) << 1;
> >=20
> > -             WREG32_SOC15(OSSSYS, 0, regIH_DOORBELL_RETRY_CAM,
> > -                             ih_v7_0_setup_retry_doorbell(adev-
> >=20
> > >irq.retry_cam_doorbell_index));
> >=20
> > -
> >=20
> >               /* Enable IH Retry CAM */
> >               tmp =3D RREG32_SOC15(OSSSYS, 0,
> >=20
> > regIH_RETRY_INT_CAM_CNTL);
> >=20
> >               tmp =3D REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL,
> >=20
> > ENABLE, 1);
> > --
> > 2.54.0
>=20
>=20




