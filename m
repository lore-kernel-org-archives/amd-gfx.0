Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64775CD98C5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 15:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9FE610E4DA;
	Mon, 15 Jun 2026 15:02:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X6KLLahO";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B8A510E4DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 15:02:10 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-68bfcf11050so5942810a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 08:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781535729; x=1782140529; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gexB/386wNDCFhwP6BNAVmmMY/GHNLBKqofK7TDNJ8s=;
 b=X6KLLahO0P+izebtA3VZehzRGaA6eawhTk/cn6fsmdKm/XLpC0WBrTnzs+vhZ6CXKN
 TymPBqwHMK6jBiYxqN6zAVjFjzO+d7+zoNeywPggACFXYcpCndguR6a55CF/XTJQHjZY
 MubCmkXRdGo1zQekgQquKqp3qgMUQtRXvTm8U6ms/pX4pKfWDypIdv8F8LgfMOHk+K3r
 CjBWcLiFITp+NNPfqyaNI72z1anpOURFkc4a9RoierudeoOo+jR0+LSsx0wh2fZjxb0Z
 SPDcy506zxIJqHNrnKpXBcwEjIKeSa+w2rExYrb6BnIkpHIMgfAsvF8u11UYCRpBQknI
 J0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781535729; x=1782140529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gexB/386wNDCFhwP6BNAVmmMY/GHNLBKqofK7TDNJ8s=;
 b=Y3F1UAqoc3GysLNxqSjPQY6+SKKmBxj8Shnh1pml4iYxxDoM8xmMGphQLKXz8W0i47
 8Ea3FcgGae8qLdAnXhmDuQZ2sNHol5ATS3tnYI6/YDlwpRtJDpNJKM2NXUqWwtZU2HSa
 vJkJkY/R8YtP/NaCttCxsEZdU+XI1KCspC7vdVd+GvDdi6NXtXoLVV+Zsdkgcm/g2y6z
 GPbA3IiDUAP6mJ1x9aa/L5HK6IPW4UwTTRrbmhSRajISYpj0d29Q46Wx9txd3vlqN3N5
 5fBcvbEM5vPnS7uI86RusKttZ7xBRDEzUKri70PZyepb1COKDJhKwhIWsbp/aviiIq3e
 NQcg==
X-Gm-Message-State: AOJu0YwWBvs0rFg+YjrG/KpQizxTkMSRC+OB9b9Q52PBwIwQdtjh0bYO
 nJRo9yHxsPc+0qP4AdoSan+w0qfNZmxcTp2+LAJPsMUg8GUSdszi4wHTvidTtw==
X-Gm-Gg: Acq92OFQRqor1JrY6GT3/G9FS0HRPmTDe0a80+OKqEjbuL2NZcO9CNrzy3LrqfqqOce
 1hut1Q36psc1jsk0gFQXQD6/PmnPTru9+3U1L/zHq4svtlrtBqZhuud+IFDo9IPzCM4axlqd7Bp
 KeJtJSqVtHu5i9nRzpxMRcm2dimprZMFE2qh/Ie92v0Yed9Oo5cT5Ny8egbKj6CbLia32/7gEjh
 W66ydxX5G7dX3541kY+vyrGfIHiuQR9RoD74QC4Kp/fvMY9ldOnnyp19yfJU0EoKDP2tItPqEc4
 RnImlmn0Z9JAvqTtx80VOzwxeUepdME6GrdUHV1WXXJRnn2cxVvxC7ucToPae/J25FPQfGD8Gw1
 l4QPeZYPzZ7LtvsqDcf8xAAINI5naZgk18A/yXKrFHBSS5CZ3eMXDIDWY3FPs7PVZ5EPD2QZeTl
 UbEE1TJjj19yKlm3YKSAgRmrLKvoHAAhutLkbT8Z/J7igWeP1vTHd+kCwllmecLN3R3QwcAwQ8s
 JCu5mPp
X-Received: by 2002:a05:6402:3202:b0:691:703d:2279 with SMTP id
 4fb4d7f45d1cf-69378176d27mr7273154a12.24.1781535728386; 
 Mon, 15 Jun 2026 08:02:08 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6937948fc99sm3841078a12.23.2026.06.15.08.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 08:02:07 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 4/7] drm/amdgpu/ih: Add retry_cam_ack IH function pointer
Date: Mon, 15 Jun 2026 17:02:06 +0200
Message-ID: <3701855.dWV9SEqChM@timur-hyperion>
In-Reply-To: <828817bb-8d69-429f-b206-7c9858eeca72@ursulin.net>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
 <20260525114507.24566-5-timur.kristof@gmail.com>
 <828817bb-8d69-429f-b206-7c9858eeca72@ursulin.net>
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

On Monday, June 15, 2026 4:44:22=E2=80=AFPM Central European Summer Time Tv=
rtko=20
Ursulin wrote:
> On 25/05/2026 12:45, Timur Krist=C3=B3f wrote:
> > Instead of writing the doorbell in amdgpu_gmc_handle_retry_fault()
> > directly, add an IH function pointer which can be defined in
> > a different way for different IH versions.
> >=20
> > This is to allow implementing the filter CAM without a doorbell.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 1 +
> >   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c    | 6 ++++++
> >   drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 8 +++++++-
> >   4 files changed, 15 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
> > 52258f1341c2..d790b7619ccd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -565,7 +565,7 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_dev=
ice
> > *adev,>=20
> >   		ret =3D amdgpu_vm_handle_fault(adev, entry->pasid,=20
entry->vmid, node_id,
> >   	=09
> >   					     addr, entry-
>timestamp, write_fault);
> >=20
> > -		WDOORBELL32(adev->irq.retry_cam_doorbell_index,=20
cam_index);
> > +		adev->irq.ih_funcs->retry_cam_ack(adev, cam_index);
>=20
> How does not map which IP generations can end up calling it? Presumably
> your selection of ih_v7_0 and vega20_ih.c is an insightful one, but for
> me I see amdgpu_gmc_handle_retry_fault() is called from
> gmc_v9_0_process_interrupt, gmc_v10_0_process_interrupt,
> gmc_v11_0_process_interrupt and gmc_v12_0_process_interrupt(). Is there
> a map somewhere which shows which GMC versions go with which IH blocks?

The hardware writes interrupt data into a so-called IH ring (interrupt hand=
ler=20
ring):
=2D Old GPUs only have one IH ring
=2D Newer dedicated GPUs have two IH rings
=2D APUs only have one IH ring
=2D Additionally there is a soft IH ring, which is implemented entirely in =
the=20
driver and is used to make the processing more reliable.

Specifically for retry faults, it is beneficial to configure page fault=20
interrupts on the second IH ring (when available) to avoid them competing w=
ith=20
other interrupts for space in the ring. In the upstream code this is only d=
one=20
on Vega dGPUs. My series implements that for GFX11 and a subsequent series=
=20
also for GFX12 dGPUs.

To answer your actual question, it all depends on the IH IP block for any=20
given generation. For some GPUs (but not all), the IH code configures the=20
hardware to use the second IH ring for page fault interrupts. For everythin=
g=20
else, the first IH ring is used. On GFX12 it seems the interrupts are handl=
ed=20
on the first IH ring even though the second ring is configured; it's unclea=
r if=20
that's a bug or missing code in the kernel.

Hope this helps,
Timur




>=20
> >   		if (ret)
> >   	=09
> >   			return 1;
> >   =09
> >   	} else {
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h index 444437c30088..e6e34f6e86=
f4
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> > @@ -97,6 +97,7 @@ struct amdgpu_ih_funcs {
> >=20
> >   	const char *(*node_id_to_die_name)(struct amdgpu_device *adev,
> >   =09
> >   					   unsigned int=20
node_id,
> >   					   char *buf, size_t=20
size);
> >=20
> > +	void (*retry_cam_ack)(struct amdgpu_device *adev, u32 cam_index);
> >=20
> >   };
> >  =20
> >   #define amdgpu_ih_get_wptr(adev, ih)
> >   (adev)->irq.ih_funcs->get_wptr((adev), (ih))>=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> > b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c index 6de9e87e04e1..c2431f4c2671
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> > @@ -289,6 +289,11 @@ static uint32_t ih_v7_0_setup_retry_doorbell(u32
> > doorbell_index)>=20
> >   	return val;
> >  =20
> >   }
> >=20
> > +static void ih_v7_0_retry_cam_ack(struct amdgpu_device *adev, u32
> > cam_index) +{
> > +	WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
> > +}
> > +
> >=20
> >   #define regIH_RING1_CLIENT_CFG_INDEX_V7_1             0x122
> >   #define regIH_RING1_CLIENT_CFG_INDEX_V7_1_BASE_IDX    0
> >   #define regIH_RING1_CLIENT_CFG_DATA_V7_1              0x123
> >=20
> > @@ -858,6 +863,7 @@ static const struct amdgpu_ih_funcs ih_v7_0_funcs =
=3D {
> >=20
> >   	.decode_iv_ts =3D amdgpu_ih_decode_iv_ts_helper,
> >   	.set_rptr =3D ih_v7_0_set_rptr,
> >   	.node_id_to_die_name =3D ih_v7_0_node_id_to_die_name,
> >=20
> > +	.retry_cam_ack =3D ih_v7_0_retry_cam_ack,
> >=20
> >   };
> >  =20
> >   static void ih_v7_0_set_interrupt_funcs(struct amdgpu_device *adev)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> > b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c index 85846fd08ce4..30a82fff3f=
f7
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> > @@ -293,6 +293,11 @@ static uint32_t vega20_setup_retry_doorbell(u32
> > doorbell_index)>=20
> >   	return val;
> >  =20
> >   }
> >=20
> > +static void vega20_retry_cam_ack(struct amdgpu_device *adev, u32
> > cam_index) +{
> > +	WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
> > +}
> > +
> >=20
> >   /**
> >  =20
> >    * vega20_ih_irq_init - init and enable the interrupt ring
> >    *
> >=20
> > @@ -738,7 +743,8 @@ static const struct amdgpu_ih_funcs vega20_ih_funcs=
 =3D
> > {
> >=20
> >   	.get_wptr =3D vega20_ih_get_wptr,
> >   	.decode_iv =3D amdgpu_ih_decode_iv_helper,
> >   	.decode_iv_ts =3D amdgpu_ih_decode_iv_ts_helper,
> >=20
> > -	.set_rptr =3D vega20_ih_set_rptr
> > +	.set_rptr =3D vega20_ih_set_rptr,
> > +	.retry_cam_ack =3D vega20_retry_cam_ack,
> >=20
> >   };
> >  =20
> >   static void vega20_ih_set_interrupt_funcs(struct amdgpu_device *adev)




