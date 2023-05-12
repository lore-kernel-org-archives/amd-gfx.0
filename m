Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF10C77B7C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 01:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DFF410E60C;
	Fri, 12 May 2023 01:38:47 +0000 (UTC)
X-Greylist: delayed 425 seconds by postgrey-1.36 at gabe;
 Fri, 12 May 2023 01:38:44 UTC
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3DC810E60C
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 01:38:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E11B340B79
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 03:31:32 +0200 (CEST)
Date: Fri, 12 May 2023 03:31:29 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: amd-gfx@lists.freedesktop.org
Subject: No GTT->VRAM unswapping with amdgpu?
Message-ID: <ZF2W8ZS7FUdKHSoh@sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
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

Hi,

Initially noticed this in some games, which seem to be a bit lazy
with their VRAM allocations + freeing, that performance would drop
dramatically / become unusable once the VRAM is full and GTT gets
used. For instance in No Man's Sky after jumping a solar system
or on DCS World on several maps and in multiplayer. I'm using an
ATI/AMD Radeon RX 6650 XT, 8GB VRAM with an eGPU enclosure
(Razer Core X Chroma, Thunderbolt 3), connected via a 40Gbit/s
USB4 port. Which usually has great performance, until I hit the
VRAM limit.

I scripted some further tests and benchmarking around
memmtest_vulkan(*) and these were the results:

https://github.com/T-X/linux-amdgpu-radeon-vram-swapping-test/

I would have expected roughly the same speeds in all tests.
However tests 5) and 6) yielded significantly lower performance.

Which leads me to the conclusion that anything that gets allocated
on GTT stays there and is never unswapped from GTT / system memory
back to VRAM?

I also read that there was some rework with a new TTM allocator
in 2020. But dynamic (un)swapping via TTM seems currently unused?
Is this expected?

Regards, Linus

(*): https://github.com/GpuZelenograd/memtest_vulkan
