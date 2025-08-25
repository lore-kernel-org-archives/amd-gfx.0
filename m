Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971E3CA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 16:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A9EC10E4F0;
	Mon, 25 Aug 2025 16:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HcALk08h";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BDEB10E4F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 16:04:17 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-45a1ac7c066so29052665e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756137856; x=1756742656; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EM5hibqLSIXY5pN78y/K+eP9P+eDyZZaP0gqgcT3jZU=;
 b=HcALk08hhs/Cqe1znVYieXzW2kKaG3pT45XoD9r4coZ/wd1LaH24kp7aF4u4tUEf6X
 pg+xMt/m3SJicEwxt8eu6GhPH+o8uBs7scA/62KfJKoSWEHxJgwJmT9bpWYPfpaA1zWL
 QRYyF+7waGMF2mIwuXw6+6gxik2mTyouMG5/84QS0914Kh5Ur8yi/noiD0pw84rnD3dr
 r8oExB/O21EB0+tnOjaZA3UCFxw5D671Eo1w7PDzU1e/C3h4ixg/e7XzWO+y5Tesp1Dn
 oUW1DoENOtSFjtwgW+tobfEeTQ6cs4nJ7zvGUPF6cjH6Fbz3jVH270/54vVbOClGPUWg
 LRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756137856; x=1756742656;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EM5hibqLSIXY5pN78y/K+eP9P+eDyZZaP0gqgcT3jZU=;
 b=tAhV91TFeoWYfaBkWVXRfypp1v/V0G2SLRdK/BcvNWFYk89jaGaK4pbtUSeCQvgft1
 sdHGDAGUJ5D7fPKKHNirx6UFffrAzALqWcGKJvRUjEfHIcIh/imJJObWxh/xLuJjvlYO
 Irq0mRSdy21kWYbhIooBwLC9+i1A+iAsOzkcvP2iN9VxxnGO9yTXg8JRDNl0G+4APId8
 lxfg8hMwPWFF/hZRP4D/PS3iJQzyZcQxgxicVWoS8k+XtkUvr3udld1pPx4MkNwzWvSL
 Y0W70HaBtEvHYyQzZ3TatnrpilE9Zk2B/xTPl7ve4go9Q1JkaH9IQeAAXxkSDEjvMZTK
 m8fA==
X-Gm-Message-State: AOJu0YzZPg35Bw0933uvVqlPmblDhLh7SxRTUtUlIHZYpAjEhvP/iQU8
 t84FQtt3FUKrjtRFJs+sLCEmwGBuBen9M+EhW1jvUZc55yc3BC310a4j6t8n8A==
X-Gm-Gg: ASbGnctD3rSObmg5FAC/ff1fAEIx6Rkse/0XavT6uhpgsq0/GNMHO/j2Av3d4c8S4OF
 xRFtpqrCG5/7uXw0AvpT28cqiegAFPqMY/AEjwi1M4YA/e+d5i57GXpW64kZYRUZgiICHUaaYuv
 SSbM5xAfU+ZTC0bfLE/n0HkiaDiu3f2hVyDpKqeMk18ffQsIlWbb7ZghaVb/k7PqT8kIdNcAp7f
 gkwdTTn+ambYNP0X3AwPsSNfELwZ090bpwOa2zOp59vrTcVD0bbMBPNfIE3GKdQOtGCB5nodW0w
 qXCLy/WH5wgucE0FWhZ5TRagcu5ZcIA7bKFLMxsLCJaz4zDnn3FdfZvEWD4eeobHE9cpZ/f9ndN
 +CCjkgptwHrsEdELCRx0Av2twppbUt3yAM1RrZDoo9Jt2dGyWc1CjpDLyae3VNp+YeSkLcIqhoB
 UKXG3YxnU5KXHBEO65AuwsKzjPTZRlvegMoOqj/wSDv9JQHy1q/ZK+lWSgRf8uBw==
X-Google-Smtp-Source: AGHT+IEUAKl2re9XZdKFwh8lfTzhyDy1Kv5FmkcnKyVXVozeXaCF2hfC+VI/aHFGC4rqqas1galpjA==
X-Received: by 2002:a05:600c:674e:b0:456:1d06:f37d with SMTP id
 5b1f17b1804b1-45b65812c9fmr752075e9.16.1756137855529; 
 Mon, 25 Aug 2025 09:04:15 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24e3:6900:d571:f301:5baf:ea47?
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70ef55bddsm11886738f8f.22.2025.08.25.09.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 09:04:15 -0700 (PDT)
Message-ID: <48c5f3a3730541e360e976db84f421b73b5b7783.camel@gmail.com>
Subject: Re: [PATCH v2 1/5] drm/amdgpu: Expand kernel-doc in amdgpu_ring
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Rodrigo
 Siqueira <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Date: Mon, 25 Aug 2025 18:04:14 +0200
In-Reply-To: <285a79e9-4296-4028-89a6-02378cf9c381@amd.com>
References: <20250824233149.3780127-1-siqueira@igalia.com>
 <20250824233149.3780127-2-siqueira@igalia.com>
 <285a79e9-4296-4028-89a6-02378cf9c381@amd.com>
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

Hi,

On Mon, 2025-08-25 at 17:19 +0200, Christian K=C3=B6nig wrote:
> On 25.08.25 01:29, Rodrigo Siqueira wrote:
> > Expand the kernel-doc about amdgpu_ring and add some tiny
> > improvements.
> >=20
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 14 +++++++++++---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |=C2=A0 2 ++
> > =C2=A02 files changed, 13 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > index 6379bb25bf5c..80dd6f58a53b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -75,8 +75,15 @@ unsigned int amdgpu_ring_max_ibs(enum
> > amdgpu_ring_type type)
> > =C2=A0 * @ring: amdgpu_ring structure holding ring information
> > =C2=A0 * @ndw: number of dwords to allocate in the ring buffer
> > =C2=A0 *
>=20
> > - * Allocate @ndw dwords in the ring buffer (all asics).
> > - * Returns 0 on success, error on failure.
> > + * Allocate @ndw dwords in the ring buffer (it works in all
> > ASICs). When
> > + * inspecting the code, you may encounter places where this
> > function is called
> > + * amdgpu_ring_alloc(ring, X + Y + Z), where X, Y, and Z are
> > integer numbers.
> > + * This indicates the number of dword operations to be inserted
> > into the ring
> > + * per operation.
>=20
> I think explaining that is overkill, but the remaining comments are
> valid.
>=20
> With the change above removed that patch is Reviewed-by: Christian
> K=C3=B6nig <christian.koenig@amd.com>.
>=20
> Regards,
> Christian.

I respectfully disagree with that.

This stuff may be obvious to you, having worked on it for many years.
But it was super confusing to me when I first looked at it, so I'm glad
to see Siquiera added it here. It may help the next newcomer.

As a side note, in many places it's not fully clear when something is
in bytes vs. dwords so it's also good to emphasize that these represent
dwords of packets.

>=20
> > + *
> > + * Returns:
> > + * 0 on success, otherwise -ENOMEM if it tries to allocate more
> > than the
> > + * maximum dword allowed for one submission.
> > =C2=A0 */
> > =C2=A0int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
> > =C2=A0{
> > @@ -122,7 +129,8 @@ static void amdgpu_ring_alloc_reemit(struct
> > amdgpu_ring *ring, unsigned int ndw)
> > =C2=A0		ring->funcs->begin_use(ring);
> > =C2=A0}
> > =C2=A0
> > -/** amdgpu_ring_insert_nop - insert NOP packets
> > +/**
> > + * amdgpu_ring_insert_nop - insert NOP packets
> > =C2=A0 *
> > =C2=A0 * @ring: amdgpu_ring structure holding ring information
> > =C2=A0 * @count: the number of NOP packets to insert
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index 7670f5d82b9e..d27dbb3c109f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -62,6 +62,8 @@ enum amdgpu_ring_priority_level {
> > =C2=A0#define AMDGPU_FENCE_FLAG_64BIT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (1 << 0)
> > =C2=A0#define AMDGPU_FENCE_FLAG_INT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 1)
> > =C2=A0#define AMDGPU_FENCE_FLAG_TC_WB_ONLY=C2=A0=C2=A0=C2=A0 (1 << 2)
> > +
> > +/* Ensure the execution in case of preemption or reset */
> > =C2=A0#define AMDGPU_FENCE_FLAG_EXEC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (1 << 3)
> > =C2=A0
> > =C2=A0#define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring,
> > sched)
