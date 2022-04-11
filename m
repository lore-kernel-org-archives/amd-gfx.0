Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C099C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 22:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C9CC10E3E6;
	Mon, 11 Apr 2022 22:38:42 +0000 (UTC)
X-Greylist: delayed 408 seconds by postgrey-1.36 at gabe;
 Mon, 11 Apr 2022 22:38:40 UTC
Received: from mx2.absolutedigital.net (mx2.absolutedigital.net
 [50.242.207.105])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6C04910E3EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 22:38:40 +0000 (UTC)
Received: from lancer.cnet.absolutedigital.net
 (lancer.cnet.absolutedigital.net [10.7.5.10])
 by luxor.inet.absolutedigital.net (8.14.4/8.14.4) with ESMTP id 23BMVXAn016018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
 Mon, 11 Apr 2022 18:31:33 -0400
Received: from localhost (localhost [127.0.0.1])
 by lancer.cnet.absolutedigital.net (8.14.4/8.14.4) with ESMTP id
 23BMVTv9020230
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Mon, 11 Apr 2022 18:31:29 -0400
Date: Mon, 11 Apr 2022 18:31:29 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: AMDGPU: RX 6500 XT: System reset when loading module [SOLVED]
In-Reply-To: <CADnq5_Nx9Oski_2A-99QvqFJiUG36=+bfx_0F-eUK0gD56Vqjg@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.2204111736500.5748@lancer.cnet.absolutedigital.net>
References: <alpine.LNX.2.00.2202131848490.20545@lancer.cnet.absolutedigital.net>
 <b30922e2-04f5-2135-695c-2ea84d9307ac@amd.com>
 <alpine.LNX.2.00.2202141223020.10303@lancer.cnet.absolutedigital.net>
 <de9952a6-cba1-4927-f8e0-fcd7f115267e@amd.com>
 <alpine.LNX.2.00.2202171254420.21576@lancer.cnet.absolutedigital.net>
 <809355d6-ef2a-ca90-5a9a-813beb8ff6d1@amd.com>
 <alpine.LNX.2.00.2202181444250.8791@lancer.cnet.absolutedigital.net>
 <8cd9b639-be48-5b2f-bc3d-d6bd49be1830@amd.com>
 <alpine.LNX.2.00.2202241728250.23253@lancer.cnet.absolutedigital.net>
 <CADnq5_Nx9Oski_2A-99QvqFJiUG36=+bfx_0F-eUK0gD56Vqjg@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Cc: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi all,

I wanted to put a capper on this just in case anyone was interested, or in 
case any future people find this thread, because I did find a resolution.

Turns out the way to stop the system from crashing was to disable Global 
C-State Control in the BIOS.

Christian, Alex, you guys seem to have been on the right track in that it 
was something power related.

I haven't yet been able to figure out what Global C-State Control exactly 
does.

My best guess as to what was happening: once the GPU power management code 
was loaded and the GPU dropped into a very low power state, the CPU saw 
this and decided to match it, lowering its own power state to such a point 
that it hard resets the system. (Just a wild theory anyway :-)

If anyone knows what this feature really does, or has any better theories 
as to why it doesn't play nice with AMD GPUs, please do share!

Thanks and kind regards,

-- 
Cal Peake

