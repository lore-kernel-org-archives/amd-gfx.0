Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E329CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 08:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF9CE10E1BD;
	Tue,  2 Sep 2025 08:26:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MWsVb1XG";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF1B810E1BD
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 08:26:22 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-45b627ea685so43342065e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Sep 2025 01:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756801581; x=1757406381; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OjQa2Dx+BlLARRz9IJI4KgpzBBoMVGUA1jm60sXx2J4=;
 b=MWsVb1XGP9loRDe+kdqWTNdPvnia/+csgax/e/MPn7NaYA3aHJCy1KK1aysraN6BkF
 6NX+3U/BvKXTVxwvlLolTOxBJSiZaMrnzGXYi33YIZfAziw+X+AmJZedNv/KvbQBFZT/
 hOHe64/BJcXGluPST0x1Vg1SbpNNVG4HwaTlhLG3NYPpZo5zguBuKYoWYmvCLjfzNYGF
 3l/zRV+t1HEBPsRG5Ux/LLQy7Mx18zW9acoqqsy2mFIFWcD9/aQMDUCzj7n36Xe+z47+
 NO6CclwDqdXGMQM3eUh1CnQQDWCTLi88BhicYe0dUQDq1S/jk/s6M2YqL+H/MISz+Ccm
 6mDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756801581; x=1757406381;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OjQa2Dx+BlLARRz9IJI4KgpzBBoMVGUA1jm60sXx2J4=;
 b=XhH+e1XOqdSENzVFRj7kySaupIjFXNoRGFSE1FYhyBX8zcIuiSZ3r+cn+18dkM1mju
 b18fJFoVmkG7aGzqjDKUQ9pqF3QWazvLYahMo7CLxC1V8UXrxykZ6EpfA4X0yCGoVtfx
 3JyauX1lmTGzBW4OHIFAW8DhT7s0Rv6WzNHUnQHjvwSvAHZLin96LkiEh4Qinoch+oE3
 qW3xFkzSwZCGDzlvKRbzE0m8eYUFm9JrpjUNvT56co7ifBfbeFtuqMUNoCSWz+z2rPqu
 RiMpkhz7KOf8f8wSrfkSWEXe5vt+S2+dLlroWz7sEPFfJqsr7OeijJck8ln7NktmVbkZ
 Y+QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2PISydhBG+CIhXOa8spKxyFhVXZ8TiwSQBKtgeWYXpzDDYIM+WUfOz7lpObsGaQDEoVCTM5Pq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVLMynaH/T88r3znHHwtdEZ/O/191IWdLnJDMOXhznObEJ+371
 OBoQU9N8KGTP6t5u7QyQSU9icAmvOJNA1qIsBzImggvbAscirb5t2dYY
X-Gm-Gg: ASbGncsp591CLsSXsV981SikVv8jSqDUwUtX0Y7VjuJpzqMCwQqiZT95uS8ajAn/3ec
 GV94ymMlUTA+51KJ/tkkJxjGRZQe6zGPU9Dj1Kjyg9PQmcAo814bDj8nPWvOkvoYC8X7/XjJH+Y
 duLBRCW2tHw/DuDl2Uu3JZWN+CkTyGyvlmSKCAj2yKCj4NY2eyNlUVQrMCDEAuEi2lek6Zh6m1u
 qvbsX+J/9SQcKTYK6T1WReE9ugNlOqsBTfXAMfAgA5/dPzxV/kFR+LUjtOGL0+kqPD4PkRkaOkN
 dEhpfiv9hhE6DsRjXjucIzTa6uR9+a9LN1MlOT9Rh03EZzAOcEhttjii7Hv/bNWg/GHxB7Aaks4
 o5Hwsd11C3e/lRlSsnU/x4d1FsJTfafvtugyiByseYhhRbLbRY+QzSY0NcFT3jiiBwGzCdhLr94
 g5y5V1wbXyLGosXjCFfD0IlG1IvfEY60ePB+SVdJfhxT71AprWxXMbN4OFIM9OeQ==
X-Google-Smtp-Source: AGHT+IFulz5KQxg03aoBWJwm6dX4tizQsn9Fmz1iqA5CImqi3A0Dk0QJGXZ4I8wMe3oz1JprNHwdCQ==
X-Received: by 2002:a05:600c:c4a1:b0:45b:84b1:f638 with SMTP id
 5b1f17b1804b1-45b8559babbmr71431195e9.20.1756801580957; 
 Tue, 02 Sep 2025 01:26:20 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24c1:9400:5635:26cc:b04a:ca6d?
 (20014C4E24C19400563526CCB04ACA6D.dsl.pool.telekom.hu.
 [2001:4c4e:24c1:9400:5635:26cc:b04a:ca6d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e887fdcsm189567125e9.13.2025.09.02.01.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 01:26:20 -0700 (PDT)
Message-ID: <f1279a6181ff9dba8f18f3eec352502cfea953e2.camel@gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: Fix allocating extra dwords for rings
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Date: Tue, 02 Sep 2025 10:26:19 +0200
In-Reply-To: <cb030737-e602-4bdd-aef2-cb5fc79ee2ca@amd.com>
References: <20250901100012.439155-1-timur.kristof@gmail.com>
 <cb030737-e602-4bdd-aef2-cb5fc79ee2ca@amd.com>
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

On Tue, 2025-09-02 at 08:41 +0200, Christian K=C3=B6nig wrote:
> On 01.09.25 12:00, Timur Krist=C3=B3f wrote:
> > The amdgpu_bo_create_kernel function takes a byte count,
> > so we need to multiply the extra dword count by four.
> > (The ring_size is already in bytes so that one is correct here.)
>=20
> Good catch, it just doesn't make a difference in practice since
> everything is rounded up to 4k anyway.

Yes. It looks like extra_dw is only used by jpeg_v1_0 and vcn_v4_0 and
fortunately both of these are small enough that it doesn't cause a
difference in practice.

I'd still like to fix it though to avoid potential issues in the
future.

>=20
> But I'm really wondering if we shouldn't replace the extra_dw with
> extra_bytes instead.

It's up to you. I'm happy to change it to extra_bytes if you think
that's better. I would prefer to keep extra_dw for two reasons:

- Avoid unnecessary churn
- Most of the code related to rings are in dwords, so IMO it's better
to have the extra space in dwords too for consistency.

>=20
> It should only be used by some multimedia engines anyway.

Right. vcn_v4_0 has this:
.extra_dw =3D sizeof(struct amdgpu_vcn_rb_metadata)
Which would also need to be fixed because it's not really in dwords.



> >=20
> > Fixes: c8c1a1d2ef04 ("drm/amdgpu: define and add extra dword for
> > jpeg ring")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 11 ++++++-----
> > =C2=A01 file changed, 6 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > index 6379bb25bf5c..13f0f0209cbe 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -364,11 +364,12 @@ int amdgpu_ring_init(struct amdgpu_device
> > *adev, struct amdgpu_ring *ring,
> > =C2=A0
> > =C2=A0	/* Allocate ring buffer */
> > =C2=A0	if (ring->ring_obj =3D=3D NULL) {
> > -		r =3D amdgpu_bo_create_kernel(adev, ring->ring_size
> > + ring->funcs->extra_dw, PAGE_SIZE,
> > -					=C2=A0=C2=A0=C2=A0 AMDGPU_GEM_DOMAIN_GTT,
> > -					=C2=A0=C2=A0=C2=A0 &ring->ring_obj,
> > -					=C2=A0=C2=A0=C2=A0 &ring->gpu_addr,
> > -					=C2=A0=C2=A0=C2=A0 (void **)&ring->ring);
> > +		r =3D amdgpu_bo_create_kernel(adev, ring->ring_size
> > + ring->funcs->extra_dw * 4,
> > +						PAGE_SIZE,
> > +						AMDGPU_GEM_DOMAIN_
> > GTT,
> > +						&ring->ring_obj,
> > +						&ring->gpu_addr,
> > +						(void **)&ring-
> > >ring);
> > =C2=A0		if (r) {
> > =C2=A0			dev_err(adev->dev, "(%d) ring create
> > failed\n", r);
> > =C2=A0			kvfree(ring->ring_backup);
