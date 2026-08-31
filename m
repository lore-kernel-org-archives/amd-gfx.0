Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D27C61DE2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 12:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF1B10E5FB;
	Mon, 31 Aug 2026 12:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TAaFbFcY";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 233E110E5FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 12:30:26 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c2544ff970dso528065066b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 05:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788179424; x=1788784224; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pu6v/vKXFSzBGOHkpi9yehC8QJv9s7y6zhz5gCJXY+g=;
 b=TAaFbFcYe8Q6Jv9lvPNfna26qGSM6Z5MWu8g/fQkbtE9wtuSFjXOIF6sdjjpVp5YBq
 CwYrjxP8OihdfA8RjR0AkyYvF3Ez7fekJQGnsdUe4W6BcrCyZnLDHOCNknUMc0iBOHPB
 ubJWcYjLwkTPpfmtxVhIkc5uJ5qydOB8d5djYzLDHh5hvbO9MovY8wjwGE/9+tSmFd6e
 Yo8GAtfvS/8/gjIn7bWoACBJRvRI0pYyuWrCiCee5EW8nFFMThkxgErMwkfFL4FRzk9S
 2agZGegrkyqDuAkQ/AnwAkAUK01fN2hvzwNRhHLcGkkHCnaRaCliB9H+ecR5f0/uYbOM
 jglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788179424; x=1788784224;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pu6v/vKXFSzBGOHkpi9yehC8QJv9s7y6zhz5gCJXY+g=;
 b=O2tKmhxjZ5ZMi1mpxRGHRxJuiakN/begCCv1AOOfAKAK24h054zyk8BlV6J3pP2+1t
 w4oz/s8DPFjsKH65JFDFZyf0j7oEkiszie3WHmdyqTUFybCtzXYft1r5YMJvVSC1Z0X4
 BYvl6sOA498ErjA8e5DSqWZxhbC+Gg9C94yIWBKRVWhr+eiVxLEbBcGUnheJiFO/juY+
 AceSOv2m7CCZMvKznSRf4ibeOYn7oXDbKfCXiLYb6wFmNFOdxHdIvGG2xJRSf3t7FLCg
 ykbj4J2rbQD4Bv4VVXwE9h+cuZqK7YvVVwpjeMvghTttSXI59XxcRJeQBfo9T2+2y9VX
 ahvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcihR/PR9TJ9tK707yoY5qLVIVYf0Nn2pNIEKo8HnSTnpP+Di3Y1/aGqulpSVQfN0z0ZXffW6Y@lists.freedesktop.org
X-Gm-Message-State: AFuF++k1K9+Q/t/LzbxDKu5HE/1H1sR6ORIS2YXgI0eUtQQvUaefElDL
 y4gOe2+d+Zi4lO58YGWMp/xUChqUxtEm0MPd78Hqu5b9KIi0QEDrN03R
X-Gm-Gg: AR+sD10V7hAKQrXW76ErxgWnnSsTSJvCHpUCzqayo9UWv2wogw6HKlLKYnGr+f3kRLZ
 c3lE8usQGbsI35ZCTVhdGxDRrz+XhK0eOpIkuu7NGqJ7Un6YPDzSpeGvBj4tkh4bWY0EEElJaNP
 PTMTlcJxgN4b0PDdKjpAugiWrbinVIgGfNlIFRhkCFQMUkjPTGT46PtimxkwyMXU2NiIleZ30Kx
 BzI5RGr3PJgNKxeWiTCy1rbcgNSd3FLaf7VW8v5TNc3DZg99k8AuxzSjm2aLURCEPpgN1JOvwyD
 dFO7lyz5KGz5+ir624cn33L+Aw/gnzV693OOdlb9Ihyo5od+fvoc0ZVPXktcLg9GSvVUh0b9nrs
 4xN8XCG+zcVU2LhWIKfmVWO1WObwi7Dr2DoibzChLYU1BnZlL2p05guOoFM83YvCuMUISxmY0ZN
 2KiK8uNguIPb6JzecQJz0s4tOB6YP12c6CVmtls95LBkAqcAmTmUTgLku9a/6ZheU1LHXUkyU9W
 fUd7Pdk/z9/6LL1UaoSjxdnaIz9+3Ye4xsO
X-Received: by 2002:a17:906:7947:b0:c25:4ba1:5953 with SMTP id
 a640c23a62f3a-c255702dfb5mr1707153566b.11.1788179423981; 
 Mon, 31 Aug 2026 05:30:23 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B9A5E.dsl.pool.telekom.hu.
 [94.27.154.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25895beeb8sm225045566b.31.2026.08.31.05.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 05:30:23 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: skip the VMID 0 flush for VRAM
 clear-on-release
Date: Mon, 31 Aug 2026 14:30:20 +0200
Message-ID: <UJ9MXKXkSh6txd43wHcgSg@gmail.com>
In-Reply-To: <03347904-e0ee-42ef-a40a-478309a2ba33@amd.com>
References: <20260828044734.135460-1-Arunpravin.PaneerSelvam@amd.com>
 <voa7PnOgTa6oSIPH4Hu9jQ@gmail.com>
 <03347904-e0ee-42ef-a40a-478309a2ba33@amd.com>
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

On Monday, August 31, 2026 2:13:47=E2=80=AFPM Central European Summer Time =
Christian=20
K=C3=B6nig wrote:
> On 8/31/26 13:39, Timur Krist=C3=B3f wrote:
> > On 2026. augusztus 28., p=C3=A9ntek 6:47:34 k=C3=B6z=C3=A9p-eur=C3=B3pa=
i ny=C3=A1ri id=C5=91 Arunpravin
> >=20
> > Paneer Selvam wrote:
> >> Clear-on-release only runs on VRAM, which amdgpu_ttm_map_buffer() reac=
hes
> >> via its direct MC address without programming a GART window, yet the w=
ipe
> >> still forces a VMID 0 flush.
> >=20
> > Makes sense.
> > We don't need the VM flush when we are not changing the page tables.
> >=20
> > I agree with the patch, just would like to ask a few questions to better
> >=20
> > understand the underlying problem:
> >> On GFX11 (e.g. Navi33) that spurious SDMA
> >> flush can wedge the engine
> >=20
> > What is happening when the SDMA engine is wedged?
>=20
> As far as Arun has investigate the UTCL1 request queue (which is part of =
the
> memory interface of the SDMA) is in a deadlock, but we haven't quite
> figured out why yet.

> > Can it be recovered by an
> > SDMA queue reset?
>=20
> Most likely no. The UTCL1 is the translation and memory request queue
> between SDMA and the core memory hub. To reset that one you need to reset
> both ends and the core memory hub usually needs a full ASIC reset for tha=
t.

I see. That's very unfortunate.

> > Is it just a hang, or can it cause other issues such as page faults?
>=20
> Good question we honestly don't know at this point. The HW guys need to f=
ind
> the root cause first.

> >> only flush when a GART window is actually used.
> >=20
> > Does that mean that there is still a risk of the wedge when the GART
> > windows are used?
>=20
> Yes, and that is actually not limited to the GART windows. It looks like
> every time we map something into any VM it can happen that the SDMA crash=
es
> when there are concurrent operations ongoing.

Would it help to set
adev->vm_manager.concurrent_flush =3D false
until the problem is figured out?
Or can the crash also happen when the VM is not concurrently flushed?

By the way, is this the same issue as the Navi 1 sdma_invalidation_workarou=
nd=20
or is that completely different?

> It's just that the GART flushes triggered by the SDMA made that scenario
> much more likely than anything else.
> > Can you remind me when/why we need the GART windows exactly?
>=20
> Basically every time we want to copy something from system memory to VRAM
> with the kernel.

Understood. Thanks for explaining!

Best regards,
Timur


>=20
> >> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> >> Cc: stable@vger.kernel.org
> >> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.c=
om>
> >=20
> > Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >=20



