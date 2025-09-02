Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6FCCA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 07:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5D6B10E1AC;
	Tue,  2 Sep 2025 07:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dde5L3V+";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD7B710E1AC
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 07:42:11 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-45b82a21e6bso22585595e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Sep 2025 00:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756798930; x=1757403730; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RyLDFfGD4A6O9Vlm1/452xu+KHg4kfg1ScKpxAy3HjI=;
 b=Dde5L3V+MneLXEQaquRx9DZjC4fDg1sDiXb9RwdxSTc+bpsgSRlMaKeMU6Pwgfzvk+
 2uBrzdQSAJEcR7y5b2Z+pdsawfK7asN8Py1XVQOG5MhB2TOVmQNlpapn4/vlcTdlolD6
 paksWenEEIORT0Q4rxI26kZ3qe2N6Gmua+vaHIuVy/DNfSR5aGxt/YOI3LNhwZiLanT5
 R//qqQxCsrvWVnfjWnGrUlz3nXvVBor+5oIuOdTvu0heYNGLlxnwRiXF3s+qV7iX6B2S
 X8RByurHac1R80MV+BmotWeOxnjcpc/ocvwYk38wsybfPK3+TqAk9BytgGTUWAePHNio
 IUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756798930; x=1757403730;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RyLDFfGD4A6O9Vlm1/452xu+KHg4kfg1ScKpxAy3HjI=;
 b=fxURpNLin0t09Z3Zg5xFl1cuBtrKRTShKJKudvufUr7Ef2cGn7p0pIVCwe7m4uItoW
 VCiDGhr9y3pBOE7WXo2nFy92oji9CgJBxSwTgRMrjxPjVNyvG6AR0RoYh3PzIq2SI5kZ
 6URpBIXwhEXzK5H/aoR7drkaAFeU2qUu08cLzhoc6jcl3L/I+Wkf45OsbrnllZYFC5V8
 fhRJ4yWToBjtabKNuQyam3iTIP8ycuorquQJ1LN4XSdX0L1kOh6dhGAlt8YxHSw017Gl
 uddBVRRJWKUR3Ug/PcnETg1xb5Q4q8/vSKdsYcWCB+GzSEZA6ZcVmjG3IvhmT9NKibOl
 7FNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKlYlt+wOmJ1uMvwcFS9wWIhuOQmn+VpbSVHrq2dyWrtzoQvzkxfsTcLGZiPsHsdslno811WV8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKq6DXtr3CuXzc32OwMDefyQMVo4XcEQAcTu4CS/AgUBDAHkTG
 jSYwF/+v+Jl78ZgTEFm3mNf2EcJRlXKq7l6ds8PpE1FOJ7D1nJrxIPYm
X-Gm-Gg: ASbGncvgrWWk+t7ElhZjgbq+Ht2fmLPv+ijnjMQjnSTvd5ymIlPkX9PED3zOjF5e3si
 ibOiiaiy7Of1hABg32lTJO9GvUvYOFkZI7Apob9+rUwwMItYxWz91URtQN6QUTAtKQRUCycsB6Q
 NY6yxkHZDAGPloKgvWxiuGMKvLUt1UrGHAn1Iho+jvkBAqKqIFh0Iup90OlxpwfIqNlNTURm9u9
 l/nyv7M53jc75L26vEiCD0Z98jLmmUoguP4rljKGd3VkrJ3ut1IjiI1KYijl6p6mEKM71qIx5yV
 WI3nqFg3t0FyjpFYNyGYeONhdeklFIK5+AYx+Yo1KdDs1LezmNs0YS1lAAASg6FKuoeKk0hAuKS
 tbrpeOl3B6uRFKIEkogDetr+WBZWT7Ht9sXYGeuBcvjk9TmzHy2xIpMLIacVU4hvS2RIRK0OOTk
 A4KumOy1g7wzMDDEk6zu3e7cvdnm2WriQ2xAS45VpkVWUz702R41WO54UKxwvGWg==
X-Google-Smtp-Source: AGHT+IFo8ks5UcUfqcwO54ykNs7V1RJrD+8j3ZKILXegnaX9JfBIhDINHGSIeLzNQOrP5SMjZfJ6Vw==
X-Received: by 2002:a05:600c:3111:b0:45b:8c5e:5f8 with SMTP id
 5b1f17b1804b1-45b8f43c876mr34740925e9.28.1756798930039; 
 Tue, 02 Sep 2025 00:42:10 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24c1:9400:5635:26cc:b04a:ca6d?
 (20014C4E24C19400563526CCB04ACA6D.dsl.pool.telekom.hu.
 [2001:4c4e:24c1:9400:5635:26cc:b04a:ca6d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e68c83asm198356905e9.20.2025.09.02.00.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 00:42:09 -0700 (PDT)
Message-ID: <6b780734f2e33ee4351b6c605f33e95a84a9b752.camel@gmail.com>
Subject: Re: [PATCH 3/4] drm/amdgpu: Fill extra dwords with NOPs
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Date: Tue, 02 Sep 2025 09:42:08 +0200
In-Reply-To: <64c1bcdb-8954-43a6-b0cd-90c75b29d3f4@amd.com>
References: <20250901100012.439155-1-timur.kristof@gmail.com>
 <20250901100012.439155-3-timur.kristof@gmail.com>
 <64c1bcdb-8954-43a6-b0cd-90c75b29d3f4@amd.com>
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

On Tue, 2025-09-02 at 08:39 +0200, Christian K=C3=B6nig wrote:
> On 01.09.25 12:00, Timur Krist=C3=B3f wrote:
> > Technically not necessary, but clear the extra dwords too,
> > so that the command processors don't read uninitialized memory.
>=20
> That is most likely a really bad idea.
>=20
> The extra DWs are filled with a specific pattern for a HW workaround.

I was unaware so it looked to me like the extra dwords just remain
uninitialized.

Where in the code does that happen?
And what is the issue that is being worked around?

Also, while we are at it, how was it possible to initialize that
without causing VM faults? Considering that the allocated BO was not
sufficiently large to hold the extra dwords. (That is fixed by the
first patch of this series.)

>=20
> Clearing them to NOPs makes no sense at all and potentially even
> breaks the HW workaround.
>=20
> Regards,
> Christian.
>=20
> >=20
> > Fixes: c8c1a1d2ef04 ("drm/amdgpu: define and add extra dword for
> > jpeg ring")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +++++
> > =C2=A01 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index 7670f5d82b9e..6a55a85744a9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -474,6 +474,11 @@ static inline void
> > amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
> > =C2=A0	while (i <=3D ring->buf_mask)
> > =C2=A0		ring->ring[i++] =3D ring->funcs->nop;
> > =C2=A0
> > +	/* Technically not necessary, but clear the extra dwords
> > too,
> > +	 * so that the command processors don't read uninitialized
> > memory.
> > +	 */
> > +	for (i =3D 0; i < ring->funcs->extra_dw; i++)
> > +		ring->ring[ring->ring_size / 4 + i] =3D ring->funcs-
> > >nop;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static inline void amdgpu_ring_write(struct amdgpu_ring *ring,
> > uint32_t v)
