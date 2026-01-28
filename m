Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636B4D25B4C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 12:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E0F10E6B9;
	Wed, 28 Jan 2026 12:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GiK4idKk";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F82410E6AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 12:15:02 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-43596062728so491390f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 04:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769602500; x=1770207300; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EG38pFgYHFmse9QO3EO0YAuSiyVhbofejs4VZvyDsQs=;
 b=GiK4idKkNHf1Jl4FLQGp9OWUs4m9YFg0gZ+oYjrXRR79EFy1DQUS3FuoGODG7jnCLn
 u8JQPirqHpr0rSIq8iy1qsoYVTvI0pHn/WMmeoVS6XesaEV+cXd6sqc2JfI+E8L4ZlKT
 9yE1JHKGTTbIEVTNR222+lVmSzLn9sMkvyBKyxRs0ht8st1hul40O4TTztT/OcnA7BHz
 gne/c7lRTXmY6FI9L9h6l+xc3AI1JfEJG3/pBbnj2FE3MHe7hgucfajNW+INjmEjGS/s
 8AjjyGM1UWsebrOxzcPVBnsFnxLdxZq949ksudPWU59a6RSYsrMNJbkyHI59/+3u0UI9
 +mUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769602500; x=1770207300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EG38pFgYHFmse9QO3EO0YAuSiyVhbofejs4VZvyDsQs=;
 b=fowI3g0ZflLYR8ni6caZ9Juk887l2VmsXnodgGdE6LF/8hxeh/49sRj+2ekj0e41KK
 pSEeEFxub+b9njMMlLPxQZj3E2E6VnuUqeYBldUeq/j5GjhOcYcvdTmovSPacI+J+0vc
 EoPYUqhWOdqTyHPctbXO1vqhCeLtfJLQCG2sXkbvA9W3SxBJT40JoUv9BA+cZ8hL4Noi
 Zoq3vOtoeCtcvs+ipyFzKm7yk6hoxzbs0k65NC8tJlOj6g7SEoh0lAfbbL0iPH0ISSl+
 /hTY2NdblMlmudRdF/9FOVvk5xEMwF2a0gPkVY9cyeUmctdHoX58dPngWPBjuzesqZpI
 vZ5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXodaHar4k8dbz4dAER84eIzGmlZQ0kZmOYC+AKI8QMeyg4bL/toHhGqkCBBL5I15HVUmmezWy3@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+QnE/KhtZSBtvJhrIT040UPenp6BdhmcqYKjvb9OG6zVbL+Z3
 4okjmkfCzp3RLN9FeHRZpVR+VEOU6cT9X/EC+dqIIINH9qkowenJOBo+
X-Gm-Gg: AZuq6aJcwVe+0Z8YDca6Kyx7Mc39972OxcsmMtf+RY1/+xs63wrTKWZSWhpvRd7kAuj
 BUiSgCcAda5Vj8ARd+L5dvdx7YuxyaTvlNpoEL92SbVFR56csow/OAUzPW81BcDuLUgZOWBRNQK
 II49OzgO7B8eoFcq13ZzIdrAFLgjogKe7wUR8CIvk6pvdUyqYPsiEaw1ZnOsX4DDUnktUO+RK0F
 +JBL7MxU7rHMbdzs5fmifVHjFn4JNry7pirJSbRYpXBxIoLEkztv/xFSxRndCGv01163lHhplso
 dx2a8hJcBLDUlc82qX+BKF54j9vaBLme/M/FowyMqtDiVQglNltnlkSyPVyLf4hGgQsYI5FrXMo
 9zzuuZwK8AtodeLwxQHvGbWIxaGipwKqU+fNVFnxWrVcnzNBtoHw7gNQguRCyH1uKk6DRo1tuIb
 8NcadFwHWyNrQJReH8ZPCzVXeEK2wK6Vu4SUwgLaHXY1rTQV/FxCFlMpW3Uqc=
X-Received: by 2002:a05:6000:2689:b0:431:8bf:f08c with SMTP id
 ffacd0b85a97d-435dd211888mr8047625f8f.21.1769602500162; 
 Wed, 28 Jan 2026 04:15:00 -0800 (PST)
Received: from timur-hyperion.localnet (5401DF8B.dsl.pool.telekom.hu.
 [84.1.223.139]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cf16sm6937398f8f.22.2026.01.28.04.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 04:14:59 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Hamza Mahfooz <someguy@effective-light.com>,
 Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Sunil Khatri <sunil.khatri@amd.com>, Ce Sun <cesun102@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Melissa Wen <mwen@igalia.com>,
 Michel =?UTF-8?B?RMOkbnplcg==?= <mdaenzer@redhat.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: introduce page_flip_timeout()
Date: Wed, 28 Jan 2026 13:14:58 +0100
Message-ID: <2203806.9o76ZdvQCi@timur-hyperion>
In-Reply-To: <f71df23e-f267-46b7-8fd8-4235e9a7a7fb@mailbox.org>
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <17cd6378-e3fa-419b-90d3-7e0549817110@amd.com>
 <f71df23e-f267-46b7-8fd8-4235e9a7a7fb@mailbox.org>
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

On Wednesday, January 28, 2026 12:26:20=E2=80=AFPM Central European Standar=
d Time=20
Michel D=C3=A4nzer wrote:
> On 1/28/26 11:39, Christian K=C3=B6nig wrote:
> > On 1/27/26 23:57, Alex Deucher wrote:
> >> On Tue, Jan 27, 2026 at 5:53=E2=80=AFPM Hamza Mahfooz
> >>=20
> >> <someguy@effective-light.com> wrote:
> >>> On Mon, Jan 26, 2026 at 09:20:55AM -0500, Alex Deucher wrote:
> >>>> I suspect just calling drm_crtc_send_vblank_event() here on the
> >>>> relevant crtcs would be enough.
> >>>=20
> >>> Seems like an interesting idea, though I would imagine we would still
> >>> want to attempt a reset (of some kind) assuming that the subsequent p=
age
> >>> flip also experiences a timeout.
> >>=20
> >> Is it actually a timeout or just missed interrupts?  I'm wondering if
> >> some power feature races with the modeset and causes the interrupt to
> >> get missed from time to time.
> >=20
> > That is my strong suspicion as well.
> >=20
> > Even if we missed a vblank interrupt that thing is reoccurring, so the
> > worst thing that can happen is that we delayed reporting back success by
> > one frame.
> >=20
> > So something must have turned the CRTC fully off.
>=20
> Not sure that's a generally valid conclusion (do the gitlab issues talk
> about the display going black, or about it staying on but freezing?).

In all the bug reports I've seen about page flip timeouts, and in all the=20
timeouts I've seen on my machine, the screen remains on, but frozen.
It doesn't go black and doesn't turn off.

Christian, why would the CRTC be turned off?

> AFAIR
> at least in some cases amdgpu uses a dedicated "page flip" interrupt
> instead of the vblank interrupt,

That matches what I saw when I was digging in the code.

> in which case missing a single interrupt
> could cause a timeout.
>=20
>=20
> P.S. Completing the atomic commit and sending the completion event must w=
ork
> even if user space turns off any CRTCs as part of the commit[0]. So your
> hypothesis would be a kernel bug, accidentally turning off the CRTC and/or
> not handling a CRTC getting turned off correctly.
>=20
> [0] If any CRTC for which the commit has state is off both before and aft=
er
> the commit though, the commit fails with an error before it could result =
in
> a timeout.




