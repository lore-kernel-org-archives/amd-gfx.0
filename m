Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A89C61D85
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 00:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB8AB10E217;
	Tue, 21 Nov 2023 00:59:16 +0000 (UTC)
Received: from vps.thesusis.net (vps.thesusis.net
 [IPv6:2600:1f18:60b9:2f00:6f85:14c6:952:bad3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE0610E1B9
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 22:08:35 +0000 (UTC)
Received: by vps.thesusis.net (Postfix, from userid 1000)
 id 02882149C52; Mon, 20 Nov 2023 17:08:32 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Christian =?utf-8?Q?K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Dave Airlie <airlied@gmail.com>, Linux regressions mailing list
 <regressions@lists.linux.dev>
Subject: Re: Radeon regression in 6.6 kernel
In-Reply-To: <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com>
References: <87edgv4x3i.fsf@vps.thesusis.net>
 <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com>
Date: Mon, 20 Nov 2023 17:08:32 -0500
Message-ID: <87o7fojcwv.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-kernel@vger.kernel.org,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Luben Tuikov <luben.tuikov@amd.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com> writes:

> Well none of the commits mentioned can affect radeon in any way. Radeon=20
> simply doesn't use the scheduler.
>
> My suspicion is that the user is actually using amdgpu instead of=20
> radeon. The switch potentially occurred accidentally, for example by=20
> compiling amdgpu support for SI/CIK.

Indeed, the lspci I originally posted does indicate amdgpu.  What is the
difference and should I switch it?  If so, how?

> Those amdgpu problems for older ASIC have already been worked on and=20
> should be fixed by now.

I just pulled v6.7-rc2 and it's still broken.  I'll see if I can revert
those 3 patches.
