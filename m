Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E119ACA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 11:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8997B10E66D;
	Tue,  2 Sep 2025 11:30:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hAxoSTrq";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5799310E66D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 11:30:24 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45b7d497ab9so47189375e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Sep 2025 04:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756812623; x=1757417423; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=85ykL5I1LsZxy5paPkkJv3BIB4IGcCDSAnDtI1OEfi8=;
 b=hAxoSTrq0ZTcxQJ5Ti2A9bvx+1KOGo1eaGsWGrqY+EC3W50RzZt7O6eky7jcT4LP1f
 0af9OR6YNjaoONbmvv4Qy5m4n05EncnZmQrdxdNkw2feuf1Pnke3osnFz/b9JnTpRwSC
 O+CvPaaWIpJJ0VTxE43YrHaIWIzwyPc+UwbaYcgE2rIYvZFCjS/iCE8/BlnsvYIDkmtT
 AhR2bx1WhVz1F54EaabWEXGbNsSah7MieZsWW1t5dCmCDJv4ySBpKo/a0skm43lKp/Zd
 K22AdTuR2Ao2ZE8g8Yl4BD1eoe2lSrI2xvj8Lrl6095gCp+b9pppd2A8MtI6NnAsOvkU
 BEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756812623; x=1757417423;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=85ykL5I1LsZxy5paPkkJv3BIB4IGcCDSAnDtI1OEfi8=;
 b=jMBnzjyOx+aHu4vCmRJtFRerM/0ZvVioWZPLXMW5P4Ean9P/HrR2of6/6GFfrXor8n
 atlA5FIeeWUt7CmZFbeTJQIVVTzGqkxzIhDnEkyuTuZDdjlCGbsR23kTpJrhLL/aOIhx
 EAYfIaik4ZPd+QJCVby5nvTGrsiQdx02PWjgAkJUb2HlKTaPmvIclqH2WfopREZSCqfe
 Aeb88PF2tChQNLcmI5caswTHN9l5l9WLfspGzS2e7/iwPXjye80tvLHkNnoFL1CXKFvm
 SzfjxvawtFuo2iM0uWvHh3deSZCWA127tE3WCArjkgDygfJ/5yIhjQgLxIVeuQgSy2Fj
 REsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSFvHwyYhGu72hDw99L3T3kOjR5NwYjUHSGCshksaIm45EpIv7o4XHFfjTx31H/2fsNfq2RCAS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNxV3d73xLSKFDqtbIZG8rUM2JioliViqkZa3FqTlN3TAN4ayA
 8VrxdcqgQ4Kt8u+mkNf69iRjmSz9ulyd/gDQhUJjB2XSjLf1+wbmn3q05rK4KQ==
X-Gm-Gg: ASbGnctEj9rd6DsAlooNF/vPjqhBNyc4xFht6lCeK0ZXA4ZSkIcGaRwSwFFYfrP9DvJ
 huCMo/s/V/A0om6OQPCDZNfwMauBp9RUoNI+tDC/yD29L9fVdntBcRb9hhRSCWcOmjmePw6+mEc
 PbobX4GlSVjZ2aOQARJS9g71RR8RuoZ7u/SxfI4OgsFr7xolayIApowWRBnXMkqTwUnFlQWFtE+
 xYhn5rDuv9zycIDzDuxeHXVg6+bK7WXSOsal8guVNb9TQm6ih7UpB255D44n8pVevp2y9btbJW+
 +11/K1PywVKwAt7JIm/xEXvBGqr80g6gHco/KJkGRobjkgDYm3B/ETGRD6IaEQDYFE9ool76S5o
 SGYJCRnFKduGzM0uHSsOczV1rWHlQa3Pf7o0HtL6RE9X0gmPQLIrNi4mlo5/d9NWJqJ2n0SWvQZ
 B608LMrdGVu1YLpBoRUBPxw7bsNfSxS3VH7cPTv8f7yyuCKj69OCqPtSSxJC2+fA==
X-Google-Smtp-Source: AGHT+IHgpfZubVIPibgJjMxNygiviPv1dmUzB4sRhY+se8Q52e0UHKVQhTw6uCpx/P/ndf0tHxfFtw==
X-Received: by 2002:a05:600c:8b23:b0:456:1dd2:4e3a with SMTP id
 5b1f17b1804b1-45b855506e2mr84376425e9.3.1756812622501; 
 Tue, 02 Sep 2025 04:30:22 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24c1:9400:5635:26cc:b04a:ca6d?
 (20014C4E24C19400563526CCB04ACA6D.dsl.pool.telekom.hu.
 [2001:4c4e:24c1:9400:5635:26cc:b04a:ca6d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6b99sm275794565e9.4.2025.09.02.04.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 04:30:22 -0700 (PDT)
Message-ID: <1aef6170994c05c98f215690665f837529da5950.camel@gmail.com>
Subject: Re: [PATCH 3/4] drm/amdgpu: Fill extra dwords with NOPs
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Date: Tue, 02 Sep 2025 13:30:21 +0200
In-Reply-To: <9d3566f4-9ede-4d4c-8849-2ccac3fa65a6@ursulin.net>
References: <20250901100012.439155-1-timur.kristof@gmail.com>
 <20250901100012.439155-3-timur.kristof@gmail.com>
 <9d3566f4-9ede-4d4c-8849-2ccac3fa65a6@ursulin.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
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

On Mon, 2025-09-01 at 11:13 +0100, Tvrtko Ursulin wrote:
>=20
> Hi,
>=20
> On 01/09/2025 11:00, Timur Krist=C3=B3f wrote:
> > Technically not necessary, but clear the extra dwords too,
> > so that the command processors don't read uninitialized memory.
> >=20
> > Fixes: c8c1a1d2ef04 ("drm/amdgpu: define and add extra dword for
> > jpeg ring")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +++++
> > =C2=A0 1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index 7670f5d82b9e..6a55a85744a9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -474,6 +474,11 @@ static inline void
> > amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
> > =C2=A0=C2=A0	while (i <=3D ring->buf_mask)
> > =C2=A0=C2=A0		ring->ring[i++] =3D ring->funcs->nop;
> > =C2=A0=20
> > +	/* Technically not necessary, but clear the extra dwords
> > too,
> > +	 * so that the command processors don't read uninitialized
> > memory.
> > +	 */
> > +	for (i =3D 0; i < ring->funcs->extra_dw; i++)
> > +		ring->ring[ring->ring_size / 4 + i] =3D ring->funcs-
> > >nop;
>=20
> Should I resend this maybe?


Hi Tvrtko,

The patch you commented on is going to be dropped.

However, your patch makes good sense, so I can include it in the next
version of this series if that's OK.

@Christian - does that sound alright to you?


>=20
> commit 11b0b5d942fe46bfb01f021cdb0616c8385d5ea8
> Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Date:=C2=A0=C2=A0 Thu Dec 26 16:12:37 2024 +0000
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 drm/amdgpu: Use memset32 for ring clearing
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Use memset32 instead of open coding it, just bec=
ause it is
> =C2=A0=C2=A0=C2=A0=C2=A0 a tiny bit nicer.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@ig=
alia.com>
> =C2=A0=C2=A0=C2=A0=C2=A0 Cc: Christian K=C3=B6nig <christian.koenig@amd.c=
om>
> =C2=A0=C2=A0=C2=A0=C2=A0 Cc: Sunil Khatri <sunil.khatri@amd.com>
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h=20
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index dee5a1b4e572..96bfc0c23413 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -369,10 +369,7 @@ static inline void=20
> amdgpu_ring_set_preempt_cond_exec(struct amdgpu_ring *ring,
>=20
> =C2=A0 static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring=
)
> =C2=A0 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i =3D 0;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (i <=3D ring->buf_mask)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ring->ring[i++] =3D ring->funcs->nop;
> -
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset32(ring->ring, ring->funcs->n=
op, ring->buf_mask + 1);
> =C2=A0 }
>=20
> =C2=A0 static inline void amdgpu_ring_write(struct amdgpu_ring *ring,
> uint32_t v)
>=20
> Looks like with two loops it would made even more sense to
> consolidate.
>=20
> Regards,
>=20
> Tvrtko
>=20
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static inline void amdgpu_ring_write(struct amdgpu_ring *ring,
> > uint32_t v)
>=20
