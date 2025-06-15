Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18418C71155
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 13:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CF010E3A0;
	Mon, 16 Jun 2025 13:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="PTpGEuVX";
	dkim-atps=neutral
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B7A10E20E
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Jun 2025 09:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1749981101; x=1750240301;
 bh=VJQgMpmHTeeoZYrCQy+SA7PdH5AFlipJ6dsXxWqLrnI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=PTpGEuVXHr7xXmdIXTIXZYb7XZuWdVNyS1e0muJoyjHuD0mpLi5IMyHuEJFRv4laI
 XSM6504PGt70uT8HOZTp+xPE0hAM5Gn9fvglOs/zygP257Z5sdpNHt/54tlIEE+IpE
 3vpSeH25TUF/P3g24Tu6E+6Xo1rTedGgGtkQZxpfq78MOKpYQUttq0bUm6ihcKrmvG
 E2d5ibhUnO7QEp1mN25tjWjZKPAczSBPM7NU5eaKlR4v26SKtBqSuUJ/AWhtfLvIrh
 Zki46fdjeUUEmpd8T6rQ0bsSxZJM9bJtEvpFSFsh4WFoZSIBA/Ml93wtZpkdD3P6cq
 oxigjPy2gwHog==
Date: Sun, 15 Jun 2025 09:51:37 +0000
To: Alex Deucher <alexdeucher@gmail.com>
From: SyntheticBird <syntheticbirdxmr@protonmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: drm/amdgpu: AMDGPU unusable since 6.12.1 and it looks like no one
 cares.
Message-ID: <gE19BlFWNv1spLRDzd5---KtXkBEYRKTKFR-R2YSWJ4rBnQG8R_Gaeqh56sFHvTc-QlLLPc-rYgKCJSCgxsTlKUhJ-zGovqmZq7BnjVlZTw=@protonmail.com>
In-Reply-To: <CADnq5_MoZ7W0pf2BFx7Rs2e+6YyJNO2KBCfjjnrkv-+hKNqduA@mail.gmail.com>
References: <o93Aruut7VI05oqVX7Se1udr5FAyqfyP_TGDutW0p2fXBSkRv7QkhpLmAT-buTpdWIwn8PnC8B2DNSMtaTp5kk00ZtK653PDLuK14uoUI4k=@protonmail.com>
 <CADnq5_PatAYdyKGVJpX5TrVJ451Ga9PJjCx85jna+CUxsaFAhA@mail.gmail.com>
 <8o8j5o9K-GIowaV5BW0uUds5QSczbsDlObPMAEUyGjPMV1G2tq-3sdYaQwbZHt_d4p-9sqBe5OnsUkkbS2gb6eZT1d5KiOXyTdz3vy75_V8=@protonmail.com>
 <EefQ4XqoUhDVKwtzYbP7Cwv1m6p8brSTBJzVQeojHh8X688L3QdBfGkakTuU0yf3lWfne5Bhcj90MXHhB9nblEqobkXeWvluAnwrplGkH2A=@protonmail.com>
 <CADnq5_MoZ7W0pf2BFx7Rs2e+6YyJNO2KBCfjjnrkv-+hKNqduA@mail.gmail.com>
Feedback-ID: 130782727:user:proton
X-Pm-Message-ID: 07997c61df64830737079e4a10468aa82d53229e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 16 Jun 2025 13:10:04 +0000
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

Dear Alex,

The situation is more than concerning and my frustration, as well as others=
, is growing.

https://gitlab.freedesktop.org/drm/amd/-/issues/3787
https://gitlab.freedesktop.org/drm/amd/-/issues/2950

There has been a hundred of reports on gitlab, I can find more on reddit, t=
ech1level forum, phoronix forum, I got confirmation by some folks on Matrix=
 that are staying in 6.1 and are starting to mock the amdgpu driver. I've s=
een features after features being merged in amdgpu yet people are laughing =
in forum, at how bugs are not fixed. On reddit, some users decided to go ba=
ck on Windows because of it.

There has been 4 bisection attempts so far, that led to no result, and (I'm=
 in part at fault here for having used an experimental filesystem with majo=
r version changes). There are people that managed to grasp debug infos befo=
re the timeout.

In two months, this significant issue will be a year old.=20

I do not understand, how you guys are not hitting it/trying to bisect it. A=
re you not keeping your machine up for more than 30 sec.
With the immense spectrum of hardware concerned, I cannot believe that you =
guys are immune to this. And I cannot believe that you guys are letting thi=
s rot.

Right now, only a minority is managing to recover their session after a few=
 minutes. Some people are able to get away with it by enabling the debug fl=
ag, but this only work for some people and there are no guarantees that it =
will last long.=20

Please,
It's time to forget trying to pass the hotball and get a maintainer investi=
gate and fix this before it gets too late. If we let it rot another year, n=
o one will be able to bisect it because distros and hardware will make use =
of recent versions only.
