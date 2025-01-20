Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26925C02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 19:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B1AA10E47C;
	Mon, 20 Jan 2025 19:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dorfdsl.de header.i=@dorfdsl.de header.b="W6jOnhjf";
	dkim-atps=neutral
Received: from srv1.dorfdsl.de (srv1.dorfdsl.de [82.139.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1DDB10E47C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 19:46:33 +0000 (UTC)
Authentication-Results: srv1; none (SPF check N/A for local connections 
 -  client-ip=2a01:170:118f:2:ff15:8f86:7746:f11f; 
 helo=[IPv6:2a01:170:118f:2:ff15:8f86:7746:f11f]; 
 envelope-from=mm@dorfdsl.de; receiver=<UNKNOWN>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorfdsl.de;
 s=default; t=1737402269;
 bh=6TNgDDCy/A2623UolwrGUpUzGQSPZZ46Upg47tOkp6Y=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=W6jOnhjfoklbotG3+FnxlYgwUpfKyv1SUZI5OD3BqZxFhJtQM5ijhHGGS2K4yDVqx
 yAUFDKs+r/na8ztQWmVkvmY+GXdsnJsMF0U8ORi15/MguBXOjh8zgDaJLA1Kr8VVnK
 hZz6ajUGJAQIJ9V301+ykNJXzYxKYdm1WsGXrSQJhNId1nxb+84HFPFnI8mOE3RCpl
 SzBS6bIyIP3K16vAyZuFHeJqvbND3a5onD3zwnB4MuaY7OiVjZc2kt8H5W3nFCKiiK
 gPM/a51v/HROcLHZudIH8fthc/95tHrFY7ROtmCzACqIQb+Tc9Oro7AFNU72uUCjJU
 cDSRvP8TmjDZw==
Received: from ryz.dorfdsl.de ([IPv6:2a01:170:118f:2:ff15:8f86:7746:f11f])
 (authenticated bits=0)
 by srv1.dorfdsl.de (8.18.1/8.18.1/Debian-6~bpo12+1) with ESMTPSA id
 50KJiScp295898
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 20:44:29 +0100
Date: Mon, 20 Jan 2025 20:44:28 +0100
From: Marco Moock <mm@dorfdsl.de>
To: amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu 100% CPU usage causing freeze 1002:15d8
Message-ID: <20250120204428.2bc7b3e6@ryz.dorfdsl.de>
In-Reply-To: <CADnq5_O_WcZJ7yoDKEJpktSqffbP8RENhChmkD8Es7NHRYhCAg@mail.gmail.com>
References: <20250114213157.19de9009@ryz.dorfdsl.de>
 <CADnq5_MFq-OWn7dwTTPPcBbFKQmBHvD6qCi8ngiVumk2V1U40g@mail.gmail.com>
 <20250115160834.033e8aad@ryz.dorfdsl.de>
 <20250115211039.09e6e69e@zbook>
 <CADnq5_MY+cN0dPTis582HY0a80rNiO86kz9Ha=e=HS2Toim=4w@mail.gmail.com>
 <20250115213511.2feaa331@zbook>
 <CADnq5_MbeTRb642qwb0Q7JbL=2UsnK6RnLm6NWTeVLZOEuyn4A@mail.gmail.com>
 <20250116172916.0dba9ff6@ryz.dorfdsl.de>
 <CADnq5_NU-stpay1uFHXD9fVemg4snyE-eZZ4rfyg2Mc3x2OLyg@mail.gmail.com>
 <20250116173734.256704ca@ryz.dorfdsl.de>
 <CADnq5_O_WcZJ7yoDKEJpktSqffbP8RENhChmkD8Es7NHRYhCAg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
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

Am 20.01.2025 um 11:35:07 Uhr schrieb Alex Deucher:

> On Thu, Jan 16, 2025 at 11:57=E2=80=AFAM Marco Moock <mm@dorfdsl.de> wrot=
e:
> >
> > Am 16.01.2025 um 11:32:42 Uhr schrieb Alex Deucher:
> >
> > > I'd like to see the driver messages leading up to that.
> >
> > I've now attached the entire dmesg without the firewall stuff.
>=20
> Does the attached test patch help?

Is there a simple way to compile just the module and install it in a
"safe" way?
I haven't compiled kernels yet and don't know how far that could
destroy my installed system.

If that is too risky, I will set up another on a second disk.

--=20
Gru=C3=9F
Marco
