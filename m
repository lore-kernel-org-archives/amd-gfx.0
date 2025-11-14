Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BDFCE7AA8
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 10:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2131410EA33;
	Fri, 14 Nov 2025 10:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y6Q7Me51";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B60FF10EA33
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 10:47:28 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4711810948aso12467785e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 02:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763117247; x=1763722047; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7fiyCvhEpO4OH5/Qa7F1MFmUPEwyBn/BiZmawVTUVI=;
 b=Y6Q7Me51MuY+3CGF1x/uZvPTaHTO1i3vjs1y8NuuEIE9BDgGBCXj7oEdi2o4rQi3na
 8Q0xB0zAL5RI3QsYn2MflxDD2GZi370UKkw22VfGefMwUrvajhXtLOVsFVF824Wv0Y5m
 0zqT2PvDFFodu4fPjMueqGeGyGzcnOxAMebfPsg6boQX4UX2LrBmMcBUraLTDkoeGxHH
 Pz+C1cyN0f7ebbHNn/vUFWCk8BA91d7H7X4rmL1xvTuWoAJu5GgJB+wA0TX81sUx5llg
 XMV319FWh9Hkvm4a4cEOK/+tmz61ZMnizQvpYOiIwsjav0UAtDilWVmcVF6MBMTss3Te
 CRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763117247; x=1763722047;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p7fiyCvhEpO4OH5/Qa7F1MFmUPEwyBn/BiZmawVTUVI=;
 b=ArRrRTWDqhmK4rmhALN4LlLpVIOPQ1SYYCQiO2n9k6HzbxnQZOi3OgvAdKleo/b0Rf
 zpLK8OKTd/jmFR+sqtn0PQ0F34DkF2hNjflCiFZ5S9fMVo+zQm5elLGk+vnT2poVKuw2
 E/tT/OnZyMnYWhEx0aL1j/52PB59lXtBXXMJrqjs0tvLf7zG7ToU0T08wswzFu1tu62j
 ySVXqeP6TZns2SYtHR5P6CI7ITKn1ZVyCismD/UdIJda1oc/qTsrFd7hEUGykmkZLfod
 baCM+u24tHxnboR84KPECamYlPOVOhWHjJsE3X0DQButnNjgdhWXjFq/u/yF2f6t7E4V
 /vqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXb0ltiP2AIz4FKvFPFjFh2o1RykWOVP2wWd9EDwhWdWgXNl070wcDZvHB4XBMUWhxwusolrkd@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5eE8AXM0eFXDyukmn/5WvFfDffoFbB5537dpFllRAifVuhYmH
 3Gtbn/3WZjCqMP76dBX/JogX36CB82ejlMTuKcRt16jH6xLUQpkScocE
X-Gm-Gg: ASbGncuQ1T7XvBBptAm+03GmQgU1LNufRKXUMFFatpk6QpwvZwlMXJPtwmhOKbG8l4i
 mswUJLSY6941ilTS+J0a2ol0MxhU0z4D7e43sO/e4YkkQ2VQzdGjtlRXO8yjnb7OmUuYJqGPp2j
 oqyajGsQZR3dJBnFIsFtAFpYBuSoipAd99W/jzI9GLmcCTYaQks9jiA85AnbRVwWs+8wxaVTjJ/
 zbUTWD0Dtlmw1kZpJNFOunnYT//WLQQLOO0q7AER4SK6TP3onXsOVRvleOoLUPWf45U6SXIza4T
 HqHDlMNU2YW6P74B9p/TqpnCw0AFDxR6XN+zF3Cv+0EKUb9b49Bk4Dkxdw1Mi+kWskigBUEc+vS
 zKgHq9FdV5+2NtNKksuX7Ego7hjcEAoCDA6t8oaA6jCb6LyZkPkvjWufW+ySZ6aQZFs6bVlwyMq
 wVy9t0nWZjM0ZXwsSognZETUHp57QmUd6M8YthX3TuecpmpqbKXLCVX1vnHSXBSXbKSUMKpFBqe
 jiBzURVF3f18J3/nSauk7/9P/abMxlnyj1eH9c7cpdETU7Q7KmfhqF6x4e+sfs+b4Bwk9k3S4i4
X-Google-Smtp-Source: AGHT+IEJqbVwynQfCXkeHlxuhaHLoL+yCRfk/+NsLOqZcvWI1cGqWwPGwE96SQU9CPBfbwd0wGgOhg==
X-Received: by 2002:a05:600c:c4ab:b0:477:8b2e:aa7d with SMTP id
 5b1f17b1804b1-4778feaf8e6mr25619315e9.30.1763117247006; 
 Fri, 14 Nov 2025 02:47:27 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24e1:af00:ba20:88e6:9f55:3967?
 (20014C4E24E1AF00BA2088E69F553967.dsl.pool.telekom.hu.
 [2001:4c4e:24e1:af00:ba20:88e6:9f55:3967])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bd1bf5asm40619835e9.14.2025.11.14.02.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 02:47:26 -0800 (PST)
Message-ID: <3cb44392f5fac69558bbf2933d2a8806a05379e8.camel@gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: Use amdgpu by default on SI dedicated GPUs
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Alexandre Demers <alexandre.f.demers@gmail.com>, Rodrigo Siqueira
 <siqueira@igalia.com>
Date: Fri, 14 Nov 2025 11:47:25 +0100
In-Reply-To: <7604807a-86ac-4e46-8690-3a605e9023f1@amd.com>
References: <20251113190721.258617-1-timur.kristof@gmail.com>
 <20251113190721.258617-2-timur.kristof@gmail.com>
 <7604807a-86ac-4e46-8690-3a605e9023f1@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
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

On Fri, 2025-11-14 at 11:40 +0100, Christian K=C3=B6nig wrote:
> On 11/13/25 20:07, Timur Krist=C3=B3f wrote:
> > Now that the DC analog connector support and VCE1 support landed,
> > SI dGPUs are at feature parity with the old radeon driver.
> >=20
> > Enabling the amdgpu driver by default for SI dGPUs has the
> > following benefits:
> >=20
> > - More stable OpenGL support through RadeonSI
> > - Vulkan support through RADV
> > - Improved performance
> > - Better display features through DC
> >=20
> > Users who want to keep using the old driver can do so using:
> > amdgpu.si_support=3D0 radeon.si_support=3D1
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>=20
> The patch should probably also update the text in the Kconfig file
> drivers/gpu/drm/amd/amdgpu/Kconfig.

Nice catch.

I will send a second version for both SI and CIK to update the Konfig
file as well.

>=20
> That currently reads:
>=20
> config DRM_AMDGPU_SI
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Enable amdgpu support fo=
r SI parts"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on DRM_AMDGPU
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Choose this option=
 if you want to enable experimental
> support
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for SI (Southern I=
slands) asics.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SI is already supp=
orted in radeon. Experimental support for
> SI
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in amdgpu will be =
disabled by default and is still provided
> by
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 radeon. Use module=
 options to override this:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 radeon.si_support=
=3D0 amdgpu.si_support=3D1
>=20
> Same for CIK BTW.
>=20
> Apart from that look good to me,
> Christian.
>=20
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
> > =C2=A0drivers/gpu/drm/radeon/radeon_drv.c=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> > =C2=A02 files changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 3cf36d28d27f..0539f97fa2f5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2327,6 +2327,7 @@ static bool amdgpu_support_enabled(struct
> > device *dev,
> > =C2=A0		param =3D "si_support";
> > =C2=A0		module_param =3D amdgpu_si_support;
> > =C2=A0		amdgpu_support_built =3D
> > IS_ENABLED(CONFIG_DRM_AMDGPU_SI);
> > +		support_by_default =3D true;
> > =C2=A0		break;
> > =C2=A0
> > =C2=A0	case CHIP_BONAIRE:
> > diff --git a/drivers/gpu/drm/radeon/radeon_drv.c
> > b/drivers/gpu/drm/radeon/radeon_drv.c
> > index 40dff6feac8a..fe7ed70f4703 100644
> > --- a/drivers/gpu/drm/radeon/radeon_drv.c
> > +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> > @@ -273,6 +273,7 @@ static bool radeon_support_enabled(struct
> > device *dev,
> > =C2=A0		gen =3D "SI";
> > =C2=A0		module_param =3D radeon_si_support;
> > =C2=A0		amdgpu_support_built &=3D
> > IS_ENABLED(CONFIG_DRM_AMDGPU_SI);
> > +		support_by_default =3D false;
> > =C2=A0		break;
> > =C2=A0
> > =C2=A0	case CHIP_BONAIRE:
