Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354F8D2ED12
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 14:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F1610E604;
	Tue, 20 Jan 2026 14:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lZayfKvh";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D97E110E5D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 12:47:11 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-64ce9d80429so684053a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 04:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768913230; x=1769518030; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=b2YlJZiAZT7kTnDMLrP5TooRkttJj7D7VhWFPs2HhFs=;
 b=lZayfKvhXOtv5qrQMJbtA2oaHbedmYmdycFlwn/PbO9pmNvE+37F3ynt6F7pfG3oAm
 eApjHJ7oXEzjLWGqMyMsWl4wK6w7EFVEatYItnwFhYtI92ubZc6anKpExy8uc4xrY18K
 +V5LO0qQyvGGUbExOY7Xl5EueyJgZ5AkfVnZ+B8vxZ2pc1WuDvJMfHy3JPdggE56VtW3
 YW9c4v3jem05j3hbt/t9tK4yaczCZ12WMCl3SX//CKHzqSzl5Y5wsMu3KU4qBbDM17gs
 x9csaPCLmVUZ4Y3w8ScFHXZzfSW5Px4GUadiV+Vyx4EUPky7EWLSYkjgK7fBfIMQ4ZOT
 XgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768913230; x=1769518030;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=b2YlJZiAZT7kTnDMLrP5TooRkttJj7D7VhWFPs2HhFs=;
 b=ZLMNLkCqIV0MhAdSucG9MkIRXVN6gl91hIkUiqvlneEstg9+fMkZEF92PQ5fyRXtrd
 MCstiwnTAozTSrFOk93urVCDgO2b+Vv61Rd3UsTKL+hA7h60aCMmAWeMZqHEXf5JAD21
 qDR2RkgsTv9oLttC5RXwyenlNFw+QnhxkXzEHSiJQTxSDeaTm+H72moJs80LeJMg/CMT
 lBJ/+6mr956TJiifQoewZ/ldd4JbgWtTGRLsLduStrLHBc6/Rap6P+uYzslRuZ2Uhdv+
 KT9EQ6JUZWAFIRlaseYkmpLwOGmX7SB5kHgCIPvZ8ghEw6gP1bzxU+tFoGTYVLSnwj3M
 5PnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSoVE017PL3XGWbqYF31PbstbmEPInQK+EdZHXZM2C9gEcWhJsFGxHiddF1GmAYRd/NwPxNPIS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGBZwwMGmnZdY7IAyd9l/qgktzAKqtl2igYQMnysyrXAvHtuY7
 54sTMywltZW107NlEDR/8lsL/pqm3MDYU62cf2WTmwecaYeVE4wSvZ/7
X-Gm-Gg: AZuq6aLkbP1pEcFFNZawfftpfuMpoNQkUaE/e6zsqqLsEvqhKc283xbR9s8MNJepqrZ
 QzwIEwN05DGS//3wCM1ZtnvIKn/fDMCVWLmokiy1MDFR5nxVJs1GEs7QSngMwAT72Foy/u8pJfn
 OSIsc4YBmTSbBQzi3lUKlwMAiHj4A3XjI72YFP5GLGfMnMYlWkRmN3EYYlRkj9rIwPmUdcrUiKA
 4BCnAcBygpD24i0hSEiNeKCJD4RNcN7AoWeCEcK1wmgyUK4jzGorWdxNQFJ/oDaLo0AIrYV6MI7
 UZmx+PBCugnr4J/2o6vClHo5XajuOtXNu4l+gsRrKbup/qpg0QByQB3oyaVCok35N+KFrZJC8hI
 qH9QUuZeyX+APLT50kIm3+zw0I+ijc1B1OOSKdvA1/+WNEzW/G09bSiZq15nU0NeH8StkEv3QCA
 9fSwOlZT/rOQBOE7iFz2avOLBAz9tM9hmkH2Ii/A3cctEo75DIZZ5Uwqavryz6cXpY3yEBjGStU
 NwB1mC5Gw==
X-Received: by 2002:a05:6402:27cf:b0:64d:4623:8475 with SMTP id
 4fb4d7f45d1cf-654524cf67cmr6634369a12.2.1768913229909; 
 Tue, 20 Jan 2026 04:47:09 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl.
 [87.205.5.123]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-658029e060asm1309600a12.21.2026.01.20.04.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 04:47:09 -0800 (PST)
Message-ID: <de91cf5d1e282f12cb902a9c4b87ed074338b71b.camel@gmail.com>
Subject: Re: [PATCH 15/17] drm/amd/display: Trigger ALLM if it's available
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, Daniel Stone
 <daniel@fooishbar.org>, Michel =?ISO-8859-1?Q?D=E4nzer?=
 <michel.daenzer@mailbox.org>
Cc: alexander.deucher@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com, 
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, bernhard.berger@gmail.com, 
 ville.syrjala@linux.intel.com
Date: Tue, 20 Jan 2026 13:47:06 +0100
In-Reply-To: <34863839c6d54e911597192bba6a54c3b9c97b75@intel.com>
References: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
 <20260119011146.62302-16-tomasz.pakula.oficjalny@gmail.com>
 <82645a06-2d15-48fe-a250-56d736d636da@mailbox.org>
 <CAPj87rPyt2+cWjM7KmpRzY4sBgaUzZBOS3FJoxF+PjkijapTag@mail.gmail.com>
 <34863839c6d54e911597192bba6a54c3b9c97b75@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 20 Jan 2026 14:32:27 +0000
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

On Tue, 2026-01-20 at 13:45 +0200, Jani Nikula wrote:
> On Tue, 20 Jan 2026, Daniel Stone <daniel@fooishbar.org> wrote:
> > Hi,
> >=20
> > On Tue, 20 Jan 2026 at 10:33, Michel D=C3=A4nzer <michel.daenzer@mailbo=
x.org> wrote:
> > > On 1/19/26 02:11, Tomasz Paku=C5=82a wrote:
> > > > [Why]
> > > > ALLM automatically puts TVs into low latency modes (gaming modes) w=
hich
> > > > we basically always want for PC use, be it gaming, or using precise
> > > > inputs like mice and keyboards.
> > >=20
> > > How about e.g. video playback though?
> > >=20
> > > It might make sense to let the Wayland compositor control this, e.g. =
via the Wayland content type hint protocol.
> >=20
> > Yes, I think this should be a connector property. We'll happily
> > implement support for Weston as the uAPI vehicle.
>=20
> Content type might be a useful policy hint also for content adaptive
> brightness control and the like.
>=20
> Ville and I have also tossed around ideas for passing the "power mode"
> to the DRM drivers (e.g. Performance, Balanced, Power Saver). There are
> various cases where the drivers need to make policy decisions that would
> be better decided by userspace. However, it gets complicated and
> unweildy if all of them are individual knobs. A power mode input might
> be useful in making the latency decisions too.
>=20
> BR,
> Jani.

Hmm, looking at the wp_content_type_v1 enum, I see it was probably based
on the CTA-861 Content Type information than can be supplied to the AVI
info frame? The values are identical. This surely could be plumbed into
drm_connector and basically directly set in the AVI info frame.

But, ALLM is something different and overrides the content type info. It
should be separate information, probably a simple switch to inform
drm_connector if it should be used. I don't know if ALLM setting should
always be exposed and let the drivers determine if it can be used, or
should it appear dynamically based on EDID though that's a consideration
for desktop environments.

In this case, ALLM of course would always take precedence and as far as
it's activation, it maybe would only be disabled when presenting
fullscreen photos/video? Content type notwithstanding.

Now, from a perspective of someone that actually uses PCs connected to
TVs and dip his toes into more TV topics, there should be a way to force
ALLM to be always on, no matter the content. I'd even advocate for it to
be the default because a long standing truth is that all the special
modes we have in our TVs and Monitors are garbage. They mess up the
picture, boost it to high heavens and some mode forcibly turn on motion-
smoothing.

With a PCs, we always expect the content to already be sent in high
quality, and even HTPC users prefer any post-process to be done on the
PC itself. Moreover, mode picture mode switching causes jarring
transitions and in same cases, toggling game mode can even blank a
screen for a moment, though it's rare.

We at least got Filmmaker mode as a crux, that often still need little
fine tuning, but doesn't make a mess of the picture. Oftentimes TVs will
detect PCs and disable most processing outright and content types can
have little to no effect. Again, like always with TVs, YMMV.

Game mode, sometimes merged with PC mode doesn't suck, and usually gives
the picture that's the closest to what the media actually is (be it
vide, HDR video, photo) and closest to selected color gamut standards
like bt.709, DCI-P3, bt.2020. In many ways, it will provide best picture
quality already, but maybe marketing departments wouldn't agree.

I can assure you, that as soon as the TV starts changing modes based on
the content, and there isn't a way to disable it, people will complain
hard.

All in all, if there will be a way to obtain all this information and
set appropriate info in AVI/HF-VSDB, then I'm sure it will be plumbed
through but for now, I think just having ALLM forced is a good idea.=20

Maybe, just maybe a property in sysfs/module setting could be used to
disable this if there's a big need.

There's another thing though. amdgpu already sets the IT content type
bit which already disables most if not all post-processing in sink
devices (or at least should). TVs often detect this as "PC" mode.
Sometimes ALLM is then needed to expose features like higher refresh
rate and VRR, thus the aforementioned mode change to update the exposed
EDID.

Oh, and ALLM only toggles the game mode if the game mode setting on the
TV is actually auto, with other values "off" and "on". It's just nice to
not have to manually turn it on.

Tomasz
