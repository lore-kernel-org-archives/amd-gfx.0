Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D841DCD98C5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 14:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F0310E489;
	Mon, 15 Jun 2026 14:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b18YyQ91";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BB7210E489
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 14:52:06 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490b12270b3so21521625e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 07:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781535124; x=1782139924; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=exHhcFF/T+GHzMHcDp8a1aw064BuGqQL548i1ys01oU=;
 b=b18YyQ91mRKI/M1A6bzst/N6ixesvbNIy6hstvyyYJCXkThjEMS47u2ASHu8+okzjm
 tzkzgDrdtyy3r51dsjX+Ub3mZfsO3uDMCsAg/K9KmWsKidfrWkKXHwzLxWmTh8js8MuQ
 nTRy06gTDFnhvIUXDh6SL10KoP6Kd64fCIOiI1U1HLyI3m6kjxcHSYpeRtToQi26+8Nq
 vspLR4Spm+eAMZyzmm0WopK0Os9Cgp8TWng5VkDWUFYlnnMHRv41a2+LmMySKs1CR/KQ
 aqclwpIPi1BeQ3ZZsmk1LplUbXl0ot18f8xf7wSiE+o+PiiEbfJTTcI5IxulGkJi2ibe
 IX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781535124; x=1782139924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=exHhcFF/T+GHzMHcDp8a1aw064BuGqQL548i1ys01oU=;
 b=G6JcQWW5SKoBgHX1cf04xLKsBvoJl30irzYvQYp5q939UrdRxs16LVYYDwJ71SWc+/
 R5uu+0NLcW5j2jqoYd84XzmaYQzopfzFIxitsVPAdsulIXfm+iuuxTTXq7+Eqqccez1K
 5jt34Vw83AW+S8IiugZsqcOqGmZBxvlN+amQCsmoLEZtbCCuKFxLqtJV/IJr5ZHgVYbj
 6Bqa6TrlEerMWJ8RB5KuaF1JbzqP0dVBZ7V1dM/fI1hkl4BP4J9wroNF/MSp5zvhFlU9
 0glFgiNjX//vli3MSPwi0ka1J6O1JhK02wd9CUgaX56hkB4XgpNQI3WQzBP19Oz3PdC8
 idDA==
X-Gm-Message-State: AOJu0YwLQpjs4xj7gjUMKuwEPk9YZ8j0eebWSN5lPVn6RRusf/LABlHe
 smVjGnj3Q0YRKlWshHZjqQ4Nz0GZ1v051ZqNMyDv10/a6Z5aOt6/w2+jbqGWRA==
X-Gm-Gg: Acq92OGPncAOmEv6LMkaeGvLSOO3M7ZGCaoFmdc2t33ePnmEL/OHXmcM6O7UN7FIBJk
 e6o8sbmlFDS0F2PfSg1tyYZMfFOZiVBdDVDlPh60RMKcCBBYLTxBn+cPy/2SfV7QN9nVQrpEDbi
 BDhHR4cv06OJwGXrYCZLLmv5xKPy0noCdMj1AkTHshKsiGGbujYBhtW7r27wAp8dSGb35iAtZEr
 EARkT+EYudiAsKJDoAV0ugPrqrZ12BlGaD3U30e76DkVXHDyWLAymDUwE4kUWBtSHS86vYeOVmv
 YwAmdUIR0UITY/chPv4OygIhouBLcUmsFNFtKpYYqdTKH/lyFhNrEZIPzCAO7kjek6cdR1H28eQ
 Ig0USY+sB30Tv9onmaVPS713/TYiMrbHTxG2GOzwBGbotsJu5/0PDc3TQACAUxILZP8ZzvwlJiu
 5Jw9ZZOCXeZCMe4sS+t5BEgNYhGu8l3ZTIdrjyo167T2XsBdwlHwN/HeioEgJKw6XnqBZU0g==
X-Received: by 2002:a05:600c:4685:b0:490:e190:3b50 with SMTP id
 5b1f17b1804b1-490ec4d4f7cmr226399955e9.9.1781535124118; 
 Mon, 15 Jun 2026 07:52:04 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220207efesm223415765e9.0.2026.06.15.07.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 07:52:03 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 3/7] drm/amdgpu/gmc: Don't compare page fault timestamps
 with other interrupts
Date: Mon, 15 Jun 2026 16:52:02 +0200
Message-ID: <2805750.vuYhMxLoTh@timur-hyperion>
In-Reply-To: <fc23a624-650b-40b3-8de2-07d4a44ff603@ursulin.net>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
 <20260525114507.24566-4-timur.kristof@gmail.com>
 <fc23a624-650b-40b3-8de2-07d4a44ff603@ursulin.net>
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

On Monday, June 15, 2026 4:32:23=E2=80=AFPM Central European Summer Time Tv=
rtko=20
Ursulin wrote:
> On 25/05/2026 12:45, Timur Krist=C3=B3f wrote:
> > Different interrupts may have different timestamp sources,
> > which shouldn't be compared.
> >=20
> > If we compare the timestamps of retry faults to timestamps
> > of other interrupts, it may result in all retry fault
> > interrupts being filtered out, because of the different
> > time stamp source.
> >=20
> > This issue was observed on Strix Halo.
> > Solved by storing the timestamp of the last page fault interrupt.
>=20

Hi,

> This one may require access to AMD docs to review. For example I am
> immediately curious as to how many different clock sources on a single
> IH there are

As far as I know there are various timestamp sources in the GPU and some=20
interrupts use different ones. I am not aware of any documentation on this=
=20
topic, unfortunately.

> how does that relate to the timestamp_src field

The timestamp_src field is set differently when the timestamp source is=20
different. So, it could happen that we accidentally filter out all page fau=
lts=20
when we shouldn't.

> and if there are indeed multiple clock domains should the patch perhaps be
> generalized to something like
> ih->processed_timestamp[entry->timestamp_src] or something?

=46or the context of this patch, I think it doesn't matter how many differe=
nt=20
kinds of time stamps there are. What's important is that we just shouldn't=
=20
compare timestamps of page faults with time stamps of other interrupts.

As far as I see the timestamp doesn't really matter for other interrupts as=
 we=20
only use it to filter out page faults and nothing else.

Hope this helps,
Timur

> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
> >   2 files changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
> > 13bec8461cde..52258f1341c2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -437,9 +437,12 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device
> > *adev,>=20
> >   	uint32_t hash;
> >   =09
> >   	/* Stale retry fault if timestamp goes backward */
> >=20
> > -	if (amdgpu_ih_ts_after(timestamp, ih->processed_timestamp))
> > +	if (timestamp =3D=3D adev->gmc.processed_fault_timestamp ||
> > +		amdgpu_ih_ts_after(timestamp, adev-
>gmc.processed_fault_timestamp))
> >=20
> >   		return true;
> >=20
> > +	adev->gmc.processed_fault_timestamp =3D MAX(timestamp,
> > adev->gmc.processed_fault_timestamp); +
> >=20
> >   	/* If we don't have space left in the ring buffer return=20
immediately */
> >   	stamp =3D max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
> >   =09
> >   		AMDGPU_GMC_FAULT_TIMEOUT;
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h index
> > 676e3aaa1f27..77eb15380284 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > @@ -361,6 +361,7 @@ struct amdgpu_gmc {
> >=20
> >   	u64 noretry_flags;
> >   	u64 init_pte_flags;
> >=20
> > +	u64 processed_fault_timestamp;
> >=20
> >   	bool flush_tlb_needs_extra_type_0;
> >   	bool flush_tlb_needs_extra_type_2;




