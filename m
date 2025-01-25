Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A791BC0218C
	for <amd-gfx@archiver.kernel.org>; Sat, 25 Jan 2025 18:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C8B710E032;
	Sat, 25 Jan 2025 18:38:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dorfdsl.de header.i=@dorfdsl.de header.b="85Otb+FF";
	dkim-atps=neutral
Received: from srv1.dorfdsl.de (srv1.dorfdsl.de [82.139.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7248210E032
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Jan 2025 18:38:41 +0000 (UTC)
Authentication-Results: srv1; none (SPF check N/A for local connections 
 -  client-ip=2a01:170:118f:2:9a32:bb9c:ccbb:f9c5; 
 helo=[IPv6:2a01:170:118f:2:9a32:bb9c:ccbb:f9c5]; 
 envelope-from=mm@dorfdsl.de; receiver=<UNKNOWN>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorfdsl.de;
 s=default; t=1737830318;
 bh=7BaFUcABcNB48eYufZKe9ZXjf8MWDZn8wa2r6hRaMrU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=85Otb+FFOh9KA0J9suGVT4gZpe3WPlbYViRRz2quKe2izCw9XQpM7FrmBuTDqGkpV
 2qVTwh+AfbM7gAWcFyMNTuqvu/FZ3dJrDE0f+jnasLw3713g9Dz4wN6ePYovQ+tiiy
 i0EvDh7n2w4PIH9biQjPI/VYcoeUfHq4iFWMBFrYZSKgvamt2V3hzqC62uUuxS3OY6
 r7Oa/eK9OIZ5UnLifPCyOKbccKryJogDNBNzUNgeoPdq4n7eHB1LRk4qaMDQUE4tTM
 3jU+w56RQI1PXOv1GJNHRNFyYpJlY7q6dCX8itmR8v/fHLHNI9loC37yVJYX0VrAnm
 1ZYgRg4F3OmQw==
Received: from ryz.dorfdsl.de ([IPv6:2a01:170:118f:2:9a32:bb9c:ccbb:f9c5])
 (authenticated bits=0)
 by srv1.dorfdsl.de (8.18.1/8.18.1/Debian-6~bpo12+1) with ESMTPSA id
 50PIcbVA020673
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 25 Jan 2025 19:38:38 +0100
Date: Sat, 25 Jan 2025 19:38:37 +0100
From: Marco Moock <mm@dorfdsl.de>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu 100% CPU usage causing freeze 1002:15d8
Message-ID: <20250125193837.373438f7@ryz.dorfdsl.de>
In-Reply-To: <CADnq5_PwhCK0DfUrEgmdpoFmcBcS-FobGf8p20fSDHOrPTFrNg@mail.gmail.com>
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
 <20250124110225.6a0a87ad@ryz.dorfdsl.de>
 <CADnq5_PwhCK0DfUrEgmdpoFmcBcS-FobGf8p20fSDHOrPTFrNg@mail.gmail.com>
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

Am 24.01.2025 um 16:40:37 Uhr schrieb Alex Deucher:

> On Fri, Jan 24, 2025 at 9:17=E2=80=AFAM Marco Moock <mm@dorfdsl.de> wrote:
> >
> > Am 20.01.2025 um 11:35:07 Uhr schrieb Alex Deucher:
> > =20
> > > On Thu, Jan 16, 2025 at 11:57=E2=80=AFAM Marco Moock <mm@dorfdsl.de>
> > > wrote: =20
> > > >
> > > > Am 16.01.2025 um 11:32:42 Uhr schrieb Alex Deucher:
> > > > =20
> > > > > I'd like to see the driver messages leading up to that. =20
> > > >
> > > > I've now attached the entire dmesg without the firewall stuff. =20
> > >
> > > Does the attached test patch help? =20
> >
> > I've now compiled a kernel with the patch.
> > It doesn't change the freeze problem. =20
>=20
> Thanks,
>=20
> Does setting amdgpu.ppfeaturemask=3D0xfff73fff on the kernel command
> line in grub help?

No crash anymore.


--=20
Gru=C3=9F
Marco

Send unsolicited bulk mail to 1737733237muell@cartoonies.org
