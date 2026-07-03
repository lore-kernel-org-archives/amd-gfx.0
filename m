Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7A4C43458
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 18:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE24110E66D;
	Fri,  3 Jul 2026 18:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qKVfmDd5";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB83110F8B3
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 18:46:36 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so18941605e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Jul 2026 11:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783104395; x=1783709195; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bKuhu6MyEQkcdujyNw+lEWFtLHpycBAyxP9BC09Q7K4=;
 b=qKVfmDd59yOYNnbluY7SJ/1RYPiJZtIjmlflW8KOtkf7kYi5ZsNBH6wG62KJOAjyaw
 y0xqXvT80Eh6D9TASkbJnQC6oXaBDAWHGdN0/r4mpxBxkdDzBCU4ZbpxYsRgLwYvR5ec
 au941Dz7zNh7dRczepAL0e+HzzCnjANuDqpyfeg7Qy7EC9LtHmWG0HuHb2peAZRNNE2A
 E7w5ULxEjTgYbPBAFsyoReNwcX4WyEEGMOHh5Fqq9RZ5wSfLD2t0dYyo9Zj1KAEe3hHH
 H4sJkNCG+lD8SoNQD5OT1/uxNlDQrdjdPGSZbajyFG+2wzI8QAlmBL0c1lOLmxPDEydA
 xpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783104395; x=1783709195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bKuhu6MyEQkcdujyNw+lEWFtLHpycBAyxP9BC09Q7K4=;
 b=LSz7m5YWPVvZiOT8uzgFmSPKMXG5CRkHV2uIGKBRK8zmiPnchC7KktPpwS/eVmzN9m
 tGSZKeIPGSC4U6EZd7zTkinehLcQr79374N+VkA9NsbmrSGi835yQZtrRtWE5qqMQ/zd
 s/24HdlwXhXLd6nNxHljYVcMQ9VEx8Y0VwlYQxpkFHZKzx1yIaB/Db9fIdhk3R8T+vVL
 0wKPu5CvGHU+ZaSb5tIDXy6NdLVALz9qCVApPlk0GB7l52BNQ17WhWz6hXp4vPRX5hbl
 FLyZ/al1quxApKobu2O9SX8yjllIaK2ebBgGjPk90IIL3yWdJB9A/79fKAX8GMivitTo
 tVJA==
X-Gm-Message-State: AOJu0Yzce2Z5x5PNZJ5rI3l/GnlKG/XZA/KKzLSTFPXm5RJsiM5ckO5f
 mpalivh+TF+k6+aVIXxl/STJmmjScOKSupO8/WEJZMuPHGAFMbKEHFHvAqJR6IHR
X-Gm-Gg: AfdE7ck6nXGQCwiCL8ltinwizMD/MYR2pdODeEvJlQAEKVVflynkBcSGLzcmnMri0TH
 BytO/dDwZqXJByMQQ7JLmwc+H304vv1KxsQQ8gNqSZ2z0UtyKakKYcN4OLUYHXskgaTsWdsiyfP
 lzAIoIU7Pjpmgsp5p6Vijbiic6GO0vmUYPEWAigZ6/ldN9txDrAAbHOdAXWwWd+TGa4fiGYR1FR
 dvddy+BOVxE7EO0t6Gjmosbi/1aW5kJ/J1ALtnbn/SRA3+EBjhTyoghu7K6pgx9//nU8XY4FwN4
 TgOtIEkrPX1w08C55YNbssA76MbZtsGlFbdy6DxboWD0TuzQ70IrAiet9xMetOY53+ZLcbjsD8X
 KkvXigA/7Gwzli4DJ2yHwWcZkkF/U6J7FF4+6U9ZxD/if+jn7FiWXKc91S/y7tJCqAHW7Qk5g6B
 WKvkZX/HtsUcn23SQvgMdLt5mLivOVUpKKvv6EIReUJcFlNBLuWbieik0SdHd0aM9jfcdhTHY8h
 8jNMjvB4VYOcDrrstI=
X-Received: by 2002:a05:600c:8a1a:10b0:493:d117:18a8 with SMTP id
 5b1f17b1804b1-493d149a38amr2054845e9.9.1783104394733; 
 Fri, 03 Jul 2026 11:46:34 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24D8E500AC9DAEE3E0CDFA47.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e500:ac9d:aee3:e0cd:fa47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdb62d3sm79376625e9.8.2026.07.03.11.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:46:34 -0700 (PDT)
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
Subject: Re: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on IH
 6.0
Date: Fri, 03 Jul 2026 20:46:33 +0200
Message-ID: <3281153.KVeVyVuyWN@timur-max>
In-Reply-To: <BL3PR12MB6425244AF10CABCDF2A131D3EEF42@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-12-timur.kristof@gmail.com>
 <BL3PR12MB6425244AF10CABCDF2A131D3EEF42@BL3PR12MB6425.namprd12.prod.outlook.com>
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

On 2026. j=C3=BAlius 3., p=C3=A9ntek 19:46:03 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Joshi, Mukul=20
wrote:
> AMD General
>=20
>=20
> > -----Original Message-----
> > From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Sent: Wednesday, July 1, 2026 12:17 PM
> > To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Natalie Vock <natalie.vock@gmx.de>; Shetaia,
> > Amir <Amir.Shetaia@amd.com>; Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>;
> > Limonciello, Mario <Mario.Limonciello@amd.com>; Tvrtko Ursulin
> > <tursulin@ursulin.net>; Kuehling, Felix <Felix.Kuehling@amd.com>; Lazar,
> > Lijo
> <Lijo.Lazar@amd.com>; He, Siwei <Siwei.He@amd.com>; Yang, Philip
> > <Philip.Yang@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> > Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Subject: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on =
IH
> > 6.0
> >
> >
> >
> > The doorbell is not working on Navi 31.
> > Use the IH_RETRY_CAM_ACK register.
>=20

Hi Mukul,

> I think the doorbell path is not enabled for IH CAM so that=E2=80=99s pro=
bably the
> reason its not working.
> I think we need an update to the NBIO
> ih_doorbell_range() function to enable the doorbell path.

Can you please be more specific and elaborate on what we need to do on the =
NBIO=20
ih_doorbell_range() function? Also, can you say which NBIO version is used =
for=20
for Navi 3 and Navi 4 GPUs?

> Having said that, we intend to use doorbells on all ASICs to ack IH CAMs
> that support retry faults.
=20
I'm OK with that, if the doorbell really works on these GPUs.

Thanks & best regards,
Timur

>=20
>=20
> >
> >
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> >
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> > b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> > index 65e5d21753f9..a97c85b0cb99 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> > @@ -307,6 +307,11 @@ static int ih_v6_0_enable_ring(struct amdgpu_device
> > *adev,
> >=20
> >       return 0;
> > =20
> >  }
> >
> >
> >
> > +static void ih_v6_0_retry_cam_ack(struct amdgpu_device *adev, u32
> > +cam_index) {
> > +     WREG32_SOC15(OSSSYS, 0, regIH_RETRY_CAM_ACK, cam_index); }
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
> >       .get_wptr =3D ih_v6_0_get_wptr,
> >       .decode_iv =3D amdgpu_ih_decode_iv_helper,
> >       .decode_iv_ts =3D amdgpu_ih_decode_iv_ts_helper,
> >=20
> > -     .set_rptr =3D ih_v6_0_set_rptr
> > +     .set_rptr =3D ih_v6_0_set_rptr,
> > +     .retry_cam_ack =3D ih_v6_0_retry_cam_ack,
> >=20
> >  };
> >
> >
> >
> >  static void ih_v6_0_set_interrupt_funcs(struct amdgpu_device *adev)
> >=20
> > --
> > 2.54.0
>=20
>=20




