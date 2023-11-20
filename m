Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61713C61D93
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 00:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE6510E216;
	Tue, 21 Nov 2023 00:59:16 +0000 (UTC)
X-Greylist: delayed 1945 seconds by postgrey-1.36 at gabe;
 Mon, 20 Nov 2023 22:40:59 UTC
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D52B10E1FD;
 Mon, 20 Nov 2023 22:40:59 +0000 (UTC)
Received: by vps.thesusis.net (Postfix, from userid 1000)
 id 4203E149C71; Mon, 20 Nov 2023 17:40:58 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Alex Deucher <alexdeucher@gmail.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: Re: Radeon regression in 6.6 kernel
In-Reply-To: <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
References: <87edgv4x3i.fsf@vps.thesusis.net>
 <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com>
 <CADnq5_NVGS1XykxGxpcu_bpPbzboCUJQkcCF3r+0N9a23KUgiQ@mail.gmail.com>
 <96e2e13c-f01c-4baf-a9a3-cbaa48fb10c7@amd.com>
 <CADnq5_NBfeAXEyQw0gnSd67=tR-bUKg8w=10+4z9pGGuRnP9uw@mail.gmail.com>
Date: Mon, 20 Nov 2023 17:40:58 -0500
Message-ID: <87bkbodp51.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 21 Nov 2023 00:59:15 +0000
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
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 Christian =?utf-8?Q?K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 linux-kernel@vger.kernel.org,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Luben Tuikov <luben.tuikov@amd.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Alex Deucher <alexdeucher@gmail.com> writes:

> Yes.  Those changes went into 6.7 though, not 6.6 AFAIK.  Maybe I'm
> misunderstanding what the original report was actually testing.  If it
> was 6.7, then try reverting:
> 56e449603f0ac580700621a356d35d5716a62ce5
> b70438004a14f4d0f9890b3297cd66248728546c

I had been running v6.6-rc5 before pulling.  It looks like that got me
somewhere between v6.6 and v6.7-rc1.  Reverting those two commits fixes
it.

