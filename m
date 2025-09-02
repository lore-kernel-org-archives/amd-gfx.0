Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F24CA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 10:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52A8C10E649;
	Tue,  2 Sep 2025 10:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T3f9MMnU";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB7D10E649
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 10:10:14 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-45b9853e630so4967585e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Sep 2025 03:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756807813; x=1757412613; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zRLy5i4PKGtzDTVWgkbq4KZ0DhRTmwAgi4X9J4XkY9s=;
 b=T3f9MMnUyJBRppouhaxZcFF8/3+Yd2rCySLZ7WCEgVxQS40cLzj8ltnVlz+G37xDeX
 D/ev1pj4USJEtonBSQQsHHAU+DX84F/MN1o9p/O1kgy+BvXXp4clY1W4UaLyPXiewbrI
 mXm8m8OL4MaXov2OJ24LtpYNoq/ptSbhHx6B+WRdssb/NnPLlCflNYyDvt2JQF0QAa7L
 0LSwfwPW23hZ849QdO+EgP+Wff2lKs8ap/dQVPNSoh8gT97GWU2y9Jix4Epv5khPEjnF
 4SCq8mCbzCG+7O5pIT2H7lzIfS3/8oZyNbELyyJemfONpkHGa2iDV44QP85Krzn7DC73
 40BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756807813; x=1757412613;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zRLy5i4PKGtzDTVWgkbq4KZ0DhRTmwAgi4X9J4XkY9s=;
 b=maH6RYl2HW4JyuDkYuZ+NOANxVPbQFHW+2M+ipZJpiG8pa1unj08RbEuULIm/kPqQB
 ULPdNZPWgE8EYp0Cv5WdMF0Rk8JDvHYyujXZy/u7rDcp3fOO5BkmsTOD2Tf9mu8+TFLS
 dPzbPZjv3TIz8zzNXDvxZWc9n5gdXgTEScZeHOaV8A2SgWoOtcf201DRzD5N7w7IvVDu
 ckP9e0z0crNVomb39My+lrNg0m/LSXcL73zdW6ixUcWfu2FZf2yDmrSt+JCXZk0P7Cem
 lYAb7oAb92QC2RsH3OjWySYZPjgT8q3od16L2N8Wsw/gXKnFxY8nfePwGuTSzyap7yBm
 YRYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+2siPTtMn97c0H34LsZUAroPVsV7J3BUSi8ZrXAWoEVlZODWpUloh/rtUN+qFX5PGp+K+kLE8@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx09+FAzIhoSZf1ix4PldwRRXkruGH4Q14G085vmcbEO5ocjMSy
 S6PJYNGid1ha0PBbDq/CmyFJYZnM8FiCxpsp4AXrVxryb95uvcbC+VOWSBgiiQ==
X-Gm-Gg: ASbGncvedmMFZQY066QHaiGQR1CeAtrAlEy3uuj+wCbaLMGskbGF/PP4eJMRaI0ii7e
 R6UnobyuF4tLDrgn1i82QNS8IV4IP4KWfEnaPAs+WrSBB78x8U8poDvqEnedd7dLoP63meTMuBR
 aj8U9JU0RydDAjg20yyI7lew8qyWlTD4RnWqnZTBA7lgzGNJHsGi/GeN3cpHbh1mQWiUiJyvx3M
 PjgamtAJhly3M9jSZoHz0P8dUh3Mc1xYQB8URHVbWu+WgYImNazhHUYohgTfqv9hh3oU34u8Tam
 616Xoig3ujD/fITfqXJr51NoxCB9GIqX0nCpdFoijP/fv7Sm+t4JOvaSSzzw16dOqEJ1g9pm64L
 EoMsw2i1sBPDJy4Tti4J7tftXcs+c15ocuB/fxUA7C0TYfTzkhhNJ0iSZlf9B5dAyakQuScxrMe
 Ck/3p7ug1QmVgK/qLruIm4eZIjfEOoTViGMNo3QTFd8xiKGgqDFN9hC2GyXz9ZGw==
X-Google-Smtp-Source: AGHT+IGjuIGlWyPrbLjmMV44Top3xElh/M7cjEFR/hzkhePEwAWF8Fjg8bFpNrlIZHX6TJ0mx8OImQ==
X-Received: by 2002:a05:600c:154a:b0:45b:8a20:5437 with SMTP id
 5b1f17b1804b1-45b95fd646bmr21411965e9.31.1756807812520; 
 Tue, 02 Sep 2025 03:10:12 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24c1:9400:5635:26cc:b04a:ca6d?
 (20014C4E24C19400563526CCB04ACA6D.dsl.pool.telekom.hu.
 [2001:4c4e:24c1:9400:5635:26cc:b04a:ca6d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33add294sm20259596f8f.29.2025.09.02.03.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 03:10:11 -0700 (PDT)
Message-ID: <10ffb7f30065f67a5a0e753328aa6063934d825c.camel@gmail.com>
Subject: Re: [PATCH 3/4] drm/amdgpu: Fill extra dwords with NOPs
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Date: Tue, 02 Sep 2025 12:10:11 +0200
In-Reply-To: <9b366fac-4a12-438a-a630-98f60b3e49c4@amd.com>
References: <20250901100012.439155-1-timur.kristof@gmail.com>
 <20250901100012.439155-3-timur.kristof@gmail.com>
 <64c1bcdb-8954-43a6-b0cd-90c75b29d3f4@amd.com>
 <6b780734f2e33ee4351b6c605f33e95a84a9b752.camel@gmail.com>
 <9b366fac-4a12-438a-a630-98f60b3e49c4@amd.com>
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

On Tue, 2025-09-02 at 11:54 +0200, Christian K=C3=B6nig wrote:
> On 02.09.25 09:42, Timur Krist=C3=B3f wrote:
> > On Tue, 2025-09-02 at 08:39 +0200, Christian K=C3=B6nig wrote:
> > > On 01.09.25 12:00, Timur Krist=C3=B3f wrote:
> > > > Technically not necessary, but clear the extra dwords too,
> > > > so that the command processors don't read uninitialized memory.
> > >=20
> > > That is most likely a really bad idea.
> > >=20
> > > The extra DWs are filled with a specific pattern for a HW
> > > workaround.
> >=20
> > I was unaware so it looked to me like the extra dwords just remain
> > uninitialized.
> >=20
> > Where in the code does that happen?
>=20
> See vcn_v4_0_init_ring_metadata() for an example.

I see, thanks for explaining that.

So basically it's up to the ring initialization to fill the extra
dwords with something, and it shouldn't be done when clearing the ring.

>=20
> > And what is the issue that is being worked around?
>=20
> IIRC on the VCN4 engine there is a HW bug which triggered when some
> metadata for the ring was not in the same X megabyte segment of the
> ring buffer. So we just put this small metadata structure directly
> after the ring.
>=20
> On some jpeg engine you had to insert commands after the end of the
> ring to actually make the ring work reliable. See
> jpeg_v1_0_decode_ring_set_patch_ring().

Thanks!

>=20
> > Also, while we are at it, how was it possible to initialize that
> > without causing VM faults? Considering that the allocated BO was
> > not
> > sufficiently large to hold the extra dwords. (That is fixed by the
> > first patch of this series.)
>=20
> BOs for VRAM and GTT are always rounded to the next 4KiB. The
> workaround need something like 100 bytes or 64 DW, so that always
> worked.
>=20
> BTW: I just found that vcn_v4_0_unified_ring_vm_funcs() is using
> extra_dw as bytes already :)

I can fix that and include the fix in the next version of this series.

>=20


> > >=20
> > > Clearing them to NOPs makes no sense at all and potentially even
> > > breaks the HW workaround.
> > >=20
> > > Regards,
> > > Christian.
> > >=20
> > > >=20
> > > > Fixes: c8c1a1d2ef04 ("drm/amdgpu: define and add extra dword
> > > > for
> > > > jpeg ring")
> > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > ---
> > > > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +++++
> > > > =C2=A01 file changed, 5 insertions(+)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > > index 7670f5d82b9e..6a55a85744a9 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > > @@ -474,6 +474,11 @@ static inline void
> > > > amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
> > > > =C2=A0	while (i <=3D ring->buf_mask)
> > > > =C2=A0		ring->ring[i++] =3D ring->funcs->nop;
> > > > =C2=A0
> > > > +	/* Technically not necessary, but clear the extra
> > > > dwords
> > > > too,
> > > > +	 * so that the command processors don't read
> > > > uninitialized
> > > > memory.
> > > > +	 */
> > > > +	for (i =3D 0; i < ring->funcs->extra_dw; i++)
> > > > +		ring->ring[ring->ring_size / 4 + i] =3D ring-
> > > > >funcs-
> > > > > nop;
> > > > =C2=A0}
> > > > =C2=A0
> > > > =C2=A0static inline void amdgpu_ring_write(struct amdgpu_ring *ring=
,
> > > > uint32_t v)
