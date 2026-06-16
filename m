Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3A7CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 12:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D71D10EA99;
	Tue, 16 Jun 2026 12:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="huFe+n1s";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F0B410EA99
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 12:04:21 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490acbb0f89so28987325e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 05:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781611460; x=1782216260; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1KVrjICdeM3mIrPellFipuZEyPBQmzEzyZHZTHXsA+0=;
 b=huFe+n1sXeAgDI4mGgy/M6Drl7arAdA3aXG7VBV/1sMKJP5n03tlDrI6XUg5pce4rX
 Mj8auVYJlc40lDPwTQVOKF+T+Li5WWVhiZEQ/biQey+P8T2GkLTQp86ZRMLBw4/yZ1b/
 cKjJVQDVG5uBDt1l51qOHkRu/PgyIe9DIdU/UnUHnw4TqckzDq4hBY5dH74CSjcyMVAW
 QXXh2Ip6IG13LJzajvaiAIJBoQN3fHk8AFQS0o+zk0ulP6LO81ULwgOFfHduock0MG14
 2oak3XwpN2Elpq91NbpKBmpifW2AY6cgBVDNrCSh5OnO1lD9V02F/I+y6reY061k4MVn
 iGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781611460; x=1782216260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1KVrjICdeM3mIrPellFipuZEyPBQmzEzyZHZTHXsA+0=;
 b=QR6PkxpJT63WM65V1Ed51eoQPvc7YAwe+wkUtd2+52pTTXfomO5Tz/hC7nHm4ryCA3
 jJTezIskCXf50aUkjtMrOGaa1KdVFFkc9hE8NdM0KwUh16R6U7nsfI2wOPRYhw6dg8v1
 9vThPsYbyYjyb2JFqB2Z7lXc/kaTs5msjv8+p9yqTCjtvcwGb3HsyreribBGbGjuyhWe
 e9dGVcJp5yKOG8lfWyZIlGc1+r+xEW086kbQ5eJVWzLZy8nP3SqbF+AWqBAXyU4Uhsvi
 FdA974hyNE+WmLX4vtBeGWoSQpOXmahIuEjDukJs20xkLG4GuolHl566DNJdn9WmNxZ/
 yxag==
X-Gm-Message-State: AOJu0Yx1gK+HRNjTMTCzelkYnjyEno1bOlpr4udgsrBBlfUtnNRj53hX
 mMxOKagvLZXx8NnLroEnuu1Y/rpxO69c9Ej79b4DNcMoPLkzZ0iAmlXHiEv4mA==
X-Gm-Gg: Acq92OF62cvUnGpynmkhm8h6Gw18kpOKpcZVCndD0hX0/WNodR0nUgP/T0ain8gklnR
 FzxxP0dkHyApt2ZF9RDzxgigf/mSWPWgCeWJb6WEKZBGa3GJ2EKFfx0A0TF4f5bGDp8Sy+3A+6k
 HINDaUsfwCGTGPwCERdX1W7HH8svc5O+Mfetv6m6fG+ZJLwkjcvvljC+y56nvbBPCgF3K9eNGin
 4TZoqqilQ8pesNB/wwDaliO503lmJLtHx/ClOcifqN5WTow3qG1p/WcKuz64VFOJcWCl16oZd9I
 euq9Wd5mTHe/5rkaNbPePzNgfXXWUKBPXv1UJKaxQ++g0ulLuYCO70yKBG+VT4AEBj71D8nIEgC
 Vj0fyxvnIBYMDe5xk4TEFsZDlmgKDp6laF7BP1dULOzBKwGCsFbXTDd37AGtt6VXBeXjp+ADK/4
 hjq9b11iZ2iDzfXmRlKazTO8bw7bDCLCRcjwKjOn7jOphgWI/8SEhFe6xrNXkK/p4RIg0jLg==
X-Received: by 2002:a05:600c:5246:b0:490:a296:fdad with SMTP id
 5b1f17b1804b1-4922011df3emr192234225e9.24.1781611458158; 
 Tue, 16 Jun 2026 05:04:18 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea95c512sm239188195e9.2.2026.06.16.05.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 05:04:16 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 amir.shetaia@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 2/3] amdgpu/ih: Don't perturb HW registers when accessing
 soft IH ring
Date: Tue, 16 Jun 2026 14:04:15 +0200
Message-ID: <5402227.Qq0lBPeGtt@timur-hyperion>
In-Reply-To: <6f5c367e-b234-491b-81e2-d928cd54050d@ursulin.net>
References: <20260513170849.27061-1-timur.kristof@gmail.com>
 <20260513170849.27061-3-timur.kristof@gmail.com>
 <6f5c367e-b234-491b-81e2-d928cd54050d@ursulin.net>
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

On Tuesday, June 16, 2026 1:39:56=E2=80=AFPM Central European Summer Time T=
vrtko=20
Ursulin wrote:
> On 13/05/2026 18:08, Timur Krist=C3=B3f wrote:
> > The soft IH ring is implemented entirely in software.
> > We shouldn't read (or write) and HW registers when accessing it.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c   | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c   | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 4 ++++
> >   4 files changed, 25 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> > b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c index 333e9c30c091..65e5d21753f9
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> > @@ -439,6 +439,10 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device
> > *adev,>=20
> >   	struct amdgpu_ih_regs *ih_regs;
> >   =09
> >   	wptr =3D le32_to_cpu(*ih->wptr_cpu);
> >=20
> > +
> > +	if (ih =3D=3D &adev->irq.ih_soft)
> > +		goto out;
> > +
>=20
> Would it be feasible to move amdgpu_ih_funcs from device global into the
> IH rings themselves? Then we could have soft IH ops and it would be very
> clean.
>=20
> Possibly also cleanup all the protoptyes to operate only on ih and not
> the adev + ih pair.

Sure, we can do that in the future. The reason I chose not to do that is=20
because that feels like an extremely intrusive refactor across all GPU=20
generations with a high chance of introducing regressions and not much valu=
e=20
to end users.

=46or now I would like to just focus on making the current code work well w=
ith=20
minimal refactoring, ie. just get the current soft IH ring implementation t=
o=20
work reliably with retry faults.

In the meantime if you have a good idea how to refactor this code to make i=
t=20
cleaner without breaking it, I'm happy to listen and we can make a plan how=
 to=20
do that in a future series.

Thanks,
Timur




>=20
> >   	ih_regs =3D &ih->ih_regs;
> >   =09
> >   	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> >=20
> > @@ -514,6 +518,9 @@ static void ih_v6_0_set_rptr(struct amdgpu_device
> > *adev,>=20
> >   {
> >  =20
> >   	struct amdgpu_ih_regs *ih_regs;
> >=20
> > +	if (ih =3D=3D &adev->irq.ih_soft)
> > +		return;
> > +
> >=20
> >   	if (ih->use_doorbell) {
> >   =09
> >   		/* XXX check if swapping is necessary on BE */
> >   		*ih->rptr_cpu =3D ih->rptr;
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> > b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c index 699c274d357e..9dbc20131410
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> > @@ -410,6 +410,10 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device
> > *adev,>=20
> >   	struct amdgpu_ih_regs *ih_regs;
> >   =09
> >   	wptr =3D le32_to_cpu(*ih->wptr_cpu);
> >=20
> > +
> > +	if (ih =3D=3D &adev->irq.ih_soft)
> > +		goto out;
> > +
> >=20
> >   	ih_regs =3D &ih->ih_regs;
> >   =09
> >   	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> >=20
> > @@ -481,6 +485,9 @@ static void ih_v6_1_irq_rearm(struct amdgpu_device
> > *adev,>=20
> >   static void ih_v6_1_set_rptr(struct amdgpu_device *adev,
> >  =20
> >   			       struct amdgpu_ih_ring *ih)
> >  =20
> >   {
> >=20
> > +	if (ih =3D=3D &adev->irq.ih_soft)
> > +		return;
> > +
> >=20
> >   	struct amdgpu_ih_regs *ih_regs;
> >   =09
> >   	if (ih->use_doorbell) {
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> > b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c index 6de9e87e04e1..bd332e8cc5bf
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> > @@ -457,6 +457,10 @@ static u32 ih_v7_0_get_wptr(struct amdgpu_device
> > *adev,>=20
> >   	struct amdgpu_ih_regs *ih_regs;
> >   =09
> >   	wptr =3D le32_to_cpu(*ih->wptr_cpu);
> >=20
> > +
> > +	if (ih =3D=3D &adev->irq.ih_soft)
> > +		goto out;
> > +
> >=20
> >   	ih_regs =3D &ih->ih_regs;
> >   =09
> >   	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> >=20
> > @@ -527,6 +531,9 @@ static void ih_v7_0_set_rptr(struct amdgpu_device
> > *adev,>=20
> >   {
> >  =20
> >   	struct amdgpu_ih_regs *ih_regs;
> >=20
> > +	if (ih =3D=3D &adev->irq.ih_soft)
> > +		return;
> > +
> >=20
> >   	if (ih->use_doorbell) {
> >   =09
> >   		/* XXX check if swapping is necessary on BE */
> >   		*ih->rptr_cpu =3D ih->rptr;
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> > b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c index 4cd325149b63..e7ed37bb48=
e0
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> > @@ -417,6 +417,10 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device
> > *adev,>=20
> >   		 */
> >   	=09
> >   		wptr =3D le32_to_cpu(*ih->wptr_cpu);
> >=20
> > +		if (ih =3D=3D &adev->irq.ih_soft)
> > +			goto out;
> > +
> > +
> >=20
> >   		if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> >   	=09
> >   			goto out;
> >   =09
> >   	}




