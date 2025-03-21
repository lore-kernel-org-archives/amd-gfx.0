Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A89C36000
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 10:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 531E610E77E;
	Fri, 21 Mar 2025 10:24:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="USwN9O5c";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38FEC10E77E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 10:24:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id E7952A48D27;
 Fri, 21 Mar 2025 10:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B7AC4CEE3;
 Fri, 21 Mar 2025 10:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742552664;
 bh=D24M1M8nS14Me4tboiVm1/oePTkar2wchrnm8pcbf1w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=USwN9O5cfKZkLeODD9Fj649FR8pHBXVkQ9GUif6gjWjm7YOodBEL8Ont0MBX2s3cw
 hY79l2YkV1/6s0687tUKEj0PkPt3UkMVlzo+QGUqj0yR4Uw0Hcntn+mIi0A8Mw7sTQ
 zdIzG74IWaedYjxu4ggOmQ2l7p0CUrICogtmWlXD8qkB2WwiSqc74OO8md145mBYnz
 TaLE/eYqnZmU7WMmooxMUBa9HR8fKSyrcsn85ikXutqqkH+GkiMf+TJexvKaw0AlaN
 h8FBrhJxTadLSkn3aE6B531Pwq6mnb6gyxQwA5cwYHD5Zx/01KPCCIDAGzbGWQSRV+
 aifNE7T4T0Ubw==
Date: Fri, 21 Mar 2025 11:24:20 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Bert Karwatzki <spasswolf@web.de>, Alex Deucher <alexdeucher@gmail.com>,
 Kees Cook <kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Subject: Re: commit 7ffb791423c7 breaks steam game
Message-ID: <Z90-VOyC5oanCC8z@gmail.com>
References: <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
 <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
 <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
 <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
 <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
 <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
 <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
 <b5d80ef2-fd5a-41cc-9184-6c82226c330a@nvidia.com>
 <Z9vZYIbXOz2wF59j@gmail.com>
 <2cafd3e1-9265-403a-9854-7200d84ca397@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cafd3e1-9265-403a-9854-7200d84ca397@nvidia.com>
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


* Balbir Singh <balbirs@nvidia.com> wrote:

> On 3/20/25 20:01, Ingo Molnar wrote:
> > 
> > * Balbir Singh <balbirs@nvidia.com> wrote:
> > 
> >> On 3/17/25 00:09, Bert Karwatzki wrote:
> >>> This is related to the admgpu.gttsize. My laptop has the maximum amount 
> >>> of memory (64G) and usually gttsize is half of main memory size. I just 
> >>> tested with cmdline="nokaslr amdgpi.gttsize=2048" and the problem does 
> >>> not occur. So I did some more testing with varying gttsize and got this
> >>> for the built-in GPU
> >>>
> >>> 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
> >>> Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
> >>>
> >>> (nokaslr is always enabeld)
> >>> gttssize   input behaviour
> >>>  2048		GOOD
> >>>  2064		GOOD
> >>>  2080		SEMIBAD (i.e. noticeable input lag but not as bad as below)
> >>>  3072		BAD
> >>>  4096		BAD
> >>>  8192		BAD
> >>> 16384		BAD
> >>>
> >>> As the build-in GPU has ~512 VRAM there seems to be problems when gttsize >
> >>> 4*VRAM so I tested for the discrete GPU with 8G of VRAM
> >>> gttsize   input behaviour
> >>> 49152		GOOD
> >>> 64000		GOOD
> >>>
> >>> So for the discrete GPU increasing gttsize does no reproduce the bug.
> >>>
> >>
> >> Very interesting, I am not a GTT expert, but with these experiments do you
> >> find anything interesting in
> >>
> >> /sys/kernel/debug/x86/pat_memtype_list?
> >>
> >> It's weird that you don't see any issues in Xorg (Xfce), just the games.
> >> May be we should get help from the amd-gfx experts to further diagnose/debug
> >> the interaction of nokaslr with the game.
> > 
> > So basically your commit:
> > 
> >   7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
> > 
> > inflicts part of the effects of a 'nokaslr' boot command line option, 
> > and triggers the regression due to that?
> > 
> > Or is there some other cause?
> > 
> 
> You are right in your assessment of the root cause. Just to reiterate
>
> - nokaslr does not work with the iGPU, specifically for the games 
>   mentioned
>
> - There is a workaround for the problem, which involves reducing the 
>   amdgpu.gttsize
>
> - The patch exposes the system to nokaslr situation (effect) when 
>   PCI_P2PDMA is enabled

Note that every major x86 distro I checked enables CONFIG_PCI_P2PDMA=y 
and also keeps KASLR enables, so the above qualifiers are immaterial in 
terms of user impact: it's a 100% certainty that distro kernels on 
these systems will regress under these games, right?

What is the importance of the original fix? I should have insisted on a 
fuller changelog, because it's rather thin on details:

  If the BAR address is beyond this limit, PCI peer to peer DMA
  mappings fail.

How frequently does this happen and what is the impact to users if this 
happens?

We might be forced to revert this change if it regresses other systems.

Thanks,

	Ingo
