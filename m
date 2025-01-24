Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BD8C02181
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 10:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16BB710E93E;
	Fri, 24 Jan 2025 10:02:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dorfdsl.de header.i=@dorfdsl.de header.b="73PP78w4";
	dkim-atps=neutral
Received: from srv1.dorfdsl.de (srv1.dorfdsl.de [82.139.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 826CD10E93E
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 10:02:52 +0000 (UTC)
Authentication-Results: srv1; none (SPF check N/A for local connections 
 -  client-ip=2a01:170:118f:2:8c1:6d7e:9067:8c91; 
 helo=[IPv6:2a01:170:118f:2:8c1:6d7e:9067:8c91]; 
 envelope-from=mm@dorfdsl.de; receiver=<UNKNOWN>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorfdsl.de;
 s=default; t=1737712971;
 bh=vLv6QC4vv+e4HU6eXicTBvj3mUwqiJVVjksGDt4498Q=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=73PP78w4tL5OEKBLxSAM8OKcIAF4o2jO8c1AXq3xpoPkDKKonTPE/n1xie615oVPO
 ELgkejhmJKFAZWvWsV3DUn+uQEo+XEIGzLo10XuROQNmxuITzUgKC/JcZvg105jO5w
 PQ10Q2raYXT+ha/gZ52IKJnkGmv7kw9UdjMuO03KnUvhQXotuKY2Q3K4HJodAR/YM9
 tqI+8G/qffcnZnEWcvTnfOqrruSVEZXBgYhX2Hb3pTqQ/C3QbI04Z3pEB1o0TA0Csj
 gNH2UVPctUDzmR2uBxRQHXkMxTzunBhCkJ3A28jAlfvHUWaoTO1pY5W/MyKjusRC+W
 cmCErTLxKOxBw==
Received: from ryz.dorfdsl.de ([IPv6:2a01:170:118f:2:8c1:6d7e:9067:8c91])
 (authenticated bits=0)
 by srv1.dorfdsl.de (8.18.1/8.18.1/Debian-6~bpo12+1) with ESMTPSA id
 50OA2ouY003234
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 11:02:51 +0100
Date: Fri, 24 Jan 2025 11:02:50 +0100
From: Marco Moock <mm@dorfdsl.de>
To: amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu 100% CPU usage causing freeze 1002:15d8
Message-ID: <20250124110250.6139a8bb@ryz.dorfdsl.de>
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
> > =20
> > > I'd like to see the driver messages leading up to that. =20
> >
> > I've now attached the entire dmesg without the firewall stuff. =20
>=20
> Does the attached test patch help?

I've now compiled a kernel with the patch.
It doesn't change the freeze problem.

As the file is too big for the list, I've uploaded it here.
https://dorfdsl.de/dmesg-neu.txt
