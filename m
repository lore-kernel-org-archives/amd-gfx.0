Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7837C44507
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 22:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680D889B12;
	Wed, 15 Jul 2026 22:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DV/6Eghb";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B6A389B12
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 22:54:43 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so3207067f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 15:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784156082; x=1784760882; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y3z8vYiAu3/kMtO9Nlf31Vcv+I6qtLezndmw3OEK+GE=;
 b=DV/6EghbwGyFwuuEk/dIk7nKB5yLcf69S0o+1BcT6hxWIK4kHkf/nFSJrrLo99S1Of
 OPfP4l0DrPu39byRL9AFiWNwhEi62/U/Dh7HHCNLX1qk7eIe+xHZ1D2BQcNKd+39FBn2
 zxyVrAidaUwJ1cG8q0c2ZxFhwZ0qqR/tEx9KLzKK8TuBOhShcU7KsO6qseeF4RjXirYl
 l1wxQErdT0jJIteMImF/GTiASjBc/9GuBBT+WjVoTCZHR/F3yq1EHMm7LOdvOTbyWB+v
 FmOGGebpGTuKjidroEQrxMoZg3N7AMJVUqFyZoJSKm339GPJi4xKCx8JvQSeHBp13x/F
 NRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784156082; x=1784760882;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y3z8vYiAu3/kMtO9Nlf31Vcv+I6qtLezndmw3OEK+GE=;
 b=M2//fhECPKLt7fE/MgkbGsTE871jdyFX+MpktuIdugXU8ccfUVR0opF8LJx1C0dAwZ
 y/ENpq8iIHh+90kOWfaKh2yEPy9VInexjF+plUbCbX//7h6kj1gBB6Wcs5V4kXOgUwYG
 mkjdqTUVBi8x5o2jNDehQWNU5oxYlWrtSVX/6Ze+WhOECYzyj4dCJKb9gTM0iLKH6yb1
 WhFy0U+xyA3/v3tExYTa+ocwkvK9cTaVjbis6UpakLWiUTV381Foy9AlX5FI6SR2zPGk
 99CQyZ8RBOCqi67bMtnb9FWeMwEetiavT26jZ8XZrmfA0PIu9dQvxHZZu/23IFzjK5Z8
 jQXw==
X-Gm-Message-State: AOJu0YxCt0EkhXjqP4lls0F4po4IZCWuIQu2+aChV1arajjNA0krW+qj
 IIj3YMfX6lKJCT0+Juv0RAqWniDIgE0Ebl5avD0fVRf6fS6/WP1cuY+w33n77f9e
X-Gm-Gg: AfdE7cnzfhLbT7KGqP61wOWCSRKO2gHMkDTfVJnjkIa00TlWVG9IOH7EWjkzabQq34F
 nEqEv0uowxeLt5XDz6tyEMWDvkaCmkwHO8CayS+8mf7xHNqEYCZZC2jHmQ/AgRzA7J3IWOdwRee
 vTcIZVHq5QpTMMJzuC455VECTlZY8hJTQhzX3P4vWxp1RbTHU5t44srZdvcxc5Y0i2QLDcACCvY
 OpFBudnc6PaTa0/lyn/YQ/Kn3+0VA/NBufQqJxqWSYOxIW/e83YlwbGfd9MUJhpW7cNPYWA5Mwf
 JsBjfskkgLiVskO8E/OoKOiZq8teM/vemKcy+Ct6j72WxdMo+KfMg3F398kwFSZOJAe48aCHr/k
 X1zJOhMmKYZirT8FIBhz7POaN/bJgWUwr9aUe4jIkMVffTX5vtP0Utu1sUKFR+JOHklMKm2xMo4
 4pzfW6pKKvPSb1Fqk+vRnYV/jrY0JwJg+RbAcU+3/9CNKqSJRY
X-Received: by 2002:a05:6000:4608:b0:47f:2a3a:1801 with SMTP id
 ffacd0b85a97d-47f4886f04fmr11570924f8f.12.1784156081525; 
 Wed, 15 Jul 2026 15:54:41 -0700 (PDT)
Received: from timur-hyperion.localnet (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a973fsm20860042f8f.17.2026.07.15.15.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 15:54:41 -0700 (PDT)
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
 "Yang, Philip" <Philip.Yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: Re: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on IH
 6.0
Date: Thu, 16 Jul 2026 00:54:39 +0200
Message-ID: <rlm5QnfMQUCvU4htjptxTw@gmail.com>
In-Reply-To: <51657a60-6f2b-484e-a0a6-f0bdd6e2eee7@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <BL3PR12MB6425480A86F7104104D58B0DEEF12@BL3PR12MB6425.namprd12.prod.outlook.com>
 <51657a60-6f2b-484e-a0a6-f0bdd6e2eee7@amd.com>
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

On Monday, July 6, 2026 11:27:50=E2=80=AFPM Central European Summer Time Mu=
kul Joshi=20
wrote:
> Hi Timur,
>=20
> For Navi3x, please make the similar change as I suggested for Navi4x to
> enable the doorbell path along with your
> existing changes and use doorbell to clear the CAM entries.
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> index f89e5f40e1a5..a66e3073aed8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
> @@ -199,7 +199,7 @@ static void nbio_v4_3_ih_doorbell_range(struct
> amdgpu_device *adev,
>                  ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range,
> S2A_DOORBELL_ENTRY_1_CTRL,
> S2A_DOORBELL_PORT1_RANGE_SIZE,
> -                                                 2);
> +                                                 8);
>                  ih_doorbell_range =3D REG_SET_FIELD(ih_doorbell_range,
>=20
> Please let us know how it goes.
>=20
> Thanks and regards,
>=20
> Mukul

Hi Mukul,

Sorry for the late reply.

I've now tested this on Navi 31 and with this change the doorbell works=20
correctly for the retry CAM. I will test the same on Navi 48 next week. If =
it=20
works well then I will drop the patches that use the MMIO register and I'm =
fine=20
using the doorbell.

Thanks & best regards,
Timur

>=20
> On 7/6/2026 2:04 PM, Joshi, Mukul wrote:
> > AMD General
> >=20
> >> -----Original Message-----
> >> From: Timur Krist=C3=B3f<timur.kristof@gmail.com>
> >> Sent: Friday, July 3, 2026 2:47 PM
> >> To:amd-gfx@lists.freedesktop.org; Deucher, Alexander
> >> <Alexander.Deucher@amd.com>; Koenig, Christian
> >> <Christian.Koenig@amd.com>; Natalie Vock<natalie.vock@gmx.de>; Shetaia,
> >> Amir<Amir.Shetaia@amd.com>; Marek Ol=C5=A1=C3=A1k<maraeo@gmail.com>;
> >> Limonciello, Mario<Mario.Limonciello@amd.com>; Tvrtko Ursulin
> >> <tursulin@ursulin.net>; Kuehling, Felix<Felix.Kuehling@amd.com>; Lazar,
> >> Lijo <Lijo.Lazar@amd.com>; He, Siwei<Siwei.He@amd.com>; Yang, Philip
> >> <Philip.Yang@amd.com>; Joshi, Mukul<Mukul.Joshi@amd.com>
> >> Subject: Re: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry
> >> CAM on IH 6.0
> >>=20
> >> On 2026. j=C3=BAlius 3., p=C3=A9ntek 19:46:03 k=C3=B6z=C3=A9p-eur=C3=
=B3pai ny=C3=A1ri id=C5=91 Joshi, Mukul
> >>=20
> >> wrote:
> >>> AMD General
> >>>=20
> >>>> -----Original Message-----
> >>>> From: Timur Krist=C3=B3f<timur.kristof@gmail.com>
> >>>> Sent: Wednesday, July 1, 2026 12:17 PM
> >>>> To:amd-gfx@lists.freedesktop.org; Deucher, Alexander
> >>>> <Alexander.Deucher@amd.com>; Koenig, Christian
> >>>> <Christian.Koenig@amd.com>; Natalie Vock<natalie.vock@gmx.de>;
> >>>> Shetaia, Amir<Amir.Shetaia@amd.com>; Marek Ol=C5=A1=C3=A1k
> >>>> <maraeo@gmail.com>; Limonciello, Mario<Mario.Limonciello@amd.com>;
> >>>> Tvrtko Ursulin<tursulin@ursulin.net>; Kuehling, Felix
> >>>> <Felix.Kuehling@amd.com>; Lazar, Lijo
> >>>=20
> >>> <Lijo.Lazar@amd.com>; He, Siwei<Siwei.He@amd.com>; Yang, Philip
> >>>=20
> >>>> <Philip.Yang@amd.com>; Joshi, Mukul<Mukul.Joshi@amd.com>
> >>>> Cc: Timur Krist=C3=B3f<timur.kristof@gmail.com>
> >>>> Subject: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM
> >>>> on IH
> >>>> 6.0
> >>>>=20
> >>>>=20
> >>>>=20
> >>>> The doorbell is not working on Navi 31.
> >>>> Use the IH_RETRY_CAM_ACK register.
> >>=20
> >> Hi Mukul,
> >>=20
> >>> I think the doorbell path is not enabled for IH CAM so that=E2=80=99s=
 probably
> >>> the reason its not working.
> >>> I think we need an update to the NBIO
> >>> ih_doorbell_range() function to enable the doorbell path.
> >=20
> > Hi Timur,
> >=20
> >> Can you please be more specific and elaborate on what we need to do on
> >> the
> >> NBIO
> >> ih_doorbell_range() function?
> >=20
> > Through NBIO, we route the doorbell to the correct HW block.
> > That is currently not enabled/done for the IH CAM doorbell.
> > So, you basically need to enable it inside ih_doorbell_range() function.
> >=20
> >> Also, can you say which NBIO version is used
> >> for for Navi 3 and Navi 4 GPUs?
> >=20
> > Navi3 --> NBIO v4.3 (nbio_v4_3.c)
> > Navi4 --> NBIO v6.3.1 (nbif_v6_3_1.c)
> >=20
> > I am working on the change that you need to enable the doorbell path for
> > Navi4x first. Once that is working, I can send you a test patch for
> > enabling it on Navi3x.
> >=20
> > Regards,
> > Mukul
> >=20
> >>> Having said that, we intend to use doorbells on all ASICs to ack IH
> >>> CAMs that support retry faults.
> >>=20
> >> I'm OK with that, if the doorbell really works on these GPUs.
> >>=20
> >> Thanks & best regards,
> >> Timur
> >>=20
> >>>> Signed-off-by: Timur Krist=C3=B3f<timur.kristof@gmail.com>
> >>>> ---
> >>>>=20
> >>>>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 8 +++++++-
> >>>>   1 file changed, 7 insertions(+), 1 deletion(-)
> >>>>=20
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> >>>> index 65e5d21753f9..a97c85b0cb99 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> >>>> @@ -307,6 +307,11 @@ static int ih_v6_0_enable_ring(struct
> >>>> amdgpu_device *adev,
> >>>>=20
> >>>>        return 0;
> >>>>  =20
> >>>>   }
> >>>>=20
> >>>> +static void ih_v6_0_retry_cam_ack(struct amdgpu_device *adev, u32
> >>>> +cam_index) {
> >>>> +     WREG32_SOC15(OSSSYS, 0, regIH_RETRY_CAM_ACK, cam_index); }
> >>>> +
> >>>>=20
> >>>>   /**
> >>>>  =20
> >>>>    * ih_v6_0_irq_init - init and enable the interrupt ring
> >>>>    *
> >>>>=20
> >>>> @@ -807,7 +812,8 @@ static const struct amdgpu_ih_funcs
> >>>> ih_v6_0_funcs =3D {
> >>>>=20
> >>>>        .get_wptr =3D ih_v6_0_get_wptr,
> >>>>        .decode_iv =3D amdgpu_ih_decode_iv_helper,
> >>>>        .decode_iv_ts =3D amdgpu_ih_decode_iv_ts_helper,
> >>>>=20
> >>>> -     .set_rptr =3D ih_v6_0_set_rptr
> >>>> +     .set_rptr =3D ih_v6_0_set_rptr,
> >>>> +     .retry_cam_ack =3D ih_v6_0_retry_cam_ack,
> >>>>=20
> >>>>   };
> >>>>  =20
> >>>>  =20
> >>>>  =20
> >>>>   static void ih_v6_0_set_interrupt_funcs(struct amdgpu_device *adev)
> >>>>=20
> >>>> --
> >>>> 2.54.0




