Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A51BC02183
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 20:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA8710E7DA;
	Wed, 15 Jan 2025 20:37:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dorfdsl.de header.i=@dorfdsl.de header.b="0lr4qcwQ";
	dkim-atps=neutral
Received: from srv1.dorfdsl.de (srv1.dorfdsl.de [82.139.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A661010E7DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 20:37:15 +0000 (UTC)
Authentication-Results: srv1; none (SPF check N/A for local connections 
 -  client-ip=2a01:170:118f:5:769d:b986:18ec:4188; 
 helo=[IPv6:2a01:170:118f:5:769d:b986:18ec:4188]; 
 envelope-from=mm@dorfdsl.de; receiver=<UNKNOWN>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorfdsl.de;
 s=default; t=1736973312;
 bh=YyHZ1eQskzIsUha7Nv3kBXbEpHyvTxV6k/NBNF7yIIs=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=0lr4qcwQdsy1McXGUbLV06zs2g2whnTQTc6zSjd3znoFAHES35oQWURz1YBLpIWAe
 FtPxfp3gk7hm09wm9+cyQu6JjpTOUZEp5zC0LH3/zIPOWIWj7nyQ7hVjTdcDmGZdeB
 GeblNXYzkaRGmLsab+E0fTkLHx6dGFE3U0oUEdceTAC8M3346AuT0EhqcHTYk4KDt6
 1JEAoa8j864jpHd5P1Wz0l5yngwuE8NfbEglQVtGdlyby58kEqZQgFm+zIrixOwcK7
 9iVC978fugBxZ8u//oixd9fZGQz9d1/iu0CKtQjfBIi4Xr1zxKw+1oHBXlSNBm5CDS
 DF3V3ztej9ZJQ==
Received: from zbook ([IPv6:2a01:170:118f:5:769d:b986:18ec:4188])
 (authenticated bits=0)
 by srv1.dorfdsl.de (8.18.1/8.18.1/Debian-6~bpo12+1) with ESMTPSA id
 50FKZCjb239410
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 21:35:12 +0100
Date: Wed, 15 Jan 2025 21:35:11 +0100
From: Marco Moock <mm@dorfdsl.de>
To: amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu 100% CPU usage causing freeze 1002:15d8
Message-ID: <20250115213511.2feaa331@zbook>
In-Reply-To: <CADnq5_MY+cN0dPTis582HY0a80rNiO86kz9Ha=e=HS2Toim=4w@mail.gmail.com>
References: <20250114213157.19de9009@ryz.dorfdsl.de>
 <CADnq5_MFq-OWn7dwTTPPcBbFKQmBHvD6qCi8ngiVumk2V1U40g@mail.gmail.com>
 <20250115160834.033e8aad@ryz.dorfdsl.de>
 <20250115211039.09e6e69e@zbook>
 <CADnq5_MY+cN0dPTis582HY0a80rNiO86kz9Ha=e=HS2Toim=4w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Am Wed, 15 Jan 2025 15:27:00 -0500
schrieb Alex Deucher <alexdeucher@gmail.com>:

> On Wed, Jan 15, 2025 at 3:22=E2=80=AFPM Marco Moock <mm@dorfdsl.de> wrote:
> >
> > Am Wed, 15 Jan 2025 16:08:34 +0100
> > schrieb Marco Moock <mm@dorfdsl.de>:
> > =20
> > > I assume it was 6.12.6, but Debian doesn't have the old packages
> > > anymore and it has been purged from my system already. =20
> >
> > I've now tried 6.12.6, same situation.
> >
> > Any further ideas what could cause this? =20
>=20
> Can you provide more details about what you are seeing?  What does `ps
> aux` or `top` show as using all of the CPU time?

I saw
   2977 root      20   0       0      0      0 R  99,3   0,0   5:18.68
   kworker/u16:39+amdgpu-reset-dev =20

But the system is almost unusable, it takes seconds to print the
characters in terminal when connecting from a remote machine. Local,
the system doesn't care about keyboard anymore, except Sysrq.
Switching to another tty wasn't possible.

In some cases, even the sysrq keystroke won't be recognized and I need
to use the reset switch on the case.
