Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E53CD98CF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 15:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3AA010E512;
	Mon, 15 Jun 2026 15:32:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mo+jWhOf";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1592610E512
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 15:32:29 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so25278355e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 08:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781537547; x=1782142347; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5//rp2z4Q/FmecMoArAMs/mP5JhixUvPBzynevurrKM=;
 b=Mo+jWhOfuFfpOzUSay7BpvAMuh8tPJzXfdgz2O0KMN5t/Y8/7WDt+Hyms/ZfbanB5l
 Kz9LDBUHU5oxb1Hqlr2PR1jFJJH8DFFxbiXOFH4Rx29jUPTpKeMakPpP8VW056jL+jhD
 LQFJNptnYmPoJN6lvqyRHvRel3+b6+aAj2RPDhlq+KkVpbI6LoVFELqHtvfCiDYjgdw9
 Fv+fUqDpoVFtXibrNMIcuuMGpHS3Oszv+5o10m+6qmw73bQdWzexLDIkyU2eThY6+qdc
 Zm8i+LaOc4I2LgiDUPTQAhNOJaIPFseZgKJZJ0LmcaUHnvDe8d+LWhiY6XdkeIg6AjtV
 EBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781537547; x=1782142347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5//rp2z4Q/FmecMoArAMs/mP5JhixUvPBzynevurrKM=;
 b=WY5t3idC3X+FQHWJEtMxmFIvPo+wMrI0zUGXbgcLM7PQvjLsB8YbQmIGh4kdHOozmz
 WWEjGYn0/9YeZDhBsWlq0EWGBoQxPDmZWG/9T3g1nWORyLc7aRVXfPfiyXAKXxDbYI2N
 bbMytCp23am11o1OX5dWAeZJ2054tFNezJWQminYj/AJWzPrjJXrzaEPB8s5A4pTRzl/
 8l05Ja4QhDE7mLMyyJNsHJQlioPqIsA6v5DVkqS+bwJQj8maxvUv3+CoiZgTvyGDbiAA
 aTnRJVUOrWfdZKLbEqTQJdkvlRSoKaMsKKJidlT53l8BnTZ+17Wfy7nDzkH1+qtVC0mD
 2mlA==
X-Gm-Message-State: AOJu0YweiomIfPVsgO/8afZ5dg4Cg8BMxc/kW4h2z9R6sx6ev4d5Fxq8
 W3rhNIIe+tfLXlqPTjQba2bgWUJO1YkKJajz3wcSwcAmFSnyO7loAQ984E3lZw==
X-Gm-Gg: Acq92OE9j8BQv5w0GvVRoumwFSNKpuo2rjVPdUVXzQQoxJE7b0ALIdC0D8GJINnrlfu
 Ftn3LoCdx/aEho3qTLrNl8sx4y/skXbjfedFXwMkrQG+KtvNzHSUYy/0FsV6aSF31Jibnaz7aVN
 yhtlDCOkz1JPdHg9X8jGpnZWczHnLqz0dqtQNDaFwaoavNVa3PgU54qxtM+5sMesa/JsXadSA9s
 fodbFC9YOPYlIpLyRl0TJREr40BHGQrGlejxBVGCFQR+Fh4sWcz6gclCLy8NT4aRIqD9RdeYezc
 RbMDPQNK3Kn7l0wz47S0Qwe2WYFv+ybW9oSc7cNtu8mnNLavm61W7ww1aB4SZTvop1CTVm2Ad7Z
 pALSphrrMIkoEZuUndqhVaNPUXPZcpHBO4TVzcx0jn5QzpOnTR5YED5WF96tqqY+YhwTOPxcIyb
 y3jKXTMGP2PL3fHx1sb33wsUZpT091lR2savQxDy4x3s0ocrDD/b8yL13C29GXhZe7XaBaYg==
X-Received: by 2002:a05:600c:348b:b0:490:e5c1:b89e with SMTP id
 5b1f17b1804b1-49220061e38mr142497135e9.10.1781537547283; 
 Mon, 15 Jun 2026 08:32:27 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa682d5sm535545e9.14.2026.06.15.08.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 08:32:26 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 3/7] drm/amdgpu/gmc: Don't compare page fault timestamps
 with other interrupts
Date: Mon, 15 Jun 2026 17:32:25 +0200
Message-ID: <10078559.eNJFYEL58v@timur-hyperion>
In-Reply-To: <0b18193b-9f2d-4ea9-8db3-08579325ab0c@ursulin.net>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
 <2805750.vuYhMxLoTh@timur-hyperion>
 <0b18193b-9f2d-4ea9-8db3-08579325ab0c@ursulin.net>
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

On Monday, June 15, 2026 5:23:52=E2=80=AFPM Central European Summer Time Tv=
rtko=20
Ursulin wrote:
> On 15/06/2026 15:52, Timur Krist=C3=B3f wrote:
> > On Monday, June 15, 2026 4:32:23=E2=80=AFPM Central European Summer Tim=
e Tvrtko
> >=20
> > Ursulin wrote:
> >> On 25/05/2026 12:45, Timur Krist=C3=B3f wrote:
> >>> Different interrupts may have different timestamp sources,
> >>> which shouldn't be compared.
> >>>=20
> >>> If we compare the timestamps of retry faults to timestamps
> >>> of other interrupts, it may result in all retry fault
> >>> interrupts being filtered out, because of the different
> >>> time stamp source.
> >>>=20
> >>> This issue was observed on Strix Halo.
> >>> Solved by storing the timestamp of the last page fault interrupt.
> >=20
> > Hi,
> >=20
> >> This one may require access to AMD docs to review. For example I am
> >> immediately curious as to how many different clock sources on a single
> >> IH there are
> >=20
> > As far as I know there are various timestamp sources in the GPU and some
> > interrupts use different ones. I am not aware of any documentation on t=
his
> > topic, unfortunately.
> >=20
> >> how does that relate to the timestamp_src field
> >=20
> > The timestamp_src field is set differently when the timestamp source is
> > different. So, it could happen that we accidentally filter out all page
> > faults when we shouldn't.
> >=20
> >> and if there are indeed multiple clock domains should the patch perhaps
> >> be
> >> generalized to something like
> >> ih->processed_timestamp[entry->timestamp_src] or something?
> >=20
> > For the context of this patch, I think it doesn't matter how many
> > different
> > kinds of time stamps there are. What's important is that we just should=
n't
> > compare timestamps of page faults with time stamps of other interrupts.
>=20
> True, thank you!
>=20
> Another question is why the backward timestamp check is needed only for
> fault interrupts? I do not see it elsewhere.

Correct, this is only used for retry fault interrupts and only when they ar=
e=20
dispatched to the soft IH ring.

The reason this was added is because when retry faults are enabled and the =
GPU=20
hits a VM fault, it keeps spamming the CPU with many interrupts for the sam=
e=20
fault until the fault is resolved. The CPU needs to filter out the faults w=
hich=20
it is already handling, otherwise we would end up handling the same fault=20
multiple times.

(As a side note, I should also probably look into how to reduce the frequen=
cy=20
of how often these interrupts are repeated.)

>=20
> Let me also ask two more things below.
>=20
> > As far as I see the timestamp doesn't really matter for other interrupts
> > as we only use it to filter out page faults and nothing else.
> >=20
> > Hope this helps,
> > Timur
> >=20
> >>> ---
> >>>=20
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++++-
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
> >>>    2 files changed, 5 insertions(+), 1 deletion(-)
> >>>=20
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
> >>> 13bec8461cde..52258f1341c2 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >>> @@ -437,9 +437,12 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_devi=
ce
> >>> *adev,>
> >>>=20
> >>>    	uint32_t hash;
> >>>    =09
> >>>    	/* Stale retry fault if timestamp goes backward */
> >>>=20
> >>> -	if (amdgpu_ih_ts_after(timestamp, ih->processed_timestamp))
> >>> +	if (timestamp =3D=3D adev->gmc.processed_fault_timestamp ||
> >>> +		amdgpu_ih_ts_after(timestamp, adev-
> >>=20
> >> gmc.processed_fault_timestamp))
>=20
> First thing is whether you are confident the equality check is either
> safe or required?

I don't see why it wouldn't be safe. But maybe it isn't required.
What do you suggest instead?

> For example can two blocks fault with the same timestamp on different
> addresses?

They might. But keep in mind that the GFX block just keeps spamming the=20
interrupts until the fault is handled. So, if we filter one out by mistake,=
 we=20
know we will just receive the same fault again very soon.

> Or from a different angle, is the clock granularity good enough to not
> coalesce two separate faults to a single timestamp?

I am not sure about that.

>=20
> >>>    		return true;
> >>>=20
> >>> +	adev->gmc.processed_fault_timestamp =3D MAX(timestamp,
> >>> adev->gmc.processed_fault_timestamp); +
>=20
> Doesn't a plain assign work here? The if above has already verified new
> timestamp is larger than the old.
>=20
> Regards,
>=20
> Tvrtko
>=20
> >>>    	/* If we don't have space left in the ring buffer return
> >=20
> > immediately */
> >=20
> >>>    	stamp =3D max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
> >>>    =09
> >>>    		AMDGPU_GMC_FAULT_TIMEOUT;
> >>>=20
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h index
> >>> 676e3aaa1f27..77eb15380284 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> >>> @@ -361,6 +361,7 @@ struct amdgpu_gmc {
> >>>=20
> >>>    	u64 noretry_flags;
> >>>    	u64 init_pte_flags;
> >>>=20
> >>> +	u64 processed_fault_timestamp;
> >>>=20
> >>>    	bool flush_tlb_needs_extra_type_0;
> >>>    	bool flush_tlb_needs_extra_type_2;




