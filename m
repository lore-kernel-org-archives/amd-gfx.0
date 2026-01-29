Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9109BD61006
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 11:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA3F010E327;
	Thu, 29 Jan 2026 11:25:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hMV5RgLu";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1BE510E327
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 11:25:48 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso3863585e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 03:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769685947; x=1770290747; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ouo/mg65aOcXSM62YmotwBXBKDEb8Yzi3FDBO7jCaMY=;
 b=hMV5RgLu5DfVna3ybsrfuHgWttd+JnMg0cB1oagGKfRb4cxPRhYo+GY7fNDcNBfdXA
 ZluEcM4mReKVX7ysbo+1GjGD7nzcbG120H6bPvVQ/a0dzZYk7hTNvR86jOne6Hg1gqAL
 TttNhEZkxla7SOTVC/zqz5k/IMDeCRgH/gusgXfgxZ7FxKB0TNLvvlQYQQuZMR4yEWhk
 x+pkpTXsaluWzD7EYj4zzBkw0EUvcqRhbTTMdbJKrUuVwdNCzZt8kxDwd2P71Fnj9ITy
 FdHSWx0vdReGD20sM5ixNr7S2VODpkLlf5hXMZd7UXdk3klRaJ2ljrxn75DbEr4Oki3M
 OXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769685947; x=1770290747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ouo/mg65aOcXSM62YmotwBXBKDEb8Yzi3FDBO7jCaMY=;
 b=VCM12vSXlO+T2vNkN5w9hfi0Ol1cS6QIq2E6nRFfhdJ8OE5Sy5yJlwDjM1gwYasFwG
 pacgFXnTTlZhDblqispwXVldgWwFTywiaw57Ih5ACU7ruHXiUgHadqWsUaoc0/nia4wv
 en6NRcRDdU5PmdmzmgisX5ypiH6aZCYwj9o2uxB6qU3rD+gNRsEXADGpkNCRmX4bRzN+
 7X522+0jEF9mSoBqcAjQp8ihui9Ehu9MQ5yBg/NoaUw5xYgB1l/HGsrP0P+BBaU3Xb4p
 fkYrJaRAeFHIi1rk0pEeJaWQnQMLyE3n93c9QuDBcsgJIYxRNG02Zsu4vzXlLviVLZal
 f3fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEGQ83k7Jyg9TdVeZ91PN44AyZpJyLXT+NHouYz+S4S0tWMYiQ/5q/fNI55z+B0CNgcvHH4kpR@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3tYzLDeBSadGeZgHLH6cw5QrOAgzRnNsR3htnKYLZRkWxX3Nh
 z3Mg5GZQXDDyk5oMmZJ/CwxbwIV3YcmN9vTfjO1pnPqvI12WHIO9Fs3p
X-Gm-Gg: AZuq6aJk8bKYrahO2+b6AyvWyoGN33//3mvDXdo2fmm0l2Vu6BkTYQSzmQ5REyGcE9/
 3j3M0IypQWDTcnWHwrl4o4v1w4GiwC6qzJ+dAnVnUqpeR7NDZQLRGyPChqQUt37r97y6PG916bl
 3Lym+7SLuWSA9234Xnn9jaF8nKDRAxO1N34OXJOuZtculubPbOhF0WlsMmRBjORyupu1crro3uN
 MYM5NnACpb7AnkcqmPt7x+1k93q6HVlqjb7TmPvnrXgzt6D5liSPdLuVmVVlykBiOzfWUghpV/p
 WnN9/VG/rsinpsuBKY2eicOx7TiQ3lFyHcqX2d466GaEouReuRayJvdJOhhmtYisodbT0VyNLit
 6WvgzdJN6YLArxr3VX1Eet5n6mT0cHm3m0tyL6R7PrR0e0fGt4nmNljPQ1IXFqeXywFz7cKylXn
 SvVYMj7OBiY1gX9oxu6l+rRFbFGWUiM6J2DZZQo5eLCObnSQdus25PyBQpgWI=
X-Received: by 2002:a05:600c:4e8b:b0:480:1b65:b741 with SMTP id
 5b1f17b1804b1-48069c4ae9cmr98553855e9.15.1769685946522; 
 Thu, 29 Jan 2026 03:25:46 -0800 (PST)
Received: from timur-hyperion.localnet (5401DF8B.dsl.pool.telekom.hu.
 [84.1.223.139]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cddffc0sm151978565e9.5.2026.01.29.03.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 03:25:45 -0800 (PST)
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
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: introduce page_flip_timeout()
Date: Thu, 29 Jan 2026 12:25:44 +0100
Message-ID: <2719069.vYhyI6sBWr@timur-hyperion>
In-Reply-To: <6f1239d2-eec3-40b6-aca7-5b278350dd04@mailbox.org>
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <ab52825d-8f26-4b52-af5d-4051760b2aa4@mailbox.org>
 <6f1239d2-eec3-40b6-aca7-5b278350dd04@mailbox.org>
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

On Thursday, January 29, 2026 11:06:11=E2=80=AFAM Central European Standard=
 Time=20
Michel D=C3=A4nzer wrote:
> >>>=20
> >>> Christian, why would the CRTC be turned off?
> >>=20
> >> Exactly that's the question we need to answer.
> >>=20
> >> But from what you describe the CRTC keeps on, just doesn't send any mo=
re
> >> vblank events.>=20
> > The vblank interrupt source getting accidentally disabled might be one
> > possible cause though.
> Another possibility is that test-only commits with the
> DRM_MODE_ATOMIC_TEST_ONLY flag (which can happen in parallel while the
> kernel is processing a "real" commit) accidentally have side effects on t=
he
> current kernel state, resulting in the "real" commit failing to do
> something it should. There have been bugs like that in the amdgpu DM code
> before.
>=20
>=20
> Anyway, this is all speculation. Somebody just needs to dig in and get to
> the bottom of why the commits aren't getting completed.

Yes, I agree.

However, just like we do with ring timeouts, we also need to be prepared fo=
r=20
the situation where a page flip timeout happens and we should try to recove=
r=20
from it. And if it isn't recoverable, fall back to GPU reset.

I strongly suspect that there are many different issues depending on the=20
hardware generation and display configuration. There isn't going to be a si=
lver=20
bullet to fix all of them, and in case it cannot be fixed, I think a GPU re=
set=20
is the right thing to do - it's drastic, but still better than letting the=
=20
machine just freeze irrecoverably.

One example of such a bug was fixed by 6cbe6e072c5d where DC was trying to =
use=20
an interrupt that didn't exist on some hardware. This type of bug would be=
=20
impossible for userspace to solve in any way, but a GPU reset would have=20
helped to recover the machine into a usable state.

Another example would be Strix Halo with adaptive sync and/or tearing updat=
es=20
enabled, which 100% reproduces a page flip timeout for me. I haven't had ti=
me=20
to investigate that one just yet.

Timur


