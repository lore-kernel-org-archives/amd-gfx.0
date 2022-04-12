Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7108DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 09:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA0F10FF63;
	Tue, 12 Apr 2022 09:02:29 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B69010FF63
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 09:02:29 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aef95.dynamic.kabel-deutschland.de
 [95.90.239.149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3310961EA1923;
 Tue, 12 Apr 2022 11:02:27 +0200 (CEST)
Message-ID: <b2c1807b-e88d-103c-2643-5d2303ec2977@molgen.mpg.de>
Date: Tue, 12 Apr 2022 11:02:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: AMDGPU: RX 6500 XT: System reset when loading module [SOLVED]
Content-Language: en-US
To: Cal Peake <cp@absolutedigital.net>
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
 <alpine.LNX.2.00.2204111736500.5748@lancer.cnet.absolutedigital.net>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <alpine.LNX.2.00.2204111736500.5748@lancer.cnet.absolutedigital.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Cal,


Am 12.04.22 um 00:31 schrieb Cal Peake:

> I wanted to put a capper on this just in case anyone was interested, or in
> case any future people find this thread, because I did find a resolution.

Yes, that is very much appreciated.

> Turns out the way to stop the system from crashing was to disable Global
> C-State Control in the BIOS.
> 
> Christian, Alex, you guys seem to have been on the right track in that it
> was something power related.
> 
> I haven't yet been able to figure out what Global C-State Control exactly
> does.
> 
> My best guess as to what was happening: once the GPU power management code
> was loaded and the GPU dropped into a very low power state, the CPU saw
> this and decided to match it, lowering its own power state to such a point
> that it hard resets the system. (Just a wild theory anyway :-)
> 
> If anyone knows what this feature really does, or has any better theories
> as to why it doesn't play nice with AMD GPUs, please do share!

It might be related to bug report *Random Soft Lockup on new Ryzen 
build* [1], and the referenced issues there. It’d be great if you could 
post here or there a summary with your system details (especially the 
system and GPU firmware versions).

Me is still a little upset, how AMD has until now not been able to 
properly analyze and fix this (with the ODMs).


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=196683
