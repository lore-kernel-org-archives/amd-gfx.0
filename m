Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4493CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 18:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8353010E0F2;
	Fri, 19 Jun 2026 18:18:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="en03z8oa";
	dkim-atps=neutral
X-Greylist: delayed 1946 seconds by postgrey-1.36 at gabe;
 Fri, 19 Jun 2026 18:18:14 UTC
Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch
 [109.224.244.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5830410E0F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 18:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1781893092; x=1782152292;
 bh=9MoLvimzx+bSftmBe7LQLFHvrzzoKgLDqPHsYoCjrDY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=en03z8oa8eMmu4gqdQzg+6vlFAC1Vba2hIaJfnJ1mDyg069z0eMdJLhvllmN/mbLc
 dGjQY1m/ceqZywCujp2N7IuSrhaIoXKssV+bdgy1/hVimU9Tut2SZX0YW3W2dUDN7y
 QHxQSLe8A4e9kK/gaPvO4+ucdvA4rpV4fsU32F4f0p77s0KcW/dpY8OP31fzUtCCtV
 9qThTPQe0y7Eq3zMfxMdVhOdJSbUVhw3Isltihz1IN/JPFCEEqA14cMOIGP5vpcpHq
 f4IRjTUCpXXTXo8X8c6uK6fP7ozM/4BGlWb10loDuuU99e8YF1gTTY4eM4GfB7iGHs
 pZbYKtavDZNuQ==
Date: Fri, 19 Jun 2026 18:18:07 +0000
To: Alex Deucher <alexdeucher@gmail.com>
From: Matthew Jacob <feralmatt@pm.me>
Cc: Christian Koenig <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: support a couple of extra BARCO graphics
 adapters
Message-ID: <_wGLMSmA5KwXMOdJR9DMYYcrBGyWjl_lFPeCksAOJyOgTvqj_3yZOanviNEGgUKz2_z0RfvkZbU7hSjN_4iRXdwn3J5NtEQBIASG3v-hvM8=@pm.me>
In-Reply-To: <CADnq5_M+A0C6cQmkwG3Kt_AOQEgxB9+iGaq8E8p-XPnKakMLpg@mail.gmail.com>
References: <kb82H17fFzuBQ-ZxQz8SJqF6DPycZtYEc7XvSWxR0nww24pZJTnkYUU_d8bbJpqC34uGL7IhIPFznw4nMYtzozBZCxxTWBgjjA3gTdR49Fc=@pm.me>
 <CADnq5_M+A0C6cQmkwG3Kt_AOQEgxB9+iGaq8E8p-XPnKakMLpg@mail.gmail.com>
Feedback-ID: 169730088:user:proton
X-Pm-Message-ID: c39596485f41abb62771a9a9e25becff18ee8305
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Yeah, sorry. Let me figure out how to do that



Wizard, 3rd Class

Sent with Proton Mail secure email.

On Friday, June 19th, 2026 at 11:15, Alex Deucher <alexdeucher@gmail.com> w=
rote:

> On Fri, Jun 19, 2026 at 1:54=E2=80=AFPM Matthew Jacob <feralmatt@pm.me> w=
rote:
> >
> >
> >
> > BARCO produces its own adapters using AMD chipsets. Mostly they are use=
d on Windows platforms for radiology PACS review workstations. They don't w=
ant to spend resources to support Linux. Working with them unofficially joi=
ntly with Kaiser who is experimenting with Linux as an alternate platform I=
 got some patches to support some of the cards that Kaiser has in its fleet=
s in several regions. Neither Kaiser nor BARCO have any objection to inclus=
ion of these changes in Linux.
> >
> > Changes attached.
> >
>=20
> So you can retain authorship, can you send this as a proper git patch
> with your signed-off-by?
>=20
> Thanks,
>=20
> Alex
> 
