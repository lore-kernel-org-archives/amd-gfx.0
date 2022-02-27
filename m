Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8D7C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Feb 2022 00:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C733A10E564;
	Sun, 27 Feb 2022 00:33:22 +0000 (UTC)
Received: from mx2.absolutedigital.net (mx2.absolutedigital.net
 [50.242.207.105])
 by gabe.freedesktop.org (Postfix) with ESMTP id C735F10E564
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Feb 2022 00:33:21 +0000 (UTC)
Received: from lancer.cnet.absolutedigital.net
 (lancer.cnet.absolutedigital.net [10.7.5.10])
 by luxor.inet.absolutedigital.net (8.14.4/8.14.4) with ESMTP id 21R0X25c020916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
 Sat, 26 Feb 2022 19:33:03 -0500
Received: from localhost (localhost [127.0.0.1])
 by lancer.cnet.absolutedigital.net (8.14.4/8.14.4) with ESMTP id
 21R0WJg4016407
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Sat, 26 Feb 2022 19:32:19 -0500
Date: Sat, 26 Feb 2022 19:32:19 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: AMDGPU: RX 6500 XT: System reset when loading module
In-Reply-To: <CADnq5_Nx9Oski_2A-99QvqFJiUG36=+bfx_0F-eUK0gD56Vqjg@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.2202252053130.27388@lancer.cnet.absolutedigital.net>
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

So... with me running out of things to test, I had to give consideration 
to the CPU and memory. Memory was easier to test. Tried a few different 
modules in different combinations to no change.

CPU, sadly, was another story. I was able to swap in a 3700X and it 
yielded positive results. I stressed the RX 560 across Linux and Windows 
yesterday and today and had no instability.

Doing a quick google search for "5950x system crash" returns a lot of 
similar stories. One poster on the AMD community forums[1] said they 
"fixed" things by downgrading from a 5950X to a 3950X (smh).

It's a little funny to me that AMD's own products won't play nice with 
each other. And it's utterly bizarre to me that its flagship desktop CPU 
has so many stability problems.

Just for kicks, I tried the HD 6350 I have in my current rig and it 
crashes the system too. Three different architectures on three different 
vendors' boards, all the same result.

So the RX 560 is going back and I guess I'll have to find a nice potato 
with good open source driver support to be my next GPU lol

-- 
Cal Peake

[1] https://community.amd.com/t5/processors/5950x-random-crashes-pulling-hair-out/td-p/431724

